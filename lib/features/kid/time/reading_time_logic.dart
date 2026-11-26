import 'package:ai_storytelling_mobile/models/reading_time_dto.dart';

/// Các trạng thái bé không được đọc.
const Set<String> _blockingStates = {
  'Outside',
  'Bedtime',
  'ScreenLimitReached',
  'Break',
};

/// Kiểm tra trạng thái hiện tại có đang chặn bé đọc không.
bool isBlocking(ReadingTimeStatusDto? status) {
  if (status == null) return false;
  return _blockingStates.contains(status.state);
}

const Map<String, String> _codeState = {
  'READING_TIME_BREAK': 'Break',
  'READING_TIME_BEDTIME': 'Bedtime',
  'READING_TIME_SCREEN_LIMIT': 'ScreenLimitReached',
  'READING_TIME_OUTSIDE': 'Outside',
};

/// Mã lỗi READING_TIME_* của phản hồi 403 -> trạng thái chặn tương ứng; mã khác thì null.
String? blockedStateOf(String? errorCode) {
  if (errorCode == null) return null;
  return _codeState[errorCode];
}

/// Tìm trạng thái chặn từ danh sách lỗi 403; không có thì null.
String? blockedStateOfErrors(Iterable<String>? errors) {
  for (final code in errors ?? const <String>[]) {
    final state = _codeState[code];
    if (state != null) return state;
  }
  return null;
}

/// Số giây còn lại tới mốc [target] (làm tròn lên, không âm).
int secondsUntil(DateTime target, DateTime now) {
  final diffMs = target.millisecondsSinceEpoch - now.millisecondsSinceEpoch;
  if (diffMs <= 0) return 0;
  return (diffMs / 1000).ceil();
}

/// "4:05" cho dưới 1 giờ; từ 1 giờ trở lên "1 giờ 5 phút".
String formatCountdown(int seconds) {
  if (seconds >= 3600) {
    final h = seconds ~/ 3600;
    final m = ((seconds % 3600) / 60).ceil();
    if (m == 60) return '${h + 1} giờ';
    if (m == 0) return '$h giờ';
    return '$h giờ $m phút';
  }
  final m = seconds ~/ 60;
  final s = seconds % 60;
  return '$m:${s.toString().padLeft(2, '0')}';
}

/// Số phút làm tròn lên, tối thiểu 1: dùng trong câu "còn 3 phút".
int minutesOf(int seconds) {
  final m = (seconds / 60).ceil();
  return m < 1 ? 1 : m;
}

const Map<String, String> _breakHints = {
  'Eyes': 'Nhìn ra xa một chút cho mắt nghỉ nhé!',
  'Water': 'Em uống một ngụm nước nhé!',
  'Move': 'Em đứng dậy vươn vai, đi lại vài bước nhé!',
};

class RestCopy {
  final String title;
  final String hint;
  final String mood;
  final String label;
  final DateTime? until;

