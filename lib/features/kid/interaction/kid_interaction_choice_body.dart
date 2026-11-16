import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../models/child_interaction_dto.dart';

class KidInteractionChoiceBody extends StatefulWidget {
  const KidInteractionChoiceBody({
    super.key,
    required this.interaction,
    required this.busy,
    required this.result,
    required this.onPick,
    this.onPlayAudio,
  });

  final ReadingInteraction interaction;
  final bool busy;
  final ListeningAttemptResult? result;
  final void Function(int optionId) onPick;
  final void Function(String url)? onPlayAudio;

  @override
  State<KidInteractionChoiceBody> createState() =>
      _KidInteractionChoiceBodyState();
}

class _KidInteractionChoiceBodyState extends State<KidInteractionChoiceBody> {
  late final List<InteractionOption> _options;
  int? _pickedId;

  @override
  void initState() {
    super.initState();
    _options = List.of(widget.interaction.options)..shuffle(Random());
  }

  void _handleTap(InteractionOption option) {
    if (widget.busy || widget.result != null) return;
    setState(() => _pickedId = option.id);
    final audio = option.audioUrl;
    if (audio != null && audio.isNotEmpty && widget.onPlayAudio != null) {
      widget.onPlayAudio!(audio);
    }
    widget.onPick(option.id);
  }

  (Color, Color) _colors(bool isPicked, bool hasResult, TtColors tt) {
    if (isPicked && hasResult) {
      final matched = widget.result!.matched;
      if (matched == true) {
        return (tt.okInk.withValues(alpha: 0.15), tt.okInk);
      }
      if (matched == false) {
        return (tt.danger.withValues(alpha: 0.12), tt.danger);
      }
      return (tt.surface, tt.gold);
    }
    return (tt.surface, tt.line);
  }

  Widget _buildCircle(int index, bool isPicked, TtColors tt) {
    if (isPicked && widget.busy) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: tt.surface2, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 3, color: tt.text),
        ),
      );
    }
    if (isPicked && widget.result != null) {
      final matched = widget.result!.matched;
      if (matched == true) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: tt.okInk, shape: BoxShape.circle),
          child: const Icon(Icons.check_rounded, color: Colors.white, size: 26),
        );
      }
      if (matched == false) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: tt.danger, shape: BoxShape.circle),
          child: const Icon(Icons.close_rounded, color: Colors.white, size: 26),
        );
      }
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: tt.surface,
          border: Border.all(color: tt.gold, width: 3),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.star_rounded, color: tt.goldDeep, size: 28),
      );
    }
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: tt.surface2,
        border: Border.all(color: tt.line, width: 2),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '${index + 1}',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: tt.text,
        ),
      ),
    );
  }

  Widget _wrapAnimation(Widget card, int index, bool isPicked) {
    if (isPicked && widget.result?.matched == true) {
      card = card
          .animate()
          .scale(
            begin: const Offset(1, 1),
            end: const Offset(1.04, 1.04),
            duration: 150.ms,
          )
          .then()
          .scale(
            begin: const Offset(1.04, 1.04),
            end: const Offset(1, 1),
            duration: 150.ms,
          );
    }
    return card
        .animate()
        .fadeIn(delay: (index * 80).ms, duration: 300.ms)
        .slideY(begin: 0.15, end: 0, duration: 300.ms);
  }

  Widget _buildCheckpointItem(int index, InteractionOption option, TtColors tt) {
    final isPicked = _pickedId == option.id;
    final hasResult = widget.result != null;
    final (bg, border) = _colors(isPicked, hasResult, tt);

    Widget card = Material(
      color: bg,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => _handleTap(option),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          constraints: const BoxConstraints(minHeight: 72),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: border,
              width: (isPicked && hasResult) ? 3 : 2.5,
            ),
          ),
          child: Row(
            children: [
              _buildCircle(index, isPicked, tt),
              const SizedBox(width: 14),
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

    if (hasResult && !isPicked) card = Opacity(opacity: 0.4, child: card);
    return _wrapAnimation(card, index, isPicked);
  }

  Widget _buildPictureItem(int index, InteractionOption option, TtColors tt) {
    final isPicked = _pickedId == option.id;
    final hasResult = widget.result != null;
    final (bg, border) = _colors(isPicked, hasResult, tt);

    Widget card = Material(
      color: bg,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => _handleTap(option),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: border, width: 3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: TtNetworkImage(
                        url: option.imageUrl,
                        fit: BoxFit.cover,
                        radius: BorderRadius.circular(14),
                      ),
                    ),
                    Positioned(
                      top: 6,
                      left: 6,
                      child: _buildCircle(index, isPicked, tt),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                option.text,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: tt.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (hasResult && !isPicked) card = Opacity(opacity: 0.4, child: card);
    return _wrapAnimation(card, index, isPicked);
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final isPicture = widget.interaction.type == 'PicturePrediction';

    return IgnorePointer(
      ignoring: widget.busy || widget.result != null,
      child: isPicture
          ? GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: _options.length,
              itemBuilder: (context, i) =>
                  _buildPictureItem(i, _options[i], tt),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int i = 0; i < _options.length; i++) ...[
                  if (i > 0) const SizedBox(height: 12),
                  _buildCheckpointItem(i, _options[i], tt),
                ],
              ],
            ),
    );
  }
}
