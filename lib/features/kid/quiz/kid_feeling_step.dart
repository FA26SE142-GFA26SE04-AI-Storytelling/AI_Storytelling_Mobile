import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_reading_dto.dart';
import '../data/kid_reading_repository.dart';
import '../data/kid_rewards_repository.dart';

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

/// Bước khảo sát cảm xúc của bé sau khi đọc xong truyện.
class KidFeelingStep extends ConsumerStatefulWidget {
  const KidFeelingStep({
    super.key,
    required this.sessionId,
    required this.result,
    required this.onNext,
    required this.isLast,
  });

  final int sessionId;
  final ReadingCompleted result;
  final VoidCallback onNext;
  final bool isLast;

  @override
  ConsumerState<KidFeelingStep> createState() => _KidFeelingStepState();
}

class _KidFeelingStepState extends ConsumerState<KidFeelingStep> {
  String? _selectedFeeling;
  bool _sending = false;

  /// Kết quả đọc chỉ có mã huy hiệu: lấy tên từ bảng phần thưởng (như web).
  Map<String, String> _badgeNames = const {};

  @override
  void initState() {
    super.initState();
    if (widget.result.newBadges.isEmpty) return;
    ref.read(kidRewardsRepositoryProvider).rewards().then((r) {
      if (mounted) {
        setState(
          () => _badgeNames = {for (final b in r.badges) b.code: b.name},
        );
      }
    }, onError: (_) {}); // không lấy được tên thì vẫn hiện số lượng
  }

  Future<void> _handleSelectFeeling(_FeelingOption option) async {
    if (_sending) return;
    if (_selectedFeeling == option.id) return;

    setState(() {
      _sending = true;
    });

    try {
      final repo = ref.read(kidReadingRepositoryProvider);
      final res = await repo.feeling(
        widget.sessionId.toString(),
        feeling: option.id,
      );
      if (!mounted) return;
      setState(() {
        _selectedFeeling = option.id;
        _sending = false;
      });
      showTtToast(
        context,
        'Đã ghi nhận: ${res.label}',
        type: TtToastType.success,
      );
    } catch (e) {
      if (!mounted) return;
      final message = e is ApiException
          ? e.message
          : 'Có lỗi xảy ra. Vui lòng thử lại.';
      setState(() {
        _selectedFeeling = null;
        _sending = false;
      });
      showTtToast(context, message, type: TtToastType.error);
    }
  }

  Widget _buildFeelingCard(_FeelingOption option, TtColors tt) {
    final isSelected = _selectedFeeling == option.id;
    final borderColor = isSelected ? tt.primary : tt.line2;
    final borderWidth = isSelected ? 4.0 : 2.0;
    final bgColor = isSelected ? tt.primary.withValues(alpha: 0.12) : tt.panel;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _sending ? null : () => _handleSelectFeeling(option),
        borderRadius: BorderRadius.circular(TtRadius.xl),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          constraints: const BoxConstraints(minHeight: 120),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(TtRadius.xl),
            border: Border.all(color: borderColor, width: borderWidth),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: tt.primary.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    color: isSelected ? tt.primary : tt.text,
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
    final res = widget.result;

    final hasRewardInfo =
        res.isRetake ||
        res.expGained > 0 ||
        res.newBadges.isNotEmpty ||
        res.roadmapStepCompleted;

    return Column(
      children: [
        // Phần thân nội dung cho phép cuộn
        Expanded(
          child:
              SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 1. Linh vật Ếch với animation nhún 1 lần 300ms
                        Center(
                          child: const TtFrog(mood: TtFrogMood.happy, size: 120)
                              .animate()
                              .moveY(
                                begin: 0,
                                end: -10,
                                duration: 150.ms,
                                curve: Curves.easeOut,
                              )
                              .then()
                              .moveY(
                                begin: -10,
                                end: 0,
                                duration: 150.ms,
                                curve: Curves.easeIn,
                              ),
                        ),
                        const SizedBox(height: 20),

                        // 2. Tiêu đề hoàn thành
                        Text(
                          'Em đọc xong rồi!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Baloo2',
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: tt.text,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 3. Khối phần thưởng (nếu có thông tin)
                        if (hasRewardInfo) ...[
                          TtCard(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (res.isRetake)
                                  Text(
                                    'Em đọc lại truyện này rồi',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: tt.muted,
                                    ),
                                  ),
                                if (res.expGained > 0) ...[
                                  if (res.isRetake) const SizedBox(height: 12),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.stars_rounded,
                                        color: tt.goldDeep,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '+${res.expGained} EXP',
                                        style: TextStyle(
                                          fontFamily: 'Baloo2',
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800,
                                          color: tt.warnInk,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (res.newBadges.isNotEmpty) ...[
                                  if (res.isRetake || res.expGained > 0)
                                    const SizedBox(height: 12),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.military_tech_rounded,
                                        color: tt.gold,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          _badgeNames.isEmpty
                                              ? 'Em mở được ${res.newBadges.length} huy hiệu mới'
                                              : 'Huy hiệu mới: ${res.newBadges.map((c) => _badgeNames[c] ?? c).join(', ')}!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: tt.text,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (res.roadmapStepCompleted) ...[
                                  if (res.isRetake ||
                                      res.expGained > 0 ||
                                      res.newBadges.isNotEmpty)
                                    const SizedBox(height: 12),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.auto_stories_rounded,
                                        color: tt.primary,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          'Em đã đi thêm một bước trong hành trình đọc!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: tt.text,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // 4. Câu hỏi khảo sát cảm nhận
                        Text(
                          'Em thấy truyện này thế nào?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Baloo2',
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: tt.text,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 5. Lưới 2x2 lựa chọn cảm xúc
                        Row(
                          children: [
                            Expanded(
                              child: _buildFeelingCard(_kFeelingOptions[0], tt),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildFeelingCard(_kFeelingOptions[1], tt),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildFeelingCard(_kFeelingOptions[2], tt),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildFeelingCard(_kFeelingOptions[3], tt),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 350.ms, curve: Curves.easeOut)
                  .slideY(
                    begin: 0.04,
                    end: 0,
                    duration: 350.ms,
                    curve: Curves.easeOut,
                  ),
        ),

        // 6. Footer cố định dưới đáy màn hình
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 64,
                    child: TtButton(
                      label: 'Bỏ qua',
                      variant: TtButtonVariant.secondary,
                      onPressed: _sending ? null : widget.onNext,
                      expanded: true,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 64,
                    child: TtButton(
                      label: widget.isLast ? 'Về trang chính' : 'Tiếp',
                      icon: widget.isLast ? Icons.home_rounded : null,
                      onPressed: _sending ? null : widget.onNext,
                      expanded: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
