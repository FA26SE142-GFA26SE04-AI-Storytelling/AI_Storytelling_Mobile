import 'package:flutter/material.dart';

import '../theme/tt_radius.dart';
import '../utils/cover_crop.dart';
import 'tt_network_image.dart';

/// Thành phần hiển thị hình ảnh mạng có hỗ trợ cắt ảnh (crop) theo tỉ lệ.
///
/// Nếu [url] chứa thông tin crop (dạng `#crop=x,y,w,h`), ảnh sẽ được phóng to
/// và căn chỉnh vị trí để hiển thị đúng vùng cắt phủ kín khung hình kích thước [width] x [height].
/// Khi không có thông tin crop hoặc không phân tích được, widget sẽ hiển thị qua [TtNetworkImage] thông thường.
class TtCroppedImage extends StatelessWidget {
  /// Khởi tạo widget hiển thị ảnh hỗ trợ crop.
  const TtCroppedImage({
    super.key,
    this.url,
    this.width,
    this.height,
    this.radius = const BorderRadius.all(Radius.circular(TtRadius.lg)),
  });

  /// Đường dẫn hình ảnh (có thể chứa hậu tố #crop=x,y,w,h).
  final String? url;

  /// Chiều rộng mong muốn của khung ảnh.
  final double? width;

  /// Chiều cao mong muốn của khung ảnh.
  final double? height;

  /// Bán kính bo góc khung ảnh.
  final BorderRadiusGeometry radius;

  @override
  Widget build(BuildContext context) {
    final source = parseCoverUrl(url);
    final crop = source?.crop;

    if (source == null || crop == null) {
      return TtNetworkImage(
        url: source?.src ?? url,
        width: width,
        height: height,
        radius: radius,
        fit: BoxFit.cover,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final frameW = width ?? (constraints.hasBoundedWidth ? constraints.maxWidth : double.infinity);
        final frameH = height ?? (constraints.hasBoundedHeight ? constraints.maxHeight : double.infinity);

        if (frameW <= 0 || frameH <= 0 || frameW.isInfinite || frameH.isInfinite) {
          return TtNetworkImage(
            url: source.src,
            width: width,
            height: height,
            radius: radius,
            fit: BoxFit.cover,
          );
        }

        final fullW = frameW / crop.w;
        final fullH = frameH / crop.h;
        final left = -crop.x * fullW;
        final top = -crop.y * fullH;

        return ClipRRect(
          borderRadius: radius,
          child: SizedBox(
            width: frameW,
            height: frameH,
            child: Stack(
              children: [
                Positioned(
                  left: left,
                  top: top,
                  width: fullW,
                  height: fullH,
                  child: TtNetworkImage(
                    url: source.src,
                    width: fullW,
                    height: fullH,
                    fit: BoxFit.fill,
                    radius: BorderRadius.zero,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
