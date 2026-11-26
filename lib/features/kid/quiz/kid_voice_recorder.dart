import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/kid_panel.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_reading_dto.dart';

/// Widget ghi âm giọng nói dùng chung cho trẻ em.
class KidVoiceRecorder extends ConsumerStatefulWidget {
  const KidVoiceRecorder({
    super.key,
    required this.audioPath,
    required this.onChanged,
    this.enabled = true,
    this.sending = false,
    this.canDelete = true,
  });

  /// Đường dẫn file wav đã ghi (null nếu chưa có bản ghi).
  final String? audioPath;

  /// Callback khi có bản ghi mới hoặc khi bản ghi bị xóa (null).
  final ValueChanged<String?> onChanged;

  /// Cho phép ghi âm hay không (false: nút mic mờ, không bấm được).
  final bool enabled;

  /// Đang gửi dữ liệu hay không (true: khóa tất cả các nút).
  final bool sending;

  /// Hiện nút xóa bản ghi (false: bản ghi đã gửi xong, chỉ còn nghe lại).
  final bool canDelete;

  @override
  ConsumerState<KidVoiceRecorder> createState() => _KidVoiceRecorderState();
}

class _KidVoiceRecorderState extends ConsumerState<KidVoiceRecorder> {
  // WAV mono 16 kHz 16-bit = 32000 byte/giây, giới hạn thời lượng 120 giây và dung lượng tối đa 3 MB
  static const int _maxDurationSeconds =
      ((kSummaryMaxBytes - 44) ~/ 32000) > 120
      ? 120
      : (kSummaryMaxBytes - 44) ~/ 32000;

  late final AudioRecorder _recorder;
  late final AudioPlayer _player;
  StreamSubscription<PlayerState>? _playerSub;

  Timer? _timer;
  int _elapsed = 0;
  bool _isRecording = false;
  String? _currentRecordingPath;
  bool _isPlaying = false;

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
  void didUpdateWidget(covariant KidVoiceRecorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.audioPath != widget.audioPath) {
      if (_isPlaying) {
        _player.stop().ignore();
        setState(() {
          _isPlaying = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _playerSub?.cancel();

    if (_isRecording) {
      _recorder.stop().ignore();
      if (_currentRecordingPath != null) {
        try {
          final file = File(_currentRecordingPath!);
          if (file.existsSync()) {
            file.deleteSync();
          }
        } catch (_) {}
      }
    }
    _recorder.dispose();
    _player.dispose();

    super.dispose();
  }

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  Future<void> _startRecording() async {
    if (!widget.enabled || widget.sending) return;

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
            'Em cần cho phép dùng micro để ghi âm nhé.',
            type: TtToastType.error,
          );
        }
        return;
      }

      final tempDir = await getTemporaryDirectory();
      final path =
          '${tempDir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.wav';

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
        _currentRecordingPath = path;
        _isRecording = true;
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
      final effectivePath = path ?? _currentRecordingPath;

      if (!mounted) return;

      if (effectivePath == null) {
        setState(() {
          _isRecording = false;
          _elapsed = 0;
          _currentRecordingPath = null;
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
          _isRecording = false;
          _elapsed = 0;
          _currentRecordingPath = null;
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
          _isRecording = false;
          _elapsed = 0;
          _currentRecordingPath = null;
        });
        showTtToast(
          context,
          'Bản ghi quá dài, em kể lại ngắn hơn nhé.',
          type: TtToastType.error,
        );
        return;
      }

      setState(() {
        _isRecording = false;
        _currentRecordingPath = null;
      });

      widget.onChanged(effectivePath);

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
        _isRecording = false;
        _elapsed = 0;
        _currentRecordingPath = null;
      });
      showTtToast(
        context,
        'Có lỗi khi dừng ghi âm. Em thử lại nhé.',
        type: TtToastType.error,
      );
    }
  }

  Future<void> _togglePlay() async {
    final path = widget.audioPath;
    if (path == null || widget.sending) return;

    try {
      if (_isPlaying) {
        await _player.stop();
        if (mounted) {
          setState(() {
            _isPlaying = false;
          });
        }
      } else {
        await _player.setFilePath(path);
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
    if (widget.sending) return;

    try {
      if (_isPlaying) {
        await _player.stop();
      }
      final path = widget.audioPath;
      if (path != null) {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
        }
      }
    } catch (_) {}

    if (!mounted) return;
    setState(() {
      _isPlaying = false;
      _elapsed = 0;
    });

    widget.onChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final hasRecording =
        widget.audioPath != null && widget.audioPath!.isNotEmpty;

    return KidPanel(
      borderColor: _isRecording ? tt.goldDeep : tt.gold,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isRecording) ...[
            // Huy hiệu đồng hồ đếm giây với màu vàng gold
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: tt.muted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            KidBtn3D(
              label: 'Dừng (${_formatDuration(_elapsed)})',
              icon: Icons.stop_rounded,
              color: tt.danger,
              expand: true,
              big: true,
              onPressed: widget.sending ? null : () => _stopRecording(),
            ),
          ] else if (hasRecording) ...[
            Row(
              children: [
                Expanded(
                  child: KidBtn3D(
                    label: _isPlaying ? 'Dừng' : 'Nghe lại',
                    icon: _isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: tt.sky,
                    onPressed: widget.sending ? null : _togglePlay,
                  ),
                ),
                if (widget.canDelete) ...[
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: tt.panel,
                        foregroundColor: tt.danger,
                        disabledForegroundColor: tt.danger.withValues(
                          alpha: 0.4,
                        ),
                        side: BorderSide(
                          color: tt.danger.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: widget.sending ? null : _deleteRecording,
                      child: const Icon(Icons.delete_outline_rounded, size: 28),
                    ),
                  ),
                ],
              ],
            ),
          ] else ...[
            Opacity(
              opacity: widget.enabled ? 1.0 : 0.45,
              child: KidBtn3D(
                label: 'Bấm để ghi âm',
                icon: Icons.mic_rounded,
                color: tt.primary,
                expand: true,
                big: true,
                onPressed: (widget.enabled && !widget.sending)
                    ? _startRecording
                    : null,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
