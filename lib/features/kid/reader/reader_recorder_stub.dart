import 'dart:typed_data';

const bool kMicSupported = false;

/// Bộ ghi âm đọc to cho nền tảng web (stub không hỗ trợ).
class ReaderRecorder {
  /// Kiểm tra nền tảng có hỗ trợ ghi âm hay không.
  bool get isSupported => false;

  /// Bắt đầu ghi âm đọc to (stub luôn trả về false).
  Future<bool> start({void Function()? onLimit}) async => false;

  /// Dừng ghi âm và trả về dữ liệu âm thanh (stub luôn trả về null).
  Future<Uint8List?> stop() async => null;

  /// Giải phóng tài nguyên ghi âm.
  Future<void> dispose() async {}
}
