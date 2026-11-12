/// Tiện ích phân tích URL ảnh bìa kèm thông tin cắt (crop) tỉ lệ.
library;

/// Vùng cắt ảnh theo tỉ lệ chuẩn hóa 0..1 của ảnh gốc.
class CoverCrop {
  /// Khởi tạo thông tin vùng cắt ảnh bìa.
  const CoverCrop({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
  });

  /// Tọa độ x góc trên bên trái (tỉ lệ 0..1).
  final double x;

  /// Tọa độ y góc trên bên trái (tỉ lệ 0..1).
  final double y;

  /// Chiều rộng vùng cắt (tỉ lệ 0..1).
  final double w;

  /// Chiều cao vùng cắt (tỉ lệ 0..1).
  final double h;
}

/// Nguồn ảnh bìa gồm đường dẫn gốc và thông tin cắt (nếu có).
class CoverSource {
  /// Khởi tạo nguồn ảnh bìa.
  const CoverSource({
    required this.src,
    this.crop,
  });

  /// URL hoặc đường dẫn ảnh nguồn đã loại bỏ phần crop hash.
  final String src;

  /// Vùng cắt ảnh (nếu có).
  final CoverCrop? crop;
}

/// Biểu thức chính quy trích xuất tham số crop từ đuôi URL.
final RegExp _cropRegex = RegExp(r'#crop=(-?[\d.]+),(-?[\d.]+),([\d.]+),([\d.]+)$');

/// Phân tích chuỗi [raw] thành [CoverSource] chứa URL và vùng cắt.
///
/// Trả về `null` nếu chuỗi rỗng hoặc chỉ chứa khoảng trắng.
CoverSource? parseCoverUrl(String? raw) {
  if (raw == null) return null;
  final trimmed = raw.trim();
  if (trimmed.isEmpty) return null;

  final match = _cropRegex.firstMatch(trimmed);
  if (match != null) {
    final src = trimmed.substring(0, match.start).trim();
    if (src.isEmpty) return null;

    final parsedX = double.tryParse(match.group(1)!);
    final parsedY = double.tryParse(match.group(2)!);
    final parsedW = double.tryParse(match.group(3)!);
    final parsedH = double.tryParse(match.group(4)!);

    if (parsedX == null || parsedY == null || parsedW == null || parsedH == null) {
      return CoverSource(src: src);
    }

    final x = parsedX.clamp(0.0, 1.0);
    final y = parsedY.clamp(0.0, 1.0);
    final w = parsedW.clamp(0.0, 1.0);
    final h = parsedH.clamp(0.0, 1.0);

    if (w <= 0 || h <= 0) {
      return CoverSource(src: src);
    }

    return CoverSource(
      src: src,
      crop: CoverCrop(x: x, y: y, w: w, h: h),
    );
  }

  return CoverSource(src: trimmed);
}
