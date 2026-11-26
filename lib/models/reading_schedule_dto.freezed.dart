// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_schedule_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReadingScheduleDto {

 int get childProfileId; bool get enabled; String? get bedtimeWeekday; String? get bedtimeWeekend; bool get breakEnabled; int get breakAfterMinutes; int get breakDurationMinutes; bool get breakRemindEyes; bool get breakRemindWater; bool get breakRemindMove; bool get screenLimitEnabled; int get screenLimitWeekdayMinutes; int get screenLimitWeekendMinutes; bool get habitEnabled; String? get readingReminderWeekday; String? get readingReminderWeekend; int? get weeklyGoalDays; ReadingHabitProgressDto? get habit; List<ReadingScheduleWindowDto> get windows; bool get isSuggested;
/// Create a copy of ReadingScheduleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingScheduleDtoCopyWith<ReadingScheduleDto> get copyWith => _$ReadingScheduleDtoCopyWithImpl<ReadingScheduleDto>(this as ReadingScheduleDto, _$identity);

  /// Serializes this ReadingScheduleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingScheduleDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingScheduleDto&&(identical(other.childProfileId, _this.childProfileId) || other.childProfileId == _this.childProfileId)&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.bedtimeWeekday, _this.bedtimeWeekday) || other.bedtimeWeekday == _this.bedtimeWeekday)&&(identical(other.bedtimeWeekend, _this.bedtimeWeekend) || other.bedtimeWeekend == _this.bedtimeWeekend)&&(identical(other.breakEnabled, _this.breakEnabled) || other.breakEnabled == _this.breakEnabled)&&(identical(other.breakAfterMinutes, _this.breakAfterMinutes) || other.breakAfterMinutes == _this.breakAfterMinutes)&&(identical(other.breakDurationMinutes, _this.breakDurationMinutes) || other.breakDurationMinutes == _this.breakDurationMinutes)&&(identical(other.breakRemindEyes, _this.breakRemindEyes) || other.breakRemindEyes == _this.breakRemindEyes)&&(identical(other.breakRemindWater, _this.breakRemindWater) || other.breakRemindWater == _this.breakRemindWater)&&(identical(other.breakRemindMove, _this.breakRemindMove) || other.breakRemindMove == _this.breakRemindMove)&&(identical(other.screenLimitEnabled, _this.screenLimitEnabled) || other.screenLimitEnabled == _this.screenLimitEnabled)&&(identical(other.screenLimitWeekdayMinutes, _this.screenLimitWeekdayMinutes) || other.screenLimitWeekdayMinutes == _this.screenLimitWeekdayMinutes)&&(identical(other.screenLimitWeekendMinutes, _this.screenLimitWeekendMinutes) || other.screenLimitWeekendMinutes == _this.screenLimitWeekendMinutes)&&(identical(other.habitEnabled, _this.habitEnabled) || other.habitEnabled == _this.habitEnabled)&&(identical(other.readingReminderWeekday, _this.readingReminderWeekday) || other.readingReminderWeekday == _this.readingReminderWeekday)&&(identical(other.readingReminderWeekend, _this.readingReminderWeekend) || other.readingReminderWeekend == _this.readingReminderWeekend)&&(identical(other.weeklyGoalDays, _this.weeklyGoalDays) || other.weeklyGoalDays == _this.weeklyGoalDays)&&(identical(other.habit, _this.habit) || other.habit == _this.habit)&&const DeepCollectionEquality().equals(other.windows, _this.windows)&&(identical(other.isSuggested, _this.isSuggested) || other.isSuggested == _this.isSuggested));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingScheduleDto;
  return Object.hashAll([runtimeType,_this.childProfileId,_this.enabled,_this.bedtimeWeekday,_this.bedtimeWeekend,_this.breakEnabled,_this.breakAfterMinutes,_this.breakDurationMinutes,_this.breakRemindEyes,_this.breakRemindWater,_this.breakRemindMove,_this.screenLimitEnabled,_this.screenLimitWeekdayMinutes,_this.screenLimitWeekendMinutes,_this.habitEnabled,_this.readingReminderWeekday,_this.readingReminderWeekend,_this.weeklyGoalDays,_this.habit,const DeepCollectionEquality().hash(_this.windows),_this.isSuggested]);
}

