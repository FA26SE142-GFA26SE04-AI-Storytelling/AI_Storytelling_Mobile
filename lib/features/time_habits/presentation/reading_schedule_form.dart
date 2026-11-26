import '../../../models/reading_schedule_dto.dart';

class TimeRange {
  final String start;
  final String end;

  const TimeRange({required this.start, required this.end});

  TimeRange copyWith({String? start, String? end}) => TimeRange(
        start: start ?? this.start,
        end: end ?? this.end,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeRange &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => Object.hash(start, end);
}

/// Giá trị form: giờ là chuỗi HH:mm ("" = chưa đặt), khung giờ tách theo ngày thường / cuối tuần.
class ScheduleValue {
  static const Object _sentinel = Object();

  final bool enabled;
  final List<TimeRange> weekday;
  final List<TimeRange> weekend;
  final String bedtimeWeekday;
  final String bedtimeWeekend;
  final bool breakEnabled;
  final int breakAfterMinutes;
  final int breakDurationMinutes;
  final bool breakRemindEyes;
  final bool breakRemindWater;
  final bool breakRemindMove;
  final bool screenLimitEnabled;
  final int screenLimitWeekdayMinutes;
  final int screenLimitWeekendMinutes;
  final bool habitEnabled;
  final String readingReminderWeekday;
  final String readingReminderWeekend;
  final int? weeklyGoalDays;

  const ScheduleValue({
    required this.enabled,
    required this.weekday,
    required this.weekend,
    required this.bedtimeWeekday,
    required this.bedtimeWeekend,
    required this.breakEnabled,
    required this.breakAfterMinutes,
    required this.breakDurationMinutes,
    required this.breakRemindEyes,
    required this.breakRemindWater,
    required this.breakRemindMove,
    required this.screenLimitEnabled,
    required this.screenLimitWeekdayMinutes,
    required this.screenLimitWeekendMinutes,
    required this.habitEnabled,
    required this.readingReminderWeekday,
    required this.readingReminderWeekend,
    this.weeklyGoalDays,
  });

  ScheduleValue copyWith({
    bool? enabled,
    List<TimeRange>? weekday,
    List<TimeRange>? weekend,
    String? bedtimeWeekday,
    String? bedtimeWeekend,
    bool? breakEnabled,
    int? breakAfterMinutes,
    int? breakDurationMinutes,
    bool? breakRemindEyes,
    bool? breakRemindWater,
    bool? breakRemindMove,
    bool? screenLimitEnabled,
    int? screenLimitWeekdayMinutes,
    int? screenLimitWeekendMinutes,
    bool? habitEnabled,
    String? readingReminderWeekday,
    String? readingReminderWeekend,
    Object? weeklyGoalDays = _sentinel,
  }) {
    return ScheduleValue(
      enabled: enabled ?? this.enabled,
      weekday: weekday ?? this.weekday,
      weekend: weekend ?? this.weekend,
      bedtimeWeekday: bedtimeWeekday ?? this.bedtimeWeekday,
      bedtimeWeekend: bedtimeWeekend ?? this.bedtimeWeekend,
      breakEnabled: breakEnabled ?? this.breakEnabled,
      breakAfterMinutes: breakAfterMinutes ?? this.breakAfterMinutes,
      breakDurationMinutes: breakDurationMinutes ?? this.breakDurationMinutes,
      breakRemindEyes: breakRemindEyes ?? this.breakRemindEyes,
      breakRemindWater: breakRemindWater ?? this.breakRemindWater,
      breakRemindMove: breakRemindMove ?? this.breakRemindMove,
      screenLimitEnabled: screenLimitEnabled ?? this.screenLimitEnabled,
      screenLimitWeekdayMinutes:
          screenLimitWeekdayMinutes ?? this.screenLimitWeekdayMinutes,
      screenLimitWeekendMinutes:
          screenLimitWeekendMinutes ?? this.screenLimitWeekendMinutes,
      habitEnabled: habitEnabled ?? this.habitEnabled,
      readingReminderWeekday:
          readingReminderWeekday ?? this.readingReminderWeekday,
      readingReminderWeekend:
          readingReminderWeekend ?? this.readingReminderWeekend,
      weeklyGoalDays: identical(weeklyGoalDays, _sentinel)
          ? this.weeklyGoalDays
          : (weeklyGoalDays as int?),
    );
  }

