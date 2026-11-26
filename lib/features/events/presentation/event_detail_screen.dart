import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_adaptive.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../models/event_dto.dart';
import '../../library/presentation/library_shelf.dart';
import '../data/event_logic.dart';
import '../data/event_repository.dart';
import 'event_activity_panels.dart';
import 'event_detail_actions.dart';
import 'event_info_card.dart';
import 'event_mission_panels.dart';
import 'event_widgets.dart';

/// Chi tiết một sự kiện cho phụ huynh: ảnh + thông tin chung, phần tham gia
/// (kiểu cũ: đăng ký gia đình + bảng nhiệm vụ; kiểu hoạt động: đăng ký từng
/// hoạt động), phần thưởng của tôi và thông tin / thể lệ.
class EventDetailScreen extends ConsumerStatefulWidget {
  const EventDetailScreen({super.key, required this.eventId});

  final int eventId;

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  /// 'info' | 'mission'; null = mặc định (Nhiệm vụ & Quà khi đã tham gia).
  String? _tab;

  /// Khoá khi đang mở popup để bấm nhanh hai lần không mở hai popup.
  bool _busy = false;

  int get _id => widget.eventId;

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    _busy = true;
    try {
      await action();
    } finally {
      _busy = false;
    }
  }

  void _back() =>
      context.canPop() ? context.pop() : context.go(AppRoutes.events);

  Future<void> _refresh() async {
    refreshEventData(ProviderScope.containerOf(context, listen: false), _id);
    try {
      await ref.read(eventDetailProvider(_id).future);
    } catch (_) {
      // Lỗi đã hiện bằng trạng thái lỗi của màn.
    }
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(eventDetailProvider(_id));
    final detail = async.value;
    return Scaffold(
      backgroundColor: context.tt.bg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final side = math.max(16.0, (c.maxWidth - 760) / 2);
            final backButton = TtIconButton(
              icon: Icons.arrow_back_rounded,
              tooltip: 'Quay lại',
              size: 40,
              onPressed: _back,
            );
            final List<Widget> children;
            if (detail == null && async.hasError) {
              final e = async.error;
              children = [
                Align(alignment: Alignment.centerLeft, child: backButton),
                TtErrorState(
                  title: 'Chưa tải được sự kiện',
                  message: e is ApiException
                      ? e.message
                      : 'Có lỗi xảy ra. Vui lòng thử lại.',
                  onRetry: () => ref.invalidate(eventDetailProvider(_id)),
                ),
              ];
            } else if (detail == null) {
              children = [
                Align(alignment: Alignment.centerLeft, child: backButton),
                const SizedBox(height: 8),
                for (final h in const [200.0, 120.0, 160.0]) ...[
                  TtSkeleton(
                    height: h,
                    radius: const BorderRadius.all(
                      Radius.circular(TtRadius.lg),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ];
            } else {
              children = [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: TtNetworkImage(url: detail.bannerUrl),
                    ),
                    Positioned(top: 8, left: 8, child: backButton),
                  ],
                ),
                const SizedBox(height: 12),
                ..._sections(detail),
              ];
            }
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(side, 8, side, 24),
                children: [
                  for (final (i, w) in children.indexed)
                    w
                        .animate()
                        .fadeIn(
                          delay: (40 * math.min(i, 8)).ms,
                          duration: 260.ms,
                        )
                        .slideY(begin: 0.05, end: 0, duration: 260.ms),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Các khung dưới phần giới thiệu, cách nhau 12.
  List<Widget> _sections(EventDetailDto detail) {
    final parts =
        ref.watch(myParticipationsProvider).value ??
        const <EventParticipationDto>[];
    final rewards = rewardsForEvent(
      ref.watch(myRewardsProvider).value ?? const [],
      detail,
    );
    final activityBased = detail.configVersion == 'ActivityBased';
    final readState = detail.myActivityStates
        .where((s) => s.isEligible && s.activityType == 'ReadingMissions')
        .firstOrNull;
    final joined = activityBased
        ? readState?.isRegistered ?? false
        : parts.any((p) => p.eventId == _id && p.trackType == 'Parent');
    final dashboard = joined ? ref.watch(missionDashboardProvider(_id)) : null;
    final tab = _tab ?? 'mission';

    void checkin(EventTaskProgressItemDto task) => _run(
      () => confirmEventCheckin(
        context,
        _id,
        task,
        dashboard?.value?.stories ?? const [],
      ),
    );

    final missionWidgets = <Widget>[
      if (dashboard != null)
        switch (dashboard) {
          AsyncValue(:final value?) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EventMissionPanel(dashboard: value, onCheckin: checkin),
              const SizedBox(height: 12),
              EventStoriesPanel(stories: value.stories),
            ],
          ),
          AsyncValue(hasError: true) => EventPanel(
            child: TtErrorState(
              title: 'Chưa tải được bảng nhiệm vụ',
              message: 'Bạn thử tải lại nhé.',
              onRetry: () => ref.invalidate(missionDashboardProvider(_id)),
            ),
          ),
          _ => const TtSkeleton(
            height: 220,
            radius: BorderRadius.all(Radius.circular(TtRadius.lg)),
          ),
        },
    ];

    // ── Cột trái: giới thiệu + phần đăng ký ──────────────────────────────
    final leftItems = <Widget>[
      _EventHero(detail: detail),
      if (activityBased)
        EventActivitiesPanel(
          detail: detail,
          onRegister: (st) => _run(
            () => confirmEventRegister(
              context,
              detail,
              activityType: st.activityType,
              eventActivityId: st.activityId,
              successText:
                  'Đã đăng ký hoạt động ${eventActivityLabel[st.activityType] ?? ''}.',
            ),
          ),
        )
      else if (!joined)
        EventJoinPanel(
          detail: detail,
          onRegister: () => _run(
            () => confirmEventRegister(
              context,
              detail,
              trackType: 'Parent',
              successText: 'Đã đăng ký tham gia cho gia đình.',
            ),
          ),
        )
      else
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            libraryChip(
              context,
              label: 'Nhiệm vụ & Quà',
              selected: tab == 'mission',
              onSelected: () => setState(() => _tab = 'mission'),
            ),
            libraryChip(
              context,
              label: 'Thông tin',
              selected: tab == 'info',
              onSelected: () => setState(() => _tab = 'info'),
            ),
          ],
        ),
    ];

    // ── Cột phải: nhiệm vụ & quà ─────────────────────────────────────────
    final rightItems = <Widget>[
      if (activityBased) ...missionWidgets,
      if (!activityBased && joined && tab == 'mission') ...missionWidgets,
      if (rewards.isNotEmpty)
        EventRewardsPanel(
          rewards: rewards,
          onClaim: (aw) => _run(() => confirmEventClaim(context, _id, aw)),
        ),
      if (activityBased || !joined || tab == 'info')
        EventInfoCard(detail: detail),
    ];

    return [
      const SizedBox(height: 12),
      TtAdaptiveColumns(
        spacing: 12,
        left: leftItems,
        right: rightItems,
      ),
    ];
  }
}

