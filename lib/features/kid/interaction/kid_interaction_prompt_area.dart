import 'package:flutter/material.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_frog.dart';

class KidInteractionPromptArea extends StatelessWidget {
  const KidInteractionPromptArea({
    super.key,
    required this.mood,
    required this.prompt,
  });

  final TtFrogMood mood;
  final String prompt;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TtFrog(mood: mood, size: 120),
        const SizedBox(height: 12),
        if (prompt.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              prompt,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: tt.text,
                  ),
            ),
          ),
      ],
    );
  }
}
