import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../models/child_profile_dto.dart';
import 'learning_providers.dart';
import 'learning_roadmap_tab.dart';
import 'learning_widgets.dart';

/// Tab "Tổng quan" (như web): 4 ô số liệu, truyện đang đọc, truyện mới đọc xong.
class LearningOverviewTab extends ConsumerWidget {
  const LearningOverviewTab({
    super.key,
    required this.child,
    required this.onTab,
  });

  final ChildProfileDto child;

  /// Chuyển sang tab [index].
  final ValueChanged<int> onTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tt = context.tt;
    final id = child.id;
    final roadmap = ref.watch(learningRoadmapProvider(id));
    final feedback = ref.watch(readingFeedbackProvider(id));
    final summaries = ref.watch(storySummariesProvider(id));
    final wishes = ref.watch(learningWishesProvider(id));

    String value<T>(AsyncValue<T> a, String Function(T v) f) =>
        a.hasValue ? f(a.value as T) : (a.hasError ? '–' : '…');

    final pending = wishes.value?.where((w) => w.status == 'Pending').length;
    final g = roadmap.hasValue ? RoadmapGroups(roadmap.value) : null;

    Future<void> refresh() async {
      ref.invalidate(learningRoadmapProvider(id));
      ref.invalidate(readingFeedbackProvider(id));
      ref.invalidate(storySummariesProvider(id));
      ref.invalidate(learningWishesProvider(id));
      try {
        await Future.wait([
          ref.read(learningRoadmapProvider(id).future),
          ref.read(readingFeedbackProvider(id).future),
          ref.read(storySummariesProvider(id).future),
          ref.read(learningWishesProvider(id).future),
        ]);
      } catch (_) {}
    }

    final tiles = [
      _Tile(
        icon: Icons.route_rounded,
        label: 'Lộ trình',
        value: value(
          roadmap,
          (r) => '${r?.completedCount ?? 0}/${r?.totalCount ?? 0}',
        ),
        onTap: () => onTab(1),
      ),
      _Tile(
        icon: Icons.menu_book_rounded,
        label: 'Đã đọc xong',
        value: value(feedback, (p) => '${p.totalCount}'),
        onTap: () => onTab(2),
      ),
      _Tile(
        icon: Icons.mic_rounded,
        label: 'Bé kể lại',
        value: value(summaries, (p) => '${p.totalCount}'),
        onTap: () => onTab(2),
      ),
      _Tile(
        icon: Icons.auto_awesome_rounded,
        label: 'Điều ước chờ',
        value: value(wishes, (_) => '$pending'),
        alert: (pending ?? 0) > 0,
        onTap: () => onTab(3),
      ),
    ];

    final Widget nowBody;
    if (roadmap.hasError && !roadmap.hasValue) {
      nowBody = LearningInlineError(
        error: roadmap.error,
        onRetry: () => ref.invalidate(learningRoadmapProvider(id)),
      );
    } else if (g == null) {
      nowBody = const TtSkeleton(height: 96);
    } else if (g.open == null) {
      nowBody = LearningEmpty(
        title: g.totalCount > 0
            ? '${child.nickname} đã đọc hết lộ trình'
            : 'Lộ trình đang trống',
        mood: g.totalCount > 0 ? TtFrogMood.happy : TtFrogMood.think,
        frogSize: 72,
      );
    } else {
      final open = g.open!;
      final next = g.queued.take(3).toList();
      nowBody = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              StoryCover(storyId: open.storyId, width: 64, height: 86),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roadmapTitle(open),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (open.expectedCompletionAt != null) ...[
                      const SizedBox(height: 6),
                      LearningChip(
                        label: 'Hạn ${learningDate(open.expectedCompletionAt)}',
                        color:
                            open.expectedCompletionAt!.isBefore(DateTime.now())
                            ? tt.danger
                            : tt.muted,
                        icon: Icons.schedule_rounded,
                      ),
                    ],
                    const SizedBox(height: 10),
                    RoadmapProgress(
                      done: g.completedCount,
                      total: g.totalCount,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (next.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text('Tiếp theo', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            for (final n in next)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    StoryCover(storyId: n.storyId, width: 32, height: 42),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        roadmapTitle(n),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      );
    }

    final Widget recentBody;
    if (feedback.hasError && !feedback.hasValue) {
      recentBody = LearningInlineError(
        error: feedback.error,
        onRetry: () => ref.invalidate(readingFeedbackProvider(id)),
      );
    } else if (!feedback.hasValue) {
      recentBody = const TtSkeleton(height: 96);
    } else if (feedback.value!.items.isEmpty) {
      recentBody = LearningEmpty(
        title: '${child.nickname} chưa đọc xong truyện nào',
        frogSize: 72,
      );
    } else {
      final items = feedback.value!.items.take(3).toList();
      recentBody = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const Divider(height: 20),
            Text(
              items[i].title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: feedbackChips(context, items[i]),
            ),
          ],
        ],
      );
    }

    return LearningTabList(
      onRefresh: refresh,
      children: [
        LayoutBuilder(
          builder: (context, c) {
            const gap = 12.0;
            final cols = c.maxWidth >= 560 ? 4 : 2;
            final w = (c.maxWidth - gap * (cols - 1)) / cols;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [for (final t in tiles) SizedBox(width: w, child: t)],
            );
          },
        ),
        LearningSection(
          title: 'Đang đọc',
          trailing: TtIconButton(
            icon: Icons.chevron_right_rounded,
            tooltip: 'Xem lộ trình',
            size: 36,
            onPressed: () => onTab(1),
          ),
          child: nowBody,
        ),
        LearningSection(
          title: 'Mới đọc xong',
          trailing: feedback.value?.items.isNotEmpty == true
              ? TtIconButton(
                  icon: Icons.chevron_right_rounded,
                  tooltip: 'Xem tất cả',
                  size: 36,
                  onPressed: () => onTab(2),
                )
              : null,
          child: recentBody,
        ),
      ],
    );
  }
}

/// Ô số liệu bấm được; [alert] tô vàng khi có việc cần bố mẹ xem.
class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    this.alert = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  final bool alert;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final radius = BorderRadius.circular(TtRadius.lg);
    return Material(
      color: alert
          ? tt.gold.withValues(alpha: 0.35)
          : tt.panel.withValues(alpha: 0.92),
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: alert ? tt.goldDeep : tt.line2, width: 1.5),
      ),
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: tt.goldDeep),
              const SizedBox(height: 6),
              Text(value, maxLines: 1, style: textTheme.headlineMedium),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleSmall?.copyWith(color: tt.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
