import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_profile_dto.dart';
import '../../../models/parent_reading_feedback_dto.dart';
import 'learning_providers.dart';
import 'learning_summary_card.dart';
import 'learning_widgets.dart';
import 'summary_audio.dart';

/// Chi tiết một lần đọc (như SessionDialog của web): tóm tắt, cảm nhận, đọc to,
/// câu đố, từ mới, câu bé trả lời và phần bé kể lại.
Future<void> showSessionSheet(
  BuildContext context, {
  required ChildProfileDto child,
  required ParentReadingFeedbackItemDto item,
  required String title,
  required int ordinal,
  required SummaryAudio audio,
}) {
  return showLearningSheet(
    context,
    title: '$title · Lần $ordinal',
    initialSize: 0.9,
    builder: (controller) => _SessionBody(
      controller: controller,
      child: child,
      item: item,
      audio: audio,
    ),
  ).whenComplete(audio.stop);
}

class _SessionBody extends StatelessWidget {
  const _SessionBody({
    required this.controller,
    required this.child,
    required this.item,
    required this.audio,
  });

  final ScrollController controller;
  final ChildProfileDto child;
  final ParentReadingFeedbackItemDto item;
  final SummaryAudio audio;

  @override
  Widget build(BuildContext context) {
    final parts = <Widget>[
      _SummaryPart(item: item),
      if (item.reflection != null ||
          item.emotions.isNotEmpty ||
          item.feeling != null)
        _Part(
          icon: Icons.favorite_rounded,
          title: 'Cảm nhận',
          child: _FeelingPart(child: child, item: item, audio: audio),
        ),
      if (item.readAloud != null ||
          item.readAloudPractice != null ||
          item.readAloudRecordingCount > 0)
        _Part(
          icon: Icons.mic_rounded,
          title: 'Đọc to',
          child: _ReadAloudPart(item: item),
        ),
      if (item.quizTotalQuestions > 0)
        _Part(
          icon: Icons.quiz_rounded,
          title: 'Câu đố',
          child: _QuizPart(item: item),
        ),
      if (item.wordsCollected.isNotEmpty)
        _Part(
          icon: Icons.bookmarks_rounded,
          title: 'Từ mới',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final w in item.wordsCollected)
                LearningChip(label: w.term, color: context.tt.primaryStrong),
            ],
          ),
        ),
      if (item.conversationAnswers.isNotEmpty)
        _Part(
          icon: Icons.forum_rounded,
          title: 'Bé trả lời',
          child: _AnswersPart(answers: item.conversationAnswers),
        ),
      if (item.retell != null)
        _RetellPart(child: child, item: item, audio: audio),
    ];

    return ListView.separated(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: parts.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, i) => parts[i]
          .animate(delay: (50 * (i < 6 ? i : 6)).ms)
          .fadeIn(duration: 260.ms)
          .slideY(begin: 0.04, end: 0, duration: 260.ms),
    );
  }
}

/// Một mục có icon + tiêu đề; [framed] false thì nội dung tự có khung (vd thẻ kể lại).
class _Part extends StatelessWidget {
  const _Part({
    required this.icon,
    required this.title,
    required this.child,
    this.framed = true,
  });

  final IconData icon;
  final String title;
  final Widget child;
  final bool framed;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: tt.goldDeep),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (framed)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: tt.panel.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(TtRadius.md),
              border: Border.all(color: tt.line2, width: 1.5),
            ),
            child: child,
          )
        else
          child,
      ],
    );
  }
}

/// Thanh tiến độ vàng có nhãn bên phải.
class _Bar extends StatelessWidget {
  const _Bar({required this.value, this.label});

  final double value;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(TtRadius.full),
            child: LinearProgressIndicator(
              value: value.clamp(0, 1),
              minHeight: 10,
              backgroundColor: tt.surface2,
              valueColor: AlwaysStoppedAnimation(tt.gold),
            ),
          ),
        ),
        if (label != null) ...[
          const SizedBox(width: 10),
          Text(label!, style: Theme.of(context).textTheme.titleSmall),
        ],
      ],
    );
  }
}

