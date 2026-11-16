import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_interaction_dto.dart';
import 'kid_interaction_choice_body.dart';
import 'kid_interaction_feedback_bar.dart';
import 'kid_interaction_fillblank_body.dart';
import 'kid_interaction_ordering_body.dart';
import 'kid_interaction_prompt_area.dart';
import 'kid_interaction_roleplay_body.dart';
import 'kid_interaction_top_bar.dart';

typedef KidAttemptCallback = Future<ListeningAttemptResult> Function({
  int? optionId, String? answer, List<int>? orderedOptionIds,
});

class KidInteractionResult {
  const KidInteractionResult({this.resume = false, this.replaySceneIndex});
  final bool resume;
  final int? replaySceneIndex;
}

class KidInteractionScreen extends StatefulWidget {
  const KidInteractionScreen({
    super.key, required this.interaction, required this.onAttempt, required this.onPlayAudio,
  });

  final ReadingInteraction interaction;
  final KidAttemptCallback onAttempt;
  final void Function(String url) onPlayAudio;

  @override
  State<KidInteractionScreen> createState() => _KidInteractionScreenState();
}

class _KidInteractionScreenState extends State<KidInteractionScreen> {
  bool _busy = false;
  ListeningAttemptResult? _result;
  int _nonce = 0;

  String get _typeLabel => switch (widget.interaction.type) {
        'Checkpoint' => 'Đoán xem',
        'PicturePrediction' => 'Đoán tranh',
        'RolePlay' => 'Nhập vai',
        'FillBlank' => 'Điền chữ',
        'EventOrdering' => 'Xếp thứ tự',
        _ => 'Học',
      };

  TtFrogMood get _frogMood {
    final res = _result;
    if (res == null) return TtFrogMood.idle;
    final isHappy = res.matched == true || widget.interaction.type == 'RolePlay' || res.revealed;
    return isHappy ? TtFrogMood.happy : TtFrogMood.think;
  }

  Future<void> _submit({int? optionId, String? answer, List<int>? orderedOptionIds}) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final r = await widget.onAttempt(
        optionId: optionId, answer: answer, orderedOptionIds: orderedOptionIds,
      );
      if (!mounted) return;
      setState(() => _result = r);
      final audio = r.feedbackAudioUrl;
      if (audio != null && audio.isNotEmpty) widget.onPlayAudio(audio);
    } catch (_) {
      if (!mounted) return;
      showTtToast(context, 'Em thử lại nhé, máy chưa gửi được câu trả lời.', type: TtToastType.error);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  List<Widget> _buildActions(ListeningAttemptResult res) {
    if (widget.interaction.type != 'EventOrdering') return const [];
    final actions = <Widget>[];
    if (res.matched != true) {
      actions.add(TtButton(
        label: 'Xếp lại',
        variant: TtButtonVariant.secondary,
        onPressed: () => setState(() {
          _result = null;
          _busy = false;
          _nonce++;
        }),
      ));
    }
    if (res.matched == false && !res.revealed && res.replaySceneIndexes.isNotEmpty) {
      final first = res.replaySceneIndexes.first;
      actions.add(TtButton(
        label: 'Nghe lại cảnh ${first + 1}',
        variant: TtButtonVariant.secondary,
        onPressed: () => Navigator.of(context).pop(KidInteractionResult(replaySceneIndex: first)),
      ));
    }
    return actions;
  }

  Widget? _buildExtra(ListeningAttemptResult res, BuildContext context) {
    final tt = context.tt;
    final suggested = res.suggestedAnswer?.trim();
    if (suggested != null && suggested.isNotEmpty) {
      return Text(
        'Chữ cần điền là: $suggested',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700, color: tt.text,
            ),
      );
    }
    if (widget.interaction.type == 'EventOrdering' &&
        res.revealed &&
        res.correctOrderOptionIds != null &&
        res.correctOrderOptionIds!.isNotEmpty) {
      final optMap = {for (final o in widget.interaction.options) o.id: o.text};
      final texts = res.correctOrderOptionIds!.map((id) => optMap[id] ?? '').where((t) => t.isNotEmpty).toList();
      if (texts.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < texts.length; i++)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${i + 1}. ${texts[i]}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600, color: tt.text,
                      ),
                ),
              ),
          ],
        );
      }
    }
    return null;
  }

  Widget _buildBody() {
    final key = ValueKey(_nonce);
    switch (widget.interaction.type) {
      case 'Checkpoint':
      case 'PicturePrediction':
        return KidInteractionChoiceBody(
          key: key,
          interaction: widget.interaction,
          busy: _busy,
          result: _result,
          onPick: (id) => _submit(optionId: id),
          onPlayAudio: widget.onPlayAudio,
        );
      case 'RolePlay':
        return KidInteractionRolePlayBody(
          key: key,
          interaction: widget.interaction,
          busy: _busy,
          onDone: () => _submit(),
          onPlayModel: () {
            final url = widget.interaction.modelAudioUrl;
            if (url != null && url.isNotEmpty) widget.onPlayAudio(url);
          },
        );
      case 'FillBlank':
        return KidInteractionFillBlankBody(
          key: key,
          interaction: widget.interaction,
          busy: _busy,
          result: _result,
          onSubmit: (text) => _submit(answer: text),
        );
      case 'EventOrdering':
        return KidInteractionOrderingBody(
          key: key,
          interaction: widget.interaction,
          busy: _busy,
          result: _result,
          onSubmit: (ids) => _submit(orderedOptionIds: ids),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final result = _result;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.of(context).pop(const KidInteractionResult(resume: true));
        }
      },
      child: Scaffold(
        backgroundColor: tt.bg,
        body: SafeArea(
          child: Column(
            children: [
              KidInteractionTopBar(
                typeLabel: _typeLabel,
                onClose: () => Navigator.of(context).pop(const KidInteractionResult(resume: true)),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      KidInteractionPromptArea(
                        mood: _frogMood,
                        prompt: widget.interaction.prompt ?? '',
                      ),
                      const SizedBox(height: 16),
                      _buildBody(),
                    ],
                  ),
                ),
              ),
              if (result != null)
                KidInteractionFeedbackBar(
                  result: result,
                  fallbackText: (result.feedback != null && result.feedback!.isNotEmpty)
                      ? result.feedback!
                      : 'Em làm tốt lắm!',
                  onContinue: () => Navigator.of(context).pop(const KidInteractionResult(resume: true)),
                  actions: _buildActions(result),
                  extra: _buildExtra(result, context),
                ).animate().slideY(begin: 1, end: 0, duration: 300.ms, curve: Curves.easeOutCubic),
            ],
          ),
        ),
      ),
    );
  }
}
