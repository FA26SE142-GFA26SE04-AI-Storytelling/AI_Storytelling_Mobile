import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/kid_panel.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_toast.dart';
import '../data/kid_reading_repository.dart';
import 'kid_voice_recorder.dart';

/// Bước kể lại truyện bằng giọng nói cho bố mẹ nghe trong wizard sau khi đọc xong.
class KidSummaryStep extends ConsumerStatefulWidget {
  const KidSummaryStep({super.key, required this.sessionId});

  /// Mã phiên đọc truyện.
  final int sessionId;

  @override
  ConsumerState<KidSummaryStep> createState() => _KidSummaryStepState();
}

class _KidSummaryStepState extends ConsumerState<KidSummaryStep> {
  String? _audioPath;
  bool _sending = false;
  bool _sent = false;
  String? _sentMessage;

  Future<void> _sendSummary() async {
    if (_audioPath == null || _sending || _sent) return;

    setState(() {
      _sending = true;
    });

    try {
      final repo = ref.read(kidReadingRepositoryProvider);
      final result = await repo.summaryRecording(
        widget.sessionId.toString(),
        filePath: _audioPath!,
      );

      if (!mounted) return;
      setState(() {
        _sending = false;
        _sent = true;
        _sentMessage = result.message;
      });

      showTtToast(context, result.message, type: TtToastType.success);
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _sending = false;
      });
      showTtToast(context, e.message, type: TtToastType.error);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _sending = false;
      });
      showTtToast(
        context,
        'Không gửi được bản kể. Em thử lại nhé.',
        type: TtToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

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
                      mood: _sent
                          ? TtFrogMood.happy
                          : (_sending ? TtFrogMood.think : TtFrogMood.idle),
                      size: 130,
                    )
                    .animate(
                      key: ValueKey(
                        _sent
                            ? 'sent'
                            : _sending
                            ? 'sending'
                            : 'idle',
                      ),
                    )
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
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: tt.muted,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 300.ms, delay: 100.ms),
                const SizedBox(height: 28),

                // Widget ghi âm
                KidVoiceRecorder(
                      audioPath: _audioPath,
                      onChanged: (p) => setState(() => _audioPath = p),
                      enabled: !_sent,
                      sending: _sending,
                    )
                    .animate()
                    .fadeIn(duration: 350.ms)
                    .slideY(begin: 0.08, end: 0, duration: 350.ms),
                const SizedBox(height: 20),

                // Dòng ✓ sau khi gửi thành công
                if (_sent) ...[
                  KidPanel(
                    borderColor: tt.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: tt.primary,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            _sentMessage ?? '',
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
                  ).animate().fadeIn(duration: 350.ms),
                ] else if (_audioPath != null) ...[
                  // Nút Gửi bố mẹ (chỉ hiện khi có bản ghi và chưa gửi)
                  SizedBox(
                    width: double.infinity,
                    child: KidBtn3D(
                      label: 'Gửi bố mẹ',
                      icon: Icons.send_rounded,
                      color: tt.primary,
                      expand: true,
                      onPressed: _sending ? null : _sendSummary,
                    ),
                  ).animate().fadeIn(duration: 300.ms),
                ],

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
