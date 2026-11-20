import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_toast.dart';
import '../data/kid_reading_repository.dart';

class _FeelingOption {
  const _FeelingOption({
    required this.id,
    required this.icon,
    required this.label,
  });

  final String id;
  final IconData icon;
  final String label;
}

const _kFeelingOptions = <_FeelingOption>[
  _FeelingOption(
    id: 'VeryLike',
    icon: Icons.sentiment_very_satisfied_rounded,
    label: 'Rất thích',
  ),
  _FeelingOption(
    id: 'Like',
    icon: Icons.sentiment_satisfied_rounded,
    label: 'Thích',
  ),
  _FeelingOption(
    id: 'Neutral',
    icon: Icons.sentiment_neutral_rounded,
    label: 'Bình thường',
  ),
  _FeelingOption(
    id: 'Dislike',
    icon: Icons.sentiment_dissatisfied_rounded,
    label: 'Chưa thích',
  ),
];

/// Trang 0 sau khi đọc: bé chọn mức thích truyện; chọn xong là lưu và tự sang trang sau.
/// Vừa một màn như web: chỉ tiêu đề + 4 mặt (phần thưởng nằm ở đầu KidAfterReadingScreen).
class KidFeelingStep extends ConsumerStatefulWidget {
  const KidFeelingStep({
    super.key,
    required this.sessionId,
    required this.onNext,
  });

  final int sessionId;
  final VoidCallback onNext;

  @override
  ConsumerState<KidFeelingStep> createState() => _KidFeelingStepState();
}

class _KidFeelingStepState extends ConsumerState<KidFeelingStep> {
  String? _selectedFeeling;
  bool _sending = false;

  Future<void> _handleSelectFeeling(_FeelingOption option) async {
    if (_sending) return;
    setState(() => _sending = true);

    try {
      await ref
          .read(kidReadingRepositoryProvider)
          .feeling(widget.sessionId.toString(), feeling: option.id);
      if (!mounted) return;
      setState(() {
        _selectedFeeling = option.id;
        _sending = false;
      });
      widget.onNext();
    } catch (e) {
      if (!mounted) return;
      setState(() => _sending = false);
      showTtToast(
        context,
        e is ApiException ? e.message : 'Chưa lưu được cảm nhận của em.',
        type: TtToastType.error,
      );
    }
  }

  Widget _buildFeelingCard(_FeelingOption option, TtColors tt) {
    final isSelected = _selectedFeeling == option.id;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _sending ? null : () => _handleSelectFeeling(option),
        borderRadius: BorderRadius.circular(TtRadius.xl),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          constraints: const BoxConstraints(minHeight: 110),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? tt.gold.withValues(alpha: 0.18) : tt.panel,
            borderRadius: BorderRadius.circular(TtRadius.xl),
            border: Border.all(
              color: isSelected ? tt.gold : tt.line2,
              width: isSelected ? 4 : 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(option.icon, size: 48, color: tt.goldDeep),
              const SizedBox(height: 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  option.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: tt.text,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final wide = MediaQuery.sizeOf(context).width >= 600;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: wide ? 760 : 560),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Em thấy truyện này thế nào?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: tt.text,
                ),
              ),
              const SizedBox(height: 16),
              // Màn rộng (ngang / tablet) xếp 4 mặt một hàng để không phải cuộn; màn dọc 2x2.
              for (final row
                  in wide
                      ? [_kFeelingOptions]
                      : [
                          _kFeelingOptions.sublist(0, 2),
                          _kFeelingOptions.sublist(2),
                        ]) ...[
                if (row.first != _kFeelingOptions.first)
                  const SizedBox(height: 12),
                Row(
                  children: [
                    for (var i = 0; i < row.length; i++) ...[
                      if (i > 0) const SizedBox(width: 12),
                      Expanded(child: _buildFeelingCard(row[i], tt)),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms, curve: Curves.easeOut);
  }
}
