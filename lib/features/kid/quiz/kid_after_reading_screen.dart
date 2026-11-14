import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../models/child_reading_dto.dart';
import './kid_feeling_step.dart';
import './kid_flags_step.dart';
import './kid_quiz_step.dart';
import './kid_summary_step.dart';

/// Màn hình wizard "Sau khi đọc xong" dành cho bé (toàn màn hình).
///
/// Quản lý thanh trạng thái bước, điểm thưởng EXP và điều phối chuyển bước.
/// Nội dung và hành động chuyển tiếp của từng bước do widget bước đó tự quản lý.
class KidAfterReadingScreen extends StatefulWidget {
  const KidAfterReadingScreen({
    super.key,
    required this.sessionId,
    required this.result,
    required this.scenes,
  });

  final int sessionId;
  final ReadingCompleted result;
  final List<ReadingScene> scenes;

  @override
  State<KidAfterReadingScreen> createState() => _KidAfterReadingScreenState();
}

class _KidAfterReadingScreenState extends State<KidAfterReadingScreen> {
  int _stepIndex = 0;
  int _bonusExp = 0;

  int get _totalSteps => widget.scenes.isNotEmpty ? 4 : 3;

  void _onExpGained(int delta) {
    if (delta <= 0) return;
    setState(() {
      _bonusExp += delta;
    });
  }

  void _next() {
    if (_stepIndex >= _totalSteps - 1) {
      if (mounted) {
        context.go('/kid');
      }
      return;
    }
    setState(() {
      _stepIndex++;
    });
  }

  Widget _buildCurrentStep(bool isLast) {
    switch (_stepIndex) {
      case 0:
        return KidFeelingStep(
          sessionId: widget.sessionId,
          result: widget.result,
          onNext: _next,
          isLast: isLast,
        );
      case 1:
        return KidQuizStep(
          sessionId: widget.sessionId,
          onExpGained: _onExpGained,
          onNext: _next,
          isLast: isLast,
        );
      case 2:
        return KidSummaryStep(
          sessionId: widget.sessionId,
          onNext: _next,
          isLast: isLast,
        );
      case 3:
        return KidFlagsStep(
          sessionId: widget.sessionId,
          scenes: widget.scenes,
          onNext: _next,
          isLast: isLast,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final totalSteps = _totalSteps;
    final isLast = _stepIndex >= totalSteps - 1;
    final totalExp = widget.result.expGained + _bonusExp;

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Thanh trên: Nút thoát ✕, thanh chấm lá sen và chip EXP
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                height: 48,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Nút thoát (✕)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: tt.text,
                          size: 28,
                        ),
                        tooltip: 'Thoát',
                        constraints: const BoxConstraints(
                          minWidth: 48,
                          minHeight: 48,
                        ),
                        onPressed: () {
                          if (mounted) {
                            context.go('/kid');
                          }
                        },
                      ),
                    ),

                    // Hàng chấm lá sen thể hiện tiến trình
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(totalSteps, (index) {
                          final isCurrent = index == _stepIndex;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: isCurrent ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: isCurrent ? tt.gold : tt.line2,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }),
                      ),
                    ),

                    // Chip hiển thị EXP tích lũy (+N EXP)
                    if (totalExp > 0)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: tt.gold.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: tt.gold.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.stars_rounded,
                                color: tt.goldDeep,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '+$totalExp EXP',
                                style: TextStyle(
                                  fontFamily: 'Baloo2',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: tt.warnInk,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Khung nội dung chuyển bước
            Expanded(
              child:
                  KeyedSubtree(
                        key: ValueKey(_stepIndex),
                        child: _buildCurrentStep(isLast),
                      )
                      .animate()
                      .fadeIn(duration: 300.ms)
                      .slideX(begin: 0.05, end: 0, duration: 300.ms),
            ),
          ],
        ),
      ),
    );
  }
}
