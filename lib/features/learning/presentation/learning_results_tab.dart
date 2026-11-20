import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../models/child_profile_dto.dart';
import '../../../models/parent_reading_feedback_dto.dart';
import 'learning_providers.dart';
import 'learning_session_sheet.dart';
import 'learning_widgets.dart';
import 'summary_audio.dart';

/// Tab "Kết quả đọc" (như web): lưới truyện bé đã đọc, mỗi ô gộp các lần đọc
/// cùng một truyện; bấm để xem từng lần đọc và chi tiết.
class LearningResultsTab extends ConsumerWidget {
  const LearningResultsTab({
    super.key,
    required this.child,
    required this.audio,
  });

  final ChildProfileDto child;
  final SummaryAudio audio;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(readingFeedbackProvider(child.id));

    Future<void> refresh() async {
      try {
        ref.invalidate(readingFeedbackProvider(child.id));
        await ref.read(readingFeedbackProvider(child.id).future);
      } catch (_) {
        // Lỗi đã hiện bằng trạng thái lỗi của tab.
      }
    }

    final List<Widget> body;
    if (async.hasError && !async.hasValue) {
      body = [
        learningError(
          async.error,
          () => ref.invalidate(readingFeedbackProvider(child.id)),
          title: 'Chưa tải được truyện bé đã đọc',
        ),
      ];
    } else if (!async.hasValue) {
      body = learningSkeleton();
    } else {
      final page = async.value!;
      body = page.items.isEmpty
          ? [LearningEmpty(title: '${child.nickname} chưa đọc xong truyện nào')]
          : [
              _StoryGrid(
                child: child,
                groups: groupByStory(page.items),
                audio: audio,
              ),
              if (page.hasNext)
                LoadMoreTile(
                  key: ValueKey('more-${page.page}'),
                  onLoadMore: () => ref
                      .read(readingFeedbackProvider(child.id).notifier)
                      .loadMore(),
                ),
            ];
    }

    return LearningTabList(onRefresh: refresh, children: body);
  }
}

/// Gộp các lần đọc theo truyện, giữ thứ tự truyện xuất hiện (mới nhất trước).
List<List<ParentReadingFeedbackItemDto>> groupByStory(
  List<ParentReadingFeedbackItemDto> items,
) {
  final groups = <int, List<ParentReadingFeedbackItemDto>>{};
  for (final i in items) {
    (groups[i.storyId] ??= []).add(i);
  }
  return groups.values.toList();
}

/// Lưới ô truyện: 2 cột < 600px, 3 cột ≥ 600, 4 cột ≥ 900; ô cùng hàng cao bằng nhau.
class _StoryGrid extends StatelessWidget {
  const _StoryGrid({
    required this.child,
    required this.groups,
    required this.audio,
  });

  final ChildProfileDto child;
  final List<List<ParentReadingFeedbackItemDto>> groups;
  final SummaryAudio audio;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        const gap = 12.0;
        final cols = c.maxWidth >= 900 ? 4 : (c.maxWidth >= 600 ? 3 : 2);
        final cellW = (c.maxWidth - gap * (cols - 1)) / cols;
        final rows = <Widget>[];
        for (var start = 0; start < groups.length; start += cols) {
          final end = start + cols < groups.length
              ? start + cols
              : groups.length;
          rows.add(
            // Chiều cao hàng = ô cao nhất; ô thấp hơn giãn ra bằng nó.
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var k = 0; k < cols; k++) ...[
                    if (k > 0) const SizedBox(width: gap),
                    Expanded(
                      child: start + k < end
                          ? _StoryTile(
                              key: ValueKey(
                                'story-${groups[start + k][0].storyId}',
                              ),
                              child: child,
                              items: groups[start + k],
                              width: cellW,
                              audio: audio,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ],
              ),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < rows.length; i++) ...[
              if (i > 0) const SizedBox(height: gap),
              rows[i],
            ],
          ],
        );
      },
    );
  }
}

