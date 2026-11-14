import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_confirm_dialog.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_reading_dto.dart';
import '../data/kid_reading_repository.dart';

/// Trạng thái của bước kể lại câu chuyện cho bé.
enum _SummaryStepState { idle, recording, recorded, sending, sent }

/// Bước kể lại truyện bằng giọng nói cho bố mẹ nghe trong wizard sau khi đọc xong.
class KidSummaryStep extends ConsumerStatefulWidget {
  const KidSummaryStep({
    super.key,
    required this.sessionId,
    required this.onNext,
    required this.isLast,
  });

  /// Mã phiên đọc truyện.
  final int sessionId;

  /// Callback chuyển sang bước tiếp theo.
  final VoidCallback onNext;

  /// Cờ đánh dấu đây có phải bước cuối cùng không.
  final bool isLast;

  @override
  ConsumerState<KidSummaryStep> createState() => _KidSummaryStepState();
}

class _KidSummaryStepState extends ConsumerState<KidSummaryStep> {
  // WAV mono 16 kHz 16-bit = 32000 byte/giây
  static const int _maxDurationSeconds = (kSummaryMaxBytes - 44) ~/ 32000;

  _SummaryStepState _state = _SummaryStepState.idle;
  late final AudioRecorder _recorder;
  late final AudioPlayer _player;
  StreamSubscription<PlayerState>? _playerSub;

  Timer? _timer;
  int _elapsed = 0;
  String? _recordedPath;
  String? _sentMessage;
  bool _isPlaying = false;

  bool get _isSending => _state == _SummaryStepState.sending;

  @override
  void initState() {
    super.initState();
    _recorder = AudioRecorder();
    _player = AudioPlayer();
    _playerSub = _player.playerStateStream.listen((playerState) {
      final playing =
          playerState.playing &&
          playerState.processingState != ProcessingState.completed;
      if (_isPlaying != playing) {
        if (mounted) {
          setState(() {
            _isPlaying = playing;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _playerSub?.cancel();

    if (_state == _SummaryStepState.recording) {
      _recorder.stop().ignore();
    }
    _recorder.dispose();
    _player.dispose();

    // Dọn file tạm nếu chưa gửi thành công
    if (_state != _SummaryStepState.sent && _recordedPath != null) {
      try {
        final file = File(_recordedPath!);
        if (file.existsSync()) {
          file.deleteSync();
        }
      } catch (_) {}
    }
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  Future<void> _startRecording() async {
    if (kIsWeb) {
      showTtToast(
        context,
        'Thiết bị này chưa ghi âm được.',
        type: TtToastType.error,
      );
      return;
    }

    try {
      final isSupported = await _recorder.isEncoderSupported(AudioEncoder.wav);
      if (!isSupported) {
        if (mounted) {
          showTtToast(
            context,
            'Thiết bị này chưa ghi âm được.',
            type: TtToastType.error,
          );
        }
        return;
      }

      final hasPermission = await _recorder.hasPermission();
      if (!hasPermission) {
        if (mounted) {
          showTtToast(
            context,
            'Em cần cho phép dùng micro để kể lại nhé.',
            type: TtToastType.error,
          );
        }
        return;
      }

      final tempDir = await getTemporaryDirectory();
      final path =
          '${tempDir.path}/summary_${DateTime.now().millisecondsSinceEpoch}.wav';

      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000,
          numChannels: 1,
        ),
        path: path,
      );

      if (!mounted) return;
      setState(() {
        _recordedPath = path;
        _state = _SummaryStepState.recording;
        _elapsed = 0;
      });

      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        final next = _elapsed + 1;
        if (next >= _maxDurationSeconds) {
          timer.cancel();
          _stopRecording(reachedLimit: true);
        } else {
          setState(() {
            _elapsed = next;
          });
        }
      });
    } catch (_) {
      if (mounted) {
        showTtToast(
          context,
          'Có lỗi khi bật ghi âm. Em thử lại nhé.',
          type: TtToastType.error,
        );
      }
    }
  }

  Future<void> _stopRecording({bool reachedLimit = false}) async {
    _timer?.cancel();
    try {
      final path = await _recorder.stop();
      final effectivePath = path ?? _recordedPath;

      if (!mounted) return;

      if (effectivePath == null) {
        setState(() {
          _state = _SummaryStepState.idle;
          _elapsed = 0;
        });
        showTtToast(
          context,
          'Không tìm thấy bản ghi. Em thử lại nhé.',
          type: TtToastType.error,
        );
        return;
      }

      final file = File(effectivePath);
      if (!await file.exists()) {
        if (!mounted) return;
        setState(() {
          _state = _SummaryStepState.idle;
          _elapsed = 0;
        });
        showTtToast(
          context,
          'Không tìm thấy bản ghi. Em thử lại nhé.',
          type: TtToastType.error,
        );
        return;
      }

      final length = await file.length();
      if (length > kSummaryMaxBytes) {
        try {
          await file.delete();
        } catch (_) {}
        if (!mounted) return;
        setState(() {
          _state = _SummaryStepState.idle;
          _recordedPath = null;
          _elapsed = 0;
        });
        showTtToast(
          context,
          'Bản ghi quá dài, em kể lại ngắn hơn nhé.',
          type: TtToastType.error,
        );
        return;
      }

      setState(() {
        _recordedPath = effectivePath;
        _state = _SummaryStepState.recorded;
      });

      if (!mounted) return;
      if (reachedLimit) {
        showTtToast(
          context,
          'Đã đủ thời lượng kể, em nghe lại nhé.',
          type: TtToastType.info,
        );
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _state = _SummaryStepState.idle;
        _elapsed = 0;
      });
      showTtToast(
        context,
        'Có lỗi khi dừng ghi âm. Em thử lại nhé.',
        type: TtToastType.error,
      );
    }
  }

  Future<void> _togglePlay() async {
    if (_recordedPath == null) return;
    try {
      if (_isPlaying) {
        await _player.stop();
        if (mounted) {
          setState(() {
            _isPlaying = false;
          });
        }
      } else {
        await _player.setFilePath(_recordedPath!);
        await _player.play();
      }
    } catch (_) {
      if (mounted) {
        showTtToast(
          context,
          'Không thể phát lại bản ghi.',
          type: TtToastType.error,
        );
      }
    }
  }

  Future<void> _deleteRecording() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Bỏ bản kể?',
      message: 'Em có muốn xoá bản ghi âm này để kể lại từ đầu không?',
      confirmLabel: 'Xoá và kể lại',
      cancelLabel: 'Giữ lại',
      destructive: true,
    );

    if (!confirmed || !mounted) return;

    try {
      if (_isPlaying) {
        await _player.stop();
      }
      if (_recordedPath != null) {
        final file = File(_recordedPath!);
        if (await file.exists()) {
          await file.delete();
        }
      }
    } catch (_) {}

    if (!mounted) return;
    setState(() {
      _state = _SummaryStepState.idle;
      _recordedPath = null;
      _elapsed = 0;
      _isPlaying = false;
    });
  }