class _SummaryPart extends StatelessWidget {
  const _SummaryPart({required this.item});

  final ParentReadingFeedbackItemDto item;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final secs = item.timeSpentSeconds;
    final timeText = secs < 60
        ? '$secs giây'
        : '${(secs / 60).round().clamp(1, 1 << 30)} phút';
    final ordinal = item.readOrdinal;
    final done = item.status == null || item.status == 'Completed';
    final stopped = item.status == 'Abandoned' || item.status == 'ForceExited';

    return _Part(
      icon: Icons.menu_book_rounded,
      title: 'Tóm tắt',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              LearningChip(
                label: timeText,
                color: tt.muted,
                icon: Icons.schedule_rounded,
              ),
              if (item.totalPages > 0)
                LearningChip(
                  label: '${item.pagesCompleted}/${item.totalPages} trang',
                  color: tt.muted,
                  icon: Icons.description_outlined,
                ),
              if (ordinal != null && ordinal >= 2)
                LearningChip(
                  label: 'Lần $ordinal',
                  color: tt.muted,
                  icon: Icons.repeat_rounded,
                ),
              if (item.expEarned > 0)
                LearningChip(
                  label: '+${item.expEarned} EXP',
                  color: tt.goldDeep,
                  fill: tt.gold,
                  icon: Icons.auto_awesome_rounded,
                ),
              if (item.readingMode == 'ListenFirst')
                LearningChip(
                  label: 'Nghe là chính',
                  color: tt.muted,
                  icon: Icons.headphones_rounded,
                ),
              if (item.readingMode == 'ReadFirst')
                LearningChip(
                  label: 'Tự đọc',
                  color: tt.muted,
                  icon: Icons.menu_book_rounded,
                ),
              LearningChip(
                label: learningShortDate(item.completedAt ?? item.startedAt),
                color: tt.muted,
                icon: Icons.event_rounded,
              ),
            ],
          ),
          if (!done) ...[
            if (item.totalPages > 0) ...[
              const SizedBox(height: 12),
              _Bar(
                value: item.pagesCompleted / item.totalPages,
                label: '${item.pagesCompleted}/${item.totalPages}',
              ),
            ],
            if (item.laterCompleted || stopped) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (item.laterCompleted)
                    LearningChip(label: 'Đã đọc xong sau đó', color: tt.okInk),
                  if (stopped)
                    LearningChip(label: 'Đã dừng giữa chừng', color: tt.danger),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }
}

/// Tiêu đề nhỏ trong một mục (icon + chữ).
class _Sub extends StatelessWidget {
  const _Sub(this.icon, this.label);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: context.tt.goldDeep),
        const SizedBox(width: 6),
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.titleSmall),
        ),
      ],
    );
  }
}

class _FeelingPart extends ConsumerWidget {
  const _FeelingPart({
    required this.child,
    required this.item,
    required this.audio,
  });

  final ChildProfileDto child;
  final ParentReadingFeedbackItemDto item;
  final SummaryAudio audio;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final key = (childId: child.id, sessionId: item.sessionId);
    final async = ref.watch(storyReflectionProvider(key));
    final feeling = feelingChip(context, item);

