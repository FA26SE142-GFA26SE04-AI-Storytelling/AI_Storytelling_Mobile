import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../models/event_dto.dart';
import '../data/event_logic.dart';
import 'event_widgets.dart';

// Hoạt động (sự kiện kiểu ActivityBased) và Phần thưởng của tôi
// (như EventActivityParticipantView của web, phần phụ huynh).

const _lifecycleLabel = {
  'NotOpen': 'Chưa mở',
  'Open': 'Đang mở',
  'Ended': 'Đã kết thúc',
};

/// Các hoạt động gia đình đủ điều kiện tham gia, nút đăng ký từng hoạt động.
class EventActivitiesPanel extends StatelessWidget {
  const EventActivitiesPanel({
    super.key,
    required this.detail,
    required this.onRegister,
  });

  final EventDetailDto detail;
  final void Function(EventActivityUserStateDto state) onRegister;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final states = detail.myActivityStates.where((s) => s.isEligible).toList();
    final byId = {for (final a in detail.activities) a.id: a};
    return EventPanel(
      title: 'Hoạt động gia đình tham gia được (${states.length})',
      icon: Icons.extension_rounded,
      child: states.isEmpty
          ? Text(
              'Sự kiện chưa có hoạt động dành cho gia đình.',
              style: textTheme.bodyMedium?.copyWith(color: tt.muted),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final st in states) ...[
                  if (st != states.first) const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: tt.surface,
                      borderRadius: BorderRadius.circular(TtRadius.md),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          [
                            eventActivityLabel[st.activityType] ??
                                st.activityType,
                            eventAudienceLabel[st.allowedAudience] ??
                                st.allowedAudience,
                          ].join(' · '),
                          style: textTheme.titleSmall,
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            st.lifecycleStatus == 'Open'
                                ? EventTag(
                                    'Đang mở',
                                    bg: tt.primary.withValues(alpha: 0.15),
                                    fg: tt.primaryStrong,
                                  )
                                : EventTag(
                                    _lifecycleLabel[st.lifecycleStatus] ??
                                        st.lifecycleStatus,
                                    bg: tt.surface2,
                                    fg: tt.muted,
                                  ),
                            if (st.isRegistered &&
                                st.participationStatus != null)
                              EventTag(
                                participationStatusLabel[st
                                        .participationStatus] ??
                                    st.participationStatus!,
                                bg: tt.gold.withValues(alpha: 0.3),
                                fg: TtColors.light.inkWarm,
                              ),
                          ],
                        ),
                        if (byId[st.activityId] case final act?) ...[
                          const SizedBox(height: 6),
                          Text(
                            'Đăng ký: ${formatVnDateTime(act.registrationStartAt)} → ${formatVnDateTime(act.registrationEndAt)} · Thực hiện: ${formatVnDateTime(act.startAt)} → ${formatVnDateTime(act.endAt)}',
                            style: textTheme.bodySmall?.copyWith(
                              color: tt.muted,
                            ),
                          ),
                        ],
                        if (st.canRegister && !st.isRegistered) ...[
                          const SizedBox(height: 8),
                          EventGoldButton(
                            label: 'Đăng ký',
                            icon: Icons.auto_awesome_rounded,
                            compact: true,
                            onPressed: () => onRegister(st),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}

/// Giải thưởng của tôi trong sự kiện; giải chờ nhận có nút "Nhận thưởng".
class EventRewardsPanel extends StatelessWidget {
  const EventRewardsPanel({
    super.key,
    required this.rewards,
    required this.onClaim,
  });

  final List<EventAwardSlotDto> rewards;
  final void Function(EventAwardSlotDto award) onClaim;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    return EventPanel(
      title: 'Phần thưởng của tôi',
      icon: Icons.card_giftcard_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final aw in rewards) ...[
            if (aw != rewards.first) const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.redeem_rounded, color: tt.goldDeep),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${aw.rankOrTier} · ${aw.rewardName}',
                        style: textTheme.titleSmall,
                      ),
                      Text(
                        '(${rewardTypeLabel[aw.rewardType] ?? aw.rewardType})',
                        style: textTheme.bodySmall?.copyWith(color: tt.muted),
                      ),
                      const SizedBox(height: 4),
                      EventTag(awardStatusLabel[aw.status] ?? aw.status),
                    ],
                  ),
                ),
                if (aw.status == 'AwaitingClaim') ...[
                  const SizedBox(width: 8),
                  EventGoldButton(
                    label: 'Nhận thưởng',
                    compact: true,
                    onPressed: () => onClaim(aw),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
