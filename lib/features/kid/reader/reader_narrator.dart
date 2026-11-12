import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../../../models/reading_segment_dto.dart';

/// Hàm phân giải URL âm thanh thành [AudioSource].
typedef AudioSourceResolver = Future<AudioSource> Function(String url);

/// Bộ phát thuyết minh danh sách phân đoạn đọc truyện theo thứ tự.
class ReaderNarrator {
  /// Khởi tạo [ReaderNarrator] với bộ phân giải nguồn âm thanh [resolve].
  ReaderNarrator({required this.resolve});

  final AudioSourceResolver resolve;
  AudioPlayer? _player;
  int _token = 0;
  bool _isPlaying = false;

  /// ID của phân đoạn đang phát hiện tại, nhận giá trị `null` khi không phát.
  final ValueNotifier<int?> activeSegmentId = ValueNotifier<int?>(null);

  /// Cờ trạng thái cho biết bộ thuyết minh có đang phát hay không.
  bool get isPlaying => _isPlaying;

  AudioPlayer get _audioPlayer => _player ??= AudioPlayer();

  /// Phát tuần tự danh sách [segments] theo thứ tự `segmentOrder`.
  ///
  /// Bỏ qua các phân đoạn có `audioUrl` null hoặc rỗng.
  Future<void> playSegments(
    List<ReadingSegmentDto> segments, {
    VoidCallback? onStarted,
    VoidCallback? onFinished,
  }) async {
    final validSegments = segments
        .where((s) => s.audioUrl != null && s.audioUrl!.trim().isNotEmpty)
        .toList()
      ..sort((a, b) => a.segmentOrder.compareTo(b.segmentOrder));

    if (validSegments.isEmpty) {
      return;
    }

    final token = ++_token;
    _isPlaying = true;
    onStarted?.call();

    try {
      for (final segment in validSegments) {
        if (token != _token) {
          break;
        }

        activeSegmentId.value = segment.segmentId;
        final source = await resolve(segment.audioUrl!);

        if (token != _token) {
          break;
        }

        await _audioPlayer.setAudioSource(source);
        await _audioPlayer.play();
      }

      if (token == _token) {
        activeSegmentId.value = null;
        _isPlaying = false;
        onFinished?.call();
      }
    } catch (e) {
      activeSegmentId.value = null;
      _isPlaying = false;
      rethrow;
    }
  }

  /// Dừng phát âm thanh hiện tại và huỷ token phát.
  Future<void> stop() async {
    _token++;
    _isPlaying = false;
    activeSegmentId.value = null;
    if (_player != null) {
      await _player!.stop();
    }
  }

  /// Dọn dẹp tài nguyên âm thanh và bộ lắng nghe [activeSegmentId].
  Future<void> dispose() async {
    await stop();
    if (_player != null) {
      await _player!.dispose();
    }
    activeSegmentId.dispose();
  }
}
