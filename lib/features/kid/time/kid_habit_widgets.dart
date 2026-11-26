import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../models/reading_time_dto.dart';
import 'reading_time_logic.dart';

const String _kDefaultReminderMessage = 'Đến giờ đọc truyện rồi, bé vào đọc nhé!';

/// Dải hiển thị thói quen đọc của bé: chuỗi ngày đọc, tiến độ tuần, các chấm mục tiêu và câu đạt mục tiêu.
class KidHabitStrip extends StatelessWidget {
  const KidHabitStrip({
    super.key,
    required this.habit,
  });

  final ChildHabitDto habit;

  @override
  Widget build(BuildContext context) {
    if (!habit.enabled) {
      return const SizedBox.shrink();
    }

    final tt = context.tt;
    final goal = habit.weeklyGoalDays;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: tt.panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: tt.line2, width: 1.5),
      ),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_fire_department,
                color: Colors.orange.shade700,
                size: 20,
              ),
              const SizedBox(width: 4),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 14,
                    color: tt.text,
                  ),
                  children: [
                    const TextSpan(text: 'Chuỗi ngày đọc '),
                    TextSpan(
                      text: '${habit.streakDays} ngày',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (habit.goalMetThisWeek) ...[
                Icon(
                  Icons.emoji_events,
                  size: 18,
                  color: tt.goldDeep,
                ),
                const SizedBox(width: 4),
              ],
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 14,
                    color: tt.text,
                  ),
                  children: [
                    const TextSpan(text: 'Tuần này em đọc '),
                    TextSpan(
                      text: weekProgressText(habit),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (goal != null && goal > 0)
            Semantics(
              label: '${habit.daysReadThisWeek.clamp(0, goal)} trên $goal ngày',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(goal, (i) {
                  final isFilled = i < habit.daysReadThisWeek;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFilled ? tt.primary : Colors.transparent,
                      border: Border.all(color: tt.primary, width: 2),
                    ),
                  );
                }),
              ),
            ),
          if (habit.goalMetThisWeek)
            Text(
              'Em đạt mục tiêu tuần này rồi!',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: tt.okInk,
              ),
            ),
        ],
      ),
    );
  }
}

/// Thẻ thông báo nhắc bé đọc truyện với nút đóng.
class KidReminderCard extends StatelessWidget {
  const KidReminderCard({
    super.key,
    required this.reminder,
    required this.onClose,
  });

  final HabitReminderDto reminder;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final message = reminder.message.trim().isNotEmpty
        ? reminder.message.trim()
        : _kDefaultReminderMessage;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
      decoration: BoxDecoration(
        color: tt.gold.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: tt.goldDeep.withValues(alpha: 0.4),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.notifications_active_outlined,
            size: 20,
            color: tt.warnInk,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: tt.text,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            tooltip: 'Đóng lời nhắc',
            onPressed: onClose,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            color: tt.text.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }
}

/// Widget bọc kiểm tra chu kỳ 30s và hiển thị KidReminderCard phía trên widget con khi đến giờ nhắc.
class KidReminderHost extends StatefulWidget {
  const KidReminderHost({
    super.key,
    required this.habit,
    required this.child,
  });

  final ChildHabitDto? habit;
  final Widget child;

  @override
  State<KidReminderHost> createState() => _KidReminderHostState();
}

class _KidReminderHostState extends State<KidReminderHost> {
  Timer? _timer;
  final Set<DateTime> _dismissedAts = <DateTime>{};
  HabitReminderDto? _activeReminder;

  /// Như Web: chỉ nhắc các mốc tới giờ trong lúc app đang mở, không hiện lại mốc đã qua trước khi vào sảnh.
  final DateTime _since = DateTime.now();

  @override
  void initState() {
    super.initState();
    _checkReminders();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      _checkReminders();
    });
  }

  @override
  void didUpdateWidget(KidReminderHost oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.habit != widget.habit) {
      _dismissedAts.clear();
      _checkReminders();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _checkReminders() {
    final habit = widget.habit;
    if (habit == null || !habit.enabled) {
      if (_activeReminder != null && mounted) {
        setState(() => _activeReminder = null);
      }
      return;
    }

    final now = DateTime.now();
    if (isQuiet(habit, now)) {
      if (_activeReminder != null && mounted) {
        setState(() => _activeReminder = null);
      }
      return;
    }

    HabitReminderDto? due;
    for (final r in habit.reminders) {
      final isDue = r.at.isAfter(_since) && !r.at.isAfter(now);
      if (isDue &&
          !_dismissedAts.contains(r.at) &&
          !isQuiet(habit.quietPeriods, r.at)) {
        if (due == null || r.at.isAfter(due.at)) {
          due = r;
        }
      }
    }

    if (_activeReminder != due && mounted) {
      setState(() => _activeReminder = due);
    }
  }

  @override
  Widget build(BuildContext context) {
    final reminder = _activeReminder;
    final showReminder =
        reminder != null && (widget.habit?.enabled ?? false);

    if (!showReminder) {
      return widget.child;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KidReminderCard(
          reminder: reminder,
          onClose: () {
            setState(() {
              _dismissedAts.add(reminder.at);
              _activeReminder = null;
            });
          },
        ),
        const SizedBox(height: 10),
        widget.child,
      ],
    );
  }
}