    final Widget body;
    if (async.hasError && !async.hasValue) {
      body = LearningInlineError(
        error: async.error,
        onRetry: () => ref.invalidate(storyReflectionProvider(key)),
      );
    } else if (!async.hasValue) {
      body = const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Center(
          child: SizedBox.square(
            dimension: 24,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
        ),
      );
    } else {
      final r = async.value!;
      final scene = r.favoriteScene;
      final text = r.noteText?.trim() ?? '';
      final audioUrl = r.noteAudioUrl?.trim() ?? '';
      if (r.emotions.isEmpty &&
          scene == null &&
          text.isEmpty &&
          audioUrl.isEmpty) {
        body = Text(
          '${child.nickname} chưa gửi cảm nhận.',
          style: textTheme.bodyMedium?.copyWith(color: tt.muted),
        );
      } else {
        body = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (r.emotions.isNotEmpty) ...[
              const _Sub(Icons.emoji_emotions_rounded, 'Cảm xúc'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final e in r.emotions)
                    LearningChip(
                      label: '${emotionFace[e.code] ?? ''} ${e.label}'.trim(),
                      color: tt.warnInk,
                    ),
                ],
              ),
              const SizedBox(height: 14),
            ],
            if (scene != null) ...[
              const _Sub(Icons.star_rounded, 'Cảnh thích nhất'),
              const SizedBox(height: 8),
              _SceneRow(scene: scene),
              const SizedBox(height: 14),
            ],
            if (text.isNotEmpty || audioUrl.isNotEmpty) ...[
              _Sub(Icons.favorite_rounded, 'Lời ${child.nickname} viết'),
              const SizedBox(height: 8),
              if (text.isNotEmpty) Text('“$text”', style: textTheme.titleSmall),
              if (audioUrl.isNotEmpty)
                Row(
                  children: [
                    LearningPlayButton(
                      audio: audio,
                      // Số âm để không trùng mã phần kể lại.
                      id: -item.sessionId,
                      url: audioUrl,
                      tooltip: 'Nghe lời bé',
                      onFailed: () {
                        // Link nghe hết hạn sau 15 phút: lấy link mới.
                        ref.invalidate(storyReflectionProvider(key));
                        showTtToast(
                          context,
                          'Chưa phát được bản ghi âm. Đã tải lại, hãy bấm nghe lần nữa.',
                          type: TtToastType.error,
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    Text('Bản ghi âm', style: textTheme.bodyMedium),
                  ],
                ),
            ],
          ],
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (feeling != null) ...[
          Align(alignment: Alignment.centerLeft, child: feeling),
          const SizedBox(height: 12),
        ],
        body,
      ],
    );
  }
}

/// Cảnh bé thích nhất: ảnh + chữ rút gọn, bấm để xem hết.
class _SceneRow extends StatefulWidget {
  const _SceneRow({required this.scene});

  final ParentFavoriteSceneDto scene;

  @override
  State<_SceneRow> createState() => _SceneRowState();
}

class _SceneRowState extends State<_SceneRow> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final s = widget.scene;
    return InkWell(
      borderRadius: BorderRadius.circular(TtRadius.md),
      onTap: () => setState(() => _open = !_open),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TtNetworkImage(
            url: s.illustrationUrl,
            width: 72,
            height: 72,
            radius: const BorderRadius.all(Radius.circular(TtRadius.sm)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LearningChip(
                  label: 'Cảnh ${s.sceneIndex + 1}',
                  color: tt.goldDeep,
                  fill: tt.gold,
                ),
                const SizedBox(height: 4),
                Text(
                  s.sceneText,
                  maxLines: _open ? null : 3,
                  overflow: _open
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadAloudPart extends StatelessWidget {
  const _ReadAloudPart({required this.item});

  final ParentReadingFeedbackItemDto item;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final ra = item.readAloud;
    final pr = item.readAloudPractice;
    final rec = item.readAloudRecordingCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (ra != null) ...[
          Text(
            '${ra.segmentsPracticed} đoạn · ${ra.attempts} lần thử',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          _Bar(
            value: ra.goodPercent / 100,
            label: '${ra.goodPercent.round()}% chữ đọc tốt',
          ),
          const SizedBox(height: 8),
          LearningChip(
            label: '${ra.retryWords} chữ cần đọc lại',
            color: tt.warnInk,
          ),
        ],
        if (ra != null && (pr != null || rec > 0)) const SizedBox(height: 12),
        if (pr != null || rec > 0)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (pr != null) ...[
                LearningChip(
                  label: 'Luyện đọc · ${pr.attempts} lần',
                  color: tt.muted,
                ),
                LearningChip(
                  label: 'Gần nhất ${pr.latestGoodPercent.round()}%',
                  color: tt.warnInk,
                ),
                LearningChip(
                  label: 'Tốt nhất ${pr.bestGoodPercent.round()}%',
                  color: tt.goldDeep,
                  fill: tt.gold,
                ),
              ],
              if (rec > 0)
                LearningChip(
                  label: '$rec bản ghi',
                  color: tt.muted,
                  icon: Icons.mic_rounded,
                ),
            ],
          ),
      ],
    );
  }
}

