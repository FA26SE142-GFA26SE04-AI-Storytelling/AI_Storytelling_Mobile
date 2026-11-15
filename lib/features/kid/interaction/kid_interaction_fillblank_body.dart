import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_text_field.dart';
import '../../../models/child_interaction_dto.dart';

class KidInteractionFillBlankBody extends StatefulWidget {
  const KidInteractionFillBlankBody({
    super.key,
    required this.interaction,
    required this.busy,
    required this.result,
    required this.onSubmit,
  });

  final ReadingInteraction interaction;
  final bool busy;
  final ListeningAttemptResult? result;
  final void Function(String text) onSubmit;

  @override
  State<KidInteractionFillBlankBody> createState() =>
      _KidInteractionFillBlankBodyState();
}

class _KidInteractionFillBlankBodyState
    extends State<KidInteractionFillBlankBody> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_controller.text.length > 100) {
      _controller.text = _controller.text.substring(0, 100);
      _controller.selection = const TextSelection.collapsed(offset: 100);
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final maskedSentence = widget.interaction.maskedSentence?.trim() ?? '';
    final hint = widget.interaction.hint?.trim() ?? '';
    final canSubmit = _controller.text.trim().isNotEmpty &&
        !widget.busy &&
        widget.result == null;

    final Color borderColor;
    if (widget.result != null) {
      if (widget.result!.matched == true) {
        borderColor = tt.okInk;
      } else if (widget.result!.matched == false) {
        borderColor = tt.danger;
      } else {
        borderColor = tt.gold;
      }
    } else {
      borderColor = tt.line2;
    }

    final fieldTheme = Theme.of(context).copyWith(
      textTheme: Theme.of(context).textTheme.copyWith(
            bodyLarge:
                (Theme.of(context).textTheme.bodyLarge ?? const TextStyle())
                    .copyWith(fontSize: 24),
          ),
      extensions: [
        tt.copyWith(
          line2: borderColor,
          primary: borderColor,
        ),
      ],
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (maskedSentence.isNotEmpty) ...[
            Text(
              maskedSentence,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: tt.text,
              ),
            )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 300))
                .slideY(begin: 0.1, end: 0),
            const SizedBox(height: 20),
          ],
          if (hint.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lightbulb_rounded,
                  size: 24,
                  color: tt.goldDeep,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    hint,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: tt.muted,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
          Theme(
            data: fieldTheme,
            child: TtTextField(
              label: '',
              controller: _controller,
              autofocus: widget.result == null,
              enabled: widget.result == null,
              textInputAction: TextInputAction.done,
              onSubmitted: canSubmit
                  ? (_) => widget.onSubmit(_controller.text.trim())
                  : null,
            ),
          ),
          if (widget.result == null) ...[
            const SizedBox(height: 20),
            SizedBox(
              height: 64,
              width: double.infinity,
              child: TtButton(
                label: 'Xong',
                icon: Icons.check_rounded,
                variant: TtButtonVariant.primary,
                expanded: true,
                isLoading: widget.busy,
                onPressed: canSubmit
                    ? () => widget.onSubmit(_controller.text.trim())
                    : null,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
