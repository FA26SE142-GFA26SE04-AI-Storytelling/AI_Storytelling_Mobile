import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:record/record.dart';

import 'reader_recorder_limits.dart';

const bool kMicSupported = true;

/// Bộ ghi âm đọc to cho nền tảng di động và desktop (sử dụng package:record và dart:io).
class ReaderRecorder {
  final AudioRecorder _rec = AudioRecorder();
  String? _path;
  Timer? _limitTimer;

  /// Nền tảng có hỗ trợ ghi âm hay không.
  bool get isSupported => true;

  /// Bắt đầu ghi âm đọc to.
  ///
  /// Trả về `true` nếu khởi động thành công, `false` nếu không có quyền ghi âm.
  /// [onLimit] được kích hoạt khi chạm thời gian giới hạn ước tính.
  Future<bool> start({void Function()? onLimit}) async {
    final hasPermission = await _rec.hasPermission();
    if (!hasPermission) {
      return false;
    }

    final tempDir = Directory.systemTemp.createTempSync('read_aloud');
    final path = '${tempDir.path}/read-aloud.wav';
    _path = path;

    await _rec.start(
      const RecordConfig(
        encoder: AudioEncoder.wav,
        sampleRate: kWavSampleRate,
        numChannels: 1,
      ),
      path: path,
    );

    _limitTimer?.cancel();
    _limitTimer = Timer(Duration(seconds: readAloudMaxSeconds()), () {
      onLimit?.call();
    });

    return true;
  }

  /// Dừng ghi âm, đọc toàn bộ bytes của file WAV tạm và dọn dẹp file.
  Future<Uint8List?> stop() async {
    _limitTimer?.cancel();
    _limitTimer = null;

    final p = await _rec.stop() ?? _path;
    _path = null;

    if (p == null) {
      return null;
    }

    try {
      final file = File(p);
      if (await file.exists()) {
        final bytes = await file.readAsBytes();
        try {
          await file.delete();
        } catch (_) {}
        return bytes;
      }
    } catch (_) {
      return null;
    }

    return null;
  }

  /// Huỷ timer và giải phóng bộ ghi âm.
  Future<void> dispose() async {
    _limitTimer?.cancel();
    _limitTimer = null;
    await _rec.dispose();
  }
}
