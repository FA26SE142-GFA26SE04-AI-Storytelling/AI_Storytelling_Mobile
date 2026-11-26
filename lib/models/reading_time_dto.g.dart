// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_time_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReadingTimeStatusDto _$ReadingTimeStatusDtoFromJson(
  Map<String, dynamic> json,
) => _ReadingTimeStatusDto(
  state: json['state'] as String,
  endReason: json['endReason'] as String?,
  endsAt: json['endsAt'] == null
      ? null
      : DateTime.parse(json['endsAt'] as String),
  graceEndsAt: json['graceEndsAt'] == null
      ? null
      : DateTime.parse(json['graceEndsAt'] as String),
  breakUntil: json['breakUntil'] == null
      ? null
      : DateTime.parse(json['breakUntil'] as String),
  breakActivity: json['breakActivity'] as String?,
  nextAllowedAt: json['nextAllowedAt'] == null
      ? null
      : DateTime.parse(json['nextAllowedAt'] as String),
  bedtimeAt: json['bedtimeAt'] == null
      ? null
      : DateTime.parse(json['bedtimeAt'] as String),
  screenMinutesUsed: (json['screenMinutesUsed'] as num?)?.toInt(),
  screenMinutesLimit: (json['screenMinutesLimit'] as num?)?.toInt(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$ReadingTimeStatusDtoToJson(
  _ReadingTimeStatusDto instance,
) => <String, dynamic>{
  'state': instance.state,
  'endReason': instance.endReason,
  'endsAt': instance.endsAt?.toIso8601String(),
  'graceEndsAt': instance.graceEndsAt?.toIso8601String(),
  'breakUntil': instance.breakUntil?.toIso8601String(),
  'breakActivity': instance.breakActivity,
  'nextAllowedAt': instance.nextAllowedAt?.toIso8601String(),
  'bedtimeAt': instance.bedtimeAt?.toIso8601String(),
  'screenMinutesUsed': instance.screenMinutesUsed,
  'screenMinutesLimit': instance.screenMinutesLimit,
  'message': instance.message,
};

_HabitReminderDto _$HabitReminderDtoFromJson(Map<String, dynamic> json) =>
    _HabitReminderDto(
      at: DateTime.parse(json['at'] as String),
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$HabitReminderDtoToJson(_HabitReminderDto instance) =>
    <String, dynamic>{
      'at': instance.at.toIso8601String(),
      'message': instance.message,
    };

_HabitQuietPeriodDto _$HabitQuietPeriodDtoFromJson(Map<String, dynamic> json) =>
    _HabitQuietPeriodDto(
      from: DateTime.parse(json['from'] as String),
      to: DateTime.parse(json['to'] as String),
    );

Map<String, dynamic> _$HabitQuietPeriodDtoToJson(
  _HabitQuietPeriodDto instance,
) => <String, dynamic>{
  'from': instance.from.toIso8601String(),
  'to': instance.to.toIso8601String(),
};

_ChildHabitDto _$ChildHabitDtoFromJson(Map<String, dynamic> json) =>
    _ChildHabitDto(
      enabled: json['enabled'] as bool? ?? false,
      streakDays: (json['streakDays'] as num?)?.toInt() ?? 0,
      daysReadThisWeek: (json['daysReadThisWeek'] as num?)?.toInt() ?? 0,
      weeklyGoalDays: (json['weeklyGoalDays'] as num?)?.toInt(),
      goalMetThisWeek: json['goalMetThisWeek'] as bool? ?? false,
      reminders:
          (json['reminders'] as List<dynamic>?)
              ?.map((e) => HabitReminderDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <HabitReminderDto>[],
      quietPeriods:
          (json['quietPeriods'] as List<dynamic>?)
              ?.map(
                (e) => HabitQuietPeriodDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <HabitQuietPeriodDto>[],
    );

Map<String, dynamic> _$ChildHabitDtoToJson(_ChildHabitDto instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'streakDays': instance.streakDays,
      'daysReadThisWeek': instance.daysReadThisWeek,
      'weeklyGoalDays': instance.weeklyGoalDays,
      'goalMetThisWeek': instance.goalMetThisWeek,
      'reminders': instance.reminders,
      'quietPeriods': instance.quietPeriods,
    };
