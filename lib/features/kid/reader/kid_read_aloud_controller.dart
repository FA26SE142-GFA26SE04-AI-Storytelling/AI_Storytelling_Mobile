import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../core/network/api_exception.dart';
import '../../../models/child_read_aloud_dto.dart';
import '../data/kid_reading_repository.dart';
import 'kid_reader_controller.dart';

// ─── Sentinel ────────────────────────────────────────────────────────────────

const Object _sentinel = Object();

// ─── State ───────────────────────────────────────────────────────────────────

class KidReadAloudState {
  const KidReadAloudState({
    this.recording = false,
    this.sending = false,
    this.segmentId,
    this.result,
    this.errorMessage,
    this.elapsedSeconds = 0,
    this.practice = false,
  });

  final bool recording;
  final bool sending;
  final int? segmentId;
  final ReadAloudResult? result;
  final String? errorMessage;
  final int elapsedSeconds;

  /// Đang ghi/chấm câu luyện đọc to sau cảnh cuối (segmentId là interactionId).
  final bool practice;

  KidReadAloudState copyWith({
    bool? recording,
    bool? sending,
    Object? segmentId = _sentinel,
    Object? result = _sentinel,
    Object? errorMessage = _sentinel,
    int? elapsedSeconds,
    bool? practice,
  }) => KidReadAloudState(
    recording: recording ?? this.recording,
    sending: sending ?? this.sending,
    segmentId: segmentId == _sentinel ? this.segmentId : segmentId as int?,
    result: result == _sentinel ? this.result : result as ReadAloudResult?,
    errorMessage: errorMessage == _sentinel
        ? this.errorMessage
        : errorMessage as String?,
    elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    practice: practice ?? this.practice,
  );
}

// ─── Controller ──────────────────────────────────────────────────────────────

class KidReadAloudController extends Notifier<KidReadAloudState> {
  KidReadAloudController(this.storyId);

  final String storyId;
  AudioRecorder? _recorder;
  Timer? _timer;
  String? _recordedPath;
  bool _disposed = false;

  @override
  KidReadAloudState build() {
    _recorder = AudioRecorder();
    ref.onDispose(() {
      _disposed = true;
      _timer?.cancel();
      _recorder?.dispose();
      _cleanupFile(_recordedPath);
    });
    return const KidReadAloudState();
  }

  /// Bật/tắt ghi âm để đọc to; [segmentId] là id đích: segmentId, hoặc interactionId khi [practice].
  Future<void> toggle(
    int segmentId, {
    required VoidCallback onStart,
    bool practice = false,
  }) async {
    if (state.recording) {
      await _stopAndSend();
      return;
    }
    if (state.sending) return;
    if (kIsWeb) {
      _safeSetState(
        state.copyWith(errorMessage: 'Máy này chưa hỗ trợ ghi âm.'),
      );
      return;
    }

    final recorder = _recorder;
    if (recorder == null) return;

    try {
      if (!await recorder.isEncoderSupported(AudioEncoder.wav)) {
        _safeSetState(
          state.copyWith(errorMessage: 'Thiết bị này chưa ghi âm được.'),
        );
        return;
      }
      if (!await recorder.hasPermission()) {
        _safeSetState(
          state.copyWith(
            errorMessage: 'Em cần cho phép dùng micro để đọc nhé.',
          ),
        );
        return;
      }
    } catch (_) {
      _safeSetState(
        state.copyWith(errorMessage: 'Có lỗi khi bật ghi âm. Em thử lại nhé.'),
      );
      return;
    }

    try {
      onStart();
      final tempDir = await getTemporaryDirectory();
      final path =
          '${tempDir.path}/read_aloud_${DateTime.now().millisecondsSinceEpoch}.wav';

      await recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000,
          numChannels: 1,
        ),
        path: path,
      );

      _recordedPath = path;
      _safeSetState(
        state.copyWith(
          recording: true,
          sending: false,
          segmentId: segmentId,
          result: null,
          errorMessage: null,
          elapsedSeconds: 0,
          practice: practice,
        ),
      );

      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (_disposed || !state.recording) {
          timer.cancel();
          return;
        }
        final next = state.elapsedSeconds + 1;
        _safeSetState(state.copyWith(elapsedSeconds: next));

