import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../theme/tt_colors.dart';
import '../theme/tt_radius.dart';

/// Vùng ảnh giữ làm bìa, theo tỉ lệ 0–1 của cả tấm ảnh: góc trái-trên (x, y), kích thước (w, h).
typedef CoverCrop = ({double x, double y, double w, double h});

final _cropTail = RegExp(r'#crop=(-?[\d.]+),(-?[\d.]+),([\d.]+),([\d.]+)$');

/// Tách đuôi `#crop=x,y,w,h` Backend ghi sau link ảnh bìa (giống `splitCover` của web).
({String src, CoverCrop? crop}) splitCover(String? value) {
  final v = (value ?? '').trim();
  final m = _cropTail.firstMatch(v);
  if (m == null) return (src: v, crop: null);
  final n = [1, 2, 3, 4].map((i) => double.tryParse(m.group(i)!)).toList();
  final src = v.substring(0, m.start);
  if (n.any((e) => e == null || !e.isFinite)) return (src: src, crop: null);
  final [x!, y!, w!, h!] = n;
  if (w <= 0 || h <= 0 || w > 1 || h > 1) return (src: src, crop: null);
  return (
    src: src,
    crop: (x: x.clamp(0, 1 - w), y: y.clamp(0, 1 - h), w: w, h: h),
  );
}

/// Hiện TRỌN ảnh (không cắt, không méo) trong khung bất kỳ tỉ lệ: ảnh chính `contain`,
/// phần thừa của khung lấp bằng chính ảnh đó phủ kín + làm mờ. Bỏ đuôi `#crop`
/// (vùng cắt 3:4 chỉ dành cho thẻ bìa). Hai lớp cùng link nên ImageCache chỉ tải một lần.
class TtWholeImage extends StatelessWidget {
  const TtWholeImage({super.key, this.url, this.radius = BorderRadius.zero});

  final String? url;
  final BorderRadiusGeometry radius;

  @override
  Widget build(BuildContext context) {
    final src = splitCover(url).src;
    return ClipRRect(
      borderRadius: radius,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: TtNetworkImage(url: src, radius: BorderRadius.zero),
          ),
          TtNetworkImage(
            url: src,
            fit: BoxFit.contain,
            radius: BorderRadius.zero,
          ),
        ],
      ),
    );
  }
}

/// Thành phần hiển thị hình ảnh từ internet kèm hiệu ứng tải và ảnh dự phòng.
class TtNetworkImage extends StatelessWidget {
  const TtNetworkImage({
    super.key,
    this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.radius = const BorderRadius.all(Radius.circular(TtRadius.lg)),
  });

  /// Đường dẫn hình ảnh mạng.
  final String? url;

  /// Cách căn chỉnh và co dãn hình ảnh.
  final BoxFit fit;

  /// Chiều rộng mong muốn.
  final double? width;

  /// Chiều cao mong muốn.
  final double? height;

  /// Bán kính bo góc khung ảnh.
  final BorderRadiusGeometry radius;

  Widget _buildFallback(BuildContext context) {
    final tt = context.tt;
    return Container(
      width: width,
      height: height,
      color: tt.surface2,
      child: Center(
        child: Icon(Icons.auto_stories_rounded, color: tt.primary, size: 32),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Image.asset(
      'assets/images/placeholder.png',
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) => _buildFallback(context),
    );
  }

  /// Ảnh có vùng cắt: phóng ảnh để đúng vùng [crop] phủ kín khung [w]×[h] (như `coverFor` của web).
  Widget _buildCropped(
    BuildContext context,
    String src,
    CoverCrop crop,
    double w,
    double h,
  ) {
    // Khung không có kích thước cố định thì không cắt được: hiện cả ảnh.
    if (!w.isFinite || !h.isFinite) {
      return Image.network(
        src,
        fit: fit,
        cacheWidth: decodeWidth(context, w, h),
        errorBuilder: (context, error, stackTrace) =>
            _buildPlaceholder(context),
      );
    }
    return SizedBox(
      width: w,
      height: h,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Lớp dưới: ảnh mặc định, thấy được khi ảnh thật đang tải hoặc lỗi.
          Positioned.fill(child: _buildPlaceholder(context)),
          Positioned(
            left: -crop.x * w / crop.w,
            top: -crop.y * h / crop.h,
            width: w / crop.w,
            height: h / crop.h,
            child: Image.network(
              src,
              fit: BoxFit.fill,
              cacheWidth: decodeWidth(context, w / crop.w, h / crop.h),
              loadingBuilder: (context, child, progress) =>
                  progress == null ? child : const SizedBox.shrink(),
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlain(BuildContext context, String src, double w, double h) {
    return Image.network(
      src,
      fit: fit,
      width: width,
      height: height,
      cacheWidth: decodeWidth(context, w, h),
      // Đang tải thì hiện ảnh mặc định: ảnh treo không tải xong (mạng chậm,
      // bị chặn) vẫn có hình, không để khung trống.
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildPlaceholder(context);
      },
      errorBuilder: (context, error, stackTrace) => _buildPlaceholder(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cover = splitCover(url);
    final src = cover.src;
    final crop = cover.crop;
    Widget sized(Widget Function(double w, double h) child) =>
        width != null && height != null
        ? child(width!, height!)
        // Chỉ đo khung khi thiếu kích thước: LayoutBuilder lỗi khi nằm dưới IntrinsicHeight.
        : LayoutBuilder(
            builder: (context, c) =>
                child(width ?? c.maxWidth, height ?? c.maxHeight),
          );

    final Widget imageWidget = src.isEmpty
        ? _buildPlaceholder(context)
        : sized(
            (w, h) => crop == null
                ? _buildPlain(context, src, w, h)
                : _buildCropped(context, src, crop, w, h),
          );

    return ClipRRect(borderRadius: radius, child: imageWidget);
  }
}

/// Bề ngang (px thật) cần giải mã cho khung [w]×[h]. Giải mã ảnh gốc (ảnh AI ~1000px+)
/// cho thẻ ~100px làm giật khi cuộn và tốn RAM. Lấy cạnh dài để ảnh dọc/vuông `cover` vẫn nét.
/// shortcut: ảnh ngang hiện `cover` trong khung dọc sẽ hơi mờ; nếu Backend trả nhiều ảnh ngang
/// thì giải mã theo tỉ lệ ảnh thật.
int? decodeWidth(BuildContext context, double w, double h) {
  final side = math.max(w.isFinite ? w : 0.0, h.isFinite ? h : 0.0);
  if (side <= 0) return null;
  return (side * MediaQuery.devicePixelRatioOf(context)).ceil();
}
