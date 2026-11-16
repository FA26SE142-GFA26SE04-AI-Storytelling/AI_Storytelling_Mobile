import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_confirm_dialog.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_profile_dto.dart';
import '../../../models/parent_reading_feedback_dto.dart';
import '../../../models/parent_story_summary_dto.dart';
import '../data/learning_repository.dart';
import 'learning_providers.dart';
import 'learning_widgets.dart';
import 'summary_audio.dart';

/// Hai phần của tab Kết quả đọc.
enum ResultsView { readings, summaries }

/// Tab "Kết quả đọc": truyện bé đã đọc xong và phần bé kể lại (như web).
class LearningResultsTab extends ConsumerWidget {
  const LearningResultsTab({
    super.key,
    required this.child,
    required this.view,
    required this.onView,
    required this.audio,
  });

  final ChildProfileDto child;
  final ResultsView view;
  final ValueChanged<ResultsView> onView;
  final SummaryAudio audio;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readings = view == ResultsView.readings;
    final async = readings
        ? ref.watch(readingFeedbackProvider(child.id))
        : ref.watch(storySummariesProvider(child.id));

    Future<void> refresh() async {
      try {
        if (readings) {
          ref.invalidate(readingFeedbackProvider(child.id));
          await ref.read(readingFeedbackProvider(child.id).future);
        } else {
          await audio.stop();
          ref.invalidate(storySummariesProvider(child.id));
          await ref.read(storySummariesProvider(child.id).future);
        }
      } catch (_) {
        // Lỗi đã hiện bằng trạng thái lỗi của tab.
      }
    }

    final switcher = SegmentedButton<ResultsView>(
      showSelectedIcon: false,
      segments: const [
        ButtonSegment(
          value: ResultsView.readings,
          icon: Icon(Icons.menu_book_rounded),
          label: Text('Đã đọc xong'),
        ),
        ButtonSegment(
          value: ResultsView.summaries,
          icon: Icon(Icons.mic_rounded),
          label: Text('Bé kể lại'),
        ),
      ],
      selected: {view},
      onSelectionChanged: (s) => onView(s.first),
    );

    final List<Widget> body;
    if (async.hasError && !async.hasValue) {
      body = [
        learningError(
          async.error,
          () => readings
              ? ref.invalidate(readingFeedbackProvider(child.id))
              : ref.invalidate(storySummariesProvider(child.id)),
          title: readings
              ? 'Chưa tải được truyện bé đã đọc'
              : 'Chưa tải được phần bé kể lại',
        ),
      ];
    } else if (!async.hasValue) {
      body = learningSkeleton();
    } else if (readings) {
      final page = async.value! as PagedItems<ParentReadingFeedbackItemDto>;
      body = page.items.isEmpty
          ? [LearningEmpty(title: '${child.nickname} chưa đọc xong truyện nào')]
          : [
              for (final i in page.items)
                _ReadingCard(key: ValueKey('reading-${i.sessionId}'), item: i),
              if (page.hasNext)
                LoadMoreTile(
                  key: ValueKey('more-${page.page}'),
                  onLoadMore: () => ref
                      .read(readingFeedbackProvider(child.id).notifier)
                      .loadMore(),
                ),
            ];
    } else {
      final page = async.value! as PagedItems<ParentStorySummaryItemDto>;
      body = page.items.isEmpty
          ? [const LearningEmpty(title: 'Chưa có phần kể lại nào')]
          : [
              for (final s in page.items)
                _SummaryCard(
                  key: ValueKey('summary-${s.summaryId}'),
                  child: child,
                  summary: s,
                  audio: audio,
                ),
              if (page.hasNext)
                LoadMoreTile(
                  key: ValueKey('more-${page.page}'),
                  onLoadMore: () => ref
                      .read(storySummariesProvider(child.id).notifier)
                      .loadMore(),
                ),
            ];
    }

    return LearningTabList(
      onRefresh: refresh,
      children: [switcher, ...body],
    );
  }
}

/// Một truyện bé đã đọc xong; mở ra để xem câu bé trả lời ở các điểm dừng.
class _ReadingCard extends StatefulWidget {
  const _ReadingCard({super.key, required this.item});

  final ParentReadingFeedbackItemDto item;

  @override
  State<_ReadingCard> createState() => _ReadingCardState();
}

class _ReadingCardState extends State<_ReadingCard> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final item = widget.item;
    final answers = item.conversationAnswers;

    return TtCard(
      onTap: answers.isEmpty ? null : () => setState(() => _open = !_open),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              StoryCover(storyId: item.storyId, width: 40, height: 54),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall,
                ),
              ),
              if (answers.isNotEmpty)
                AnimatedRotation(
                  turns: _open ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(Icons.expand_more_rounded, color: tt.muted),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...feedbackChips(context, item),
              if (answers.isNotEmpty)
                LearningChip(
                  label: 'Bé trả lời ${answers.length}',
                  color: tt.okInk,
                  icon: Icons.forum_rounded,
                ),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: !_open
                ? const SizedBox(width: double.infinity)
                : Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final a in answers)
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: tt.surface.withValues(alpha: 0.7),
                              borderRadius:
                                  BorderRadius.circular(TtRadius.md),
                              border: Border.all(color: tt.line),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  a.sceneIndex != null
                                      ? 'Cảnh ${a.sceneIndex! + 1} · ${a.question}'
                                      : a.question,
                                  style: textTheme.bodyMedium
                                      ?.copyWith(color: tt.muted),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '“${a.answerText}”',
                                  style: textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Phần bé kể lại: nghe bản ghi âm ngay trong dòng, xem cảnh bé còn thắc mắc, xoá.
