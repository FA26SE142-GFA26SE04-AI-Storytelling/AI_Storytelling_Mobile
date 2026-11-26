import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_confirm_dialog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_profile_dto.dart';
import '../../../models/reading_schedule_dto.dart';
import '../../auth/application/auth_controller.dart';
import '../../children/data/child_profile_repository.dart';
import '../../children/presentation/children_providers.dart';
import '../data/reading_schedule_repository.dart';
import 'reading_schedule_form.dart';

// ─── Screen ──────────────────────────────────────────────────────────────────

class ChildTimeHabitsScreen extends ConsumerStatefulWidget {
  const ChildTimeHabitsScreen({super.key, required this.childId});

  final int childId;

  @override
  ConsumerState<ChildTimeHabitsScreen> createState() =>
      _ChildTimeHabitsScreenState();
}

class _ChildTimeHabitsScreenState
    extends ConsumerState<ChildTimeHabitsScreen> {
  bool _loading = true;
  bool _saving = false;
  String? _errorMessage;

  ChildProfileDto? _child;
  ReadingScheduleDto? _dto;

  ScheduleValue? _current;
  ScheduleValue? _saved;

  ScheduleSection? _errorSection;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });
    try {
      final childRepo = ref.read(childProfileRepositoryProvider);
      final schedRepo = ref.read(readingScheduleRepositoryProvider);
      final childFuture = childRepo.fetchById(widget.childId);
      final schedFuture = schedRepo.fetch(widget.childId);
      final child = await childFuture;
      final dto = await schedFuture;
      if (!mounted) return;
      final sv = scheduleFrom(dto);
      setState(() {
        _child = child;
        _dto = dto;
        _current = sv;
        _saved = sv;
        _loading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.message;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Có lỗi xảy ra. Vui lòng thử lại.';
        _loading = false;
      });
    }
  }

  Future<void> _save() async {
    if (_saving || _current == null) return;
    setState(() => _saving = true);
    try {
      final repo = ref.read(readingScheduleRepositoryProvider);
      final body = scheduleRequest(_current!);
      // Chưa lưu lần nào (gợi ý theo tuổi) thì lần lưu này áp dụng cả hai nhóm, như Web.
      final savedGroups = _dto?.isSuggested == true
          ? [...allGroups]
          : changedGroups(_current!, _saved!);
      final newDto = await repo.save(widget.childId, body);
      if (!mounted) return;
      final newSv = scheduleFrom(newDto);
      final nickname = _child?.nickname ?? 'bé';
      final text = groupsText(savedGroups);
      ref.invalidate(childOverviewProvider(widget.childId));
      setState(() {
        _dto = newDto;
        _saved = newSv;
        _current = newSv;
        _errorSection = null;
      });
      showTtToast(
        context,
        'Đã lưu $text của $nickname. Có hiệu lực ngay.',
        type: TtToastType.success,
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      showTtToast(context, e.message, type: TtToastType.error);
      setState(() => _errorSection = sectionOfError(e.message));
    } catch (_) {
      if (!mounted) return;
      showTtToast(context, 'Có lỗi xảy ra. Vui lòng thử lại.',
          type: TtToastType.error);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _update(ScheduleValue next) {
    // Clear error section if user edits a field in that section
    final cleared = _errorSection != null ? _clearErrorIfEdited(next) : false;
    setState(() {
      _current = next;
      if (cleared) _errorSection = null;
    });
  }

  bool _clearErrorIfEdited(ScheduleValue next) {
    if (_errorSection == null || _current == null) return false;
    final c = _current!;
    switch (_errorSection!) {
      case ScheduleSection.windows:
        return !ScheduleValue.listEquals(c.weekday, next.weekday) ||
            !ScheduleValue.listEquals(c.weekend, next.weekend);
      case ScheduleSection.bedtime:
        return c.bedtimeWeekday != next.bedtimeWeekday ||
            c.bedtimeWeekend != next.bedtimeWeekend;
      case ScheduleSection.screen:
        return c.screenLimitEnabled != next.screenLimitEnabled ||
            c.screenLimitWeekdayMinutes != next.screenLimitWeekdayMinutes ||
            c.screenLimitWeekendMinutes != next.screenLimitWeekendMinutes;
      case ScheduleSection.breakSection:
        return c.breakEnabled != next.breakEnabled ||
            c.breakAfterMinutes != next.breakAfterMinutes ||
            c.breakDurationMinutes != next.breakDurationMinutes ||
            c.breakRemindEyes != next.breakRemindEyes ||
            c.breakRemindWater != next.breakRemindWater ||
            c.breakRemindMove != next.breakRemindMove;
      case ScheduleSection.habit:
        return c.habitEnabled != next.habitEnabled ||
            c.readingReminderWeekday != next.readingReminderWeekday ||
            c.readingReminderWeekend != next.readingReminderWeekend ||
            c.weeklyGoalDays != next.weeklyGoalDays;
      case ScheduleSection.general:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final authState = ref.watch(authControllerProvider);
    final currentUserId =
        authState is AuthSignedIn ? authState.user.id : null;
    final isOwner = _child != null &&
        _child!.ownerUserId != null &&
        _child!.ownerUserId == currentUserId;
    final canEdit = isOwner;

    final nickname = _child?.nickname ?? 'bé';
    final groups = (_current != null && _saved != null)
        ? changedGroups(_current!, _saved!)
        : <ScheduleGroup>[];
    final showBar =
        canEdit && (groups.isNotEmpty || (_dto?.isSuggested == true));

    Widget body;
    if (_loading) {
      body = SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TtSkeleton(height: 220),
            SizedBox(height: 16),
            TtSkeleton(height: 160),
            SizedBox(height: 16),
            TtSkeleton(height: 120),
            SizedBox(height: 16),
            TtSkeleton(height: 180),
            SizedBox(height: 16),
            TtSkeleton(height: 160),
          ],
        ),
      );
    } else if (_errorMessage != null) {
      body = Center(
        child: TtErrorState(message: _errorMessage!, onRetry: _load),
      );
    } else if (_current != null && _saved != null) {
      body = _TimeHabitsBody(
        nickname: nickname,
        dto: _dto!,
        current: _current!,
        canEdit: canEdit,
        saving: _saving,
        errorSection: _errorSection,
        onChanged: _update,
      );
    } else {
      body = const SizedBox.shrink();
    }

    Widget? bottomBar;
    if (showBar && _current != null && _saved != null) {
      final labelText = groups.isNotEmpty
          ? 'Chưa lưu: ${groupsText(groups)}.'
          : 'Áp dụng gợi ý cho $nickname?';
      final btnLabel = _dto?.isSuggested == true
          ? 'Lưu gợi ý'
          : saveLabel(groups);
      bottomBar = SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: tt.panel,
            border: Border(top: BorderSide(color: tt.line2, width: 1.5)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  labelText,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: tt.muted,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              TtButton(
                label: btnLabel,
                icon: Icons.save_rounded,
                isLoading: _saving,
                onPressed: _saving ? null : _save,
              ),
            ],
          ),
        ),
      );
    }

    return PopScope(
      canPop: groups.isEmpty,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final confirmed = await showConfirmDialog(
          context,
          title: 'Bỏ thay đổi chưa lưu?',
          message:
              'Bạn có thay đổi chưa được lưu. Bỏ đi và thoát khỏi màn hình?',
          confirmLabel: 'Bỏ thay đổi',
          cancelLabel: 'Ở lại',
          destructive: true,
        );
        if (!context.mounted) return;
        if (confirmed) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Thời gian & thói quen')),
        body: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: body,
          ),
        ),
        bottomNavigationBar: bottomBar,
      ),
    );
  }
}

