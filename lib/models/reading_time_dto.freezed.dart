// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_time_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReadingTimeStatusDto {

 String get state; String? get endReason; DateTime? get endsAt; DateTime? get graceEndsAt; DateTime? get breakUntil; String? get breakActivity; DateTime? get nextAllowedAt; DateTime? get bedtimeAt; int? get screenMinutesUsed; int? get screenMinutesLimit; String? get message;
/// Create a copy of ReadingTimeStatusDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingTimeStatusDtoCopyWith<ReadingTimeStatusDto> get copyWith => _$ReadingTimeStatusDtoCopyWithImpl<ReadingTimeStatusDto>(this as ReadingTimeStatusDto, _$identity);

  /// Serializes this ReadingTimeStatusDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingTimeStatusDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingTimeStatusDto&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.endReason, _this.endReason) || other.endReason == _this.endReason)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.graceEndsAt, _this.graceEndsAt) || other.graceEndsAt == _this.graceEndsAt)&&(identical(other.breakUntil, _this.breakUntil) || other.breakUntil == _this.breakUntil)&&(identical(other.breakActivity, _this.breakActivity) || other.breakActivity == _this.breakActivity)&&(identical(other.nextAllowedAt, _this.nextAllowedAt) || other.nextAllowedAt == _this.nextAllowedAt)&&(identical(other.bedtimeAt, _this.bedtimeAt) || other.bedtimeAt == _this.bedtimeAt)&&(identical(other.screenMinutesUsed, _this.screenMinutesUsed) || other.screenMinutesUsed == _this.screenMinutesUsed)&&(identical(other.screenMinutesLimit, _this.screenMinutesLimit) || other.screenMinutesLimit == _this.screenMinutesLimit)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingTimeStatusDto;
  return Object.hash(runtimeType,_this.state,_this.endReason,_this.endsAt,_this.graceEndsAt,_this.breakUntil,_this.breakActivity,_this.nextAllowedAt,_this.bedtimeAt,_this.screenMinutesUsed,_this.screenMinutesLimit,_this.message);
}