  Future<void> _sendSummary() async {
    if (_recordedPath == null || _isSending) return;

    setState(() {
      _state = _SummaryStepState.sending;
    });

    try {
      if (_isPlaying) {
        await _player.stop();
      }

      final repo = ref.read(kidReadingRepositoryProvider);
      final result = await repo.summaryRecording(
        widget.sessionId.toString(),
        filePath: _recordedPath!,
      );

      if (!mounted) return;
      setState(() {
        _state = _SummaryStepState.sent;
        _sentMessage = result.message;
      });

      showTtToast(context, result.message, type: TtToastType.success);
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _state = _SummaryStepState.recorded;
      });
      showTtToast(context, e.message, type: TtToastType.error);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _state = _SummaryStepState.recorded;
      });
      showTtToast(
        context,
        'Không gửi được bản kể. Em thử lại nhé.',
        type: TtToastType.error,
      );
    }
  }

  Future<void> _handleNext() async {
    if (_state == _SummaryStepState.recording) {
      _timer?.cancel();
      try {
        final path = await _recorder.stop();
        final effectivePath = path ?? _recordedPath;
        if (effectivePath != null) {
          final file = File(effectivePath);
          if (await file.exists()) {
            await file.delete();
          }
        }
      } catch (_) {}
    }
    if (_isPlaying) {
      try {
        await _player.stop();
      } catch (_) {}
    }
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final isLocked = _state == _SummaryStepState.recording || _isSending;

    return Column(
      children: [
        // Nội dung cuộn ở giữa
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                // Linh vật ếch nhún 1 lần khi chuyển trạng thái
                TtFrog(
                      mood: _state == _SummaryStepState.sent
                          ? TtFrogMood.happy
                          : (_state == _SummaryStepState.recording
                                ? TtFrogMood.think
                                : TtFrogMood.idle),
                      size: 130,
                    )
                    .animate(key: ValueKey(_state))
                    .scale(
                      begin: const Offset(0.9, 0.9),
                      end: const Offset(1, 1),
                      duration: 350.ms,
                      curve: Curves.easeOutBack,
                    ),
                const SizedBox(height: 20),

                // Tiêu đề nổi bật
                Text(
                  'Em kể lại cho bố mẹ nhé',
                  style: TextStyle(
                    fontFamily: 'Baloo2',
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: tt.text,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 300.ms),
                const SizedBox(height: 8),

                // Dòng hướng dẫn phụ
                Text(
                  'Bấm nút kể lại những điều em nhớ trong truyện nhé!',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: tt.muted,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 300.ms, delay: 100.ms),
                const SizedBox(height: 28),

                // Khu vực thao tác ghi âm
                _buildActionArea(context)
                    .animate()
                    .fadeIn(duration: 350.ms)
                    .slideY(begin: 0.08, end: 0, duration: 350.ms),
              ],
            ),
          ),
        ),

        // Footer cố định dưới đáy
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: tt.bg,
            border: Border(top: BorderSide(color: tt.line2, width: 1)),
          ),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 64,
                  child: TtButton(
                    label: 'Bỏ qua',
                    variant: TtButtonVariant.secondary,
                    onPressed: isLocked ? null : _handleNext,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 64,
                  child: TtButton(
                    label: widget.isLast ? 'Về trang chính' : 'Tiếp',
                    icon: widget.isLast
                        ? Icons.home_rounded
                        : Icons.arrow_forward_rounded,
                    onPressed: isLocked ? null : _handleNext,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionArea(BuildContext context) {
    final tt = context.tt;

    // Trạng thái đã gửi thành công
    if (_state == _SummaryStepState.sent) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: tt.surface2,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: tt.primary, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_rounded, color: tt.primary, size: 32),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                _sentMessage ?? 'Đã gửi bản kể cho bố mẹ thành công!',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: tt.primaryStrong,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    // Khung viền và đồng hồ có chút sắc vàng gold
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: tt.panel,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: _state == _SummaryStepState.recording
              ? tt.goldDeep
              : tt.gold.withValues(alpha: 0.6),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: tt.shadow.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Huy hiệu đồng hồ thời lượng với màu vàng gold
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: tt.gold.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: tt.goldDeep, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.timer_rounded, size: 22, color: tt.goldDeep),
                const SizedBox(width: 6),
                Text(
                  _formatDuration(_elapsed),
                  style: TextStyle(
                    fontFamily: 'Baloo2',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: tt.warnInk,
                  ),
                ),
                Text(
                  ' / ${_formatDuration(_maxDurationSeconds)}',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: tt.muted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Các nút hành động tùy trạng thái
          if (_state == _SummaryStepState.idle) ...[
            SizedBox(
              height: 64,
              width: double.infinity,
              child: TtButton(
                label: 'Bấm để kể',
                icon: Icons.mic_rounded,
                onPressed: _startRecording,
              ),
            ),
          ] else if (_state == _SummaryStepState.recording) ...[
            SizedBox(
              height: 64,
              width: double.infinity,
              child: TtButton(
                label: 'Dừng (${_formatDuration(_elapsed)})',
                icon: Icons.stop_circle_rounded,
                variant: TtButtonVariant.danger,
                onPressed: _stopRecording,
              ),
            ),
          ] else if (_state == _SummaryStepState.recorded ||
              _state == _SummaryStepState.sending) ...[
            Row(
              children: [
                // Nút nghe lại
                Expanded(
                  child: SizedBox(
                    height: 64,
                    child: TtButton(
                      label: _isPlaying ? 'Dừng' : 'Nghe lại',
                      icon: _isPlaying
                          ? Icons.stop_rounded
                          : Icons.play_arrow_rounded,
                      variant: TtButtonVariant.secondary,
                      onPressed: _isSending ? null : _togglePlay,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Nút bỏ bản ghi
                SizedBox(
                  width: 64,
                  height: 64,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: tt.panel,
                      foregroundColor: tt.danger,
                      disabledForegroundColor: tt.danger.withValues(alpha: 0.4),
                      side: BorderSide(
                        color: tt.danger.withValues(alpha: 0.4),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: _isSending ? null : _deleteRecording,
                    child: const Icon(Icons.delete_outline_rounded, size: 28),
                  ),
                ),
                const SizedBox(width: 10),

                // Nút gửi bố mẹ
                Expanded(
                  child: SizedBox(
                    height: 64,
                    child: TtButton(
                      label: 'Gửi bố mẹ',
                      icon: Icons.send_rounded,
                      isLoading: _isSending,
                      onPressed: _isSending ? null : _sendSummary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