// ─── Body ─────────────────────────────────────────────────────────────────────

class _TimeHabitsBody extends StatelessWidget {
  const _TimeHabitsBody({
    required this.nickname,
    required this.dto,
    required this.current,
    required this.canEdit,
    required this.saving,
    required this.errorSection,
    required this.onChanged,
  });

  final String nickname;
  final ReadingScheduleDto dto;
  final ScheduleValue current;
  final bool canEdit;
  final bool saving;
  final ScheduleSection? errorSection;
  final ValueChanged<ScheduleValue> onChanged;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final locked = !canEdit || saving;

    // Cards with staggered animation delays
    final cards = <Widget>[
      if (!canEdit)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'Chỉ người quản lý chính của bé mới sửa được phần này.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: tt.muted,
                ),
          ),
        ),
      if (dto.isSuggested) _SuggestedBanner(nickname: nickname),
      _ReadingLimitCard(
        current: current,
        locked: locked,
        hasWindowsError: errorSection == ScheduleSection.windows,
        hasBedtimeError: errorSection == ScheduleSection.bedtime,
        onChanged: onChanged,
      ),
      const SizedBox(height: 4),
      _SectionHeader(title: 'Màn hình & nghỉ giữa giờ'),
      _ScreenLimitCard(
        current: current,
        locked: locked,
        hasError: errorSection == ScheduleSection.screen,
        onChanged: onChanged,
      ),
      _BreakCard(
        current: current,
        locked: locked,
        hasError: errorSection == ScheduleSection.breakSection,
        onChanged: onChanged,
      ),
      const SizedBox(height: 4),
      _SectionHeader(title: 'Thói quen đọc'),
      _HabitCard(
        nickname: nickname,
        dto: dto,
        current: current,
        locked: locked,
        hasError: errorSection == ScheduleSection.habit,
        onChanged: onChanged,
      ),
      const SizedBox(height: 16),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < cards.length; i++) ...[
            if (i > 0 && cards[i] is! SizedBox && cards[i - 1] is! SizedBox && cards[i] is! _SectionHeader && cards[i - 1] is! _SectionHeader)
              const SizedBox(height: 12),
            cards[i]
                .animate()
                .fadeIn(duration: 300.ms, delay: (60 * i).ms)
                .slideY(begin: 0.05, end: 0, duration: 300.ms, delay: (60 * i).ms),
          ],
        ],
      ),
    );
  }
}