@override
String toString() {
  final _this = this as ReadingTimeStatusDto;
  return 'ReadingTimeStatusDto(state: ${_this.state}, endReason: ${_this.endReason}, endsAt: ${_this.endsAt}, graceEndsAt: ${_this.graceEndsAt}, breakUntil: ${_this.breakUntil}, breakActivity: ${_this.breakActivity}, nextAllowedAt: ${_this.nextAllowedAt}, bedtimeAt: ${_this.bedtimeAt}, screenMinutesUsed: ${_this.screenMinutesUsed}, screenMinutesLimit: ${_this.screenMinutesLimit}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $ReadingTimeStatusDtoCopyWith<$Res>  {
  factory $ReadingTimeStatusDtoCopyWith(ReadingTimeStatusDto value, $Res Function(ReadingTimeStatusDto) _then) = _$ReadingTimeStatusDtoCopyWithImpl;
@useResult
$Res call({
 String state, String? endReason, DateTime? endsAt, DateTime? graceEndsAt, DateTime? breakUntil, String? breakActivity, DateTime? nextAllowedAt, DateTime? bedtimeAt, int? screenMinutesUsed, int? screenMinutesLimit, String? message
});




}
/// @nodoc
class _$ReadingTimeStatusDtoCopyWithImpl<$Res>
    implements $ReadingTimeStatusDtoCopyWith<$Res> {
  _$ReadingTimeStatusDtoCopyWithImpl(this._self, this._then);

  final ReadingTimeStatusDto _self;
  final $Res Function(ReadingTimeStatusDto) _then;

/// Create a copy of ReadingTimeStatusDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? endReason = freezed,Object? endsAt = freezed,Object? graceEndsAt = freezed,Object? breakUntil = freezed,Object? breakActivity = freezed,Object? nextAllowedAt = freezed,Object? bedtimeAt = freezed,Object? screenMinutesUsed = freezed,Object? screenMinutesLimit = freezed,Object? message = freezed,}) {
  return _then(ReadingTimeStatusDto(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,endReason: freezed == endReason ? _self.endReason : endReason // ignore: cast_nullable_to_non_nullable
as String?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,graceEndsAt: freezed == graceEndsAt ? _self.graceEndsAt : graceEndsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,breakUntil: freezed == breakUntil ? _self.breakUntil : breakUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,breakActivity: freezed == breakActivity ? _self.breakActivity : breakActivity // ignore: cast_nullable_to_non_nullable
as String?,nextAllowedAt: freezed == nextAllowedAt ? _self.nextAllowedAt : nextAllowedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,bedtimeAt: freezed == bedtimeAt ? _self.bedtimeAt : bedtimeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,screenMinutesUsed: freezed == screenMinutesUsed ? _self.screenMinutesUsed : screenMinutesUsed // ignore: cast_nullable_to_non_nullable
as int?,screenMinutesLimit: freezed == screenMinutesLimit ? _self.screenMinutesLimit : screenMinutesLimit // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingTimeStatusDto].
extension ReadingTimeStatusDtoPatterns on ReadingTimeStatusDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingTimeStatusDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingTimeStatusDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingTimeStatusDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadingTimeStatusDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingTimeStatusDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingTimeStatusDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String state,  String? endReason,  DateTime? endsAt,  DateTime? graceEndsAt,  DateTime? breakUntil,  String? breakActivity,  DateTime? nextAllowedAt,  DateTime? bedtimeAt,  int? screenMinutesUsed,  int? screenMinutesLimit,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingTimeStatusDto() when $default != null:
return $default(_that.state,_that.endReason,_that.endsAt,_that.graceEndsAt,_that.breakUntil,_that.breakActivity,_that.nextAllowedAt,_that.bedtimeAt,_that.screenMinutesUsed,_that.screenMinutesLimit,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String state,  String? endReason,  DateTime? endsAt,  DateTime? graceEndsAt,  DateTime? breakUntil,  String? breakActivity,  DateTime? nextAllowedAt,  DateTime? bedtimeAt,  int? screenMinutesUsed,  int? screenMinutesLimit,  String? message)  $default,) {final _that = this;
switch (_that) {
case _ReadingTimeStatusDto():
return $default(_that.state,_that.endReason,_that.endsAt,_that.graceEndsAt,_that.breakUntil,_that.breakActivity,_that.nextAllowedAt,_that.bedtimeAt,_that.screenMinutesUsed,_that.screenMinutesLimit,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String state,  String? endReason,  DateTime? endsAt,  DateTime? graceEndsAt,  DateTime? breakUntil,  String? breakActivity,  DateTime? nextAllowedAt,  DateTime? bedtimeAt,  int? screenMinutesUsed,  int? screenMinutesLimit,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _ReadingTimeStatusDto() when $default != null:
return $default(_that.state,_that.endReason,_that.endsAt,_that.graceEndsAt,_that.breakUntil,_that.breakActivity,_that.nextAllowedAt,_that.bedtimeAt,_that.screenMinutesUsed,_that.screenMinutesLimit,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingTimeStatusDto implements ReadingTimeStatusDto {
  const _ReadingTimeStatusDto({required this.state, this.endReason, this.endsAt, this.graceEndsAt, this.breakUntil, this.breakActivity, this.nextAllowedAt, this.bedtimeAt, this.screenMinutesUsed, this.screenMinutesLimit, this.message});
  factory _ReadingTimeStatusDto.fromJson(Map<String, dynamic> json) => _$ReadingTimeStatusDtoFromJson(json);

@override final  String state;
@override final  String? endReason;
@override final  DateTime? endsAt;
@override final  DateTime? graceEndsAt;
@override final  DateTime? breakUntil;
@override final  String? breakActivity;
@override final  DateTime? nextAllowedAt;
@override final  DateTime? bedtimeAt;
@override final  int? screenMinutesUsed;
@override final  int? screenMinutesLimit;
@override final  String? message;

/// Create a copy of ReadingTimeStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingTimeStatusDtoCopyWith<_ReadingTimeStatusDto> get copyWith => __$ReadingTimeStatusDtoCopyWithImpl<_ReadingTimeStatusDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingTimeStatusDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingTimeStatusDto&&(identical(other.state, state) || other.state == state)&&(identical(other.endReason, endReason) || other.endReason == endReason)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.graceEndsAt, graceEndsAt) || other.graceEndsAt == graceEndsAt)&&(identical(other.breakUntil, breakUntil) || other.breakUntil == breakUntil)&&(identical(other.breakActivity, breakActivity) || other.breakActivity == breakActivity)&&(identical(other.nextAllowedAt, nextAllowedAt) || other.nextAllowedAt == nextAllowedAt)&&(identical(other.bedtimeAt, bedtimeAt) || other.bedtimeAt == bedtimeAt)&&(identical(other.screenMinutesUsed, screenMinutesUsed) || other.screenMinutesUsed == screenMinutesUsed)&&(identical(other.screenMinutesLimit, screenMinutesLimit) || other.screenMinutesLimit == screenMinutesLimit)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,state,endReason,endsAt,graceEndsAt,breakUntil,breakActivity,nextAllowedAt,bedtimeAt,screenMinutesUsed,screenMinutesLimit,message);
}

@override
String toString() {
    return 'ReadingTimeStatusDto(state: $state, endReason: $endReason, endsAt: $endsAt, graceEndsAt: $graceEndsAt, breakUntil: $breakUntil, breakActivity: $breakActivity, nextAllowedAt: $nextAllowedAt, bedtimeAt: $bedtimeAt, screenMinutesUsed: $screenMinutesUsed, screenMinutesLimit: $screenMinutesLimit, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ReadingTimeStatusDtoCopyWith<$Res> implements $ReadingTimeStatusDtoCopyWith<$Res> {
  factory _$ReadingTimeStatusDtoCopyWith(_ReadingTimeStatusDto value, $Res Function(_ReadingTimeStatusDto) _then) = __$ReadingTimeStatusDtoCopyWithImpl;
@override @useResult
$Res call({
 String state, String? endReason, DateTime? endsAt, DateTime? graceEndsAt, DateTime? breakUntil, String? breakActivity, DateTime? nextAllowedAt, DateTime? bedtimeAt, int? screenMinutesUsed, int? screenMinutesLimit, String? message
});




}
/// @nodoc
class __$ReadingTimeStatusDtoCopyWithImpl<$Res>
    implements _$ReadingTimeStatusDtoCopyWith<$Res> {
  __$ReadingTimeStatusDtoCopyWithImpl(this._self, this._then);

  final _ReadingTimeStatusDto _self;
  final $Res Function(_ReadingTimeStatusDto) _then;

/// Create a copy of ReadingTimeStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? endReason = freezed,Object? endsAt = freezed,Object? graceEndsAt = freezed,Object? breakUntil = freezed,Object? breakActivity = freezed,Object? nextAllowedAt = freezed,Object? bedtimeAt = freezed,Object? screenMinutesUsed = freezed,Object? screenMinutesLimit = freezed,Object? message = freezed,}) {
  return _then(_ReadingTimeStatusDto(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,endReason: freezed == endReason ? _self.endReason : endReason // ignore: cast_nullable_to_non_nullable
as String?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,graceEndsAt: freezed == graceEndsAt ? _self.graceEndsAt : graceEndsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,breakUntil: freezed == breakUntil ? _self.breakUntil : breakUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,breakActivity: freezed == breakActivity ? _self.breakActivity : breakActivity // ignore: cast_nullable_to_non_nullable
as String?,nextAllowedAt: freezed == nextAllowedAt ? _self.nextAllowedAt : nextAllowedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,bedtimeAt: freezed == bedtimeAt ? _self.bedtimeAt : bedtimeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,screenMinutesUsed: freezed == screenMinutesUsed ? _self.screenMinutesUsed : screenMinutesUsed // ignore: cast_nullable_to_non_nullable
as int?,screenMinutesLimit: freezed == screenMinutesLimit ? _self.screenMinutesLimit : screenMinutesLimit // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$HabitReminderDto {

 DateTime get at; String get message;
/// Create a copy of HabitReminderDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitReminderDtoCopyWith<HabitReminderDto> get copyWith => _$HabitReminderDtoCopyWithImpl<HabitReminderDto>(this as HabitReminderDto, _$identity);

  /// Serializes this HabitReminderDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HabitReminderDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HabitReminderDto&&(identical(other.at, _this.at) || other.at == _this.at)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HabitReminderDto;
  return Object.hash(runtimeType,_this.at,_this.message);
}

@override
String toString() {
  final _this = this as HabitReminderDto;
  return 'HabitReminderDto(at: ${_this.at}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $HabitReminderDtoCopyWith<$Res>  {
  factory $HabitReminderDtoCopyWith(HabitReminderDto value, $Res Function(HabitReminderDto) _then) = _$HabitReminderDtoCopyWithImpl;
@useResult
$Res call({
 DateTime at, String message
});




}
/// @nodoc
class _$HabitReminderDtoCopyWithImpl<$Res>
    implements $HabitReminderDtoCopyWith<$Res> {
  _$HabitReminderDtoCopyWithImpl(this._self, this._then);

  final HabitReminderDto _self;
  final $Res Function(HabitReminderDto) _then;

/// Create a copy of HabitReminderDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? at = null,Object? message = null,}) {
  return _then(HabitReminderDto(
at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HabitReminderDto].
extension HabitReminderDtoPatterns on HabitReminderDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HabitReminderDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HabitReminderDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HabitReminderDto value)  $default,){
final _that = this;
switch (_that) {
case _HabitReminderDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HabitReminderDto value)?  $default,){
final _that = this;
switch (_that) {
case _HabitReminderDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime at,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HabitReminderDto() when $default != null:
return $default(_that.at,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime at,  String message)  $default,) {final _that = this;
switch (_that) {
case _HabitReminderDto():
return $default(_that.at,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime at,  String message)?  $default,) {final _that = this;
switch (_that) {
case _HabitReminderDto() when $default != null:
return $default(_that.at,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HabitReminderDto implements HabitReminderDto {
  const _HabitReminderDto({required this.at, this.message = ''});
  factory _HabitReminderDto.fromJson(Map<String, dynamic> json) => _$HabitReminderDtoFromJson(json);

@override final  DateTime at;
@override@JsonKey() final  String message;

/// Create a copy of HabitReminderDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitReminderDtoCopyWith<_HabitReminderDto> get copyWith => __$HabitReminderDtoCopyWithImpl<_HabitReminderDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HabitReminderDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HabitReminderDto&&(identical(other.at, at) || other.at == at)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,at,message);
}

@override
String toString() {
    return 'HabitReminderDto(at: $at, message: $message)';
}


}

/// @nodoc
abstract mixin class _$HabitReminderDtoCopyWith<$Res> implements $HabitReminderDtoCopyWith<$Res> {
  factory _$HabitReminderDtoCopyWith(_HabitReminderDto value, $Res Function(_HabitReminderDto) _then) = __$HabitReminderDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime at, String message
});




}
/// @nodoc
class __$HabitReminderDtoCopyWithImpl<$Res>
    implements _$HabitReminderDtoCopyWith<$Res> {
  __$HabitReminderDtoCopyWithImpl(this._self, this._then);

  final _HabitReminderDto _self;
  final $Res Function(_HabitReminderDto) _then;

/// Create a copy of HabitReminderDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? at = null,Object? message = null,}) {
  return _then(_HabitReminderDto(
at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HabitQuietPeriodDto {

 DateTime get from; DateTime get to;
/// Create a copy of HabitQuietPeriodDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitQuietPeriodDtoCopyWith<HabitQuietPeriodDto> get copyWith => _$HabitQuietPeriodDtoCopyWithImpl<HabitQuietPeriodDto>(this as HabitQuietPeriodDto, _$identity);

  /// Serializes this HabitQuietPeriodDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HabitQuietPeriodDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HabitQuietPeriodDto&&(identical(other.from, _this.from) || other.from == _this.from)&&(identical(other.to, _this.to) || other.to == _this.to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HabitQuietPeriodDto;
  return Object.hash(runtimeType,_this.from,_this.to);
}

@override
String toString() {
  final _this = this as HabitQuietPeriodDto;
  return 'HabitQuietPeriodDto(from: ${_this.from}, to: ${_this.to})';
}


}

/// @nodoc
abstract mixin class $HabitQuietPeriodDtoCopyWith<$Res>  {
  factory $HabitQuietPeriodDtoCopyWith(HabitQuietPeriodDto value, $Res Function(HabitQuietPeriodDto) _then) = _$HabitQuietPeriodDtoCopyWithImpl;
@useResult
$Res call({
 DateTime from, DateTime to
});




}
/// @nodoc
class _$HabitQuietPeriodDtoCopyWithImpl<$Res>
    implements $HabitQuietPeriodDtoCopyWith<$Res> {
  _$HabitQuietPeriodDtoCopyWithImpl(this._self, this._then);

  final HabitQuietPeriodDto _self;
  final $Res Function(HabitQuietPeriodDto) _then;

/// Create a copy of HabitQuietPeriodDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,}) {
  return _then(HabitQuietPeriodDto(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [HabitQuietPeriodDto].
extension HabitQuietPeriodDtoPatterns on HabitQuietPeriodDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HabitQuietPeriodDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HabitQuietPeriodDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HabitQuietPeriodDto value)  $default,){
final _that = this;
switch (_that) {
case _HabitQuietPeriodDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HabitQuietPeriodDto value)?  $default,){
final _that = this;
switch (_that) {
case _HabitQuietPeriodDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime from,  DateTime to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HabitQuietPeriodDto() when $default != null:
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime from,  DateTime to)  $default,) {final _that = this;
switch (_that) {
case _HabitQuietPeriodDto():
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime from,  DateTime to)?  $default,) {final _that = this;
switch (_that) {
case _HabitQuietPeriodDto() when $default != null:
return $default(_that.from,_that.to);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HabitQuietPeriodDto implements HabitQuietPeriodDto {
  const _HabitQuietPeriodDto({required this.from, required this.to});
  factory _HabitQuietPeriodDto.fromJson(Map<String, dynamic> json) => _$HabitQuietPeriodDtoFromJson(json);

@override final  DateTime from;
@override final  DateTime to;

/// Create a copy of HabitQuietPeriodDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitQuietPeriodDtoCopyWith<_HabitQuietPeriodDto> get copyWith => __$HabitQuietPeriodDtoCopyWithImpl<_HabitQuietPeriodDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HabitQuietPeriodDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HabitQuietPeriodDto&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,from,to);
}

@override
String toString() {
    return 'HabitQuietPeriodDto(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$HabitQuietPeriodDtoCopyWith<$Res> implements $HabitQuietPeriodDtoCopyWith<$Res> {
  factory _$HabitQuietPeriodDtoCopyWith(_HabitQuietPeriodDto value, $Res Function(_HabitQuietPeriodDto) _then) = __$HabitQuietPeriodDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime from, DateTime to
});




}
/// @nodoc
class __$HabitQuietPeriodDtoCopyWithImpl<$Res>
    implements _$HabitQuietPeriodDtoCopyWith<$Res> {
  __$HabitQuietPeriodDtoCopyWithImpl(this._self, this._then);

  final _HabitQuietPeriodDto _self;
  final $Res Function(_HabitQuietPeriodDto) _then;

/// Create a copy of HabitQuietPeriodDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,}) {
  return _then(_HabitQuietPeriodDto(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ChildHabitDto {

 bool get enabled; int get streakDays; int get daysReadThisWeek; int? get weeklyGoalDays; bool get goalMetThisWeek; List<HabitReminderDto> get reminders; List<HabitQuietPeriodDto> get quietPeriods;
/// Create a copy of ChildHabitDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildHabitDtoCopyWith<ChildHabitDto> get copyWith => _$ChildHabitDtoCopyWithImpl<ChildHabitDto>(this as ChildHabitDto, _$identity);

  /// Serializes this ChildHabitDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChildHabitDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildHabitDto&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.streakDays, _this.streakDays) || other.streakDays == _this.streakDays)&&(identical(other.daysReadThisWeek, _this.daysReadThisWeek) || other.daysReadThisWeek == _this.daysReadThisWeek)&&(identical(other.weeklyGoalDays, _this.weeklyGoalDays) || other.weeklyGoalDays == _this.weeklyGoalDays)&&(identical(other.goalMetThisWeek, _this.goalMetThisWeek) || other.goalMetThisWeek == _this.goalMetThisWeek)&&const DeepCollectionEquality().equals(other.reminders, _this.reminders)&&const DeepCollectionEquality().equals(other.quietPeriods, _this.quietPeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChildHabitDto;
  return Object.hash(runtimeType,_this.enabled,_this.streakDays,_this.daysReadThisWeek,_this.weeklyGoalDays,_this.goalMetThisWeek,const DeepCollectionEquality().hash(_this.reminders),const DeepCollectionEquality().hash(_this.quietPeriods));
}

@override
String toString() {
  final _this = this as ChildHabitDto;
  return 'ChildHabitDto(enabled: ${_this.enabled}, streakDays: ${_this.streakDays}, daysReadThisWeek: ${_this.daysReadThisWeek}, weeklyGoalDays: ${_this.weeklyGoalDays}, goalMetThisWeek: ${_this.goalMetThisWeek}, reminders: ${_this.reminders}, quietPeriods: ${_this.quietPeriods})';
}


}

/// @nodoc
abstract mixin class $ChildHabitDtoCopyWith<$Res>  {
  factory $ChildHabitDtoCopyWith(ChildHabitDto value, $Res Function(ChildHabitDto) _then) = _$ChildHabitDtoCopyWithImpl;
@useResult
$Res call({
 bool enabled, int streakDays, int daysReadThisWeek, int? weeklyGoalDays, bool goalMetThisWeek, List<HabitReminderDto> reminders, List<HabitQuietPeriodDto> quietPeriods
});




}
/// @nodoc
class _$ChildHabitDtoCopyWithImpl<$Res>
    implements $ChildHabitDtoCopyWith<$Res> {
  _$ChildHabitDtoCopyWithImpl(this._self, this._then);

  final ChildHabitDto _self;
  final $Res Function(ChildHabitDto) _then;

/// Create a copy of ChildHabitDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? streakDays = null,Object? daysReadThisWeek = null,Object? weeklyGoalDays = freezed,Object? goalMetThisWeek = null,Object? reminders = null,Object? quietPeriods = null,}) {
  return _then(ChildHabitDto(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,daysReadThisWeek: null == daysReadThisWeek ? _self.daysReadThisWeek : daysReadThisWeek // ignore: cast_nullable_to_non_nullable
as int,weeklyGoalDays: freezed == weeklyGoalDays ? _self.weeklyGoalDays : weeklyGoalDays // ignore: cast_nullable_to_non_nullable
as int?,goalMetThisWeek: null == goalMetThisWeek ? _self.goalMetThisWeek : goalMetThisWeek // ignore: cast_nullable_to_non_nullable
as bool,reminders: null == reminders ? _self.reminders : reminders // ignore: cast_nullable_to_non_nullable
as List<HabitReminderDto>,quietPeriods: null == quietPeriods ? _self.quietPeriods : quietPeriods // ignore: cast_nullable_to_non_nullable
as List<HabitQuietPeriodDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildHabitDto].
extension ChildHabitDtoPatterns on ChildHabitDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildHabitDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildHabitDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildHabitDto value)  $default,){
final _that = this;
switch (_that) {
case _ChildHabitDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildHabitDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChildHabitDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  int streakDays,  int daysReadThisWeek,  int? weeklyGoalDays,  bool goalMetThisWeek,  List<HabitReminderDto> reminders,  List<HabitQuietPeriodDto> quietPeriods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildHabitDto() when $default != null:
return $default(_that.enabled,_that.streakDays,_that.daysReadThisWeek,_that.weeklyGoalDays,_that.goalMetThisWeek,_that.reminders,_that.quietPeriods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  int streakDays,  int daysReadThisWeek,  int? weeklyGoalDays,  bool goalMetThisWeek,  List<HabitReminderDto> reminders,  List<HabitQuietPeriodDto> quietPeriods)  $default,) {final _that = this;
switch (_that) {
case _ChildHabitDto():
return $default(_that.enabled,_that.streakDays,_that.daysReadThisWeek,_that.weeklyGoalDays,_that.goalMetThisWeek,_that.reminders,_that.quietPeriods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  int streakDays,  int daysReadThisWeek,  int? weeklyGoalDays,  bool goalMetThisWeek,  List<HabitReminderDto> reminders,  List<HabitQuietPeriodDto> quietPeriods)?  $default,) {final _that = this;
switch (_that) {
case _ChildHabitDto() when $default != null:
return $default(_that.enabled,_that.streakDays,_that.daysReadThisWeek,_that.weeklyGoalDays,_that.goalMetThisWeek,_that.reminders,_that.quietPeriods);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildHabitDto implements ChildHabitDto {
  const _ChildHabitDto({this.enabled = false, this.streakDays = 0, this.daysReadThisWeek = 0, this.weeklyGoalDays, this.goalMetThisWeek = false,  List<HabitReminderDto> reminders = const <HabitReminderDto>[],  List<HabitQuietPeriodDto> quietPeriods = const <HabitQuietPeriodDto>[]}): _reminders = reminders,_quietPeriods = quietPeriods;
  factory _ChildHabitDto.fromJson(Map<String, dynamic> json) => _$ChildHabitDtoFromJson(json);

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  int streakDays;
@override@JsonKey() final  int daysReadThisWeek;
@override final  int? weeklyGoalDays;
@override@JsonKey() final  bool goalMetThisWeek;
 final  List<HabitReminderDto> _reminders;
@override@JsonKey() List<HabitReminderDto> get reminders {
  if (_reminders is EqualUnmodifiableListView) return _reminders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reminders);
}

 final  List<HabitQuietPeriodDto> _quietPeriods;
@override@JsonKey() List<HabitQuietPeriodDto> get quietPeriods {
  if (_quietPeriods is EqualUnmodifiableListView) return _quietPeriods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quietPeriods);
}


/// Create a copy of ChildHabitDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildHabitDtoCopyWith<_ChildHabitDto> get copyWith => __$ChildHabitDtoCopyWithImpl<_ChildHabitDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildHabitDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildHabitDto&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.streakDays, streakDays) || other.streakDays == streakDays)&&(identical(other.daysReadThisWeek, daysReadThisWeek) || other.daysReadThisWeek == daysReadThisWeek)&&(identical(other.weeklyGoalDays, weeklyGoalDays) || other.weeklyGoalDays == weeklyGoalDays)&&(identical(other.goalMetThisWeek, goalMetThisWeek) || other.goalMetThisWeek == goalMetThisWeek)&&const DeepCollectionEquality().equals(other.reminders, _reminders)&&const DeepCollectionEquality().equals(other.quietPeriods, _quietPeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,enabled,streakDays,daysReadThisWeek,weeklyGoalDays,goalMetThisWeek,const DeepCollectionEquality().hash(_reminders),const DeepCollectionEquality().hash(_quietPeriods));
}

@override
String toString() {
    return 'ChildHabitDto(enabled: $enabled, streakDays: $streakDays, daysReadThisWeek: $daysReadThisWeek, weeklyGoalDays: $weeklyGoalDays, goalMetThisWeek: $goalMetThisWeek, reminders: $reminders, quietPeriods: $quietPeriods)';
}


}

/// @nodoc
abstract mixin class _$ChildHabitDtoCopyWith<$Res> implements $ChildHabitDtoCopyWith<$Res> {
  factory _$ChildHabitDtoCopyWith(_ChildHabitDto value, $Res Function(_ChildHabitDto) _then) = __$ChildHabitDtoCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, int streakDays, int daysReadThisWeek, int? weeklyGoalDays, bool goalMetThisWeek, List<HabitReminderDto> reminders, List<HabitQuietPeriodDto> quietPeriods
});




}
/// @nodoc
class __$ChildHabitDtoCopyWithImpl<$Res>
    implements _$ChildHabitDtoCopyWith<$Res> {
  __$ChildHabitDtoCopyWithImpl(this._self, this._then);

  final _ChildHabitDto _self;
  final $Res Function(_ChildHabitDto) _then;

/// Create a copy of ChildHabitDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? streakDays = null,Object? daysReadThisWeek = null,Object? weeklyGoalDays = freezed,Object? goalMetThisWeek = null,Object? reminders = null,Object? quietPeriods = null,}) {
  return _then(_ChildHabitDto(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,daysReadThisWeek: null == daysReadThisWeek ? _self.daysReadThisWeek : daysReadThisWeek // ignore: cast_nullable_to_non_nullable
as int,weeklyGoalDays: freezed == weeklyGoalDays ? _self.weeklyGoalDays : weeklyGoalDays // ignore: cast_nullable_to_non_nullable
as int?,goalMetThisWeek: null == goalMetThisWeek ? _self.goalMetThisWeek : goalMetThisWeek // ignore: cast_nullable_to_non_nullable
as bool,reminders: null == reminders ? _self._reminders : reminders // ignore: cast_nullable_to_non_nullable
as List<HabitReminderDto>,quietPeriods: null == quietPeriods ? _self._quietPeriods : quietPeriods // ignore: cast_nullable_to_non_nullable
as List<HabitQuietPeriodDto>,
  ));
}


}

// dart format on