/// Phần giới thiệu: nhãn trạng thái, tiêu đề, mô tả, các mục thông tin.
class _EventHero extends StatelessWidget {
  const _EventHero({required this.detail});

  final EventDetailDto detail;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final window = eventScheduleWindow(null, detail);
    final category = detail.mainCategoryName ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            detail.status == 'Published'
                ? EventTag(
                    eventStatusLabel[detail.status]!,
                    bg: tt.primary.withValues(alpha: 0.15),
                    fg: tt.primaryStrong,
                  )
                : EventTag(
                    eventStatusLabel[detail.status] ?? detail.status,
                    fg: tt.muted,
                  ),
            if (isNewEvent(_summary(detail))) EventTag.isNew(context),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          detail.title,
          style: textTheme.headlineMedium?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (detail.description.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            detail.description,
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
            if (detail.targetAgeBands.isNotEmpty)
              EventMeta(
                Icons.child_care_rounded,
                'Nhóm tuổi ${detail.targetAgeBands}',
              ),
            if (category.isNotEmpty)
              EventMeta(Icons.local_offer_rounded, 'Chủ đề $category'),
            EventMeta(
              Icons.menu_book_rounded,
              '${detail.eventStoriesCount} truyện',
            ),
            EventMeta(
              Icons.card_giftcard_rounded,
              eventBudgetText(detail.budgetVnd, 'Thưởng quà / Lượt AI'),
            ),
          ],
        ),
      ],
    );
  }
}

/// isNewEvent nhận bản tóm tắt; chi tiết có đủ các trường cần.
EventSummaryDto _summary(EventDetailDto d) => EventSummaryDto(
  id: d.id,
  status: d.status,
  createdAt: d.createdAt,
  publishedAt: d.publishedAt,
);