// ─── Suggested Banner ─────────────────────────────────────────────────────────

class _SuggestedBanner extends StatelessWidget {
  const _SuggestedBanner({required this.nickname});
  final String nickname;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: tt.gold.withValues(alpha: 0.15),
        border: Border.all(color: tt.goldDeep, width: 1.5),
        borderRadius: BorderRadius.circular(TtRadius.lg),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_rounded, color: tt.goldDeep, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gợi ý theo độ tuổi của $nickname',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: tt.goldDeep,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Cấu hình này chưa được lưu. Bạn có thể điều chỉnh theo ý muốn rồi bấm Lưu.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: tt.warnInk,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: tt.text,
            ),
      ),
    );
  }
}

// ─── Card Header ──────────────────────────────────────────────────────────────

class _CardHeader extends StatelessWidget {
  const _CardHeader({
    required this.icon,
    required this.title,
    required this.description,
    this.iconColor,
    this.iconBg,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color? iconColor;
  final Color? iconBg;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconBg ?? tt.surface,
            borderRadius: BorderRadius.circular(TtRadius.md),
          ),
          child: Icon(icon, size: 18, color: iconColor ?? tt.muted),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: tt.text,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: tt.muted,
                    ),
              ),
            ],
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
      ],
    );
  }
}

// ─── Status Pill ──────────────────────────────────────────────────────────────

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.active});
  final bool active;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final color = active ? tt.primary : tt.muted;
    final bg = active
        ? tt.primary.withValues(alpha: 0.12)
        : tt.muted.withValues(alpha: 0.1);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        active ? 'Đang áp dụng' : 'Đang tắt',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

// ─── Time Button ─────────────────────────────────────────────────────────────

class _TimeButton extends StatelessWidget {
  const _TimeButton({
    required this.value,
    required this.onTap,
    this.locked = false,
  });

  final String value;
  final VoidCallback onTap;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final display = value.isEmpty ? '--:--' : value;
    return GestureDetector(
      onTap: locked ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: tt.panel,
          borderRadius: BorderRadius.circular(TtRadius.md),
          border: Border.all(color: tt.line2, width: 1.5),
        ),
        child: Text(
          display,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: value.isEmpty ? tt.faint : tt.text,
                fontWeight: FontWeight.w600,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
        ),
      ),
    );
  }
}

// ─── Helper: pick time ───────────────────────────────────────────────────────

Future<TimeOfDay?> _pickTime(BuildContext context, String current) {
  TimeOfDay initial = TimeOfDay.now();
  if (current.isNotEmpty) {
    final parts = current.split(':');
    if (parts.length == 2) {
      initial = TimeOfDay(
        hour: int.tryParse(parts[0]) ?? 0,
        minute: int.tryParse(parts[1]) ?? 0,
      );
    }
  }
  return showTimePicker(
    context: context,
    initialTime: initial,
    builder: (ctx, child) => MediaQuery(
      data: MediaQuery.of(ctx).copyWith(alwaysUse24HourFormat: true),
      child: child!,
    ),
  );
}

