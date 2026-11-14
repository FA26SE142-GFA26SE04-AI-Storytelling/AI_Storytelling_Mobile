import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

/// Quản lý phát âm thanh đọc truyện cho bé.
/// Màn hình tự tạo instance và tự gọi [dispose] khi huỷ.
class KidReaderAudio {
  /// Khởi tạo audio player, cho phép truyền [player] phục vụ kiểm thử.
  KidReaderAudio({AudioPlayer? player}) : _player = player ?? AudioPlayer();

  final AudioPlayer _player;

  /// Số thứ tự phiên phát hiện tại để huỷ phiên cũ khi có lệnh mới.
  int _currentSession = 0;

  /// Cờ đánh dấu đối tượng đã bị giải phóng.
  bool _isDisposed = false;

  /// Stream trạng thái phát (true: đang phát, false: dừng/nghỉ).
  Stream<bool> get playingStream =>
      _isDisposed ? const Stream<bool>.empty() : _player.playingStream;

  /// Trạng thái đang phát hay không tại thời điểm hiện tại.
  bool get isPlaying => !_isDisposed && _player.playing;

  /// Phát lần lượt từng URL âm thanh trong danh sách.
  ///
  /// Tự động lọc bỏ URL null hoặc rỗng. Nếu không có URL hợp lệ thì
  /// gọi [onCompleted] ngay và kết thúc.
  /// Khi có lệnh [stop] hoặc phiên [playUrls] mới, phiên cũ sẽ dừng
  /// và KHÔNG gọi [onCompleted] của phiên cũ.
  /// Lỗi tải/phát ở một URL sẽ được bỏ qua để tiếp tục URL tiếp theo.
  Future<void> playUrls(
    List<String?> urls, {
    VoidCallback? onCompleted,
    ValueChanged<int>? onIndexChanged,
  }) async {
    if (_isDisposed) return;

    // Tăng token phiên để vô hiệu hoá mọi phiên phát trước đó.
    final sessionId = ++_currentSession;

    // Dừng bài đang phát nếu có.
    try {
      await _player.stop();
    } catch (_) {
      // Bỏ qua lỗi dừng player.
    }

    if (sessionId != _currentSession || _isDisposed) return;

    // Lọc bỏ URL null hoặc rỗng/chỉ chứa khoảng trắng, giữ lại chỉ số gốc.
    final validEntries = <MapEntry<int, String>>[];
    for (var i = 0; i < urls.length; i++) {
      final url = urls[i];
      if (url != null && url.trim().isNotEmpty) {
        validEntries.add(MapEntry(i, url.trim()));
      }
    }

    if (validEntries.isEmpty) {
      if (sessionId == _currentSession && !_isDisposed) {
        onCompleted?.call();
      }
      return;
    }

    for (final entry in validEntries) {
      if (sessionId != _currentSession || _isDisposed) return;

      final originalIndex = entry.key;
      final url = entry.value;

      onIndexChanged?.call(originalIndex);
      if (sessionId != _currentSession || _isDisposed) return;

      try {
        await _player.setUrl(url);
        if (sessionId != _currentSession || _isDisposed) return;

        // Lắng nghe sự kiện hoàn thành của URL này trước khi phát.
        final completionFuture = _player.playerStateStream.firstWhere(
          (state) {
            if (sessionId != _currentSession || _isDisposed) return true;
            return state.processingState == ProcessingState.completed;
          },
          orElse: () => _player.playerState,
        );

        await _player.play();
        if (sessionId != _currentSession || _isDisposed) return;

        // Chờ URL hiện tại phát xong hoặc phiên bị ngắt.
        await completionFuture;
      } catch (_) {
        // Bỏ qua URL lỗi, tiếp tục URL tiếp theo.
      }
    }

    // Khi đã phát xong toàn bộ danh sách hợp lệ và vẫn thuộc phiên này.
    if (sessionId == _currentSession && !_isDisposed) {
      try {
        await _player.stop();
      } catch (_) {
        // Bỏ qua lỗi dừng player.
      }

      if (sessionId == _currentSession && !_isDisposed) {
        onCompleted?.call();
      }
    }
  }

  /// Dừng phát âm thanh và huỷ phiên hiện tại.
  Future<void> stop() async {
    // Tăng phiên để huỷ phiên đang chạy dở.
    _currentSession++;

    if (_isDisposed) return;

    try {
      await _player.stop();
    } catch (_) {
      // Không ném lỗi ra ngoài.
    }
  }

  /// Giải phóng tài nguyên player. Sau dispose mọi gọi không ném lỗi.
  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;
    _currentSession++;

    try {
      _player.stop();
    } catch (_) {}

    try {
      _player.dispose();
    } catch (_) {}
  }
}
