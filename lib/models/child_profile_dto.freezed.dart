// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_profile_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChildProfileDto {

 int get id; String get nickname; String get avatarId; String get ageBand; String get status; String? get language; String? get createdAt;
/// Create a copy of ChildProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildProfileDtoCopyWith<ChildProfileDto> get copyWith => _$ChildProfileDtoCopyWithImpl<ChildProfileDto>(this as ChildProfileDto, _$identity);

  /// Serializes this ChildProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChildProfileDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildProfileDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nickname, _this.nickname) || other.nickname == _this.nickname)&&(identical(other.avatarId, _this.avatarId) || other.avatarId == _this.avatarId)&&(identical(other.ageBand, _this.ageBand) || other.ageBand == _this.ageBand)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.language, _this.language) || other.language == _this.language)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChildProfileDto;
  return Object.hash(runtimeType,_this.id,_this.nickname,_this.avatarId,_this.ageBand,_this.status,_this.language,_this.createdAt);
}

@override
String toString() {
  final _this = this as ChildProfileDto;
  return 'ChildProfileDto(id: ${_this.id}, nickname: ${_this.nickname}, avatarId: ${_this.avatarId}, ageBand: ${_this.ageBand}, status: ${_this.status}, language: ${_this.language}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ChildProfileDtoCopyWith<$Res>  {
  factory $ChildProfileDtoCopyWith(ChildProfileDto value, $Res Function(ChildProfileDto) _then) = _$ChildProfileDtoCopyWithImpl;
@useResult
$Res call({
 int id, String nickname, String avatarId, String ageBand, String status, String? language, String? createdAt
});




}
/// @nodoc
class _$ChildProfileDtoCopyWithImpl<$Res>
    implements $ChildProfileDtoCopyWith<$Res> {
  _$ChildProfileDtoCopyWithImpl(this._self, this._then);

  final ChildProfileDto _self;
  final $Res Function(ChildProfileDto) _then;

/// Create a copy of ChildProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nickname = null,Object? avatarId = null,Object? ageBand = null,Object? status = null,Object? language = freezed,Object? createdAt = freezed,}) {
  return _then(ChildProfileDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,avatarId: null == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String,ageBand: null == ageBand ? _self.ageBand : ageBand // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildProfileDto].
extension ChildProfileDtoPatterns on ChildProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _ChildProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChildProfileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nickname,  String avatarId,  String ageBand,  String status,  String? language,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildProfileDto() when $default != null:
return $default(_that.id,_that.nickname,_that.avatarId,_that.ageBand,_that.status,_that.language,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nickname,  String avatarId,  String ageBand,  String status,  String? language,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ChildProfileDto():
return $default(_that.id,_that.nickname,_that.avatarId,_that.ageBand,_that.status,_that.language,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nickname,  String avatarId,  String ageBand,  String status,  String? language,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ChildProfileDto() when $default != null:
return $default(_that.id,_that.nickname,_that.avatarId,_that.ageBand,_that.status,_that.language,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildProfileDto implements ChildProfileDto {
  const _ChildProfileDto({required this.id, required this.nickname, required this.avatarId, required this.ageBand, required this.status, this.language, this.createdAt});
  factory _ChildProfileDto.fromJson(Map<String, dynamic> json) => _$ChildProfileDtoFromJson(json);

@override final  int id;
@override final  String nickname;
@override final  String avatarId;
@override final  String ageBand;
@override final  String status;
@override final  String? language;
@override final  String? createdAt;

/// Create a copy of ChildProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildProfileDtoCopyWith<_ChildProfileDto> get copyWith => __$ChildProfileDtoCopyWithImpl<_ChildProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId)&&(identical(other.ageBand, ageBand) || other.ageBand == ageBand)&&(identical(other.status, status) || other.status == status)&&(identical(other.language, language) || other.language == language)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nickname,avatarId,ageBand,status,language,createdAt);
}

@override
String toString() {
    return 'ChildProfileDto(id: $id, nickname: $nickname, avatarId: $avatarId, ageBand: $ageBand, status: $status, language: $language, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ChildProfileDtoCopyWith<$Res> implements $ChildProfileDtoCopyWith<$Res> {
  factory _$ChildProfileDtoCopyWith(_ChildProfileDto value, $Res Function(_ChildProfileDto) _then) = __$ChildProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String nickname, String avatarId, String ageBand, String status, String? language, String? createdAt
});




}
/// @nodoc
class __$ChildProfileDtoCopyWithImpl<$Res>
    implements _$ChildProfileDtoCopyWith<$Res> {
  __$ChildProfileDtoCopyWithImpl(this._self, this._then);

  final _ChildProfileDto _self;
  final $Res Function(_ChildProfileDto) _then;

/// Create a copy of ChildProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nickname = null,Object? avatarId = null,Object? ageBand = null,Object? status = null,Object? language = freezed,Object? createdAt = freezed,}) {
  return _then(_ChildProfileDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,avatarId: null == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String,ageBand: null == ageBand ? _self.ageBand : ageBand // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
