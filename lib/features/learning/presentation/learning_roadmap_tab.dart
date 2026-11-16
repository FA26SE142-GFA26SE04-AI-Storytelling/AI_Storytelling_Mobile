import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../models/child_profile_dto.dart';
import '../../../models/child_roadmap_dto.dart';
import 'learning_providers.dart';
import 'learning_widgets.dart';

/// Theo enum ChildRoadmapSkipReason của Backend.
const _skipReason = {
  'BlockedTopic': 'Chủ đề bị chặn',
  'WrongAge': 'Không hợp tuổi',
  'TooLong': 'Truyện quá dài',
  'StoryUnavailable': 'Truyện không còn đọc được',
  'SourceDeleted': 'Truyện gốc đã bị xoá',
  'DataDeleted': 'Dữ liệu đã bị xoá',
};

/// Lộ trình chia nhóm như splitRoadmap của web: đang đọc / tiếp theo / đã đọc / đã gỡ-bỏ qua.
class RoadmapGroups {
  RoadmapGroups(ChildRoadmapDto? r)
      : open = r?.open,
        queued = [...?r?.waiting]
          ..sort((a, b) => a.position.compareTo(b.position)),
        done = [...?r?.history.where((i) => i.status == 'Completed')],
        off = [...?r?.history.where((i) => i.status != 'Completed')],
        completedCount = r?.completedCount ?? 0,
        totalCount = r?.totalCount ?? 0;

  final ChildRoadmapItemDto? open;
  final List<ChildRoadmapItemDto> queued;
  final List<ChildRoadmapItemDto> done;
  final List<ChildRoadmapItemDto> off;
  final int completedCount;
  final int totalCount;
}

String roadmapTitle(ChildRoadmapItemDto i) =>
    i.title ?? 'Truyện không còn khả dụng';

/// Tab "Lộ trình": chỉ xem; sửa lộ trình làm trên web.
class LearningRoadmapTab extends ConsumerWidget {
  const LearningRoadmapTab({super.key, required this.child});

  final ChildProfileDto child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tt = context.tt;
    final async = ref.watch(learningRoadmapProvider(child.id));

    Future<void> refresh() async {
      ref.invalidate(learningRoadmapProvider(child.id));
      try {
        await ref.read(learningRoadmapProvider(child.id).future);
      } catch (_) {}
    }

    final List<Widget> body;
    if (async.hasError && !async.hasValue) {
      body = [
        learningError(
          async.error,
          () => ref.invalidate(learningRoadmapProvider(child.id)),
          title: 'Chưa tải được lộ trình',
        ),
      ];
    } else if (!async.hasValue) {
      body = learningSkeleton();
    } else {
      final g = RoadmapGroups(async.value);
      if (g.open == null && g.queued.isEmpty && g.done.isEmpty && g.off.isEmpty) {
        body = [const LearningEmpty(title: 'Lộ trình đang trống')];
      } else {
        body = [
          if (g.totalCount > 0) _ProgressCard(groups: g),
          if (g.open != null)
            LearningSection(
              title: 'Đang đọc',
              child: _Step(item: g.open!, label: 'Đang đọc', color: tt.goldDeep),
            ),
          if (g.queued.isNotEmpty)
            LearningSection(
              title: 'Tiếp theo',
              count: g.queued.length,
              child: _Steps(items: g.queued, label: 'Chưa tới', color: tt.sky),
            ),
          if (g.done.isNotEmpty)
            LearningSection(
              title: 'Đã đọc',
              count: g.completedCount,
              child: _Steps(items: g.done, label: 'Đã đọc', color: tt.okInk),
            ),
          if (g.off.isNotEmpty) _OffSection(items: g.off),
        ];
      }
    }

    return LearningTabList(onRefresh: refresh, children: body);
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.groups});

  final RoadmapGroups groups;

  @override
  Widget build(BuildContext context) {
    final g = groups;
    final done = g.open == null && g.queued.isEmpty;
    return LearningSection(
      title: 'Tiến độ',
      trailing: done ? const TtFrog(mood: TtFrogMood.happy, size: 36) : null,
      child: RoadmapProgress(done: g.completedCount, total: g.totalCount),
    );
  }
}

/// Thanh tiến độ vàng + số done/total.
class RoadmapProgress extends StatelessWidget {
  const RoadmapProgress({super.key, required this.done, required this.total});

  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: total == 0 ? 0 : done / total),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              builder: (_, v, _) => LinearProgressIndicator(
                value: v,
                minHeight: 10,
                color: tt.gold,
                backgroundColor: tt.surface2,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text('$done/$total', style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}

class _Steps extends StatelessWidget {
  const _Steps({required this.items, required this.label, required this.color});

  final List<ChildRoadmapItemDto> items;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const Divider(height: 16),
          _Step(item: items[i], label: label, color: color),
        ],
      ],
    );
  }
}

/// Một bước lộ trình: bìa + tên + trạng thái + hạn (nếu có).
class _Step extends StatelessWidget {
  const _Step({required this.item, required this.label, required this.color});

  final ChildRoadmapItemDto item;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final due = item.expectedCompletionAt;
    final overdue = due != null &&
        item.status != 'Completed' &&
        due.isBefore(DateTime.now());
    return Row(
      children: [
        StoryCover(storyId: item.storyId),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                roadmapTitle(item),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  LearningChip(label: label, color: color),
                  if (item.status == 'Completed' && item.completedAt != null)
                    LearningChip(
                      label: learningDate(item.completedAt),
                      color: tt.muted,
                      icon: Icons.event_rounded,
                    )
                  else if (due != null)
                    LearningChip(
                      label: 'Hạn ${learningDate(due)}',
                      color: overdue ? tt.danger : tt.muted,
                      icon: Icons.schedule_rounded,
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Đã gỡ hoặc bỏ qua: thu gọn mặc định như web.
class _OffSection extends StatelessWidget {
  const _OffSection({required this.items});

  final List<ChildRoadmapItemDto> items;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return LearningSection(
      title: 'Đã gỡ hoặc bỏ qua',
      count: items.length,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          title: Text(
            'Xem danh sách',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          children: [
            for (final i in items)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: _Step(
                  item: i,
                  label: i.status == 'Skipped'
                      ? (_skipReason[i.skipReason] ?? 'Bỏ qua')
                      : 'Đã gỡ',
                  color: tt.muted,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
