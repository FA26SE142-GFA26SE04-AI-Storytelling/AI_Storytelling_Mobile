import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../models/event_dto.dart';
import '../../library/data/library_logic.dart';
import '../data/event_logic.dart';
import 'event_widgets.dart';

// Thông tin sự kiện cho phụ huynh (như EventDetailInfoCard của web): hành
// trình, thể lệ & nhiệm vụ, điều kiện nhận thưởng, cơ cấu giải thưởng.

String _date(DateTime? v) => v == null ? 'Chưa có lịch' : formatVnDate(v);
String _range(DateTime? a, DateTime? b) => '${_date(a)} – ${_date(b)}';

/// Các bước của sự kiện: (icon, tên, thời gian).
List<(IconData, String, String)> eventJourney(EventDetailDto d) {
  final acts = d.activities;
  final activityBased =
      d.configVersion == 'ActivityBased' ||
      (d.tracks.isEmpty && acts.isNotEmpty);
  EventActivityDto? act(String type) =>
      acts.where((a) => a.activityType == type).firstOrNull;
  EventTrackDto? track(String type) =>
      d.tracks.where((t) => t.trackType == type).firstOrNull;
  DateTime? latest(Iterable<DateTime?> values) {
    DateTime? best;
    for (final v in values.whereType<DateTime>()) {
      if (best == null || v.isAfter(best)) best = v;
    }
    return best;
  }

  final end = activityBased
      ? d.closesAt ?? latest(acts.expand((a) => [a.endAt, a.reviewCutoffAt]))
      : latest(d.tracks.map((t) => t.executionEndAt));
  final sub = act('Submission'), read = act('ReadingMissions');
  final vote = act('Voting');
  final creator = track('Creator'), parent = track('Parent');
  return [
    if (activityBased) ...[
      if (sub != null)
        (
          Icons.edit_rounded,
          'Sáng tác / Nộp bài',
          _range(sub.startAt, sub.endAt),
        ),
      if (sub?.reviewCutoffAt != null)
        (
          Icons.fact_check_rounded,
          'Duyệt bài dự thi',
          'Hạn ${_date(sub!.reviewCutoffAt)}',
        ),
      if (read != null)
        (
          Icons.menu_book_rounded,
          'Đọc truyện & Làm nhiệm vụ',
          _range(read.startAt, read.endAt),
        ),
      if (vote != null)
        (
          Icons.star_rounded,
          'Bình chọn truyện',
          _range(vote.startAt, vote.endAt),
        ),
    ] else ...[
      if (creator != null)
        (
          Icons.edit_rounded,
          'Sáng tác truyện',
          _range(creator.executionStartAt, creator.executionEndAt),
        ),
      if (parent != null)
        (
          Icons.family_restroom_rounded,
          'Gia đình tham gia',
          _range(parent.executionStartAt, parent.executionEndAt),
        ),
    ],
    (
      Icons.emoji_events_rounded,
      'Tổng kết / Trao thưởng',
      end == null ? 'Chưa có lịch' : 'Sau ${_date(end)}',
    ),
  ];
}

class EventInfoCard extends StatelessWidget {
  const EventInfoCard({super.key, required this.detail});