        // Giống web (useRecorder): tối đa 120 giây, thường chạm giới hạn 3 MB (~98 giây WAV 16 kHz) trước.
        bool limit = next >= 120;
        if (!limit && _recordedPath != null) {
          try {
            final f = File(_recordedPath!);
            if (f.existsSync() && f.lengthSync() >= 3 * 1024 * 1024) {
              limit = true;
            }
          } catch (_) {}
        }
        if (limit) {
          timer.cancel();
          await _stopAndSend();
        }
      });
    } catch (_) {
      _safeSetState(
        state.copyWith(errorMessage: 'Có lỗi khi bật ghi âm. Em thử lại nhé.'),
      );
    }
  }

  /// Dừng ghi âm và gửi audio lên server để chấm điểm.
  Future<void> _stopAndSend() async {
    // Khoá trước await: bé bấm dừng đúng lúc bộ đếm tự dừng thì chỉ gửi một lần.
    if (_disposed || !state.recording) return;
    _timer?.cancel();
    _timer = null;
    _safeSetState(state.copyWith(recording: false, sending: true));

    final path = await _recorder?.stop() ?? _recordedPath;

    final targetSegmentId = state.segmentId;
    final practice = state.practice;

    try {
      final sid = ref.read(kidReaderControllerProvider(storyId)).sessionId;
      if (sid == null) {
        _safeSetState(state.copyWith(errorMessage: 'Chưa có phiên đọc.'));
        return;
      }
      if (targetSegmentId == null || path == null) return;

      final repo = ref.read(kidReadingRepositoryProvider);
      final result = practice
          ? await repo.readAloudPractice(
              sid.toString(),
              targetSegmentId,
              filePath: path,
            )
          : await repo.readAloud(
              sid.toString(),
              targetSegmentId,
              filePath: path,
            );
      _safeSetState(
        state.copyWith(
          result: result,
          segmentId: targetSegmentId,
          errorMessage: null,
          practice: practice,
        ),
      );
    } on ApiException catch (e) {
      if (e.statusCode == 403) {
        final msg = e.message.trim();
        _safeSetState(
          state.copyWith(
            errorMessage: msg.isNotEmpty
                ? msg
                : 'Bố mẹ chưa bật đọc bằng giọng nói cho em.',
          ),
        );
      } else {
        _safeSetState(
          state.copyWith(errorMessage: 'Chưa chấm được, em đọc lại nhé.'),
        );
      }
    } catch (_) {
      _safeSetState(
        state.copyWith(errorMessage: 'Chưa chấm được, em đọc lại nhé.'),
      );
    } finally {
      _safeSetState(state.copyWith(sending: false));
      _cleanupFile(path);
      if (_recordedPath == path) _recordedPath = null;
    }
  }

  /// Huỷ ghi âm dở dang và đặt lại trạng thái khi đổi trang/đoạn.
  Future<void> cancel() async {
    if (state.recording) {
      _timer?.cancel();
      _timer = null;
      try {
        await _recorder?.cancel();
      } catch (_) {}
      try {
        _cleanupFile(_recordedPath);
      } catch (_) {}
      _recordedPath = null;
    }
    _safeSetState(
      state.copyWith(
        recording: false,
        segmentId: null,
        result: null,
        errorMessage: null,
        elapsedSeconds: 0,
        practice: false,
      ),
    );
  }

  /// Xóa kết quả chấm khi đổi đoạn hoặc đổi trang.
  void clear() => _safeSetState(
    state.copyWith(
      result: null,
      segmentId: null,
      errorMessage: null,
      practice: false,
    ),
  );

  /// Xóa thông báo lỗi.
  void clearError() => _safeSetState(state.copyWith(errorMessage: null));

  void _safeSetState(KidReadAloudState next) {
    if (_disposed || !ref.mounted) return;
    state = next;
  }

  void _cleanupFile(String? filePath) {
    if (filePath == null) return;
    try {
      final file = File(filePath);
      if (file.existsSync()) file.deleteSync();
    } catch (_) {}
  }
}

// ─── Provider ────────────────────────────────────────────────────────────────

/// Provider quản lý việc trẻ đọc to một đoạn theo [storyId].
final kidReadAloudControllerProvider = NotifierProvider.autoDispose
    .family<KidReadAloudController, KidReadAloudState, String>(
      KidReadAloudController.new,
    );
