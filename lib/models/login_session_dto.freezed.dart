// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_session_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginSessionDto {

 int get id; DateTime get issuedAt; DateTime get expiresAt;
/// Create a copy of LoginSessionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginSessionDtoCopyWith<LoginSessionDto> get copyWith => _$LoginSessionDtoCopyWithImpl<LoginSessionDto>(this as LoginSessionDto, _$identity);

  /// Serializes this LoginSessionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LoginSessionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginSessionDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.issuedAt, _this.issuedAt) || other.issuedAt == _this.issuedAt)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LoginSessionDto;
  return Object.hash(runtimeType,_this.id,_this.issuedAt,_this.expiresAt);
}

@override
String toString() {
  final _this = this as LoginSessionDto;
  return 'LoginSessionDto(id: ${_this.id}, issuedAt: ${_this.issuedAt}, expiresAt: ${_this.expiresAt})';
}


}

/// @nodoc
abstract mixin class $LoginSessionDtoCopyWith<$Res>  {
  factory $LoginSessionDtoCopyWith(LoginSessionDto value, $Res Function(LoginSessionDto) _then) = _$LoginSessionDtoCopyWithImpl;
@useResult
$Res call({
 int id, DateTime issuedAt, DateTime expiresAt
});




}
/// @nodoc
class _$LoginSessionDtoCopyWithImpl<$Res>
    implements $LoginSessionDtoCopyWith<$Res> {
  _$LoginSessionDtoCopyWithImpl(this._self, this._then);

  final LoginSessionDto _self;
  final $Res Function(LoginSessionDto) _then;

/// Create a copy of LoginSessionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? issuedAt = null,Object? expiresAt = null,}) {
  return _then(LoginSessionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginSessionDto].
extension LoginSessionDtoPatterns on LoginSessionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginSessionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginSessionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginSessionDto value)  $default,){
final _that = this;
switch (_that) {
case _LoginSessionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginSessionDto value)?  $default,){
final _that = this;
switch (_that) {
case _LoginSessionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime issuedAt,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginSessionDto() when $default != null:
return $default(_that.id,_that.issuedAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime issuedAt,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _LoginSessionDto():
return $default(_that.id,_that.issuedAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime issuedAt,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _LoginSessionDto() when $default != null:
return $default(_that.id,_that.issuedAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginSessionDto implements LoginSessionDto {
  const _LoginSessionDto({required this.id, required this.issuedAt, required this.expiresAt});
  factory _LoginSessionDto.fromJson(Map<String, dynamic> json) => _$LoginSessionDtoFromJson(json);

@override final  int id;
@override final  DateTime issuedAt;
@override final  DateTime expiresAt;

/// Create a copy of LoginSessionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginSessionDtoCopyWith<_LoginSessionDto> get copyWith => __$LoginSessionDtoCopyWithImpl<_LoginSessionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginSessionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginSessionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,issuedAt,expiresAt);
}

@override
String toString() {
    return 'LoginSessionDto(id: $id, issuedAt: $issuedAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$LoginSessionDtoCopyWith<$Res> implements $LoginSessionDtoCopyWith<$Res> {
  factory _$LoginSessionDtoCopyWith(_LoginSessionDto value, $Res Function(_LoginSessionDto) _then) = __$LoginSessionDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime issuedAt, DateTime expiresAt
});




}
/// @nodoc
class __$LoginSessionDtoCopyWithImpl<$Res>
    implements _$LoginSessionDtoCopyWith<$Res> {
  __$LoginSessionDtoCopyWithImpl(this._self, this._then);

  final _LoginSessionDto _self;
  final $Res Function(_LoginSessionDto) _then;

/// Create a copy of LoginSessionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? issuedAt = null,Object? expiresAt = null,}) {
  return _then(_LoginSessionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