  static bool listEquals<T>(List<T> a, List<T> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleValue &&
          runtimeType == other.runtimeType &&
          enabled == other.enabled &&
          listEquals(weekday, other.weekday) &&
          listEquals(weekend, other.weekend) &&
          bedtimeWeekday == other.bedtimeWeekday &&
          bedtimeWeekend == other.bedtimeWeekend &&
          breakEnabled == other.breakEnabled &&
          breakAfterMinutes == other.breakAfterMinutes &&
          breakDurationMinutes == other.breakDurationMinutes &&
          breakRemindEyes == other.breakRemindEyes &&
          breakRemindWater == other.breakRemindWater &&
          breakRemindMove == other.breakRemindMove &&
          screenLimitEnabled == other.screenLimitEnabled &&
          screenLimitWeekdayMinutes == other.screenLimitWeekdayMinutes &&
          screenLimitWeekendMinutes == other.screenLimitWeekendMinutes &&
          habitEnabled == other.habitEnabled &&
          readingReminderWeekday == other.readingReminderWeekday &&
          readingReminderWeekend == other.readingReminderWeekend &&
          weeklyGoalDays == other.weeklyGoalDays;

  @override
  int get hashCode => Object.hash(
        enabled,
        Object.hashAll(weekday),
        Object.hashAll(weekend),
        bedtimeWeekday,
        bedtimeWeekend,
        breakEnabled,
        breakAfterMinutes,
        breakDurationMinutes,
        breakRemindEyes,
        breakRemindWater,
        breakRemindMove,
        screenLimitEnabled,
        screenLimitWeekdayMinutes,
        screenLimitWeekendMinutes,
        habitEnabled,
        readingReminderWeekday,
        readingReminderWeekend,
        weeklyGoalDays,
      );
}

class NumberRange {
  final int min;
  final int max;
  final int step;
  const NumberRange({required this.min, required this.max, required this.step});
}

class TimeLimitRange {
  final String min;
  final String max;
  const TimeLimitRange({required this.min, required this.max});
}

/// Mỗi loại ngày tối đa 2 khung giờ (backend: "Mỗi loại ngày tối đa 2 khung giờ.").
const int maxWindows = 2;
const NumberRange breakAfterRange = NumberRange(min: 15, max: 60, step: 5);
const NumberRange breakDurationRange = NumberRange(min: 1, max: 15, step: 1);
const NumberRange screenLimitRange = NumberRange(min: 10, max: 240, step: 5);
const TimeLimitRange bedtimeRange = TimeLimitRange(min: '18:00', max: '23:30');
const String reminderMin = '06:00';
const List<int> weeklyGoals = [1, 2, 3, 4, 5, 6, 7];

enum ScheduleSection {
  windows('windows'),
  bedtime('bedtime'),
  breakSection('break'),
  screen('screen'),
  habit('habit'),
  general('general');

  final String value;
  const ScheduleSection(this.value);
}

List<TimeRange> _rangesOf(ReadingScheduleDto dto, String dayType) {
  final filtered = dto.windows.where((w) => w.dayType == dayType).toList()
    ..sort((a, b) => a.slot.compareTo(b.slot));
  return filtered
      .map((w) => TimeRange(start: w.startTime, end: w.endTime))
      .toList();
}

/// Cấu hình backend trả về (đã lưu hoặc gợi ý theo tuổi) thành giá trị form.
ScheduleValue scheduleFrom(ReadingScheduleDto dto) => ScheduleValue(
      enabled: dto.enabled,
      weekday: _rangesOf(dto, 'Weekday'),
      weekend: _rangesOf(dto, 'Weekend'),
      bedtimeWeekday: dto.bedtimeWeekday ?? '',
      bedtimeWeekend: dto.bedtimeWeekend ?? '',
      breakEnabled: dto.breakEnabled,
      breakAfterMinutes: dto.breakAfterMinutes,
      breakDurationMinutes: dto.breakDurationMinutes,
      breakRemindEyes: dto.breakRemindEyes,
      breakRemindWater: dto.breakRemindWater,
      breakRemindMove: dto.breakRemindMove,
      screenLimitEnabled: dto.screenLimitEnabled,
      screenLimitWeekdayMinutes: dto.screenLimitWeekdayMinutes,
      screenLimitWeekendMinutes: dto.screenLimitWeekendMinutes,
      habitEnabled: dto.habitEnabled,
      readingReminderWeekday: dto.readingReminderWeekday ?? '',
      readingReminderWeekend: dto.readingReminderWeekend ?? '',
      weeklyGoalDays: dto.weeklyGoalDays,
    );

/// Hai nhóm trên form: giới hạn thời gian và thói quen đọc.
enum ScheduleGroup {
  limits('limits'),
  habit('habit');

