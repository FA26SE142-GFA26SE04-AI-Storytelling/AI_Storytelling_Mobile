import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_adaptive.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_text_field.dart';
import '../../../models/event_dto.dart';
import '../../library/data/library_logic.dart';
import '../../library/presentation/library_shelf.dart';
import '../../library/presentation/library_top_bar.dart';
import '../data/event_logic.dart';
import '../data/event_repository.dart';
import 'event_widgets.dart';

const _filters = [
  ('all', 'Tất cả'),
  ('open', 'Đang mở'),
  ('upcoming', 'Sắp diễn ra'),
  ('ended', 'Đã kết thúc'),
  ('joined', 'Đã tham gia'),
];

/// Tab Sự kiện của phụ huynh (như EventListView của web): ô tìm, chip lọc theo
/// nhóm / đã tham gia, danh sách thẻ sự kiện; bấm thẻ mở chi tiết.
class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  final _search = TextEditingController();
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    ref.invalidate(myParticipationsProvider);
    ref.invalidate(eventListProvider);
    try {
      await ref.read(eventListProvider.future);
    } catch (_) {
      // Lỗi đã hiện bằng trạng thái lỗi của màn.
    }
  }

  List<Widget> _body(double side, bool isWide) {
    Widget padded(Widget child) => SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: side),
      sliver: SliverToBoxAdapter(child: child),
    );
    final async = ref.watch(eventListProvider);
    final events = async.value;
    if (events == null && async.hasError) {
      final e = async.error;
      return [
        padded(
          TtErrorState(
            title: 'Chưa tải được danh sách sự kiện',
            message: e is ApiException
                ? e.message
                : 'Có lỗi xảy ra. Vui lòng thử lại.',
            onRetry: () => ref.invalidate(eventListProvider),
          ),
        ),
      ];
    }
    if (events == null) {
      return [
        padded(
          Column(
            children: [
              for (var i = 0; i < 3; i++) ...[
                const TtSkeleton(
                  height: 220,
                  radius: BorderRadius.all(Radius.circular(TtRadius.lg)),
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ];
    }

    final parts =
        ref.watch(myParticipationsProvider).value ??
        const <EventParticipationDto>[];
    final joined = <int, List<EventParticipationDto>>{};
    for (final p in parts) {
      (joined[p.eventId] ??= []).add(p);
    }
    final published = events
        .where((e) => e.status == 'Published' || e.status == 'Closed')
        .toList();
    if (published.isEmpty) {
      return [
        padded(
          const TtEmptyState(
            icon: Icons.emoji_events_rounded,
            title: 'Chưa có sự kiện nào được công bố',
          ),
        ),
      ];
    }
    final now = DateTime.now();
    final groups = {for (final e in published) e.id: groupOf(e, null, now)};
    final counts = <String, int>{
      'all': published.length,
      for (final f in _filters.skip(1)) f.$1: 0,
    };
    for (final e in published) {
      counts.update(groups[e.id]!, (n) => n + 1);
      if (joined.containsKey(e.id)) counts.update('joined', (n) => n + 1);
    }
    final needle = foldVietnamese(_search.text.trim());
    final shown = published.where((e) {
      final inFilter = switch (_filter) {
        'all' => true,
        'joined' => joined.containsKey(e.id),
        _ => groups[e.id] == _filter,
      };
      return inFilter &&
          foldVietnamese(
            '${e.title} ${e.description} ${e.mainCategoryName ?? ''}',
          ).contains(needle);
    }).toList();

    return [
      SliverToBoxAdapter(
        child: SizedBox(
          height: 34,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: side),
            itemCount: _filters.length,
            separatorBuilder: (_, _) => const SizedBox(width: 6),
            itemBuilder: (context, i) => libraryChip(
              context,
              label: '${_filters[i].$2} (${counts[_filters[i].$1]})',
              selected: _filter == _filters[i].$1,
              onSelected: () => setState(() => _filter = _filters[i].$1),
            ),
          ),
        ).animate().fadeIn(duration: 260.ms),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 12)),
      if (shown.isEmpty)
        padded(
          const TtEmptyState(
            icon: Icons.search_off_rounded,
            title: 'Không tìm thấy sự kiện phù hợp',
          ),
        )
      else if (isWide)
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: side),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, i) =>
                  EventCard(
                        event: shown[i],
                        group: groups[shown[i].id]!,
                        parts: joined[shown[i].id] ?? const [],
                        onTap: () =>
                            context.push(AppRoutes.eventPath(shown[i].id)),
                      )
                      .animate()
                      .fadeIn(delay: (40 * math.min(i, 8)).ms, duration: 260.ms)
                      .slideY(begin: 0.05, end: 0, duration: 260.ms),
              childCount: shown.length,
            ),
          ),
        )
      else
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: side),
          sliver: SliverList.separated(
            itemCount: shown.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, i) =>
                EventCard(
                      event: shown[i],
                      group: groups[shown[i].id]!,
                      parts: joined[shown[i].id] ?? const [],
                      onTap: () =>
                          context.push(AppRoutes.eventPath(shown[i].id)),
                    )
                    .animate()
                    .fadeIn(delay: (40 * math.min(i, 8)).ms, duration: 260.ms)
                    .slideY(begin: 0.05, end: 0, duration: 260.ms),
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.tt.bg,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverLayoutBuilder(
                builder: (context, constraints) {
                  final isWide =
                      constraints.crossAxisExtent >= kTwoColumnMinWidth;
                  // Nội dung rộng tối đa kWideContentMaxWidth (màn rộng) hoặc 960, căn giữa trên màn rộng.
                  final side = math.max(
                    16.0,
                    (constraints.crossAxisExtent -
                            (isWide ? kWideContentMaxWidth : 960)) /
                        2,
                  );
                  return SliverPadding(
                    padding: const EdgeInsets.only(bottom: 16),
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        PinnedHeaderSliver(
                          child: LibraryFrostedBar(
                            side: side,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TtTextField(
                                    label: 'Tìm sự kiện',
                                    hint: 'Tìm sự kiện…',
                                    hideLabel: true,
                                    prefixIcon: Icons.search_rounded,
                                    controller: _search,
                                    textInputAction: TextInputAction.search,
                                  ),
                                ),
                                if (_search.text.isNotEmpty) ...[
                                  const SizedBox(width: 8),
                                  TtIconButton(
                                    icon: Icons.close_rounded,
                                    tooltip: 'Xoá tìm kiếm',
                                    size: 40,
                                    onPressed: _search.clear,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 4)),
                        ..._body(side, isWide),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Thẻ một sự kiện: ảnh 16:9, nhãn, tiêu đề, mô tả, lịch / tuổi / chủ đề / thưởng.
class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.group,
    required this.parts,
    required this.onTap,
  });

  final EventSummaryDto event;
  final String group;
  final List<EventParticipationDto> parts;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final window = eventScheduleWindow(event, null);
    return Material(
      color: tt.panel.withValues(alpha: 0.92),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TtRadius.lg),
        side: BorderSide(color: tt.line2, width: 1.2),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: TtNetworkImage(
                url: event.bannerUrl,
                radius: BorderRadius.zero,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      EventTag.group(context, group),
                      if (isNewEvent(event)) EventTag.isNew(context),
                      for (final p in parts)
                        EventTag(
                          [
                            if (p.activityType != null)
                              eventActivityLabel[p.activityType] ??
                                  p.activityType!,
                            participationStatusLabel[p.status] ?? p.status,
                          ].join(': '),
                          bg: tt.gold.withValues(alpha: 0.3),
                          fg: TtColors.light.inkWarm,
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (event.description.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      event.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium?.copyWith(color: tt.muted),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    children: [
                      if (window.start != null && window.end != null)
                        EventMeta(
                          Icons.calendar_month_rounded,
                          '${formatVnDate(window.start)} – ${formatVnDate(window.end)}',
                        ),
                      if (event.targetAgeBands.isNotEmpty)
                        EventMeta(
                          Icons.child_care_rounded,
                          '${event.targetAgeBands} tuổi',
                        ),
                      if (event.mainCategoryName?.isNotEmpty ?? false)
                        EventMeta(
                          Icons.local_offer_rounded,
                          event.mainCategoryName!,
                        ),
                      EventMeta(
                        Icons.card_giftcard_rounded,
                        eventBudgetText(event.budgetVnd),
                      ),
                    ],
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
