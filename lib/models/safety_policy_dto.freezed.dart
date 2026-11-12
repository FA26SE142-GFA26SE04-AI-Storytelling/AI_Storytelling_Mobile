// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'safety_policy_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SafetyPolicyDto {

 int get childProfileId; bool get parentalGateEnabled; bool get voiceAnswersEnabled;
/// Create a copy of SafetyPolicyDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SafetyPolicyDtoCopyWith<SafetyPolicyDto> get copyWith => _$SafetyPolicyDtoCopyWithImpl<SafetyPolicyDto>(this as SafetyPolicyDto, _$identity);

  /// Serializes this SafetyPolicyDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SafetyPolicyDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SafetyPolicyDto&&(identical(other.childProfileId, _this.childProfileId) || other.childProfileId == _this.childProfileId)&&(identical(other.parentalGateEnabled, _this.parentalGateEnabled) || other.parentalGateEnabled == _this.parentalGateEnabled)&&(identical(other.voiceAnswersEnabled, _this.voiceAnswersEnabled) || other.voiceAnswersEnabled == _this.voiceAnswersEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SafetyPolicyDto;
  return Object.hash(runtimeType,_this.childProfileId,_this.parentalGateEnabled,_this.voiceAnswersEnabled);
}

@override
String toString() {
  final _this = this as SafetyPolicyDto;
  return 'SafetyPolicyDto(childProfileId: ${_this.childProfileId}, parentalGateEnabled: ${_this.parentalGateEnabled}, voiceAnswersEnabled: ${_this.voiceAnswersEnabled})';
}


}

/// @nodoc
abstract mixin class $SafetyPolicyDtoCopyWith<$Res>  {
  factory $SafetyPolicyDtoCopyWith(SafetyPolicyDto value, $Res Function(SafetyPolicyDto) _then) = _$SafetyPolicyDtoCopyWithImpl;
@useResult
$Res call({
 int childProfileId, bool parentalGateEnabled, bool voiceAnswersEnabled
});




}
/// @nodoc
class _$SafetyPolicyDtoCopyWithImpl<$Res>
    implements $SafetyPolicyDtoCopyWith<$Res> {
  _$SafetyPolicyDtoCopyWithImpl(this._self, this._then);

  final SafetyPolicyDto _self;
  final $Res Function(SafetyPolicyDto) _then;

/// Create a copy of SafetyPolicyDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? childProfileId = null,Object? parentalGateEnabled = null,Object? voiceAnswersEnabled = null,}) {
  return _then(SafetyPolicyDto(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,parentalGateEnabled: null == parentalGateEnabled ? _self.parentalGateEnabled : parentalGateEnabled // ignore: cast_nullable_to_non_nullable
as bool,voiceAnswersEnabled: null == voiceAnswersEnabled ? _self.voiceAnswersEnabled : voiceAnswersEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SafetyPolicyDto].
extension SafetyPolicyDtoPatterns on SafetyPolicyDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SafetyPolicyDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SafetyPolicyDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SafetyPolicyDto value)  $default,){
final _that = this;
switch (_that) {
case _SafetyPolicyDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SafetyPolicyDto value)?  $default,){
final _that = this;
switch (_that) {
case _SafetyPolicyDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int childProfileId,  bool parentalGateEnabled,  bool voiceAnswersEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SafetyPolicyDto() when $default != null:
return $default(_that.childProfileId,_that.parentalGateEnabled,_that.voiceAnswersEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int childProfileId,  bool parentalGateEnabled,  bool voiceAnswersEnabled)  $default,) {final _that = this;
switch (_that) {
case _SafetyPolicyDto():
return $default(_that.childProfileId,_that.parentalGateEnabled,_that.voiceAnswersEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int childProfileId,  bool parentalGateEnabled,  bool voiceAnswersEnabled)?  $default,) {final _that = this;
switch (_that) {
case _SafetyPolicyDto() when $default != null:
return $default(_that.childProfileId,_that.parentalGateEnabled,_that.voiceAnswersEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SafetyPolicyDto implements SafetyPolicyDto {
  const _SafetyPolicyDto({required this.childProfileId, this.parentalGateEnabled = true, this.voiceAnswersEnabled = false});
  factory _SafetyPolicyDto.fromJson(Map<String, dynamic> json) => _$SafetyPolicyDtoFromJson(json);

@override final  int childProfileId;
@override@JsonKey() final  bool parentalGateEnabled;
@override@JsonKey() final  bool voiceAnswersEnabled;

/// Create a copy of SafetyPolicyDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SafetyPolicyDtoCopyWith<_SafetyPolicyDto> get copyWith => __$SafetyPolicyDtoCopyWithImpl<_SafetyPolicyDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SafetyPolicyDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SafetyPolicyDto&&(identical(other.childProfileId, childProfileId) || other.childProfileId == childProfileId)&&(identical(other.parentalGateEnabled, parentalGateEnabled) || other.parentalGateEnabled == parentalGateEnabled)&&(identical(other.voiceAnswersEnabled, voiceAnswersEnabled) || other.voiceAnswersEnabled == voiceAnswersEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,childProfileId,parentalGateEnabled,voiceAnswersEnabled);
}

@override
String toString() {
    return 'SafetyPolicyDto(childProfileId: $childProfileId, parentalGateEnabled: $parentalGateEnabled, voiceAnswersEnabled: $voiceAnswersEnabled)';
}


}

/// @nodoc
abstract mixin class _$SafetyPolicyDtoCopyWith<$Res> implements $SafetyPolicyDtoCopyWith<$Res> {
  factory _$SafetyPolicyDtoCopyWith(_SafetyPolicyDto value, $Res Function(_SafetyPolicyDto) _then) = __$SafetyPolicyDtoCopyWithImpl;
@override @useResult
$Res call({
 int childProfileId, bool parentalGateEnabled, bool voiceAnswersEnabled
});




}
/// @nodoc
class __$SafetyPolicyDtoCopyWithImpl<$Res>
    implements _$SafetyPolicyDtoCopyWith<$Res> {
  __$SafetyPolicyDtoCopyWithImpl(this._self, this._then);

  final _SafetyPolicyDto _self;
  final $Res Function(_SafetyPolicyDto) _then;

/// Create a copy of SafetyPolicyDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? childProfileId = null,Object? parentalGateEnabled = null,Object? voiceAnswersEnabled = null,}) {
  return _then(_SafetyPolicyDto(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,parentalGateEnabled: null == parentalGateEnabled ? _self.parentalGateEnabled : parentalGateEnabled // ignore: cast_nullable_to_non_nullable
as bool,voiceAnswersEnabled: null == voiceAnswersEnabled ? _self.voiceAnswersEnabled : voiceAnswersEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
