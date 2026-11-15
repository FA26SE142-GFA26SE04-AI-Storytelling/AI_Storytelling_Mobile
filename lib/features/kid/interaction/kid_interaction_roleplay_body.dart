import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../models/child_interaction_dto.dart';

class KidInteractionRolePlayBody extends StatelessWidget {
  const KidInteractionRolePlayBody({
    super.key,
    required this.interaction,
    required this.busy,
    required this.onDone,
    required this.onPlayModel,
  });

  final ReadingInteraction interaction;
  final bool busy;
  final VoidCallback onDone;
  final VoidCallback onPlayModel;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final characterName = interaction.characterName?.trim() ?? '';
    final modelSentence = interaction.modelSentence?.trim() ?? '';
    final modelAudioUrl = interaction.modelAudioUrl?.trim() ?? '';

    final hasCharacter = characterName.isNotEmpty;
    final hasModelSentence = modelSentence.isNotEmpty;
    final hasAudio = modelAudioUrl.isNotEmpty;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hasModelSentence) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: tt.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: tt.gold, width: 3),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (hasCharacter) ...[
                  Text(
                    characterName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: tt.goldDeep,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                Text(
                  '“$modelSentence”',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: tt.text,
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 300))
              .slideY(
                begin: 0.1,
                end: 0,
                duration: const Duration(milliseconds: 300),
              ),
          const SizedBox(height: 20),
        ],
        if (hasAudio) ...[
          SizedBox(
            height: 64,
            width: double.infinity,
            child: TtButton(
              label: 'Nghe mẫu',
              icon: Icons.volume_up_rounded,
              variant: TtButtonVariant.secondary,
              expanded: true,
              onPressed: busy ? null : onPlayModel,
            ),
          ),
          const SizedBox(height: 12),
        ],
        SizedBox(
          height: 64,
          width: double.infinity,
          child: TtButton(
            label: 'Em nói xong rồi',
            icon: Icons.check_rounded,
            variant: TtButtonVariant.primary,
            expanded: true,
            isLoading: busy,
            onPressed: busy ? null : onDone,
          ),
        ),
      ],
    );
  }
}
