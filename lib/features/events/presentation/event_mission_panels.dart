import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../models/event_dto.dart';
import '../../../models/library_story_dto.dart';
import '../../library/data/library_logic.dart';
import '../../library/presentation/library_providers.dart';
import '../../library/presentation/story_preview_screen.dart';
import '../data/event_logic.dart';
import 'event_widgets.dart';

// Khung tham gia / tiến độ nhiệm vụ / truyện của sự kiện (như EventMissionView
// của web, phần phụ huynh).

/// Lý do chưa đăng ký được nhánh gia đình (ngoài thời gian đăng ký), null = được.
String? parentRegistrationNotice(EventDetailDto detail, [DateTime? now]) {
  final track = detail.tracks.where((t) => t.trackType == 'Parent').firstOrNull;
  if (track == null) return 'Sự kiện này chưa có nhánh dành cho gia đình.';
  final at = now ?? DateTime.now();
  final start = track.registrationStartAt;
  final end = track.registrationEndAt;
  if (start != null && at.isBefore(start)) {
    return 'Đăng ký gia đình mở lúc ${formatVnDateTime(start)} (giờ Việt Nam).';
  }
  if (end != null && at.isAfter(end)) {
    return 'Đăng ký gia đình đã đóng lúc ${formatVnDateTime(end)} (giờ Việt Nam).';
  }
  return null;
}

/// Khung vàng mời gia đình đăng ký (sự kiện kiểu cũ, chưa tham gia).
class EventJoinPanel extends StatelessWidget {
  const EventJoinPanel({
    super.key,
    required this.detail,
    required this.onRegister,
  });

  final EventDetailDto detail;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    final notice = parentRegistrationNotice(detail);
    final textTheme = Theme.of(context).textTheme;
    return EventPanel(
      highlight: true,
      title: 'Tham gia cùng gia đình',
      icon: Icons.family_restroom_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Đăng ký để mở bảng nhiệm vụ (${detail.activeRule?.tasks.length ?? 0} nhiệm vụ) và tính gộp tiến độ đọc của các bé.',
            style: textTheme.bodyMedium,
          ),
          if (detail.status == 'Published') ...[
            const SizedBox(height: 12),
            EventGoldButton(
              label: 'Đăng ký tham gia',
              icon: Icons.auto_awesome_rounded,
              onPressed: notice == null ? onRegister : null,
            ),
          ],
          if (notice != null) ...[
            const SizedBox(height: 8),
            Text(
              notice,
              style: textTheme.bodySmall?.copyWith(color: context.tt.muted),
            ),
          ],
        ],
      ),
    );
  }
}

const _selfCheckin = {'GuidedDiscussionCheckin', 'RealLifePracticeCheckin'};

/// Tiến độ của gia đình: 3 ô số liệu + danh sách nhiệm vụ có thanh tiến độ.
class EventMissionPanel extends StatelessWidget {
  const EventMissionPanel({
    super.key,
    required this.dashboard,
    required this.onCheckin,
  });

  final EventMissionDashboardDto dashboard;
  final void Function(EventTaskProgressItemDto task) onCheckin;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final status = dashboard.participation?.status;
    Widget kpi(String label, String value) => Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: tt.gold.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(TtRadius.md),
          border: Border.all(color: tt.gold, width: 1.2),
        ),
        child: Column(
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodySmall?.copyWith(color: tt.muted),
            ),
            Text(
              value,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );

    return EventPanel(
      title: 'Tiến độ nhiệm vụ',
      icon: Icons.flag_rounded,
      trailing: status == null
          ? null
          : Flexible(
              child: EventTag(
                participationStatusLabel[status] ?? status,
                bg: tt.primary.withValues(alpha: 0.15),
                fg: tt.primaryStrong,
              ),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                kpi(
                  'Nhiệm vụ',
                  '${dashboard.completedTasksCount} / ${dashboard.tasks.length}',
                ),
                const SizedBox(width: 8),
                kpi('Điểm', '${dashboard.earnedPoints} điểm'),
                const SizedBox(width: 8),
                kpi(
                  'Điều kiện',
                  dashboard.allRequirementsMet
                      ? 'Đạt yêu cầu'
                      : 'Đang thực hiện',
                ),
              ],
            ),
          ),
          for (final task in dashboard.tasks) ...[
            const SizedBox(height: 14),
            _TaskRow(task: task, onCheckin: () => onCheckin(task)),
          ],
        ],
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  const _TaskRow({required this.task, required this.onCheckin});

  final EventTaskProgressItemDto task;
  final VoidCallback onCheckin;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final target = task.targetValue < 1 ? 1 : task.targetValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title.isEmpty ? task.taskCode : task.title,
                    style: textTheme.titleSmall,
                  ),
                  Text(
                    [
                      verifierTypeLabel[task.verifierType] ?? task.verifierType,
                      task.isMandatory ? 'Bắt buộc' : 'Tự chọn',
                      '${task.points} điểm',
                    ].join(' · '),
                    style: textTheme.bodySmall?.copyWith(color: tt.muted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (task.isCompleted)
              Icon(
                Icons.check_circle_rounded,
                color: tt.okInk,
                semanticLabel: 'Đã hoàn thành',
              )
            else if (_selfCheckin.contains(task.verifierType))
              EventGoldButton(
                label: 'Xác nhận',
                compact: true,
                onPressed: onCheckin,
              ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(TtRadius.full),
                child: LinearProgressIndicator(
                  value: (task.currentValue / target).clamp(0, 1).toDouble(),
                  minHeight: 8,
                  color: tt.gold,
                  backgroundColor: tt.surface2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${task.currentValue}/${task.targetValue}',
              style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }
}

/// Truyện của sự kiện; truyện có trong thư viện thì bấm để xem trước.
class EventStoriesPanel extends ConsumerWidget {
  const EventStoriesPanel({super.key, required this.stories});

  final List<EventStoryLibraryItemDto> stories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final library = {
      for (final s
          in ref.watch(libraryProvider).value?.shelves.sorted ??
              const <LibraryStoryDto>[])
        s.id: s,
    };
    return EventPanel(
      title: 'Truyện của sự kiện (${stories.length})',
      icon: Icons.menu_book_rounded,
      child: stories.isEmpty
          ? Text(
              'Chưa có truyện trong sự kiện này.',
              style: textTheme.bodyMedium?.copyWith(color: tt.muted),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final s in stories) ...[
                  if (s != stories.first) const SizedBox(height: 8),
                  Material(
                    color: tt.surface,
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(TtRadius.md),
                    child: InkWell(
                      onTap: library[s.storyId] == null
                          ? null
                          : () =>
                                openStoryPreview(context, library[s.storyId]!),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(s.title, style: textTheme.titleSmall),
                                  Text(
                                    [
                                      if (s.genre.isNotEmpty) s.genre,
                                      if (s.ageBand.isNotEmpty)
                                        ageLabel(s.ageBand),
                                    ].join(' · '),
                                    style: textTheme.bodySmall?.copyWith(
                                      color: tt.muted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            s.hasFamilyRead
                                ? EventTag(
                                    'Bé đã đọc xong',
                                    bg: tt.primary.withValues(alpha: 0.15),
                                    fg: tt.primaryStrong,
                                  )
                                : const EventTag('Chưa đọc'),
                            if (library[s.storyId] != null)
                              Icon(
                                Icons.chevron_right_rounded,
                                color: tt.muted,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}
