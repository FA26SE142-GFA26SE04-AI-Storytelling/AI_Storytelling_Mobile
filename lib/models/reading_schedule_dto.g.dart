// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_schedule_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReadingScheduleDto _$ReadingScheduleDtoFromJson(
  Map<String, dynamic> json,
) => _ReadingScheduleDto(
  childProfileId: (json['childProfileId'] as num).toInt(),
  enabled: json['enabled'] as bool,
  bedtimeWeekday: json['bedtimeWeekday'] as String?,
  bedtimeWeekend: json['bedtimeWeekend'] as String?,
  breakEnabled: json['breakEnabled'] as bool,
  breakAfterMinutes: (json['breakAfterMinutes'] as num).toInt(),
  breakDurationMinutes: (json['breakDurationMinutes'] as num).toInt(),
  breakRemindEyes: json['breakRemindEyes'] as bool,
  breakRemindWater: json['breakRemindWater'] as bool,
  breakRemindMove: json['breakRemindMove'] as bool,
  screenLimitEnabled: json['screenLimitEnabled'] as bool,
  screenLimitWeekdayMinutes: (json['screenLimitWeekdayMinutes'] as num).toInt(),
  screenLimitWeekendMinutes: (json['screenLimitWeekendMinutes'] as num).toInt(),
  habitEnabled: json['habitEnabled'] as bool,
  readingReminderWeekday: json['readingReminderWeekday'] as String?,
  readingReminderWeekend: json['readingReminderWeekend'] as String?,
  weeklyGoalDays: (json['weeklyGoalDays'] as num?)?.toInt(),
  habit: json['habit'] == null
      ? null
      : ReadingHabitProgressDto.fromJson(json['habit'] as Map<String, dynamic>),
  windows:
      (json['windows'] as List<dynamic>?)
          ?.map(
            (e) => ReadingScheduleWindowDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <ReadingScheduleWindowDto>[],
  isSuggested: json['isSuggested'] as bool,
);

Map<String, dynamic> _$ReadingScheduleDtoToJson(_ReadingScheduleDto instance) =>
    <String, dynamic>{
      'childProfileId': instance.childProfileId,
      'enabled': instance.enabled,
      'bedtimeWeekday': instance.bedtimeWeekday,
      'bedtimeWeekend': instance.bedtimeWeekend,
      'breakEnabled': instance.breakEnabled,
      'breakAfterMinutes': instance.breakAfterMinutes,
      'breakDurationMinutes': instance.breakDurationMinutes,
      'breakRemindEyes': instance.breakRemindEyes,
      'breakRemindWater': instance.breakRemindWater,
      'breakRemindMove': instance.breakRemindMove,
      'screenLimitEnabled': instance.screenLimitEnabled,
      'screenLimitWeekdayMinutes': instance.screenLimitWeekdayMinutes,
      'screenLimitWeekendMinutes': instance.screenLimitWeekendMinutes,
      'habitEnabled': instance.habitEnabled,
      'readingReminderWeekday': instance.readingReminderWeekday,
      'readingReminderWeekend': instance.readingReminderWeekend,
      'weeklyGoalDays': instance.weeklyGoalDays,
      'habit': instance.habit,
      'windows': instance.windows,
      'isSuggested': instance.isSuggested,
    };

_ReadingScheduleWindowDto _$ReadingScheduleWindowDtoFromJson(
  Map<String, dynamic> json,
) => _ReadingScheduleWindowDto(
  dayType: json['dayType'] as String,
  slot: (json['slot'] as num).toInt(),
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
);

Map<String, dynamic> _$ReadingScheduleWindowDtoToJson(
  _ReadingScheduleWindowDto instance,
) => <String, dynamic>{
  'dayType': instance.dayType,
  'slot': instance.slot,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
};

_ReadingHabitProgressDto _$ReadingHabitProgressDtoFromJson(
  Map<String, dynamic> json,
) => _ReadingHabitProgressDto(
  streakDays: (json['streakDays'] as num).toInt(),
  daysReadThisWeek: (json['daysReadThisWeek'] as num).toInt(),
  goalMetThisWeek: json['goalMetThisWeek'] as bool,
);

Map<String, dynamic> _$ReadingHabitProgressDtoToJson(
  _ReadingHabitProgressDto instance,
) => <String, dynamic>{
  'streakDays': instance.streakDays,
  'daysReadThisWeek': instance.daysReadThisWeek,
  'goalMetThisWeek': instance.goalMetThisWeek,
};