String _formatTod(TimeOfDay t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

bool _inBedtimeRange(TimeOfDay t) {
  final minParts = bedtimeRange.min.split(':');
  final maxParts = bedtimeRange.max.split(':');
  final minTod =
      TimeOfDay(hour: int.parse(minParts[0]), minute: int.parse(minParts[1]));
  final maxTod =
      TimeOfDay(hour: int.parse(maxParts[0]), minute: int.parse(maxParts[1]));
  final tMin = t.hour * 60 + t.minute;
  final rMin = minTod.hour * 60 + minTod.minute;
  final rMax = maxTod.hour * 60 + maxTod.minute;
  return tMin >= rMin && tMin <= rMax;
}

bool _afterReminderMin(TimeOfDay t) {
  final parts = reminderMin.split(':');
  final minTod =
      TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  return t.hour * 60 + t.minute >= minTod.hour * 60 + minTod.minute;
}

// ─── Reading Limit Card ───────────────────────────────────────────────────────

class _ReadingLimitCard extends StatelessWidget {
  const _ReadingLimitCard({
    required this.current,
    required this.locked,
    required this.hasWindowsError,
    required this.hasBedtimeError,
    required this.onChanged,
  });

  final ScheduleValue current;
  final bool locked;
  final bool hasWindowsError;
  final bool hasBedtimeError;
  final ValueChanged<ScheduleValue> onChanged;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return TtCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(
            icon: Icons.shield_rounded,
            title: 'Giới hạn thời gian đọc',
            description:
                'Kiểm soát khi nào và bao lâu bé được đọc mỗi ngày.',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StatusPill(active: current.enabled),
                const SizedBox(width: 8),
                Switch(
                  value: current.enabled,
                  onChanged: locked
                      ? null
                      : (v) => onChanged(current.copyWith(enabled: v)),
                  activeThumbColor: tt.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Opacity(
            opacity: current.enabled ? 1.0 : 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _WindowsCard(
                  current: current,
                  locked: locked || !current.enabled,
                  hasError: hasWindowsError,
                  onChanged: onChanged,
                ),
                const SizedBox(height: 12),
                _BedtimeCard(
                  current: current,
                  locked: locked || !current.enabled,
                  hasError: hasBedtimeError,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Windows Card ─────────────────────────────────────────────────────────────

class _WindowsCard extends StatelessWidget {
  const _WindowsCard({
    required this.current,
    required this.locked,
    required this.hasError,
    required this.onChanged,
  });

  final ScheduleValue current;
  final bool locked;
  final bool hasError;
  final ValueChanged<ScheduleValue> onChanged;

  Future<void> _pickStart(
      BuildContext context, List<TimeRange> ranges, int i, bool isWeekday) async {
    final tod = await _pickTime(context, ranges[i].start);
    if (tod == null) return;
    final newRanges = List<TimeRange>.from(ranges);
    newRanges[i] = newRanges[i].copyWith(start: _formatTod(tod));
    onChanged(isWeekday
        ? current.copyWith(weekday: newRanges)
        : current.copyWith(weekend: newRanges));
  }

  Future<void> _pickEnd(
      BuildContext context, List<TimeRange> ranges, int i, bool isWeekday) async {
    final tod = await _pickTime(context, ranges[i].end);
    if (tod == null) return;
    final newRanges = List<TimeRange>.from(ranges);
    newRanges[i] = newRanges[i].copyWith(end: _formatTod(tod));
    onChanged(isWeekday
        ? current.copyWith(weekday: newRanges)
        : current.copyWith(weekend: newRanges));
  }

  void _remove(List<TimeRange> ranges, int i, bool isWeekday) {
    final newRanges = List<TimeRange>.from(ranges)..removeAt(i);
    onChanged(isWeekday
        ? current.copyWith(weekday: newRanges)
        : current.copyWith(weekend: newRanges));
  }

  void _add(List<TimeRange> ranges, bool isWeekday) {
    final newRanges = [...ranges, const TimeRange(start: '', end: '')];
    onChanged(isWeekday
        ? current.copyWith(weekday: newRanges)
        : current.copyWith(weekend: newRanges));
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Container(
      decoration: BoxDecoration(
        color: tt.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(TtRadius.md),
        border: Border.all(
          color: hasError ? tt.danger : tt.line,
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.schedule_rounded, size: 16, color: tt.muted),
            const SizedBox(width: 6),
            Text(
              'Khung giờ được đọc',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: tt.text,
                  ),
            ),
          ]),
          const SizedBox(height: 10),
          _DayWindowsSection(
            label: 'Ngày thường',
            sublabel: 'Thứ 2 – Thứ 6',
            ranges: current.weekday,
            locked: locked,
            isWeekday: true,
            onPickStart: (ctx, i) => _pickStart(ctx, current.weekday, i, true),
            onPickEnd: (ctx, i) => _pickEnd(ctx, current.weekday, i, true),
            onRemove: (i) => _remove(current.weekday, i, true),
            onAdd: () => _add(current.weekday, true),
          ),
          const SizedBox(height: 10),
          _DayWindowsSection(
            label: 'Cuối tuần',
            sublabel: 'Thứ 7, Chủ nhật',
            ranges: current.weekend,
            locked: locked,
            isWeekday: false,
            onPickStart: (ctx, i) => _pickStart(ctx, current.weekend, i, false),
            onPickEnd: (ctx, i) => _pickEnd(ctx, current.weekend, i, false),
            onRemove: (i) => _remove(current.weekend, i, false),
            onAdd: () => _add(current.weekend, false),
          ),
        ],
      ),
    );
  }
}

class _DayWindowsSection extends StatelessWidget {
  const _DayWindowsSection({
    required this.label,
    required this.sublabel,
    required this.ranges,
    required this.locked,
    required this.isWeekday,
    required this.onPickStart,
    required this.onPickEnd,
    required this.onRemove,
    required this.onAdd,
  });

  final String label;
  final String sublabel;
  final List<TimeRange> ranges;
  final bool locked;
  final bool isWeekday;
  final void Function(BuildContext, int) onPickStart;
  final void Function(BuildContext, int) onPickEnd;
  final void Function(int) onRemove;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: tt.text,
                ),
          ),
          const SizedBox(width: 6),
          Text(
            sublabel,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: tt.muted,
                ),
          ),
        ]),
        const SizedBox(height: 6),
        if (ranges.isEmpty)
          Text(
            'Chưa đặt khung: bé được đọc bất cứ lúc nào (vẫn theo giờ ngủ, nghỉ mắt & màn hình).',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: tt.muted,
                  fontStyle: FontStyle.italic,
                ),
          )
        else
          for (int i = 0; i < ranges.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  _TimeButton(
                    value: ranges[i].start,
                    locked: locked,
                    onTap: () => onPickStart(context, i),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      '→',
                      style: TextStyle(color: tt.muted),
                    ),
                  ),
                  _TimeButton(
                    value: ranges[i].end,
                    locked: locked,
                    onTap: () => onPickEnd(context, i),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    icon: Icon(Icons.close_rounded, size: 18, color: tt.muted),
                    onPressed: locked ? null : () => onRemove(i),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    tooltip: 'Xoá khung giờ',
                  ),
                ],
              ),
            ),
        const SizedBox(height: 4),
        TextButton.icon(
          onPressed: (locked || ranges.length >= maxWindows) ? null : onAdd,
          icon: Icon(Icons.add_rounded, size: 16, color: tt.primary),
          label: Text(
            '+ Thêm khung giờ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: tt.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 32),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }
}

// ─── Bedtime Card ─────────────────────────────────────────────────────────────

class _BedtimeCard extends StatelessWidget {
  const _BedtimeCard({
    required this.current,
    required this.locked,
    required this.hasError,
    required this.onChanged,
  });

  final ScheduleValue current;
  final bool locked;
  final bool hasError;
  final ValueChanged<ScheduleValue> onChanged;

  Future<void> _pick(
      BuildContext context, String field, String currentVal) async {
    final tod = await _pickTime(context, currentVal);
    if (tod == null) return;
    if (!_inBedtimeRange(tod)) {
      if (!context.mounted) return;
      showTtToast(
        context,
        'Giờ ngủ cần trong khoảng ${bedtimeRange.min} – ${bedtimeRange.max}.',
        type: TtToastType.error,
      );
      return;
    }
    final formatted = _formatTod(tod);
    onChanged(field == 'weekday'
        ? current.copyWith(bedtimeWeekday: formatted)
        : current.copyWith(bedtimeWeekend: formatted));
  }

  void _clear(String field) {
    onChanged(field == 'weekday'
        ? current.copyWith(bedtimeWeekday: '')
        : current.copyWith(bedtimeWeekend: ''));
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Container(
      decoration: BoxDecoration(
        color: tt.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(TtRadius.md),
        border: Border.all(
          color: hasError ? tt.danger : tt.line,
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.bedtime_rounded, size: 16, color: tt.muted),
            const SizedBox(width: 6),
            Text(
              'Giờ đi ngủ',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: tt.text,
                  ),
            ),
          ]),
          const SizedBox(height: 10),
          _BedtimeRow(
            label: 'Ngày thường',
            value: current.bedtimeWeekday,
            locked: locked,
            onPick: () => _pick(context, 'weekday', current.bedtimeWeekday),
            onClear: current.bedtimeWeekday.isEmpty ? null : () => _clear('weekday'),
          ),
          const SizedBox(height: 8),
          _BedtimeRow(
            label: 'Cuối tuần',
            value: current.bedtimeWeekend,
            locked: locked,
            onPick: () => _pick(context, 'weekend', current.bedtimeWeekend),
            onClear: current.bedtimeWeekend.isEmpty ? null : () => _clear('weekend'),
          ),
        ],
      ),
    );
  }
}

