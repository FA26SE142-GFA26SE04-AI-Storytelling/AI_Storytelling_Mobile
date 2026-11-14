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

  /// Ảnh có vùng cắt: phóng ảnh để đúng vùng [crop] phủ kín khung (như `coverFor` của web).
  Widget _buildCropped(BuildContext context, String src, CoverCrop crop) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = width ?? constraints.maxWidth;
        final h = height ?? constraints.maxHeight;
        // Khung không có kích thước cố định thì không cắt được: hiện cả ảnh.
        if (!w.isFinite || !h.isFinite) {
          return Image.network(
            src,
            fit: fit,
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
                  loadingBuilder: (context, child, progress) =>
                      progress == null ? child : const SizedBox.shrink(),
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cover = splitCover(url);
    final trimmedUrl = cover.src;
    final crop = cover.crop;
    Widget imageWidget;

    if (trimmedUrl.isEmpty) {
      imageWidget = _buildPlaceholder(context);
    } else if (crop != null) {
      imageWidget = _buildCropped(context, trimmedUrl, crop);
    } else {
      imageWidget = Image.network(
        trimmedUrl,
        fit: fit,
        width: width,
        height: height,
        // Đang tải thì hiện ảnh mặc định: ảnh treo không tải xong (mạng chậm,
        // bị chặn) vẫn có hình, không để khung trống.
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholder(context);
        },
        errorBuilder: (context, error, stackTrace) =>
            _buildPlaceholder(context),
      );
    }

    return ClipRRect(borderRadius: radius, child: imageWidget);
  }
}