@override
String toString() {
  final _this = this as ReadingScheduleDto;
  return 'ReadingScheduleDto(childProfileId: ${_this.childProfileId}, enabled: ${_this.enabled}, bedtimeWeekday: ${_this.bedtimeWeekday}, bedtimeWeekend: ${_this.bedtimeWeekend}, breakEnabled: ${_this.breakEnabled}, breakAfterMinutes: ${_this.breakAfterMinutes}, breakDurationMinutes: ${_this.breakDurationMinutes}, breakRemindEyes: ${_this.breakRemindEyes}, breakRemindWater: ${_this.breakRemindWater}, breakRemindMove: ${_this.breakRemindMove}, screenLimitEnabled: ${_this.screenLimitEnabled}, screenLimitWeekdayMinutes: ${_this.screenLimitWeekdayMinutes}, screenLimitWeekendMinutes: ${_this.screenLimitWeekendMinutes}, habitEnabled: ${_this.habitEnabled}, readingReminderWeekday: ${_this.readingReminderWeekday}, readingReminderWeekend: ${_this.readingReminderWeekend}, weeklyGoalDays: ${_this.weeklyGoalDays}, habit: ${_this.habit}, windows: ${_this.windows}, isSuggested: ${_this.isSuggested})';
}


}

/// @nodoc
abstract mixin class $ReadingScheduleDtoCopyWith<$Res>  {
  factory $ReadingScheduleDtoCopyWith(ReadingScheduleDto value, $Res Function(ReadingScheduleDto) _then) = _$ReadingScheduleDtoCopyWithImpl;
@useResult
$Res call({
 int childProfileId, bool enabled, String? bedtimeWeekday, String? bedtimeWeekend, bool breakEnabled, int breakAfterMinutes, int breakDurationMinutes, bool breakRemindEyes, bool breakRemindWater, bool breakRemindMove, bool screenLimitEnabled, int screenLimitWeekdayMinutes, int screenLimitWeekendMinutes, bool habitEnabled, String? readingReminderWeekday, String? readingReminderWeekend, int? weeklyGoalDays, ReadingHabitProgressDto? habit, List<ReadingScheduleWindowDto> windows, bool isSuggested
});


$ReadingHabitProgressDtoCopyWith<$Res>? get habit;

}
/// @nodoc
class _$ReadingScheduleDtoCopyWithImpl<$Res>
    implements $ReadingScheduleDtoCopyWith<$Res> {
  _$ReadingScheduleDtoCopyWithImpl(this._self, this._then);

  final ReadingScheduleDto _self;
  final $Res Function(ReadingScheduleDto) _then;

/// Create a copy of ReadingScheduleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? childProfileId = null,Object? enabled = null,Object? bedtimeWeekday = freezed,Object? bedtimeWeekend = freezed,Object? breakEnabled = null,Object? breakAfterMinutes = null,Object? breakDurationMinutes = null,Object? breakRemindEyes = null,Object? breakRemindWater = null,Object? breakRemindMove = null,Object? screenLimitEnabled = null,Object? screenLimitWeekdayMinutes = null,Object? screenLimitWeekendMinutes = null,Object? habitEnabled = null,Object? readingReminderWeekday = freezed,Object? readingReminderWeekend = freezed,Object? weeklyGoalDays = freezed,Object? habit = freezed,Object? windows = null,Object? isSuggested = null,}) {
  return _then(ReadingScheduleDto(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,bedtimeWeekday: freezed == bedtimeWeekday ? _self.bedtimeWeekday : bedtimeWeekday // ignore: cast_nullable_to_non_nullable
as String?,bedtimeWeekend: freezed == bedtimeWeekend ? _self.bedtimeWeekend : bedtimeWeekend // ignore: cast_nullable_to_non_nullable
as String?,breakEnabled: null == breakEnabled ? _self.breakEnabled : breakEnabled // ignore: cast_nullable_to_non_nullable
as bool,breakAfterMinutes: null == breakAfterMinutes ? _self.breakAfterMinutes : breakAfterMinutes // ignore: cast_nullable_to_non_nullable
as int,breakDurationMinutes: null == breakDurationMinutes ? _self.breakDurationMinutes : breakDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,breakRemindEyes: null == breakRemindEyes ? _self.breakRemindEyes : breakRemindEyes // ignore: cast_nullable_to_non_nullable
as bool,breakRemindWater: null == breakRemindWater ? _self.breakRemindWater : breakRemindWater // ignore: cast_nullable_to_non_nullable
as bool,breakRemindMove: null == breakRemindMove ? _self.breakRemindMove : breakRemindMove // ignore: cast_nullable_to_non_nullable
as bool,screenLimitEnabled: null == screenLimitEnabled ? _self.screenLimitEnabled : screenLimitEnabled // ignore: cast_nullable_to_non_nullable
as bool,screenLimitWeekdayMinutes: null == screenLimitWeekdayMinutes ? _self.screenLimitWeekdayMinutes : screenLimitWeekdayMinutes // ignore: cast_nullable_to_non_nullable
as int,screenLimitWeekendMinutes: null == screenLimitWeekendMinutes ? _self.screenLimitWeekendMinutes : screenLimitWeekendMinutes // ignore: cast_nullable_to_non_nullable
as int,habitEnabled: null == habitEnabled ? _self.habitEnabled : habitEnabled // ignore: cast_nullable_to_non_nullable
as bool,readingReminderWeekday: freezed == readingReminderWeekday ? _self.readingReminderWeekday : readingReminderWeekday // ignore: cast_nullable_to_non_nullable
as String?,readingReminderWeekend: freezed == readingReminderWeekend ? _self.readingReminderWeekend : readingReminderWeekend // ignore: cast_nullable_to_non_nullable
as String?,weeklyGoalDays: freezed == weeklyGoalDays ? _self.weeklyGoalDays : weeklyGoalDays // ignore: cast_nullable_to_non_nullable
as int?,habit: freezed == habit ? _self.habit : habit // ignore: cast_nullable_to_non_nullable
as ReadingHabitProgressDto?,windows: null == windows ? _self.windows : windows // ignore: cast_nullable_to_non_nullable
as List<ReadingScheduleWindowDto>,isSuggested: null == isSuggested ? _self.isSuggested : isSuggested // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ReadingScheduleDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReadingHabitProgressDtoCopyWith<$Res>? get habit {
    if (_self.habit == null) {
    return null;
  }

  return $ReadingHabitProgressDtoCopyWith<$Res>(_self.habit!, (value) {
    return _then(_self.copyWith(habit: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReadingScheduleDto].
extension ReadingScheduleDtoPatterns on ReadingScheduleDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingScheduleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingScheduleDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingScheduleDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadingScheduleDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingScheduleDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingScheduleDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int childProfileId,  bool enabled,  String? bedtimeWeekday,  String? bedtimeWeekend,  bool breakEnabled,  int breakAfterMinutes,  int breakDurationMinutes,  bool breakRemindEyes,  bool breakRemindWater,  bool breakRemindMove,  bool screenLimitEnabled,  int screenLimitWeekdayMinutes,  int screenLimitWeekendMinutes,  bool habitEnabled,  String? readingReminderWeekday,  String? readingReminderWeekend,  int? weeklyGoalDays,  ReadingHabitProgressDto? habit,  List<ReadingScheduleWindowDto> windows,  bool isSuggested)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingScheduleDto() when $default != null:
return $default(_that.childProfileId,_that.enabled,_that.bedtimeWeekday,_that.bedtimeWeekend,_that.breakEnabled,_that.breakAfterMinutes,_that.breakDurationMinutes,_that.breakRemindEyes,_that.breakRemindWater,_that.breakRemindMove,_that.screenLimitEnabled,_that.screenLimitWeekdayMinutes,_that.screenLimitWeekendMinutes,_that.habitEnabled,_that.readingReminderWeekday,_that.readingReminderWeekend,_that.weeklyGoalDays,_that.habit,_that.windows,_that.isSuggested);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int childProfileId,  bool enabled,  String? bedtimeWeekday,  String? bedtimeWeekend,  bool breakEnabled,  int breakAfterMinutes,  int breakDurationMinutes,  bool breakRemindEyes,  bool breakRemindWater,  bool breakRemindMove,  bool screenLimitEnabled,  int screenLimitWeekdayMinutes,  int screenLimitWeekendMinutes,  bool habitEnabled,  String? readingReminderWeekday,  String? readingReminderWeekend,  int? weeklyGoalDays,  ReadingHabitProgressDto? habit,  List<ReadingScheduleWindowDto> windows,  bool isSuggested)  $default,) {final _that = this;
switch (_that) {
case _ReadingScheduleDto():
return $default(_that.childProfileId,_that.enabled,_that.bedtimeWeekday,_that.bedtimeWeekend,_that.breakEnabled,_that.breakAfterMinutes,_that.breakDurationMinutes,_that.breakRemindEyes,_that.breakRemindWater,_that.breakRemindMove,_that.screenLimitEnabled,_that.screenLimitWeekdayMinutes,_that.screenLimitWeekendMinutes,_that.habitEnabled,_that.readingReminderWeekday,_that.readingReminderWeekend,_that.weeklyGoalDays,_that.habit,_that.windows,_that.isSuggested);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int childProfileId,  bool enabled,  String? bedtimeWeekday,  String? bedtimeWeekend,  bool breakEnabled,  int breakAfterMinutes,  int breakDurationMinutes,  bool breakRemindEyes,  bool breakRemindWater,  bool breakRemindMove,  bool screenLimitEnabled,  int screenLimitWeekdayMinutes,  int screenLimitWeekendMinutes,  bool habitEnabled,  String? readingReminderWeekday,  String? readingReminderWeekend,  int? weeklyGoalDays,  ReadingHabitProgressDto? habit,  List<ReadingScheduleWindowDto> windows,  bool isSuggested)?  $default,) {final _that = this;
switch (_that) {
case _ReadingScheduleDto() when $default != null:
return $default(_that.childProfileId,_that.enabled,_that.bedtimeWeekday,_that.bedtimeWeekend,_that.breakEnabled,_that.breakAfterMinutes,_that.breakDurationMinutes,_that.breakRemindEyes,_that.breakRemindWater,_that.breakRemindMove,_that.screenLimitEnabled,_that.screenLimitWeekdayMinutes,_that.screenLimitWeekendMinutes,_that.habitEnabled,_that.readingReminderWeekday,_that.readingReminderWeekend,_that.weeklyGoalDays,_that.habit,_that.windows,_that.isSuggested);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingScheduleDto implements ReadingScheduleDto {
  const _ReadingScheduleDto({required this.childProfileId, required this.enabled, this.bedtimeWeekday, this.bedtimeWeekend, required this.breakEnabled, required this.breakAfterMinutes, required this.breakDurationMinutes, required this.breakRemindEyes, required this.breakRemindWater, required this.breakRemindMove, required this.screenLimitEnabled, required this.screenLimitWeekdayMinutes, required this.screenLimitWeekendMinutes, required this.habitEnabled, this.readingReminderWeekday, this.readingReminderWeekend, this.weeklyGoalDays, this.habit,  List<ReadingScheduleWindowDto> windows = const <ReadingScheduleWindowDto>[], required this.isSuggested}): _windows = windows;
  factory _ReadingScheduleDto.fromJson(Map<String, dynamic> json) => _$ReadingScheduleDtoFromJson(json);

@override final  int childProfileId;
@override final  bool enabled;
@override final  String? bedtimeWeekday;
@override final  String? bedtimeWeekend;
@override final  bool breakEnabled;
@override final  int breakAfterMinutes;
@override final  int breakDurationMinutes;
@override final  bool breakRemindEyes;
@override final  bool breakRemindWater;
@override final  bool breakRemindMove;
@override final  bool screenLimitEnabled;
@override final  int screenLimitWeekdayMinutes;
@override final  int screenLimitWeekendMinutes;
@override final  bool habitEnabled;
@override final  String? readingReminderWeekday;
@override final  String? readingReminderWeekend;
@override final  int? weeklyGoalDays;
@override final  ReadingHabitProgressDto? habit;
 final  List<ReadingScheduleWindowDto> _windows;
@override@JsonKey() List<ReadingScheduleWindowDto> get windows {
  if (_windows is EqualUnmodifiableListView) return _windows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_windows);
}

@override final  bool isSuggested;

/// Create a copy of ReadingScheduleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingScheduleDtoCopyWith<_ReadingScheduleDto> get copyWith => __$ReadingScheduleDtoCopyWithImpl<_ReadingScheduleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingScheduleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingScheduleDto&&(identical(other.childProfileId, childProfileId) || other.childProfileId == childProfileId)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.bedtimeWeekday, bedtimeWeekday) || other.bedtimeWeekday == bedtimeWeekday)&&(identical(other.bedtimeWeekend, bedtimeWeekend) || other.bedtimeWeekend == bedtimeWeekend)&&(identical(other.breakEnabled, breakEnabled) || other.breakEnabled == breakEnabled)&&(identical(other.breakAfterMinutes, breakAfterMinutes) || other.breakAfterMinutes == breakAfterMinutes)&&(identical(other.breakDurationMinutes, breakDurationMinutes) || other.breakDurationMinutes == breakDurationMinutes)&&(identical(other.breakRemindEyes, breakRemindEyes) || other.breakRemindEyes == breakRemindEyes)&&(identical(other.breakRemindWater, breakRemindWater) || other.breakRemindWater == breakRemindWater)&&(identical(other.breakRemindMove, breakRemindMove) || other.breakRemindMove == breakRemindMove)&&(identical(other.screenLimitEnabled, screenLimitEnabled) || other.screenLimitEnabled == screenLimitEnabled)&&(identical(other.screenLimitWeekdayMinutes, screenLimitWeekdayMinutes) || other.screenLimitWeekdayMinutes == screenLimitWeekdayMinutes)&&(identical(other.screenLimitWeekendMinutes, screenLimitWeekendMinutes) || other.screenLimitWeekendMinutes == screenLimitWeekendMinutes)&&(identical(other.habitEnabled, habitEnabled) || other.habitEnabled == habitEnabled)&&(identical(other.readingReminderWeekday, readingReminderWeekday) || other.readingReminderWeekday == readingReminderWeekday)&&(identical(other.readingReminderWeekend, readingReminderWeekend) || other.readingReminderWeekend == readingReminderWeekend)&&(identical(other.weeklyGoalDays, weeklyGoalDays) || other.weeklyGoalDays == weeklyGoalDays)&&(identical(other.habit, habit) || other.habit == habit)&&const DeepCollectionEquality().equals(other.windows, _windows)&&(identical(other.isSuggested, isSuggested) || other.isSuggested == isSuggested));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,childProfileId,enabled,bedtimeWeekday,bedtimeWeekend,breakEnabled,breakAfterMinutes,breakDurationMinutes,breakRemindEyes,breakRemindWater,breakRemindMove,screenLimitEnabled,screenLimitWeekdayMinutes,screenLimitWeekendMinutes,habitEnabled,readingReminderWeekday,readingReminderWeekend,weeklyGoalDays,habit,const DeepCollectionEquality().hash(_windows),isSuggested]);
}

@override
String toString() {
    return 'ReadingScheduleDto(childProfileId: $childProfileId, enabled: $enabled, bedtimeWeekday: $bedtimeWeekday, bedtimeWeekend: $bedtimeWeekend, breakEnabled: $breakEnabled, breakAfterMinutes: $breakAfterMinutes, breakDurationMinutes: $breakDurationMinutes, breakRemindEyes: $breakRemindEyes, breakRemindWater: $breakRemindWater, breakRemindMove: $breakRemindMove, screenLimitEnabled: $screenLimitEnabled, screenLimitWeekdayMinutes: $screenLimitWeekdayMinutes, screenLimitWeekendMinutes: $screenLimitWeekendMinutes, habitEnabled: $habitEnabled, readingReminderWeekday: $readingReminderWeekday, readingReminderWeekend: $readingReminderWeekend, weeklyGoalDays: $weeklyGoalDays, habit: $habit, windows: $windows, isSuggested: $isSuggested)';
}


}

/// @nodoc
abstract mixin class _$ReadingScheduleDtoCopyWith<$Res> implements $ReadingScheduleDtoCopyWith<$Res> {
  factory _$ReadingScheduleDtoCopyWith(_ReadingScheduleDto value, $Res Function(_ReadingScheduleDto) _then) = __$ReadingScheduleDtoCopyWithImpl;
@override @useResult
$Res call({
 int childProfileId, bool enabled, String? bedtimeWeekday, String? bedtimeWeekend, bool breakEnabled, int breakAfterMinutes, int breakDurationMinutes, bool breakRemindEyes, bool breakRemindWater, bool breakRemindMove, bool screenLimitEnabled, int screenLimitWeekdayMinutes, int screenLimitWeekendMinutes, bool habitEnabled, String? readingReminderWeekday, String? readingReminderWeekend, int? weeklyGoalDays, ReadingHabitProgressDto? habit, List<ReadingScheduleWindowDto> windows, bool isSuggested
});


@override $ReadingHabitProgressDtoCopyWith<$Res>? get habit;

}
/// @nodoc
class __$ReadingScheduleDtoCopyWithImpl<$Res>
    implements _$ReadingScheduleDtoCopyWith<$Res> {
  __$ReadingScheduleDtoCopyWithImpl(this._self, this._then);

  final _ReadingScheduleDto _self;
  final $Res Function(_ReadingScheduleDto) _then;

/// Create a copy of ReadingScheduleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? childProfileId = null,Object? enabled = null,Object? bedtimeWeekday = freezed,Object? bedtimeWeekend = freezed,Object? breakEnabled = null,Object? breakAfterMinutes = null,Object? breakDurationMinutes = null,Object? breakRemindEyes = null,Object? breakRemindWater = null,Object? breakRemindMove = null,Object? screenLimitEnabled = null,Object? screenLimitWeekdayMinutes = null,Object? screenLimitWeekendMinutes = null,Object? habitEnabled = null,Object? readingReminderWeekday = freezed,Object? readingReminderWeekend = freezed,Object? weeklyGoalDays = freezed,Object? habit = freezed,Object? windows = null,Object? isSuggested = null,}) {
  return _then(_ReadingScheduleDto(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,bedtimeWeekday: freezed == bedtimeWeekday ? _self.bedtimeWeekday : bedtimeWeekday // ignore: cast_nullable_to_non_nullable
as String?,bedtimeWeekend: freezed == bedtimeWeekend ? _self.bedtimeWeekend : bedtimeWeekend // ignore: cast_nullable_to_non_nullable
as String?,breakEnabled: null == breakEnabled ? _self.breakEnabled : breakEnabled // ignore: cast_nullable_to_non_nullable
as bool,breakAfterMinutes: null == breakAfterMinutes ? _self.breakAfterMinutes : breakAfterMinutes // ignore: cast_nullable_to_non_nullable
as int,breakDurationMinutes: null == breakDurationMinutes ? _self.breakDurationMinutes : breakDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,breakRemindEyes: null == breakRemindEyes ? _self.breakRemindEyes : breakRemindEyes // ignore: cast_nullable_to_non_nullable
as bool,breakRemindWater: null == breakRemindWater ? _self.breakRemindWater : breakRemindWater // ignore: cast_nullable_to_non_nullable
as bool,breakRemindMove: null == breakRemindMove ? _self.breakRemindMove : breakRemindMove // ignore: cast_nullable_to_non_nullable
as bool,screenLimitEnabled: null == screenLimitEnabled ? _self.screenLimitEnabled : screenLimitEnabled // ignore: cast_nullable_to_non_nullable
as bool,screenLimitWeekdayMinutes: null == screenLimitWeekdayMinutes ? _self.screenLimitWeekdayMinutes : screenLimitWeekdayMinutes // ignore: cast_nullable_to_non_nullable
as int,screenLimitWeekendMinutes: null == screenLimitWeekendMinutes ? _self.screenLimitWeekendMinutes : screenLimitWeekendMinutes // ignore: cast_nullable_to_non_nullable
as int,habitEnabled: null == habitEnabled ? _self.habitEnabled : habitEnabled // ignore: cast_nullable_to_non_nullable
as bool,readingReminderWeekday: freezed == readingReminderWeekday ? _self.readingReminderWeekday : readingReminderWeekday // ignore: cast_nullable_to_non_nullable
as String?,readingReminderWeekend: freezed == readingReminderWeekend ? _self.readingReminderWeekend : readingReminderWeekend // ignore: cast_nullable_to_non_nullable
as String?,weeklyGoalDays: freezed == weeklyGoalDays ? _self.weeklyGoalDays : weeklyGoalDays // ignore: cast_nullable_to_non_nullable
as int?,habit: freezed == habit ? _self.habit : habit // ignore: cast_nullable_to_non_nullable
as ReadingHabitProgressDto?,windows: null == windows ? _self._windows : windows // ignore: cast_nullable_to_non_nullable
as List<ReadingScheduleWindowDto>,isSuggested: null == isSuggested ? _self.isSuggested : isSuggested // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ReadingScheduleDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReadingHabitProgressDtoCopyWith<$Res>? get habit {
    if (_self.habit == null) {
    return null;
  }

  return $ReadingHabitProgressDtoCopyWith<$Res>(_self.habit!, (value) {
    return _then(_self.copyWith(habit: value));
  });
}
}


/// @nodoc
mixin _$ReadingScheduleWindowDto {

 String get dayType; int get slot; String get startTime; String get endTime;
/// Create a copy of ReadingScheduleWindowDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingScheduleWindowDtoCopyWith<ReadingScheduleWindowDto> get copyWith => _$ReadingScheduleWindowDtoCopyWithImpl<ReadingScheduleWindowDto>(this as ReadingScheduleWindowDto, _$identity);

  /// Serializes this ReadingScheduleWindowDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingScheduleWindowDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingScheduleWindowDto&&(identical(other.dayType, _this.dayType) || other.dayType == _this.dayType)&&(identical(other.slot, _this.slot) || other.slot == _this.slot)&&(identical(other.startTime, _this.startTime) || other.startTime == _this.startTime)&&(identical(other.endTime, _this.endTime) || other.endTime == _this.endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingScheduleWindowDto;
  return Object.hash(runtimeType,_this.dayType,_this.slot,_this.startTime,_this.endTime);
}

@override
String toString() {
  final _this = this as ReadingScheduleWindowDto;
  return 'ReadingScheduleWindowDto(dayType: ${_this.dayType}, slot: ${_this.slot}, startTime: ${_this.startTime}, endTime: ${_this.endTime})';
}


}

/// @nodoc
abstract mixin class $ReadingScheduleWindowDtoCopyWith<$Res>  {
  factory $ReadingScheduleWindowDtoCopyWith(ReadingScheduleWindowDto value, $Res Function(ReadingScheduleWindowDto) _then) = _$ReadingScheduleWindowDtoCopyWithImpl;
@useResult
$Res call({
 String dayType, int slot, String startTime, String endTime
});




}
/// @nodoc
class _$ReadingScheduleWindowDtoCopyWithImpl<$Res>
    implements $ReadingScheduleWindowDtoCopyWith<$Res> {
  _$ReadingScheduleWindowDtoCopyWithImpl(this._self, this._then);

  final ReadingScheduleWindowDto _self;
  final $Res Function(ReadingScheduleWindowDto) _then;

/// Create a copy of ReadingScheduleWindowDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayType = null,Object? slot = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(ReadingScheduleWindowDto(
dayType: null == dayType ? _self.dayType : dayType // ignore: cast_nullable_to_non_nullable
as String,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingScheduleWindowDto].
extension ReadingScheduleWindowDtoPatterns on ReadingScheduleWindowDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingScheduleWindowDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingScheduleWindowDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingScheduleWindowDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadingScheduleWindowDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingScheduleWindowDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingScheduleWindowDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String dayType,  int slot,  String startTime,  String endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingScheduleWindowDto() when $default != null:
return $default(_that.dayType,_that.slot,_that.startTime,_that.endTime);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String dayType,  int slot,  String startTime,  String endTime)  $default,) {final _that = this;
switch (_that) {
case _ReadingScheduleWindowDto():
return $default(_that.dayType,_that.slot,_that.startTime,_that.endTime);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String dayType,  int slot,  String startTime,  String endTime)?  $default,) {final _that = this;
switch (_that) {
case _ReadingScheduleWindowDto() when $default != null:
return $default(_that.dayType,_that.slot,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingScheduleWindowDto implements ReadingScheduleWindowDto {
  const _ReadingScheduleWindowDto({required this.dayType, required this.slot, required this.startTime, required this.endTime});
  factory _ReadingScheduleWindowDto.fromJson(Map<String, dynamic> json) => _$ReadingScheduleWindowDtoFromJson(json);

@override final  String dayType;
@override final  int slot;
@override final  String startTime;
@override final  String endTime;

/// Create a copy of ReadingScheduleWindowDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingScheduleWindowDtoCopyWith<_ReadingScheduleWindowDto> get copyWith => __$ReadingScheduleWindowDtoCopyWithImpl<_ReadingScheduleWindowDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingScheduleWindowDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingScheduleWindowDto&&(identical(other.dayType, dayType) || other.dayType == dayType)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,dayType,slot,startTime,endTime);
}

@override
String toString() {
    return 'ReadingScheduleWindowDto(dayType: $dayType, slot: $slot, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$ReadingScheduleWindowDtoCopyWith<$Res> implements $ReadingScheduleWindowDtoCopyWith<$Res> {
  factory _$ReadingScheduleWindowDtoCopyWith(_ReadingScheduleWindowDto value, $Res Function(_ReadingScheduleWindowDto) _then) = __$ReadingScheduleWindowDtoCopyWithImpl;
@override @useResult
$Res call({
 String dayType, int slot, String startTime, String endTime
});




}
/// @nodoc
class __$ReadingScheduleWindowDtoCopyWithImpl<$Res>
    implements _$ReadingScheduleWindowDtoCopyWith<$Res> {
  __$ReadingScheduleWindowDtoCopyWithImpl(this._self, this._then);

  final _ReadingScheduleWindowDto _self;
  final $Res Function(_ReadingScheduleWindowDto) _then;

/// Create a copy of ReadingScheduleWindowDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayType = null,Object? slot = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_ReadingScheduleWindowDto(
dayType: null == dayType ? _self.dayType : dayType // ignore: cast_nullable_to_non_nullable
as String,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ReadingHabitProgressDto {

 int get streakDays; int get daysReadThisWeek; bool get goalMetThisWeek;
/// Create a copy of ReadingHabitProgressDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingHabitProgressDtoCopyWith<ReadingHabitProgressDto> get copyWith => _$ReadingHabitProgressDtoCopyWithImpl<ReadingHabitProgressDto>(this as ReadingHabitProgressDto, _$identity);

  /// Serializes this ReadingHabitProgressDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingHabitProgressDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingHabitProgressDto&&(identical(other.streakDays, _this.streakDays) || other.streakDays == _this.streakDays)&&(identical(other.daysReadThisWeek, _this.daysReadThisWeek) || other.daysReadThisWeek == _this.daysReadThisWeek)&&(identical(other.goalMetThisWeek, _this.goalMetThisWeek) || other.goalMetThisWeek == _this.goalMetThisWeek));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingHabitProgressDto;
  return Object.hash(runtimeType,_this.streakDays,_this.daysReadThisWeek,_this.goalMetThisWeek);
}

@override
String toString() {
  final _this = this as ReadingHabitProgressDto;
  return 'ReadingHabitProgressDto(streakDays: ${_this.streakDays}, daysReadThisWeek: ${_this.daysReadThisWeek}, goalMetThisWeek: ${_this.goalMetThisWeek})';
}


}

/// @nodoc
abstract mixin class $ReadingHabitProgressDtoCopyWith<$Res>  {
  factory $ReadingHabitProgressDtoCopyWith(ReadingHabitProgressDto value, $Res Function(ReadingHabitProgressDto) _then) = _$ReadingHabitProgressDtoCopyWithImpl;
@useResult
$Res call({
 int streakDays, int daysReadThisWeek, bool goalMetThisWeek
});




}
/// @nodoc
class _$ReadingHabitProgressDtoCopyWithImpl<$Res>
    implements $ReadingHabitProgressDtoCopyWith<$Res> {
  _$ReadingHabitProgressDtoCopyWithImpl(this._self, this._then);

  final ReadingHabitProgressDto _self;
  final $Res Function(ReadingHabitProgressDto) _then;

/// Create a copy of ReadingHabitProgressDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? streakDays = null,Object? daysReadThisWeek = null,Object? goalMetThisWeek = null,}) {
  return _then(ReadingHabitProgressDto(
streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,daysReadThisWeek: null == daysReadThisWeek ? _self.daysReadThisWeek : daysReadThisWeek // ignore: cast_nullable_to_non_nullable
as int,goalMetThisWeek: null == goalMetThisWeek ? _self.goalMetThisWeek : goalMetThisWeek // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingHabitProgressDto].
extension ReadingHabitProgressDtoPatterns on ReadingHabitProgressDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingHabitProgressDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingHabitProgressDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingHabitProgressDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadingHabitProgressDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingHabitProgressDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingHabitProgressDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int streakDays,  int daysReadThisWeek,  bool goalMetThisWeek)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingHabitProgressDto() when $default != null:
return $default(_that.streakDays,_that.daysReadThisWeek,_that.goalMetThisWeek);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int streakDays,  int daysReadThisWeek,  bool goalMetThisWeek)  $default,) {final _that = this;
switch (_that) {
case _ReadingHabitProgressDto():
return $default(_that.streakDays,_that.daysReadThisWeek,_that.goalMetThisWeek);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int streakDays,  int daysReadThisWeek,  bool goalMetThisWeek)?  $default,) {final _that = this;
switch (_that) {
case _ReadingHabitProgressDto() when $default != null:
return $default(_that.streakDays,_that.daysReadThisWeek,_that.goalMetThisWeek);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingHabitProgressDto implements ReadingHabitProgressDto {
  const _ReadingHabitProgressDto({required this.streakDays, required this.daysReadThisWeek, required this.goalMetThisWeek});
  factory _ReadingHabitProgressDto.fromJson(Map<String, dynamic> json) => _$ReadingHabitProgressDtoFromJson(json);

@override final  int streakDays;
@override final  int daysReadThisWeek;
@override final  bool goalMetThisWeek;

/// Create a copy of ReadingHabitProgressDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingHabitProgressDtoCopyWith<_ReadingHabitProgressDto> get copyWith => __$ReadingHabitProgressDtoCopyWithImpl<_ReadingHabitProgressDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingHabitProgressDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingHabitProgressDto&&(identical(other.streakDays, streakDays) || other.streakDays == streakDays)&&(identical(other.daysReadThisWeek, daysReadThisWeek) || other.daysReadThisWeek == daysReadThisWeek)&&(identical(other.goalMetThisWeek, goalMetThisWeek) || other.goalMetThisWeek == goalMetThisWeek));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,streakDays,daysReadThisWeek,goalMetThisWeek);
}

@override
String toString() {
    return 'ReadingHabitProgressDto(streakDays: $streakDays, daysReadThisWeek: $daysReadThisWeek, goalMetThisWeek: $goalMetThisWeek)';
}


}

/// @nodoc
abstract mixin class _$ReadingHabitProgressDtoCopyWith<$Res> implements $ReadingHabitProgressDtoCopyWith<$Res> {
  factory _$ReadingHabitProgressDtoCopyWith(_ReadingHabitProgressDto value, $Res Function(_ReadingHabitProgressDto) _then) = __$ReadingHabitProgressDtoCopyWithImpl;
@override @useResult
$Res call({
 int streakDays, int daysReadThisWeek, bool goalMetThisWeek
});




}
/// @nodoc
class __$ReadingHabitProgressDtoCopyWithImpl<$Res>
    implements _$ReadingHabitProgressDtoCopyWith<$Res> {
  __$ReadingHabitProgressDtoCopyWithImpl(this._self, this._then);

  final _ReadingHabitProgressDto _self;
  final $Res Function(_ReadingHabitProgressDto) _then;

/// Create a copy of ReadingHabitProgressDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? streakDays = null,Object? daysReadThisWeek = null,Object? goalMetThisWeek = null,}) {
  return _then(_ReadingHabitProgressDto(
streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,daysReadThisWeek: null == daysReadThisWeek ? _self.daysReadThisWeek : daysReadThisWeek // ignore: cast_nullable_to_non_nullable
as int,goalMetThisWeek: null == goalMetThisWeek ? _self.goalMetThisWeek : goalMetThisWeek // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
