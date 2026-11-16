import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../models/child_interaction_dto.dart';

/// Thanh phản hồi sau tương tác cho trẻ, gắn cố định ở đáy màn hình.
class KidInteractionFeedbackBar extends StatelessWidget {
  const KidInteractionFeedbackBar({
    super.key,
    required this.result,
    required this.fallbackText,
    required this.onContinue,
    this.actions = const [],
    this.extra,
  });

  final ListeningAttemptResult result;
  final String fallbackText;
  final VoidCallback onContinue;
  final List<Widget> actions;
  final Widget? extra;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final isMatched = result.matched == true;

    final Color backgroundColor = isMatched
        ? tt.okInk.withValues(alpha: 0.12)
        : tt.gold.withValues(alpha: 0.25);

    final Color borderColor = isMatched ? tt.okInk : tt.goldDeep;

    final IconData statusIcon;
    final Color iconColor;
    if (result.matched == true) {
      statusIcon = Icons.check_circle_rounded;
      iconColor = tt.okInk;
    } else if (result.matched == false) {
      statusIcon = Icons.cancel_rounded;
      iconColor = tt.danger;
    } else {
      statusIcon = Icons.star_rounded;
      iconColor = tt.goldDeep;
    }

    final titleStyle = (Theme.of(context).textTheme.titleLarge ??
            const TextStyle())
        .copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: tt.text,
    );

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(
            top: BorderSide(
              color: borderColor,
              width: 2,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(statusIcon, size: 32, color: iconColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    fallbackText,
                    style: titleStyle,
                  ),
                ),
              ],
            ),
            if (extra != null) ...[
              const SizedBox(height: 12),
              extra!,
            ],
            if (actions.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: actions,
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(
              height: 64,
              width: double.infinity,
              child: TtButton(
                label: 'Đọc tiếp',
                expanded: true,
                onPressed: onContinue,
                icon: Icons.arrow_forward_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
