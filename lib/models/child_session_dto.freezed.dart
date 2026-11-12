// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_session_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChildSessionDto {

 int get childProfileId; String get avatarId; String get accessToken; int get expiresInSeconds;
/// Create a copy of ChildSessionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildSessionDtoCopyWith<ChildSessionDto> get copyWith => _$ChildSessionDtoCopyWithImpl<ChildSessionDto>(this as ChildSessionDto, _$identity);

  /// Serializes this ChildSessionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChildSessionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildSessionDto&&(identical(other.childProfileId, _this.childProfileId) || other.childProfileId == _this.childProfileId)&&(identical(other.avatarId, _this.avatarId) || other.avatarId == _this.avatarId)&&(identical(other.accessToken, _this.accessToken) || other.accessToken == _this.accessToken)&&(identical(other.expiresInSeconds, _this.expiresInSeconds) || other.expiresInSeconds == _this.expiresInSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChildSessionDto;
  return Object.hash(runtimeType,_this.childProfileId,_this.avatarId,_this.accessToken,_this.expiresInSeconds);
}

@override
String toString() {
  final _this = this as ChildSessionDto;
  return 'ChildSessionDto(childProfileId: ${_this.childProfileId}, avatarId: ${_this.avatarId}, accessToken: ${_this.accessToken}, expiresInSeconds: ${_this.expiresInSeconds})';
}


}

