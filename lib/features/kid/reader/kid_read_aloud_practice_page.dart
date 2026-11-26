import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/kid_panel.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../models/child_read_aloud_dto.dart';
import '../../../models/child_reading_dto.dart';
import 'kid_read_aloud_ranges.dart';

/// Trang "Luyện đọc to" sau cảnh cuối: bé đọc một câu và được chấm từng chữ.
class KidReadAloudPracticePage extends StatelessWidget {
  const KidReadAloudPracticePage({
    super.key,
    required this.practice,
    required this.result,
    required this.recording,
    required this.sending,
    required this.onMic,
    required this.onRetry,
    this.onPlaySample,
  });

  final ReadAloudPractice practice;
  final ReadAloudResult? result;
  final bool recording;
  final bool sending;
  final VoidCallback onMic;
  final VoidCallback onRetry;

  /// Null khi câu không có audio mẫu.
  final VoidCallback? onPlaySample;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final res = result;
    final text = practice.text;
    final praise = (practice.praiseFeedback ?? '').trim();

    final spans = <InlineSpan>[];
    if (res == null) {
      spans.add(TextSpan(text: text));
    } else {
      var pos = 0;
      for (final r in readAloudWordRanges(text, res.words)) {
        if (r.start > pos) {
          spans.add(TextSpan(text: text.substring(pos, r.start)));
        }
        spans.add(
          TextSpan(
            text: text.substring(r.start, r.end),
            style: readAloudStyle(r.status, tt),
          ),
        );
        pos = r.end;
      }
      if (pos < text.length) spans.add(TextSpan(text: text.substring(pos)));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: KidPanel(
            borderColor: tt.gold,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TtFrog(
                  mood: res != null ? TtFrogMood.happy : TtFrogMood.idle,
                  size: 72,
                ),
                const SizedBox(height: 16),
                Text(
                  'Luyện đọc to',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Baloo2',
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: tt.text,
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  label: 'Câu em luyện đọc',
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: '“'),
                        ...spans,
                        const TextSpan(text: '”'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                      color: tt.text,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (onPlaySample != null)
                      KidBtn3D(
                        label: 'Nghe mẫu',
                        icon: Icons.volume_up_rounded,
                        color: tt.sky,
                        onPressed: recording || sending ? null : onPlaySample,
                      ),
                    KidBtn3D(
                      label: recording
                          ? 'Dừng'
                          : sending
                          ? 'Đang chấm'
                          : 'Đọc to',
                      icon: recording ? Icons.stop_rounded : Icons.mic_rounded,
                      color: tt.gold,
                      foregroundColor: TtColors.light.inkWarm,
                      onPressed: sending ? null : onMic,
                    ),
                    if (res != null)
                      TtIconButton(
                        icon: Icons.replay_rounded,
                        tooltip: 'Đọc lại',
                        onPressed: sending ? null : onRetry,
                      ),
                  ],
                ),
                if (res != null &&
                    res.goodCount < res.totalCount &&
                    praise.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome_rounded, color: tt.goldDeep),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          praise,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: tt.warnInk,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.05, end: 0),
        ),
      ),
    );
  }
}
