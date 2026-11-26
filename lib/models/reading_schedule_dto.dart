import 'package:freezed_annotation/freezed_annotation.dart';

part 'reading_schedule_dto.freezed.dart';
part 'reading_schedule_dto.g.dart';

@freezed
abstract class ReadingScheduleDto with _$ReadingScheduleDto {
  const factory ReadingScheduleDto({
    required int childProfileId,
    required bool enabled,
    String? bedtimeWeekday,
    String? bedtimeWeekend,
    required bool breakEnabled,
    required int breakAfterMinutes,
    required int breakDurationMinutes,
    required bool breakRemindEyes,
    required bool breakRemindWater,
    required bool breakRemindMove,
    required bool screenLimitEnabled,
    required int screenLimitWeekdayMinutes,
    required int screenLimitWeekendMinutes,
    required bool habitEnabled,
    String? readingReminderWeekday,
    String? readingReminderWeekend,
    int? weeklyGoalDays,
    ReadingHabitProgressDto? habit,
    @Default(<ReadingScheduleWindowDto>[])
    List<ReadingScheduleWindowDto> windows,
    required bool isSuggested,
  }) = _ReadingScheduleDto;

  factory ReadingScheduleDto.fromJson(Map<String, dynamic> json) =>
      _$ReadingScheduleDtoFromJson(json);
}

@freezed
abstract class ReadingScheduleWindowDto with _$ReadingScheduleWindowDto {
  const factory ReadingScheduleWindowDto({
    required String dayType,
    required int slot,
    required String startTime,
    required String endTime,
  }) = _ReadingScheduleWindowDto;

  factory ReadingScheduleWindowDto.fromJson(Map<String, dynamic> json) =>
      _$ReadingScheduleWindowDtoFromJson(json);
}

@freezed
abstract class ReadingHabitProgressDto with _$ReadingHabitProgressDto {
  const factory ReadingHabitProgressDto({
    required int streakDays,
    required int daysReadThisWeek,
    required bool goalMetThisWeek,
  }) = _ReadingHabitProgressDto;

  factory ReadingHabitProgressDto.fromJson(Map<String, dynamic> json) =>
      _$ReadingHabitProgressDtoFromJson(json);
}