/// @nodoc
abstract mixin class $ChildSessionDtoCopyWith<$Res>  {
  factory $ChildSessionDtoCopyWith(ChildSessionDto value, $Res Function(ChildSessionDto) _then) = _$ChildSessionDtoCopyWithImpl;
@useResult
$Res call({
 int childProfileId, String avatarId, String accessToken, int expiresInSeconds
});




}
/// @nodoc
class _$ChildSessionDtoCopyWithImpl<$Res>
    implements $ChildSessionDtoCopyWith<$Res> {
  _$ChildSessionDtoCopyWithImpl(this._self, this._then);

  final ChildSessionDto _self;
  final $Res Function(ChildSessionDto) _then;

/// Create a copy of ChildSessionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? childProfileId = null,Object? avatarId = null,Object? accessToken = null,Object? expiresInSeconds = null,}) {
  return _then(ChildSessionDto(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,avatarId: null == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,expiresInSeconds: null == expiresInSeconds ? _self.expiresInSeconds : expiresInSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildSessionDto].
extension ChildSessionDtoPatterns on ChildSessionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildSessionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildSessionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildSessionDto value)  $default,){
final _that = this;
switch (_that) {
case _ChildSessionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildSessionDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChildSessionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int childProfileId,  String avatarId,  String accessToken,  int expiresInSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildSessionDto() when $default != null:
return $default(_that.childProfileId,_that.avatarId,_that.accessToken,_that.expiresInSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int childProfileId,  String avatarId,  String accessToken,  int expiresInSeconds)  $default,) {final _that = this;
switch (_that) {
case _ChildSessionDto():
return $default(_that.childProfileId,_that.avatarId,_that.accessToken,_that.expiresInSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int childProfileId,  String avatarId,  String accessToken,  int expiresInSeconds)?  $default,) {final _that = this;
switch (_that) {
case _ChildSessionDto() when $default != null:
return $default(_that.childProfileId,_that.avatarId,_that.accessToken,_that.expiresInSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildSessionDto implements ChildSessionDto {
  const _ChildSessionDto({required this.childProfileId, required this.avatarId, required this.accessToken, required this.expiresInSeconds});
  factory _ChildSessionDto.fromJson(Map<String, dynamic> json) => _$ChildSessionDtoFromJson(json);

@override final  int childProfileId;
@override final  String avatarId;
@override final  String accessToken;
@override final  int expiresInSeconds;

/// Create a copy of ChildSessionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildSessionDtoCopyWith<_ChildSessionDto> get copyWith => __$ChildSessionDtoCopyWithImpl<_ChildSessionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildSessionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildSessionDto&&(identical(other.childProfileId, childProfileId) || other.childProfileId == childProfileId)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.expiresInSeconds, expiresInSeconds) || other.expiresInSeconds == expiresInSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,childProfileId,avatarId,accessToken,expiresInSeconds);
}

@override
String toString() {
    return 'ChildSessionDto(childProfileId: $childProfileId, avatarId: $avatarId, accessToken: $accessToken, expiresInSeconds: $expiresInSeconds)';
}


}

/// @nodoc
abstract mixin class _$ChildSessionDtoCopyWith<$Res> implements $ChildSessionDtoCopyWith<$Res> {
  factory _$ChildSessionDtoCopyWith(_ChildSessionDto value, $Res Function(_ChildSessionDto) _then) = __$ChildSessionDtoCopyWithImpl;
@override @useResult
$Res call({
 int childProfileId, String avatarId, String accessToken, int expiresInSeconds
});




}
/// @nodoc
class __$ChildSessionDtoCopyWithImpl<$Res>
    implements _$ChildSessionDtoCopyWith<$Res> {
  __$ChildSessionDtoCopyWithImpl(this._self, this._then);

  final _ChildSessionDto _self;
  final $Res Function(_ChildSessionDto) _then;

/// Create a copy of ChildSessionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? childProfileId = null,Object? avatarId = null,Object? accessToken = null,Object? expiresInSeconds = null,}) {
  return _then(_ChildSessionDto(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,avatarId: null == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,expiresInSeconds: null == expiresInSeconds ? _self.expiresInSeconds : expiresInSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ChildSessionProfileDto {

 int get childProfileId; String get nickname; String get ageBand;
/// Create a copy of ChildSessionProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildSessionProfileDtoCopyWith<ChildSessionProfileDto> get copyWith => _$ChildSessionProfileDtoCopyWithImpl<ChildSessionProfileDto>(this as ChildSessionProfileDto, _$identity);

  /// Serializes this ChildSessionProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChildSessionProfileDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildSessionProfileDto&&(identical(other.childProfileId, _this.childProfileId) || other.childProfileId == _this.childProfileId)&&(identical(other.nickname, _this.nickname) || other.nickname == _this.nickname)&&(identical(other.ageBand, _this.ageBand) || other.ageBand == _this.ageBand));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChildSessionProfileDto;
  return Object.hash(runtimeType,_this.childProfileId,_this.nickname,_this.ageBand);
}

@override
String toString() {
  final _this = this as ChildSessionProfileDto;
  return 'ChildSessionProfileDto(childProfileId: ${_this.childProfileId}, nickname: ${_this.nickname}, ageBand: ${_this.ageBand})';
}


}

/// @nodoc
abstract mixin class $ChildSessionProfileDtoCopyWith<$Res>  {
  factory $ChildSessionProfileDtoCopyWith(ChildSessionProfileDto value, $Res Function(ChildSessionProfileDto) _then) = _$ChildSessionProfileDtoCopyWithImpl;
@useResult
$Res call({
 int childProfileId, String nickname, String ageBand
});




}
/// @nodoc
class _$ChildSessionProfileDtoCopyWithImpl<$Res>
    implements $ChildSessionProfileDtoCopyWith<$Res> {
  _$ChildSessionProfileDtoCopyWithImpl(this._self, this._then);

  final ChildSessionProfileDto _self;
  final $Res Function(ChildSessionProfileDto) _then;

/// Create a copy of ChildSessionProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? childProfileId = null,Object? nickname = null,Object? ageBand = null,}) {
  return _then(ChildSessionProfileDto(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,ageBand: null == ageBand ? _self.ageBand : ageBand // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildSessionProfileDto].
extension ChildSessionProfileDtoPatterns on ChildSessionProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildSessionProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildSessionProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildSessionProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _ChildSessionProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildSessionProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChildSessionProfileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int childProfileId,  String nickname,  String ageBand)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildSessionProfileDto() when $default != null:
return $default(_that.childProfileId,_that.nickname,_that.ageBand);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int childProfileId,  String nickname,  String ageBand)  $default,) {final _that = this;
switch (_that) {
case _ChildSessionProfileDto():
return $default(_that.childProfileId,_that.nickname,_that.ageBand);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int childProfileId,  String nickname,  String ageBand)?  $default,) {final _that = this;
switch (_that) {
case _ChildSessionProfileDto() when $default != null:
return $default(_that.childProfileId,_that.nickname,_that.ageBand);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildSessionProfileDto implements ChildSessionProfileDto {
  const _ChildSessionProfileDto({required this.childProfileId, required this.nickname, required this.ageBand});
  factory _ChildSessionProfileDto.fromJson(Map<String, dynamic> json) => _$ChildSessionProfileDtoFromJson(json);

@override final  int childProfileId;
@override final  String nickname;
@override final  String ageBand;

/// Create a copy of ChildSessionProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildSessionProfileDtoCopyWith<_ChildSessionProfileDto> get copyWith => __$ChildSessionProfileDtoCopyWithImpl<_ChildSessionProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildSessionProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildSessionProfileDto&&(identical(other.childProfileId, childProfileId) || other.childProfileId == childProfileId)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.ageBand, ageBand) || other.ageBand == ageBand));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,childProfileId,nickname,ageBand);
}

@override
String toString() {
    return 'ChildSessionProfileDto(childProfileId: $childProfileId, nickname: $nickname, ageBand: $ageBand)';
}


}

/// @nodoc
abstract mixin class _$ChildSessionProfileDtoCopyWith<$Res> implements $ChildSessionProfileDtoCopyWith<$Res> {
  factory _$ChildSessionProfileDtoCopyWith(_ChildSessionProfileDto value, $Res Function(_ChildSessionProfileDto) _then) = __$ChildSessionProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 int childProfileId, String nickname, String ageBand
});




}
/// @nodoc
class __$ChildSessionProfileDtoCopyWithImpl<$Res>
    implements _$ChildSessionProfileDtoCopyWith<$Res> {
  __$ChildSessionProfileDtoCopyWithImpl(this._self, this._then);

  final _ChildSessionProfileDto _self;
  final $Res Function(_ChildSessionProfileDto) _then;

/// Create a copy of ChildSessionProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? childProfileId = null,Object? nickname = null,Object? ageBand = null,}) {
  return _then(_ChildSessionProfileDto(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,ageBand: null == ageBand ? _self.ageBand : ageBand // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