/// Một ô truyện: bìa, tên, mức thích / câu đố của lần gần nhất và nút xem các lần đọc.
class _StoryTile extends StatelessWidget {
  const _StoryTile({
    super.key,
    required this.child,
    required this.items,
    required this.width,
    required this.audio,
  });

  final ChildProfileDto child;
  final List<ParentReadingFeedbackItemDto> items;
  final double width;
  final SummaryAudio audio;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final latest = items.first;
    final coverW = (width - 24 - 3).clamp(60.0, 110.0);
    final titleStyle = textTheme.titleSmall;
    // Giữ chỗ đúng 2 dòng tên để các ô cùng hàng thẳng hàng.
    final lineH = MediaQuery.textScalerOf(context)
        .scale((titleStyle?.fontSize ?? 15) * (titleStyle?.height ?? 1.3));

    void open() =>
        showRunsSheet(context, child: child, items: items, audio: audio);

    return TtCard(
      padding: const EdgeInsets.all(12),
      onTap: open,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            // Khung cố định 3:4 để ô tính được chiều cao mà không cần đo bìa.
            child: SizedBox(
              width: coverW,
              height: coverW * 4 / 3,
              child: StoryCover(
                storyId: latest.storyId,
                width: coverW,
                height: coverW * 4 / 3,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: lineH * 2 + 2,
            child: Text(
              latest.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: titleStyle,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: feedbackChips(context, latest, withDate: false),
          ),
          const SizedBox(height: 8),
          Text(
            'Lần gần nhất ${learningShortDate(latest.completedAt ?? latest.startedAt)}',
            style: textTheme.bodyMedium?.copyWith(color: tt.muted),
          ),
          const Spacer(),
          const SizedBox(height: 10),
          TtButton(
            label: '${items.length} lần đọc',
            icon: Icons.history_rounded,
            variant: TtButtonVariant.secondary,
            expanded: true,
            onPressed: open,
          ),
        ],
      ),
    );
  }
}

/// Bảng liệt kê các lần đọc của một truyện; bấm một lần để xem chi tiết.
Future<void> showRunsSheet(
  BuildContext context, {
  required ChildProfileDto child,
  required List<ParentReadingFeedbackItemDto> items,
  required SummaryAudio audio,
}) {
  final title = items.first.title;
  return showLearningSheet(
    context,
    title: title,
    initialSize: 0.6,
    builder: (controller) => ListView.separated(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, idx) {
        final i = items[idx];
        final ordinal = i.readOrdinal ?? (items.length - idx);
        return _RunRow(
              item: i,
              ordinal: ordinal,
              onTap: () => showSessionSheet(
                context,
                child: child,
                item: i,
                title: title,
                ordinal: ordinal,
                audio: audio,
              ),
            )
            .animate(delay: (40 * (idx < 8 ? idx : 8)).ms)
            .fadeIn(duration: 260.ms)
            .slideX(begin: 0.06, end: 0, duration: 260.ms);
      },
    ),
  );
}

class _RunRow extends StatelessWidget {
  const _RunRow({
    required this.item,
    required this.ordinal,
    required this.onTap,
  });

  final ParentReadingFeedbackItemDto item;
  final int ordinal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final quiz = quizChip(context, item);
    final unfinished = item.status != null && item.status != 'Completed';
    final radius = BorderRadius.circular(TtRadius.md);
    return Material(
      color: tt.panel.withValues(alpha: 0.7),
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: tt.line2, width: 1.5),
      ),
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lần $ordinal · ${learningShortDate(item.completedAt ?? item.startedAt)}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    if (quiz != null || unfinished) ...[
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          ?quiz,
                          if (unfinished)
                            LearningChip(
                              label:
                                  'Dừng ở ${item.pagesCompleted}/${item.totalPages} trang',
                              color: tt.warnInk,
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: tt.muted),
            ],
          ),
        ),
      ),
    );
  }
}