  final String value;
  const ScheduleGroup(this.value);
}

const List<ScheduleGroup> allGroups = [
  ScheduleGroup.limits,
  ScheduleGroup.habit,
];

/// Nhóm nào đã khác giá trị đã lưu (thứ tự: giới hạn trước, thói quen sau).
List<ScheduleGroup> changedGroups(ScheduleValue current, ScheduleValue saved) {
  final groups = <ScheduleGroup>[];
  final limitsChanged = current.enabled != saved.enabled ||
      !ScheduleValue.listEquals(current.weekday, saved.weekday) ||
      !ScheduleValue.listEquals(current.weekend, saved.weekend) ||
      current.bedtimeWeekday != saved.bedtimeWeekday ||
      current.bedtimeWeekend != saved.bedtimeWeekend ||
      current.breakEnabled != saved.breakEnabled ||
      current.breakAfterMinutes != saved.breakAfterMinutes ||
      current.breakDurationMinutes != saved.breakDurationMinutes ||
      current.breakRemindEyes != saved.breakRemindEyes ||
      current.breakRemindWater != saved.breakRemindWater ||
      current.breakRemindMove != saved.breakRemindMove ||
      current.screenLimitEnabled != saved.screenLimitEnabled ||
      current.screenLimitWeekdayMinutes != saved.screenLimitWeekdayMinutes ||
      current.screenLimitWeekendMinutes != saved.screenLimitWeekendMinutes;

  final habitChanged = current.habitEnabled != saved.habitEnabled ||
      current.readingReminderWeekday != saved.readingReminderWeekday ||
      current.readingReminderWeekend != saved.readingReminderWeekend ||
      current.weeklyGoalDays != saved.weeklyGoalDays;

  if (limitsChanged) groups.add(ScheduleGroup.limits);
  if (habitChanged) groups.add(ScheduleGroup.habit);
  return groups;
}

const Map<ScheduleGroup, String> _groupNames = {
  ScheduleGroup.limits: 'giới hạn thời gian',
  ScheduleGroup.habit: 'thói quen đọc',
};

/// Tên các nhóm dùng trong câu: "giới hạn thời gian", "thói quen đọc" hoặc cả hai nối bằng "và".
String groupsText(List<ScheduleGroup> groups) =>
    groups.map((group) => _groupNames[group] ?? '').join(' và ');

/// Nhãn nút lưu: gọi đúng nhóm đang lưu; đủ cả hai thì dùng tên tab.
String saveLabel(List<ScheduleGroup> groups) =>
    groups.length >= allGroups.length
        ? 'Lưu thời gian & thói quen'
        : 'Lưu ${groupsText(groups)}';

String? _orNull(String time) => time.trim().isEmpty ? null : time.trim();

List<Map<String, dynamic>> _windowsOf(List<TimeRange> ranges, String dayType) =>
    // Dòng bỏ trống cả hai giờ coi như chưa thêm; dòng điền dở vẫn gửi để backend báo lỗi.
    ranges
        .where((r) => r.start.isNotEmpty || r.end.isNotEmpty)
        .map((r) => <String, dynamic>{
              'dayType': dayType,
              'startTime': r.start,
              'endTime': r.end,
            })
        .toList();

/// Backend thay toàn bộ cấu hình mỗi lần PUT, nên luôn gửi đủ mọi trường.
Map<String, dynamic> scheduleRequest(ScheduleValue v) => <String, dynamic>{
      'enabled': v.enabled,
      'bedtimeWeekday': _orNull(v.bedtimeWeekday),
      'bedtimeWeekend': _orNull(v.bedtimeWeekend),
      'breakEnabled': v.breakEnabled,
      'breakAfterMinutes': v.breakAfterMinutes,
      'breakDurationMinutes': v.breakDurationMinutes,
      'breakRemindEyes': v.breakRemindEyes,
      'breakRemindWater': v.breakRemindWater,
      'breakRemindMove': v.breakRemindMove,
      'screenLimitEnabled': v.screenLimitEnabled,
      'screenLimitWeekdayMinutes': v.screenLimitWeekdayMinutes,
      'screenLimitWeekendMinutes': v.screenLimitWeekendMinutes,
      'habitEnabled': v.habitEnabled,
      'readingReminderWeekday': _orNull(v.readingReminderWeekday),
      'readingReminderWeekend': _orNull(v.readingReminderWeekend),
      'weeklyGoalDays': v.weeklyGoalDays,
      'windows': <Map<String, dynamic>>[
        ..._windowsOf(v.weekday, 'Weekday'),
        ..._windowsOf(v.weekend, 'Weekend'),
      ],
    };

/// Phần của form mà một lời báo lỗi 400 của backend nói tới, để hiện lỗi đúng chỗ.
ScheduleSection sectionOfError(String message) {
  final m = message.toLowerCase();
  if (m.contains('nhắc đọc') || m.contains('mục tiêu')) {
    return ScheduleSection.habit;
  }
  if (m.contains('đi ngủ')) return ScheduleSection.bedtime;
  if (m.contains('khung') || m.contains('giờ bắt đầu')) {
    return ScheduleSection.windows;
  }
  if (m.contains('màn hình')) return ScheduleSection.screen;
  if (m.contains('nghỉ')) return ScheduleSection.breakSection;
  return ScheduleSection.general;
}