  final EventDetailDto detail;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final muted = textTheme.bodySmall?.copyWith(color: tt.muted);
    final rule = detail.activeRule;
    final eligibility = rule?.rewardEligibilityText?.trim() ?? '';
    final groups = <String, List<EventAwardSlotDto>>{};
    for (final a in detail.awards) {
      final key = [
        a.trackId,
        a.eventActivityId,
        a.resultSource,
        a.targetAudience,
        a.rankOrTier,
        a.rewardName,
        a.rewardType,
        a.unitValueVnd,
        a.creditGrantAmount,
      ].join('|');
      (groups[key] ??= []).add(a);
    }
    String completion(EventRuleVersionDto r) => [
      completionModeLabel[r.completionMode] ?? r.completionMode,
      if (r.completionMode == 'MinimumTasksCount')
        '${r.requiredTaskCount ?? 0} nhiệm vụ',
      if (r.completionMode == 'MinimumPointsThreshold')
        '${r.requiredPoints ?? 0} điểm',
    ].join(' · ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EventPanel(
          title: 'Hành trình sự kiện',
          icon: Icons.route_rounded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final (i, step) in eventJourney(detail).indexed) ...[
                if (i > 0) const SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: tt.gold.withValues(alpha: 0.3),
                      child: Icon(step.$1, size: 18, color: tt.goldDeep),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${i + 1}. ${step.$2}',
                            style: textTheme.titleSmall,
                          ),
                          Text(step.$3, style: muted),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        EventPanel(
          title: 'Thể lệ & nhiệm vụ',
          icon: Icons.gavel_rounded,
          child: rule == null
              ? Text('Thể lệ và nhiệm vụ chưa được công bố.', style: muted)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (rule.rulesText.trim().isNotEmpty)
                      _CollapsibleText(rule.rulesText.trim()),
                    const SizedBox(height: 6),
                    Text(completion(rule), style: textTheme.titleSmall),
                    for (final t in rule.tasks) ...[
                      const SizedBox(height: 8),
                      Text(t.title, style: textTheme.titleSmall),
                      if (t.description.isNotEmpty)
                        Text(t.description, style: textTheme.bodyMedium),
                      Text(
                        'Chỉ tiêu ${t.targetValue} · ${t.points} điểm · ${t.isMandatory ? 'Bắt buộc' : 'Tự chọn'}',
                        style: muted,
                      ),
                    ],
                  ],
                ),
        ),
        if (eligibility.isNotEmpty) ...[
          const SizedBox(height: 12),
          EventPanel(
            title: 'Điều kiện nhận thưởng',
            icon: Icons.verified_rounded,
            child: Text(eligibility, style: textTheme.bodyMedium),
          ),
        ],
        const SizedBox(height: 12),
        EventPanel(
          title: 'Cơ cấu giải thưởng',
          icon: Icons.emoji_events_rounded,
          child: groups.isEmpty
              ? Text('Chưa công bố cơ cấu giải thưởng.', style: muted)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final (i, slots) in groups.values.indexed) ...[
                      if (i > 0) const SizedBox(height: 8),
                      _AwardTile(slots: slots),
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}

class _AwardTile extends StatelessWidget {
  const _AwardTile({required this.slots});

  final List<EventAwardSlotDto> slots;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final a = slots.first;
    final value = a.unitValueVnd > 0
        ? '${groupThousands(a.unitValueVnd)} đ / suất'
        : a.creditGrantAmount > 0
        ? '${a.creditGrantAmount} lượt AI / suất'
        : '';
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tt.gold.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(TtRadius.md),
        border: Border.all(color: tt.gold, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.emoji_events_rounded, color: tt.goldDeep, size: 20),
              const SizedBox(width: 6),
              Expanded(child: Text(a.rankOrTier, style: textTheme.titleSmall)),
              EventTag('${slots.length} suất'),
            ],
          ),
          Text(a.rewardName, style: textTheme.bodyMedium),
          Text(
            [
              if (value.isNotEmpty) value,
              rewardTypeLabel[a.rewardType] ?? a.rewardType,
              if (a.targetAudience != null)
                eventAudienceLabel[a.targetAudience] ?? a.targetAudience!,
            ].join(' · '),
            style: textTheme.bodySmall?.copyWith(color: tt.muted),
          ),
        ],
      ),
    );
  }
}

/// Đoạn chữ dài: thu gọn 6 dòng, có nút "Xem thêm" / "Thu gọn" khi bị cắt.
class _CollapsibleText extends StatefulWidget {
  const _CollapsibleText(this.text);

  final String text;

  @override
  State<_CollapsibleText> createState() => _CollapsibleTextState();
}

class _CollapsibleTextState extends State<_CollapsibleText> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;
    return LayoutBuilder(
      builder: (context, c) {
        final painter = TextPainter(
          text: TextSpan(text: widget.text, style: style),
          maxLines: 6,
          textDirection: Directionality.of(context),
          textScaler: MediaQuery.textScalerOf(context),
        )..layout(maxWidth: c.maxWidth);
        final long = painter.didExceedMaxLines;
        painter.dispose();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: style,
              maxLines: _open ? null : 6,
              overflow: _open ? null : TextOverflow.ellipsis,
            ),
            if (long)
              TextButton(
                onPressed: () => setState(() => _open = !_open),
                style: TextButton.styleFrom(
                  foregroundColor: context.tt.goldDeep,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 36),
                ),
                child: Text(_open ? 'Thu gọn' : 'Xem thêm'),
              ),
          ],
        );
      },
    );
  }
}