class _BedtimeRow extends StatelessWidget {
  const _BedtimeRow({
    required this.label,
    required this.value,
    required this.locked,
    required this.onPick,
    required this.onClear,
  });

  final String label;
  final String value;
  final bool locked;
  final VoidCallback onPick;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Row(
      children: [
        SizedBox(
          width: 96,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: tt.text,
                ),
          ),
        ),
        _TimeButton(value: value, locked: locked, onTap: onPick),
        if (onClear != null) ...[
          const SizedBox(width: 4),
          IconButton(
            icon: Icon(Icons.close_rounded, size: 16, color: tt.muted),
            onPressed: locked ? null : onClear,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            tooltip: 'Bỏ giờ ngủ',
          ),
        ],
      ],
    );
  }
}

// ─── Screen Limit Card ───────────────────────────────────────────────────────

class _ScreenLimitCard extends StatelessWidget {
  const _ScreenLimitCard({
    required this.current,
    required this.locked,
    required this.hasError,
    required this.onChanged,
  });

  final ScheduleValue current;
  final bool locked;
  final bool hasError;
  final ValueChanged<ScheduleValue> onChanged;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final sliderLocked = locked || !current.screenLimitEnabled;
    return TtCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(
            icon: Icons.phone_android_rounded,
            title: 'Thời gian nhìn màn hình',
            description:
                'Giới hạn tổng thời gian bé dùng màn hình đọc sách mỗi ngày.',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StatusPill(active: current.screenLimitEnabled),
                const SizedBox(width: 8),
                Switch(
                  value: current.screenLimitEnabled,
                  onChanged: locked
                      ? null
                      : (v) =>
                          onChanged(current.copyWith(screenLimitEnabled: v)),
                  activeThumbColor: tt.primary,
                ),
              ],
            ),
          ),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Có lỗi với cài đặt màn hình. Vui lòng kiểm tra lại.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: tt.danger,
                    ),
              ),
            ),
          const SizedBox(height: 16),
          Opacity(
            opacity: current.screenLimitEnabled ? 1.0 : 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LabeledSlider(
                  label: 'Ngày thường',
                  value: current.screenLimitWeekdayMinutes.toDouble(),
                  min: screenLimitRange.min.toDouble(),
                  max: screenLimitRange.max.toDouble(),
                  divisions: (screenLimitRange.max - screenLimitRange.min) ~/
                      screenLimitRange.step,
                  locked: sliderLocked,
                  formatLabel: (v) => '${v.round()} phút',
                  onChanged: (v) => onChanged(current.copyWith(
                      screenLimitWeekdayMinutes:
                          _snap(v.round(), screenLimitRange))),
                ),
                const SizedBox(height: 8),
                _LabeledSlider(
                  label: 'Cuối tuần',
                  value: current.screenLimitWeekendMinutes.toDouble(),
                  min: screenLimitRange.min.toDouble(),
                  max: screenLimitRange.max.toDouble(),
                  divisions: (screenLimitRange.max - screenLimitRange.min) ~/
                      screenLimitRange.step,
                  locked: sliderLocked,
                  formatLabel: (v) => '${v.round()} phút',
                  onChanged: (v) => onChanged(current.copyWith(
                      screenLimitWeekendMinutes:
                          _snap(v.round(), screenLimitRange))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

int _snap(int v, NumberRange r) {
  int snapped = ((v - r.min) / r.step).round() * r.step + r.min;
  return snapped.clamp(r.min, r.max);
}

// ─── Labeled Slider ──────────────────────────────────────────────────────────

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.locked,
    required this.formatLabel,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final bool locked;
  final String Function(double) formatLabel;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: tt.text,
                ),
          ),
        ),
        Expanded(
          child: Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            divisions: divisions,
            onChanged: locked ? null : onChanged,
            activeColor: tt.primary,
            inactiveColor: tt.line2,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: tt.surface,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            formatLabel(value),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: tt.text,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}

