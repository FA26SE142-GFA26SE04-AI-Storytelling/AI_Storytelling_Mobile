import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_toast.dart';
import '../data/kid_reading_repository.dart';

/// Số lượng cảm xúc tối đa bé được chọn.
const kReflectionMaxEmotions = 2;

class _EmotionOption {
  const _EmotionOption({
    required this.code,
    required this.label,
    required this.emoji,
  });

  final String code;
  final String label;
  final String emoji;
}

const _kEmotionOptions = <_EmotionOption>[
  _EmotionOption(code: 'Happy', label: 'Vui', emoji: '😄'),
  _EmotionOption(code: 'Funny', label: 'Buồn cười', emoji: '😂'),
  _EmotionOption(code: 'Surprised', label: 'Ngạc nhiên', emoji: '😮'),
  _EmotionOption(code: 'Excited', label: 'Hồi hộp', emoji: '😆'),
  _EmotionOption(code: 'Touched', label: 'Cảm động', emoji: '🥹'),
  _EmotionOption(code: 'Sad', label: 'Buồn', emoji: '😢'),
  _EmotionOption(code: 'Scared', label: 'Hơi sợ', emoji: '😨'),
];

/// Bước phản hồi cảm xúc sau khi đọc truyện: "Truyện làm em cảm thấy gì?".
class KidEmotionStep extends ConsumerStatefulWidget {
  const KidEmotionStep({
    super.key,
    required this.sessionId,
    required this.initialCodes,
    required this.onNext,
  });

  final int sessionId;
  final List<String> initialCodes;
  final VoidCallback onNext;

  @override
  ConsumerState<KidEmotionStep> createState() => _KidEmotionStepState();
}

class _KidEmotionStepState extends ConsumerState<KidEmotionStep> {
  late Set<String> _selectedCodes;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _selectedCodes = widget.initialCodes.take(kReflectionMaxEmotions).toSet();
  }

  @override
  void didUpdateWidget(covariant KidEmotionStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCodes != oldWidget.initialCodes && !_sending) {
      _selectedCodes = widget.initialCodes.take(kReflectionMaxEmotions).toSet();
    }
  }

  Future<void> _handleToggleEmotion(_EmotionOption option) async {
    if (_sending) return;

    final isSelected = _selectedCodes.contains(option.code);

    // Nếu chưa chọn và đã đạt tối đa thì thông báo nhắc nhở và bỏ qua
    if (!isSelected && _selectedCodes.length >= kReflectionMaxEmotions) {
      showTtToast(
        context,
        'Em chỉ chọn tối đa $kReflectionMaxEmotions nhé',
        type: TtToastType.info,
      );
      return;
    }

    final previousCodes = Set<String>.from(_selectedCodes);
    final newCodes = Set<String>.from(_selectedCodes);

    if (isSelected) {
      newCodes.remove(option.code);
    } else {
      newCodes.add(option.code);
    }

    // Nếu danh sách không thay đổi thì không gọi API
    if (previousCodes.length == newCodes.length &&
        previousCodes.containsAll(newCodes)) {
      return;
    }

    setState(() {
      _sending = true;
      _selectedCodes = newCodes;
    });

    try {
      final repo = ref.read(kidReadingRepositoryProvider);
      await repo.reflectionEmotions(widget.sessionId, newCodes.toList());

      if (!mounted) return;
      setState(() {
        _sending = false;
      });

      // Tự động chuyển bước khi đã chọn đủ số lượng cảm xúc
      if (newCodes.length == kReflectionMaxEmotions) {
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          widget.onNext();
        }
      }
    } catch (e) {
      if (!mounted) return;
      final message = e is ApiException
          ? e.message
          : 'Có lỗi xảy ra. Vui lòng thử lại.';
      setState(() {
        _selectedCodes = previousCodes;
        _sending = false;
      });
      showTtToast(context, message, type: TtToastType.error);
    }
  }

  Widget _buildEmotionCard(_EmotionOption option, TtColors tt) {
    final isSelected = _selectedCodes.contains(option.code);
    final borderColor = isSelected ? tt.gold : tt.line2;
    final borderWidth = isSelected ? 4.0 : 2.0;
    final bgColor = isSelected ? tt.gold.withValues(alpha: 0.14) : tt.panel;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _sending ? null : () => _handleToggleEmotion(option),
        borderRadius: BorderRadius.circular(TtRadius.xl),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          // Màn thấp (điện thoại xoay ngang) thì ô thấp lại để không phải cuộn.
          constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).height < 500 ? 76 : 110,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: MediaQuery.sizeOf(context).height < 500 ? 8 : 14,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(TtRadius.xl),
            border: Border.all(color: borderColor, width: borderWidth),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: tt.gold.withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      option.emoji,
                      style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).height < 500
                            ? 32
                            : 44,
                      ),
                    ),
                    const SizedBox(height: 6),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        option.label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? tt.warnInk : tt.text,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: tt.gold,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: tt.gold.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: Colors.white,
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
    // Màn thấp (điện thoại ngang): bớt khoảng đệm để đủ 2 hàng cảm xúc.
    final short = MediaQuery.sizeOf(context).height < 500;

    return Column(
      children: [
        Expanded(
          child:
              SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: short ? 8 : 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (!short) const SizedBox(height: 8),
                        Text(
                          'Truyện làm em cảm thấy gì?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Baloo2',
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: tt.text,
                          ),
                        ),
                        SizedBox(height: short ? 10 : 24),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final width = constraints.maxWidth;
                            // Màn ngang 4 cột để 7 cảm xúc vừa 2 hàng.
                            final columns = width > 700
                                ? 4
                                : width > 520
                                ? 3
                                : 2;
                            const spacing = 12.0;
                            final itemWidth =
                                (width - spacing * (columns - 1)) / columns;

                            return Wrap(
                              spacing: spacing,
                              runSpacing: spacing,
                              alignment: WrapAlignment.center,
                              children: _kEmotionOptions.map((option) {
                                return SizedBox(
                                  width: itemWidth,
                                  child: _buildEmotionCard(option, tt),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
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
      ],
    );
  }
}
