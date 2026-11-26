import 'package:freezed_annotation/freezed_annotation.dart';

part 'reading_time_dto.freezed.dart';
part 'reading_time_dto.g.dart';

@freezed
abstract class ReadingTimeStatusDto with _$ReadingTimeStatusDto {
  const factory ReadingTimeStatusDto({
    required String state,
    String? endReason,
    DateTime? endsAt,
    DateTime? graceEndsAt,
    DateTime? breakUntil,
    String? breakActivity,
    DateTime? nextAllowedAt,
    DateTime? bedtimeAt,
    int? screenMinutesUsed,
    int? screenMinutesLimit,
    String? message,
  }) = _ReadingTimeStatusDto;

  factory ReadingTimeStatusDto.fromJson(Map<String, dynamic> json) =>
      _$ReadingTimeStatusDtoFromJson(json);
}

@freezed
abstract class HabitReminderDto with _$HabitReminderDto {
  const factory HabitReminderDto({
    required DateTime at,
    @Default('') String message,
  }) = _HabitReminderDto;

  factory HabitReminderDto.fromJson(Map<String, dynamic> json) =>
      _$HabitReminderDtoFromJson(json);
}

@freezed
abstract class HabitQuietPeriodDto with _$HabitQuietPeriodDto {
  const factory HabitQuietPeriodDto({
    required DateTime from,
    required DateTime to,
  }) = _HabitQuietPeriodDto;

  factory HabitQuietPeriodDto.fromJson(Map<String, dynamic> json) =>
      _$HabitQuietPeriodDtoFromJson(json);
}

@freezed
abstract class ChildHabitDto with _$ChildHabitDto {
  const factory ChildHabitDto({
    @Default(false) bool enabled,
    @Default(0) int streakDays,
    @Default(0) int daysReadThisWeek,
    int? weeklyGoalDays,
    @Default(false) bool goalMetThisWeek,
    @Default(<HabitReminderDto>[]) List<HabitReminderDto> reminders,
    @Default(<HabitQuietPeriodDto>[]) List<HabitQuietPeriodDto> quietPeriods,
  }) = _ChildHabitDto;

  factory ChildHabitDto.fromJson(Map<String, dynamic> json) =>
      _$ChildHabitDtoFromJson(json);
}
