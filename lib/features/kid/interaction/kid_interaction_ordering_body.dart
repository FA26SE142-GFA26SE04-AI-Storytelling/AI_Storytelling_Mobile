import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../models/child_interaction_dto.dart';

class KidInteractionOrderingBody extends StatefulWidget {
  const KidInteractionOrderingBody({
    super.key,
    required this.interaction,
    required this.busy,
    required this.result,
    required this.onSubmit,
  });

  final ReadingInteraction interaction;
  final bool busy;
  final ListeningAttemptResult? result;
  final void Function(List<int> orderedIds) onSubmit;

  @override
  State<KidInteractionOrderingBody> createState() =>
      _KidInteractionOrderingBodyState();
}

class _KidInteractionOrderingBodyState
    extends State<KidInteractionOrderingBody> {
  late final List<InteractionOption> _options;
  final List<int> _picked = <int>[];

  @override
  void initState() {
    super.initState();
    _options = List.of(widget.interaction.options)..shuffle(Random());
  }

  void _handleTap(int id) {
    if (widget.busy || widget.result != null) return;
    setState(() {
      if (_picked.contains(id)) {
        _picked.remove(id);
      } else {
        _picked.add(id);
      }
    });
  }

  Widget _buildCircle(bool isPicked, int orderNumber, TtColors tt) {
    if (!isPicked) {
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: tt.line2, width: 2.5),
        ),
      );
    }

    Color bgColor = tt.gold;
    Color textColor = tt.text;

    if (widget.result != null) {
      final matched = widget.result!.matched;
      if (matched == true) {
        bgColor = tt.okInk;
        textColor = Colors.white;
      } else if (matched == false) {
        bgColor = tt.danger;
        textColor = Colors.white;
      }
    }

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '$orderNumber',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildItem(int index, InteractionOption option, TtColors tt) {
    final pickedIndex = _picked.indexOf(option.id);
    final isPicked = pickedIndex != -1;
    final isLocked = widget.busy || widget.result != null;

    Color borderColor;
    if (widget.result != null) {
      if (isPicked) {
        final matched = widget.result!.matched;
        if (matched == true) {
          borderColor = tt.okInk;
        } else if (matched == false) {
          borderColor = tt.danger;
        } else {
          borderColor = tt.gold;
        }
      } else {
        borderColor = tt.line2;
      }
    } else {
      borderColor = isPicked ? tt.gold : tt.line2;
    }

    Widget card = Material(
      color: tt.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: isLocked ? null : () => _handleTap(option.id),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          constraints: const BoxConstraints(minHeight: 72),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: 2.5),
          ),
          child: Row(
            children: [
              _buildCircle(isPicked, pickedIndex + 1, tt),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  option.text,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: tt.text,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (widget.result != null && !isPicked) {
      card = Opacity(opacity: 0.5, child: card);
    }

    return card
        .animate()
        .fadeIn(delay: (index * 80).ms, duration: 300.ms)
        .slideY(begin: 0.15, end: 0, duration: 300.ms);
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final canReset =
        _picked.isNotEmpty && !widget.busy && widget.result == null;
    final canSubmit = _picked.length == _options.length &&
        !widget.busy &&
        widget.result == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.result == null) ...[
          Text(
            'Chạm lần lượt từ đầu đến cuối câu chuyện',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: tt.muted,
            ),
          ),
          const SizedBox(height: 16),
        ],
        for (int i = 0; i < _options.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          _buildItem(i, _options[i], tt),
        ],
        if (widget.result == null) ...[
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 64,
                  child: TtButton(
                    label: 'Xếp lại',
                    icon: Icons.refresh_rounded,
                    variant: TtButtonVariant.secondary,
                    expanded: true,
                    onPressed: canReset ? () => setState(_picked.clear) : null,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 64,
                  child: TtButton(
                    label: 'Xong',
                    icon: Icons.check_rounded,
                    variant: TtButtonVariant.primary,
                    expanded: true,
                    isLoading: widget.busy,
                    onPressed: canSubmit
                        ? () => widget.onSubmit(List.of(_picked))
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