// ─── Break Card ───────────────────────────────────────────────────────────────

class _BreakCard extends StatelessWidget {
  const _BreakCard({
    required this.current,
    required this.locked,
    required this.hasError,
    required this.onChanged,
  });

  final ScheduleValue current;
  final bool locked;
  final bool hasError;
  final ValueChanged<ScheduleValue> onChanged;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final sliderLocked = locked || !current.breakEnabled;
    return TtCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(
            icon: Icons.visibility_rounded,
            title: 'Nghỉ giữa các phiên đọc',
            description:
                'Nhắc bé nghỉ giải lao để bảo vệ mắt và sức khoẻ.',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StatusPill(active: current.breakEnabled),
                const SizedBox(width: 8),
                Switch(
                  value: current.breakEnabled,
                  onChanged: locked
                      ? null
                      : (v) => onChanged(current.copyWith(breakEnabled: v)),
                  activeThumbColor: tt.primary,
                ),
              ],
            ),
          ),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Có lỗi với cài đặt nghỉ giữa giờ. Vui lòng kiểm tra lại.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: tt.danger,
                    ),
              ),
            ),
          const SizedBox(height: 16),
          Opacity(
            opacity: current.breakEnabled ? 1.0 : 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LabeledSlider(
                  label: 'Nghỉ sau mỗi',
                  value: current.breakAfterMinutes.toDouble(),
                  min: breakAfterRange.min.toDouble(),
                  max: breakAfterRange.max.toDouble(),
                  divisions:
                      (breakAfterRange.max - breakAfterRange.min) ~/
                          breakAfterRange.step,
                  locked: sliderLocked,
                  formatLabel: (v) => '${v.round()} phút',
                  onChanged: (v) => onChanged(current.copyWith(
                      breakAfterMinutes:
                          _snap(v.round(), breakAfterRange))),
                ),
                const SizedBox(height: 8),
                _LabeledSlider(
                  label: 'Mỗi lần nghỉ',
                  value: current.breakDurationMinutes.toDouble(),
                  min: breakDurationRange.min.toDouble(),
                  max: breakDurationRange.max.toDouble(),
                  divisions:
                      (breakDurationRange.max - breakDurationRange.min) ~/
                          breakDurationRange.step,
                  locked: sliderLocked,
                  formatLabel: (v) => '${v.round()} phút',
                  onChanged: (v) => onChanged(current.copyWith(
                      breakDurationMinutes:
                          _snap(v.round(), breakDurationRange))),
                ),
                const SizedBox(height: 12),
                Text(
                  'Lời nhắc trên màn nghỉ (chọn ít nhất một)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: tt.muted,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    FilterChip(
                      avatar: Icon(Icons.visibility_rounded,
                          size: 14, color: tt.primary),
                      label: const Text('Thư giãn mắt'),
                      selected: current.breakRemindEyes,
                      onSelected: sliderLocked
                          ? null
                          : (v) =>
                              onChanged(current.copyWith(breakRemindEyes: v)),
                      selectedColor: tt.primary.withValues(alpha: 0.15),
                      checkmarkColor: tt.primary,
                    ),
                    FilterChip(
                      avatar: Icon(Icons.water_drop_rounded,
                          size: 14, color: tt.sky),
                      label: const Text('Uống nước'),
                      selected: current.breakRemindWater,
                      onSelected: sliderLocked
                          ? null
                          : (v) =>
                              onChanged(current.copyWith(breakRemindWater: v)),
                      selectedColor: tt.sky.withValues(alpha: 0.15),
                      checkmarkColor: tt.sky,
                    ),
                    FilterChip(
                      avatar: Icon(Icons.directions_walk_rounded,
                          size: 14, color: tt.mint),
                      label: const Text('Đứng dậy vận động'),
                      selected: current.breakRemindMove,
                      onSelected: sliderLocked
                          ? null
                          : (v) =>
                              onChanged(current.copyWith(breakRemindMove: v)),
                      selectedColor: tt.mint.withValues(alpha: 0.15),
                      checkmarkColor: tt.mint,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Habit Card ───────────────────────────────────────────────────────────────

class _HabitCard extends StatelessWidget {
  const _HabitCard({
    required this.nickname,
    required this.dto,
    required this.current,
    required this.locked,
    required this.hasError,
    required this.onChanged,
  });

  final String nickname;
  final ReadingScheduleDto dto;
  final ScheduleValue current;
  final bool locked;
  final bool hasError;
  final ValueChanged<ScheduleValue> onChanged;

  Future<void> _pickReminder(
      BuildContext context, String field, String currentVal) async {
    final tod = await _pickTime(context, currentVal);
    if (tod == null) return;
    if (!_afterReminderMin(tod)) {
      if (!context.mounted) return;
      showTtToast(
        context,
        'Giờ nhắc phải từ $reminderMin trở đi.',
        type: TtToastType.error,
      );
      return;
    }
    final formatted = _formatTod(tod);
    onChanged(field == 'weekday'
        ? current.copyWith(readingReminderWeekday: formatted)
        : current.copyWith(readingReminderWeekend: formatted));
  }

  void _clearReminder(String field) {
    onChanged(field == 'weekday'
        ? current.copyWith(readingReminderWeekday: '')
        : current.copyWith(readingReminderWeekend: ''));
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final ctrlLocked = locked || !current.habitEnabled;

    return TtCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(
            icon: Icons.auto_awesome_rounded,
            iconColor: tt.goldDeep,
            iconBg: tt.gold.withValues(alpha: 0.2),
            title: 'Thói quen & mục tiêu đọc',
            description:
                'Nhắc bé đọc sách đúng giờ và theo dõi tiến độ hàng tuần.',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StatusPill(active: current.habitEnabled),
                const SizedBox(width: 8),
                Switch(
                  value: current.habitEnabled,
                  onChanged: locked
                      ? null
                      : (v) => onChanged(current.copyWith(habitEnabled: v)),
                  activeThumbColor: tt.primary,
                ),
              ],
            ),
          ),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Có lỗi với cài đặt thói quen. Vui lòng kiểm tra lại.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: tt.danger,
                    ),
              ),
            ),
          const SizedBox(height: 16),
          Opacity(
            opacity: current.habitEnabled ? 1.0 : 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Giờ nhắc đọc sách',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: tt.text,
                      ),
                ),
                const SizedBox(height: 8),
                _BedtimeRow(
                  label: 'Ngày thường',
                  value: current.readingReminderWeekday,
                  locked: ctrlLocked,
                  onPick: () => _pickReminder(
                      context, 'weekday', current.readingReminderWeekday),
                  onClear: current.readingReminderWeekday.isEmpty
                      ? null
                      : () => _clearReminder('weekday'),
                ),
                const SizedBox(height: 8),
                _BedtimeRow(
                  label: 'Cuối tuần',
                  value: current.readingReminderWeekend,
                  locked: ctrlLocked,
                  onPick: () => _pickReminder(
                      context, 'weekend', current.readingReminderWeekend),
                  onClear: current.readingReminderWeekend.isEmpty
                      ? null
                      : () => _clearReminder('weekend'),
                ),
                const SizedBox(height: 14),
                Text(
                  'Mục tiêu đọc hàng tuần',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: tt.text,
                      ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    ChoiceChip(
                      label: const Text('Không đặt'),
                      selected: current.weeklyGoalDays == null,
                      onSelected: ctrlLocked
                          ? null
                          : (_) => onChanged(
                              current.copyWith(weeklyGoalDays: null)),
                      selectedColor: tt.surface2,
                    ),
                    for (final g in weeklyGoals)
                      ChoiceChip(
                        label: Text(g == 1 ? '1 ngày' : '$g ngày'),
                        selected: current.weeklyGoalDays == g,
                        onSelected: ctrlLocked
                            ? null
                            : (_) => onChanged(
                                current.copyWith(weeklyGoalDays: g)),
                        selectedColor: tt.gold.withValues(alpha: 0.3),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (dto.habit != null) ...[
            const SizedBox(height: 16),
            _HabitProgress(
              habit: dto.habit!,
              weeklyGoalDays: current.weeklyGoalDays,
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Habit Progress ───────────────────────────────────────────────────────────

class _HabitProgress extends StatelessWidget {
  const _HabitProgress({
    required this.habit,
    required this.weeklyGoalDays,
  });

  final ReadingHabitProgressDto habit;
  final int? weeklyGoalDays;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final goal = weeklyGoalDays;
    final x = habit.daysReadThisWeek;
    final goalMet = habit.goalMetThisWeek;
    final remaining = goal != null ? (goal - x).clamp(0, goal) : null;
    final progress = goal != null && goal > 0 ? (x / goal).clamp(0.0, 1.0) : null;

    return Container(
      decoration: BoxDecoration(
        color: tt.gold.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(TtRadius.md),
        border: Border.all(color: tt.goldDeep.withValues(alpha: 0.3), width: 1.5),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.local_fire_department_rounded,
                size: 18, color: tt.goldDeep),
            const SizedBox(width: 6),
            Text(
              'Chuỗi ngày đọc: ${habit.streakDays} ngày',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: tt.text,
                  ),
            ),
          ]),
          const SizedBox(height: 6),
          Text(
            'Từ Thứ 2: $x${goal != null ? ' / $goal' : ''} ngày',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: tt.muted,
                ),
          ),
          if (progress != null) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: LinearProgressIndicator(
                value: progress,
                color: tt.gold,
                backgroundColor: tt.line,
                minHeight: 6,
              ),
            ),
          ],
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: goalMet
                  ? tt.gold.withValues(alpha: 0.25)
                  : tt.surface,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: goalMet ? tt.goldDeep : tt.line2,
              ),
            ),
            child: Text(
              goalMet
                  ? 'Đã đạt mục tiêu'
                  : (remaining != null
                      ? 'Còn $remaining ngày'
                      : 'Chưa đặt mục tiêu'),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: goalMet ? tt.goldDeep : tt.muted,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
