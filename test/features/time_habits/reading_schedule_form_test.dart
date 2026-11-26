import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/features/time_habits/presentation/reading_schedule_form.dart';
import 'package:ai_storytelling_mobile/models/reading_schedule_dto.dart';

ScheduleValue _createScheduleValue({
  bool enabled = true,
  List<TimeRange> weekday = const [],
  List<TimeRange> weekend = const [],
  String bedtimeWeekday = '',
  String bedtimeWeekend = '',
  bool breakEnabled = false,
  int breakAfterMinutes = 30,
  int breakDurationMinutes = 5,
  bool breakRemindEyes = true,
  bool breakRemindWater = false,
  bool breakRemindMove = false,
  bool screenLimitEnabled = false,
  int screenLimitWeekdayMinutes = 60,
  int screenLimitWeekendMinutes = 90,
  bool habitEnabled = true,
  String readingReminderWeekday = '',
  String readingReminderWeekend = '',
  int? weeklyGoalDays,
}) =>
    ScheduleValue(
      enabled: enabled,
      weekday: weekday,
      weekend: weekend,
      bedtimeWeekday: bedtimeWeekday,
      bedtimeWeekend: bedtimeWeekend,
      breakEnabled: breakEnabled,
      breakAfterMinutes: breakAfterMinutes,
      breakDurationMinutes: breakDurationMinutes,
      breakRemindEyes: breakRemindEyes,
      breakRemindWater: breakRemindWater,
      breakRemindMove: breakRemindMove,
      screenLimitEnabled: screenLimitEnabled,
      screenLimitWeekdayMinutes: screenLimitWeekdayMinutes,
      screenLimitWeekendMinutes: screenLimitWeekendMinutes,
      habitEnabled: habitEnabled,
      readingReminderWeekday: readingReminderWeekday,
      readingReminderWeekend: readingReminderWeekend,
      weeklyGoalDays: weeklyGoalDays,
    );

ReadingScheduleDto _createScheduleDto({
  int childProfileId = 1,
  bool enabled = true,
  String? bedtimeWeekday,
  String? bedtimeWeekend,
  bool breakEnabled = false,
  int breakAfterMinutes = 30,
  int breakDurationMinutes = 5,
  bool breakRemindEyes = true,
  bool breakRemindWater = false,
  bool breakRemindMove = false,
  bool screenLimitEnabled = false,
  int screenLimitWeekdayMinutes = 60,
  int screenLimitWeekendMinutes = 90,
  bool habitEnabled = true,
  String? readingReminderWeekday,
  String? readingReminderWeekend,
  int? weeklyGoalDays,
  ReadingHabitProgressDto? habit,
  List<ReadingScheduleWindowDto> windows = const [],
  bool isSuggested = false,
}) =>
    ReadingScheduleDto(
      childProfileId: childProfileId,
      enabled: enabled,
      bedtimeWeekday: bedtimeWeekday,
      bedtimeWeekend: bedtimeWeekend,
      breakEnabled: breakEnabled,
      breakAfterMinutes: breakAfterMinutes,
      breakDurationMinutes: breakDurationMinutes,
      breakRemindEyes: breakRemindEyes,
      breakRemindWater: breakRemindWater,
      breakRemindMove: breakRemindMove,
      screenLimitEnabled: screenLimitEnabled,
      screenLimitWeekdayMinutes: screenLimitWeekdayMinutes,
      screenLimitWeekendMinutes: screenLimitWeekendMinutes,
      habitEnabled: habitEnabled,
      readingReminderWeekday: readingReminderWeekday,
      readingReminderWeekend: readingReminderWeekend,
      weeklyGoalDays: weeklyGoalDays,
      habit: habit,
      windows: windows,
      isSuggested: isSuggested,
    );