class _SummaryCard extends ConsumerStatefulWidget {
  const _SummaryCard({
    super.key,
    required this.child,
    required this.summary,
    required this.audio,
  });

  final ChildProfileDto child;
  final ParentStorySummaryItemDto summary;
  final SummaryAudio audio;

  @override
  ConsumerState<_SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends ConsumerState<_SummaryCard> {
  bool _busy = false;

  Future<void> _toggle(String url) async {
    final ok = await widget.audio.toggle(widget.summary.summaryId, url);
    if (!ok && mounted) {
      showTtToast(
        context,
        'Chưa phát được bản ghi âm. Kéo xuống để tải lại rồi thử lại.',
        type: TtToastType.error,
      );
    }
  }

  Future<void> _delete() async {
    final s = widget.summary;
    final confirmed = await showConfirmDialog(
      context,
      title: 'Xoá phần kể lại?',
      message:
          'Phần ${widget.child.nickname} kể lại về “${s.title}” và bản ghi âm sẽ bị xoá, không khôi phục được.',
      confirmLabel: 'Xoá',
      destructive: true,
    );
    if (!confirmed || !mounted) return;
    setState(() => _busy = true);
    try {
      if (widget.audio.currentId == s.summaryId) await widget.audio.stop();
      await ref
          .read(learningRepositoryProvider)
          .deleteSummary(widget.child.id, s.summaryId);
      if (!mounted) return;
      showTtToast(context, 'Đã xoá phần kể lại.', type: TtToastType.success);
      ref.invalidate(storySummariesProvider(widget.child.id));
    } catch (e) {
      if (!mounted) return;
      setState(() => _busy = false);
      showTtToast(
        context,
        e is ApiException ? e.message : 'Chưa xoá được phần kể lại.',
        type: TtToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final s = widget.summary;
    final url = s.recordingUrl?.trim();

    return TtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  s.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall,
                ),
              ),
              const SizedBox(width: 8),
              TtIconButton(
                icon: Icons.delete_outline_rounded,
                tooltip: 'Xoá phần kể lại',
                size: 40,
                onPressed: _busy ? null : _delete,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              if (url != null && url.isNotEmpty)
                ListenableBuilder(
                  listenable: widget.audio,
                  builder: (context, _) {
                    final playing = widget.audio.isPlaying(s.summaryId);
                    return IconButton.filled(
                      tooltip: playing ? 'Tạm dừng' : 'Nghe bé kể lại',
                      onPressed: () => _toggle(url),
                      style: IconButton.styleFrom(
                        backgroundColor: tt.gold,
                        foregroundColor: tt.text,
                        side: BorderSide(color: tt.goldDeep, width: 1.5),
                      ),
                      icon: Icon(
                        playing
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                      ),
                    );
                  },
                )
              else
                Icon(Icons.mic_off_rounded, color: tt.muted),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  url != null && url.isNotEmpty
                      ? 'Bản ghi âm'
                      : '${widget.child.nickname} chưa ghi âm',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: url != null && url.isNotEmpty ? tt.text : tt.muted,
                  ),
                ),
              ),
              LearningChip(
                label: learningDate(s.createdAt),
                color: tt.muted,
                icon: Icons.event_rounded,
              ),
            ],
          ),
          if (s.flags.isNotEmpty) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(Icons.help_outline_rounded, size: 18, color: tt.goldDeep),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Chỗ ${widget.child.nickname} còn thắc mắc',
                    style: textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            for (final f in s.flags) _FlagRow(flag: f),
          ],
        ],
      ),
    );
  }
}

/// Một cảnh bé còn thắc mắc: ảnh nhỏ + chữ rút gọn, bấm để xem hết.
class _FlagRow extends StatefulWidget {
  const _FlagRow({required this.flag});

  final ParentStorySummaryFlagDto flag;

  @override
  State<_FlagRow> createState() => _FlagRowState();
}

class _FlagRowState extends State<_FlagRow> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final f = widget.flag;
    return InkWell(
      borderRadius: BorderRadius.circular(TtRadius.md),
      onTap: () => setState(() => _open = !_open),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TtNetworkImage(
              url: f.illustrationUrl,
              width: 64,
              height: 64,
              radius: const BorderRadius.all(Radius.circular(TtRadius.sm)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LearningChip(
                    label: 'Cảnh ${f.sceneIndex + 1}',
                    color: tt.goldDeep,
                    fill: tt.gold,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    f.sceneText,
                    maxLines: _open ? null : 2,
                    overflow:
                        _open ? TextOverflow.visible : TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
