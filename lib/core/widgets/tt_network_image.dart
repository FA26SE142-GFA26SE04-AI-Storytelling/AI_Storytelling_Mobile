import 'package:flutter/material.dart';

import '../theme/tt_colors.dart';
import '../theme/tt_radius.dart';

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
        child: Icon(
          Icons.auto_stories_rounded,
          color: tt.primary,
          size: 32,
        ),
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

  @override
  Widget build(BuildContext context) {
    final trimmedUrl = url?.trim();
    Widget imageWidget;

    if (trimmedUrl == null || trimmedUrl.isEmpty) {
      imageWidget = _buildPlaceholder(context);
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

    return ClipRRect(
      borderRadius: radius,
      child: imageWidget,
    );
  }
}