  const RestCopy({
    required this.title,
    required this.hint,
    required this.mood,
    required this.label,
    this.until,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestCopy &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          hint == other.hint &&
          mood == other.mood &&
          label == other.label &&
          until == other.until;

  @override
  int get hashCode => Object.hash(title, hint, mood, label, until);

  @override
  String toString() =>
      'RestCopy(title: $title, hint: $hint, mood: $mood, label: $label, until: $until)';
}

/// Lời cho màn nghỉ / màn chặn: tiêu đề, câu dặn, nhãn đếm ngược và mốc để đếm ngược tới (nếu có).
RestCopy restCopy(ReadingTimeStatusDto status) {
  switch (status.state) {
    case 'Break':
      final hint = _breakHints[status.breakActivity] ?? _breakHints['Eyes']!;
      return RestCopy(
        title: 'Nghỉ một chút nhé',
        hint: hint,
        mood: 'idle',
        label: 'Em đọc tiếp được sau',
        until: status.breakUntil,
      );
    case 'Bedtime':
      return RestCopy(
        title: 'Đến giờ đi ngủ rồi',
        hint: 'Chúc em ngủ ngon! Mai mình đọc tiếp nhé.',
        mood: 'idle',
        label: 'Em đọc tiếp được sau',
        until: status.nextAllowedAt,
      );
    case 'ScreenLimitReached':
      return RestCopy(
        title: 'Hôm nay em đọc đủ rồi',
        hint: 'Mai mình đọc tiếp nhé!',
        mood: 'happy',
        label: 'Em đọc tiếp được sau',
        until: status.nextAllowedAt,
      );
    case 'Outside':
    default:
      return RestCopy(
        title: 'Chưa tới giờ đọc',
        hint: 'Giờ đọc hôm nay đã hết, hẹn em ở giờ đọc sau nhé!',
        mood: 'think',
        label: 'Giờ đọc kế tiếp sau',
        until: status.nextAllowedAt,
      );
  }
}

/// Chip đồng hồ ở đầu sảnh bé (như `timeChip` của web): mốc kết thúc gần nhất backend tính (`endsAt` + `endReason`).
/// Hết phút màn hình → "Còn N phút"; khung giờ / giờ ngủ → "Đọc đến HH:mm" (giờ máy); đang đọc nốt → "Đọc nốt m:ss".
/// `warn` khi còn ≤ 5 phút (EndingSoon) hoặc đang đọc nốt. Không đặt giới hạn hoặc đang bị chặn thì null.
({String text, bool warn})? timeChip(ReadingTimeStatusDto? status, DateTime now) {
  if (status == null) return null;
  if (status.state == 'Grace') {
    final end = status.graceEndsAt;
    return end == null
        ? null
        : (text: 'Đọc nốt ${formatCountdown(secondsUntil(end, now))}', warn: true);
  }
  if (status.state != 'Allowed' && status.state != 'EndingSoon') return null;
  final end = status.endsAt;
  if (end == null) return null;
  final warn = status.state == 'EndingSoon';
  if (status.endReason == 'ScreenLimit') {
    return (text: 'Còn ${minutesOf(secondsUntil(end, now))} phút', warn: warn);
  }
  final local = end.toLocal();
  String two(int n) => n.toString().padLeft(2, '0');
  return (text: 'Đọc đến ${two(local.hour)}:${two(local.minute)}', warn: warn);
}

/// Dòng cảnh báo khi sắp hết giờ (EndingSoon) hoặc đang gia hạn (Grace); các trạng thái khác thì null.
String? warnLine(ReadingTimeStatusDto? status, DateTime now) {
  if (status == null) return null;
  if (status.state == 'EndingSoon') {
    if (status.endsAt == null) {
      return 'Sắp hết giờ đọc rồi nhé!';
    }
    final left = secondsUntil(status.endsAt!, now);
    return 'Sắp hết giờ đọc rồi, còn khoảng ${minutesOf(left)} phút nhé!';
  }
  if (status.state == 'Grace') {
    if (status.graceEndsAt == null) {
      return 'Đến giờ nghỉ rồi, em đọc nốt đoạn này nhé!';
    }
    final left = secondsUntil(status.graceEndsAt!, now);
    return 'Đến giờ nghỉ rồi, em đọc nốt đoạn này nhé! (còn ${formatCountdown(left)})';
  }
  return null;
}

/// Đang trong giờ yên lặng (giờ ngủ): app không được nhắc hay báo gì.
/// Nhận [ChildHabitDto] hoặc danh sách [HabitQuietPeriodDto].
bool isQuiet(Object? periodsOrHabit, DateTime now) {
  final List<HabitQuietPeriodDto>? periods;
  if (periodsOrHabit is ChildHabitDto) {
    periods = periodsOrHabit.quietPeriods;
  } else if (periodsOrHabit is Iterable<HabitQuietPeriodDto>) {
    periods = periodsOrHabit.toList();
  } else {
    periods = null;
  }
  if (periods == null || periods.isEmpty) return false;
  final nowMs = now.millisecondsSinceEpoch;
  return periods.any((p) {
    final fromMs = p.from.millisecondsSinceEpoch;
    final toMs = p.to.millisecondsSinceEpoch;
    return fromMs <= nowMs && nowMs < toMs;
  });
}

/// Lần nhắc đọc kế tiếp sau [now] mà không rơi vào giờ yên lặng; thói quen tắt hoặc hết lần nhắc thì null.
HabitReminderDto? nextReminder(ChildHabitDto? habit, DateTime now) {
  if (habit == null || !habit.enabled) return null;
  final afterMs = now.millisecondsSinceEpoch;
  HabitReminderDto? best;
  int? bestMs;

  for (final r in habit.reminders) {
    final atMs = r.at.millisecondsSinceEpoch;
    if (atMs <= afterMs || isQuiet(habit.quietPeriods, r.at)) {
      continue;
    }
    if (bestMs == null || atMs < bestMs) {
      best = r;
      bestMs = atMs;
    }
  }
  return best;
}

/// Câu tiến độ tuần cho thẻ thói quen: "2 / 3 ngày" khi có mục tiêu, "2 ngày" khi không.
String weekProgressText(ChildHabitDto habit) {
  if (habit.weeklyGoalDays != null) {
    return '${habit.daysReadThisWeek} / ${habit.weeklyGoalDays} ngày';
  }
  return '${habit.daysReadThisWeek} ngày';
}