void main() {
  group('reading_schedule_form', () {
    test('scheduleFrom: dto có windows Weekday và Weekend sắp đúng theo slot', () {
      final dto = _createScheduleDto(
        windows: const [
          ReadingScheduleWindowDto(
            dayType: 'Weekday',
            slot: 2,
            startTime: '19:00',
            endTime: '20:00',
          ),
          ReadingScheduleWindowDto(
            dayType: 'Weekend',
            slot: 2,
            startTime: '15:00',
            endTime: '16:00',
          ),
          ReadingScheduleWindowDto(
            dayType: 'Weekday',
            slot: 1,
            startTime: '08:00',
            endTime: '09:00',
          ),
          ReadingScheduleWindowDto(
            dayType: 'Weekend',
            slot: 1,
            startTime: '09:00',
            endTime: '10:00',
          ),
        ],
      );

      final result = scheduleFrom(dto);

      expect(result.weekday, const [
        TimeRange(start: '08:00', end: '09:00'),
        TimeRange(start: '19:00', end: '20:00'),
      ]);
      expect(result.weekend, const [
        TimeRange(start: '09:00', end: '10:00'),
        TimeRange(start: '15:00', end: '16:00'),
      ]);
    });

    test('scheduleRequest: lọc khung trống, giữ khung điền dở, null hóa chuỗi rỗng và trim', () {
      final value = _createScheduleValue(
        bedtimeWeekday: '  ',
        bedtimeWeekend: ' 19:00 ',
        weekday: const [
          TimeRange(start: '', end: ''),
          TimeRange(start: '08:00', end: ''),
        ],
        weekend: const [
          TimeRange(start: '', end: '21:00'),
          TimeRange(start: '', end: ''),
        ],
      );

      final req = scheduleRequest(value);

      expect(req['bedtimeWeekday'], isNull);
      expect(req['bedtimeWeekend'], '19:00');

      final windows = req['windows'] as List<dynamic>;
      expect(windows, [
        {
          'dayType': 'Weekday',
          'startTime': '08:00',
          'endTime': '',
        },
        {
          'dayType': 'Weekend',
          'startTime': '',
          'endTime': '21:00',
        },
      ]);
    });

    test('scheduleRequest: luôn có đủ khóa enabled, breakAfterMinutes, weeklyGoalDays và windows là List', () {
      final valueWithoutGoal = _createScheduleValue(weeklyGoalDays: null);
      final reqWithoutGoal = scheduleRequest(valueWithoutGoal);

      expect(reqWithoutGoal.containsKey('enabled'), isTrue);
      expect(reqWithoutGoal.containsKey('breakAfterMinutes'), isTrue);
      expect(reqWithoutGoal.containsKey('weeklyGoalDays'), isTrue);
      expect(reqWithoutGoal['weeklyGoalDays'], isNull);
      expect(reqWithoutGoal['windows'], isA<List>());

      final valueWithGoal = _createScheduleValue(weeklyGoalDays: 5);
      final reqWithGoal = scheduleRequest(valueWithGoal);

      expect(reqWithGoal['weeklyGoalDays'], 5);
      expect(reqWithGoal['windows'], isA<List>());
    });

    test('changedGroups: so khớp thay đổi nhóm limits, habit hoặc cả hai', () {
      final base = _createScheduleValue(
        screenLimitWeekdayMinutes: 60,
        weeklyGoalDays: 3,
      );

      expect(changedGroups(base, base), isEmpty);

      final changedLimits = base.copyWith(screenLimitWeekdayMinutes: 120);
      expect(changedGroups(changedLimits, base), [ScheduleGroup.limits]);

      final changedHabit = base.copyWith(weeklyGoalDays: 5);
      expect(changedGroups(changedHabit, base), [ScheduleGroup.habit]);

      final changedBoth = base.copyWith(
        screenLimitWeekdayMinutes: 120,
        weeklyGoalDays: 5,
      );
      expect(changedBoth.screenLimitWeekdayMinutes, 120);
      expect(changedGroups(changedBoth, base), [
        ScheduleGroup.limits,
        ScheduleGroup.habit,
      ]);
    });

    test('groupsText: định dạng chuỗi nhóm hiển thị', () {
      expect(
        groupsText([ScheduleGroup.limits, ScheduleGroup.habit]),
        'giới hạn thời gian và thói quen đọc',
      );
    });

    test('sectionOfError: ánh xạ thông báo lỗi backend sang ScheduleSection', () {
      expect(
        sectionOfError('Giờ đi ngủ phải từ 18:00'),
        ScheduleSection.bedtime,
      );
      expect(
        sectionOfError('Mỗi loại ngày tối đa 2 khung giờ.'),
        ScheduleSection.windows,
      );
      expect(
        sectionOfError('Thời gian nhìn màn hình không hợp lệ'),
        ScheduleSection.screen,
      );
      expect(
        sectionOfError('Mục tiêu tuần không hợp lệ'),
        ScheduleSection.habit,
      );
      expect(
        sectionOfError('Chuyện gì đó'),
        ScheduleSection.general,
      );
    });
  });
}