class _QuizPart extends StatelessWidget {
  const _QuizPart({required this.item});

  final ParentReadingFeedbackItemDto item;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    if (item.quizRunCount == 0) {
      return Text(
        'Bé chưa làm câu đố',
        style: textTheme.bodyMedium?.copyWith(color: tt.muted),
      );
    }
    final latest = item.quizLatestPercent?.round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('${item.quizRunCount} lần làm', style: textTheme.bodyMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ?quizChip(context, item),
            if (latest != null)
              LearningChip(
                label: 'Gần nhất $latest%',
                color: latest >= 80
                    ? tt.okInk
                    : latest >= 50
                    ? tt.warnInk
                    : tt.danger,
              ),
          ],
        ),
      ],
    );
  }
}

class _AnswersPart extends StatelessWidget {
  const _AnswersPart({required this.answers});

  final List<ConversationAnswerDto> answers;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < answers.length; i++)
          Container(
            margin: EdgeInsets.only(bottom: i == answers.length - 1 ? 0 : 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tt.surface.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(TtRadius.md),
              border: Border.all(color: tt.line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  answers[i].sceneIndex != null
                      ? 'Cảnh ${answers[i].sceneIndex! + 1} · ${answers[i].question}'
                      : answers[i].question,
                  style: textTheme.bodyMedium?.copyWith(color: tt.muted),
                ),
                const SizedBox(height: 4),
                Text('“${answers[i].answerText}”', style: textTheme.titleSmall),
              ],
            ),
          ),
      ],
    );
  }
}

/// Phần bé kể lại của lần đọc: tìm theo mã; không tìm được thì chỉ hiện chip tóm tắt.
class _RetellPart extends ConsumerStatefulWidget {
  const _RetellPart({
    required this.child,
    required this.item,
    required this.audio,
  });

  final ChildProfileDto child;
  final ParentReadingFeedbackItemDto item;
  final SummaryAudio audio;

  @override
  ConsumerState<_RetellPart> createState() => _RetellPartState();
}

class _RetellPartState extends ConsumerState<_RetellPart> {
  bool _removed = false;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final retell = widget.item.retell!;
    if (_removed) return const SizedBox.shrink();

    final async = ref.watch(
      storySummaryByIdProvider((
        childId: widget.child.id,
        summaryId: retell.summaryId,
      )),
    );

    if (async.isLoading && !async.hasValue) {
      return const _Part(
        icon: Icons.record_voice_over_rounded,
        title: 'Kể lại',
        child: Center(
          child: SizedBox.square(
            dimension: 24,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
        ),
      );
    }

    final summary = async.value;
    if (summary == null) {
      return _Part(
        icon: Icons.record_voice_over_rounded,
        title: 'Kể lại',
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            retell.hasRecording
                ? LearningChip(label: 'Có ghi âm', color: tt.okInk)
                : LearningChip(label: 'Chưa ghi âm', color: tt.muted),
            if (retell.flagCount > 0)
              LearningChip(
                label: '${retell.flagCount} câu hỏi',
                color: tt.muted,
              ),
            if (retell.unansweredCount > 0)
              LearningChip(
                label: '${retell.unansweredCount} chưa trả lời',
                color: tt.warnInk,
              ),
          ],
        ),
      );
    }

    return _Part(
      icon: Icons.record_voice_over_rounded,
      title: 'Kể lại',
      framed: false,
      child: LearningSummaryCard(
        key: ValueKey('retell-${summary.summaryId}'),
        child: widget.child,
        summary: summary,
        audio: widget.audio,
        onDeleted: () => setState(() => _removed = true),
      ),
    );
  }
}
