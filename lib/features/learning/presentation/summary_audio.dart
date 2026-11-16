import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

/// Phát bản ghi âm bé kể lại: một bản tại một thời điểm.
/// Player chỉ tạo khi bấm phát lần đầu (test không cần plugin âm thanh).
class SummaryAudio extends ChangeNotifier {
  SummaryAudio({AudioPlayer Function()? createPlayer})
      : _create = createPlayer ?? AudioPlayer.new;

  final AudioPlayer Function() _create;
  AudioPlayer? _player;
  StreamSubscription<PlayerState>? _sub;
  bool _disposed = false;

  /// Bản ghi âm đang mở (đang phát hoặc tạm dừng).
  int? currentId;
  bool _playing = false;

  bool isPlaying(int id) => currentId == id && _playing;

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  AudioPlayer _init() {
    final p = _create();
    _sub = p.playerStateStream.listen((s) {
      final done = s.processingState == ProcessingState.completed;
      _playing = s.playing && !done;
      if (done) {
        currentId = null;
        unawaited(p.stop().catchError((_) {}));
      }
      _notify();
    });
    return p;
  }

  /// Phát / tạm dừng bản [id]. Trả false khi không mở được (vd link đã hết hạn).
  Future<bool> toggle(int id, String url) async {
    if (_disposed) return false;
    final p = _player ??= _init();
    try {
      if (currentId == id) {
        if (_playing) {
          await p.pause();
        } else {
          unawaited(p.play().catchError((_) {}));
        }
        return true;
      }
      currentId = id;
      _notify();
      await p.stop();
      await p.setUrl(url);
      if (_disposed || currentId != id) return true;
      unawaited(p.play().catchError((_) {}));
      return true;
    } catch (_) {
      if (currentId == id) currentId = null;
      _playing = false;
      _notify();
      return false;
    }
  }

  /// Dừng hẳn (khi rời tab, đổi bé, rời màn).
  Future<void> stop() async {
    if (currentId == null && !_playing) return;
    currentId = null;
    _playing = false;
    _notify();
    try {
      await _player?.stop();
    } catch (_) {}
  }

  @override
  void dispose() {
    _disposed = true;
    _sub?.cancel();
    _player?.dispose();
    super.dispose();
  }
}
