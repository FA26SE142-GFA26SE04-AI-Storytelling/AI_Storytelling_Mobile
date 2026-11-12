import 'package:flutter/material.dart';

import '../theme/tt_colors.dart';
import '../theme/tt_radius.dart';
import 'tt_state_views.dart';

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
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return TtSkeleton(
            width: width,
            height: height ?? 120,
            radius: radius,
          );
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
