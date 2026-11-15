// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_access_credential_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChildAccessCredentialDto {

 int get childProfileId; bool get hasEasyLogin; DateTime? get easyLoginCreatedAt; String? get secret;
/// Create a copy of ChildAccessCredentialDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildAccessCredentialDtoCopyWith<ChildAccessCredentialDto> get copyWith => _$ChildAccessCredentialDtoCopyWithImpl<ChildAccessCredentialDto>(this as ChildAccessCredentialDto, _$identity);

  /// Serializes this ChildAccessCredentialDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChildAccessCredentialDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildAccessCredentialDto&&(identical(other.childProfileId, _this.childProfileId) || other.childProfileId == _this.childProfileId)&&(identical(other.hasEasyLogin, _this.hasEasyLogin) || other.hasEasyLogin == _this.hasEasyLogin)&&(identical(other.easyLoginCreatedAt, _this.easyLoginCreatedAt) || other.easyLoginCreatedAt == _this.easyLoginCreatedAt)&&(identical(other.secret, _this.secret) || other.secret == _this.secret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChildAccessCredentialDto;
  return Object.hash(runtimeType,_this.childProfileId,_this.hasEasyLogin,_this.easyLoginCreatedAt,_this.secret);
}

@override
String toString() {
  final _this = this as ChildAccessCredentialDto;
  return 'ChildAccessCredentialDto(childProfileId: ${_this.childProfileId}, hasEasyLogin: ${_this.hasEasyLogin}, easyLoginCreatedAt: ${_this.easyLoginCreatedAt}, secret: ${_this.secret})';
}


}

/// @nodoc
abstract mixin class $ChildAccessCredentialDtoCopyWith<$Res>  {
  factory $ChildAccessCredentialDtoCopyWith(ChildAccessCredentialDto value, $Res Function(ChildAccessCredentialDto) _then) = _$ChildAccessCredentialDtoCopyWithImpl;
@useResult
$Res call({
 int childProfileId, bool hasEasyLogin, DateTime? easyLoginCreatedAt, String? secret
});




}
/// @nodoc
class _$ChildAccessCredentialDtoCopyWithImpl<$Res>
    implements $ChildAccessCredentialDtoCopyWith<$Res> {
  _$ChildAccessCredentialDtoCopyWithImpl(this._self, this._then);

  final ChildAccessCredentialDto _self;
  final $Res Function(ChildAccessCredentialDto) _then;

/// Create a copy of ChildAccessCredentialDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? childProfileId = null,Object? hasEasyLogin = null,Object? easyLoginCreatedAt = freezed,Object? secret = freezed,}) {
  return _then(ChildAccessCredentialDto(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,hasEasyLogin: null == hasEasyLogin ? _self.hasEasyLogin : hasEasyLogin // ignore: cast_nullable_to_non_nullable
as bool,easyLoginCreatedAt: freezed == easyLoginCreatedAt ? _self.easyLoginCreatedAt : easyLoginCreatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,secret: freezed == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildAccessCredentialDto].
extension ChildAccessCredentialDtoPatterns on ChildAccessCredentialDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildAccessCredentialDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildAccessCredentialDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildAccessCredentialDto value)  $default,){
final _that = this;
switch (_that) {
case _ChildAccessCredentialDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildAccessCredentialDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChildAccessCredentialDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int childProfileId,  bool hasEasyLogin,  DateTime? easyLoginCreatedAt,  String? secret)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildAccessCredentialDto() when $default != null:
return $default(_that.childProfileId,_that.hasEasyLogin,_that.easyLoginCreatedAt,_that.secret);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int childProfileId,  bool hasEasyLogin,  DateTime? easyLoginCreatedAt,  String? secret)  $default,) {final _that = this;
switch (_that) {
case _ChildAccessCredentialDto():
return $default(_that.childProfileId,_that.hasEasyLogin,_that.easyLoginCreatedAt,_that.secret);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int childProfileId,  bool hasEasyLogin,  DateTime? easyLoginCreatedAt,  String? secret)?  $default,) {final _that = this;
switch (_that) {
case _ChildAccessCredentialDto() when $default != null:
return $default(_that.childProfileId,_that.hasEasyLogin,_that.easyLoginCreatedAt,_that.secret);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildAccessCredentialDto implements ChildAccessCredentialDto {
  const _ChildAccessCredentialDto({required this.childProfileId, required this.hasEasyLogin, this.easyLoginCreatedAt, this.secret});
  factory _ChildAccessCredentialDto.fromJson(Map<String, dynamic> json) => _$ChildAccessCredentialDtoFromJson(json);

@override final  int childProfileId;
@override final  bool hasEasyLogin;
@override final  DateTime? easyLoginCreatedAt;
@override final  String? secret;

/// Create a copy of ChildAccessCredentialDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildAccessCredentialDtoCopyWith<_ChildAccessCredentialDto> get copyWith => __$ChildAccessCredentialDtoCopyWithImpl<_ChildAccessCredentialDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildAccessCredentialDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildAccessCredentialDto&&(identical(other.childProfileId, childProfileId) || other.childProfileId == childProfileId)&&(identical(other.hasEasyLogin, hasEasyLogin) || other.hasEasyLogin == hasEasyLogin)&&(identical(other.easyLoginCreatedAt, easyLoginCreatedAt) || other.easyLoginCreatedAt == easyLoginCreatedAt)&&(identical(other.secret, secret) || other.secret == secret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,childProfileId,hasEasyLogin,easyLoginCreatedAt,secret);
}

@override
String toString() {
    return 'ChildAccessCredentialDto(childProfileId: $childProfileId, hasEasyLogin: $hasEasyLogin, easyLoginCreatedAt: $easyLoginCreatedAt, secret: $secret)';
}


}

/// @nodoc
abstract mixin class _$ChildAccessCredentialDtoCopyWith<$Res> implements $ChildAccessCredentialDtoCopyWith<$Res> {
  factory _$ChildAccessCredentialDtoCopyWith(_ChildAccessCredentialDto value, $Res Function(_ChildAccessCredentialDto) _then) = __$ChildAccessCredentialDtoCopyWithImpl;
@override @useResult
$Res call({
 int childProfileId, bool hasEasyLogin, DateTime? easyLoginCreatedAt, String? secret
});




}
/// @nodoc
class __$ChildAccessCredentialDtoCopyWithImpl<$Res>
    implements _$ChildAccessCredentialDtoCopyWith<$Res> {
  __$ChildAccessCredentialDtoCopyWithImpl(this._self, this._then);

  final _ChildAccessCredentialDto _self;
  final $Res Function(_ChildAccessCredentialDto) _then;

/// Create a copy of ChildAccessCredentialDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? childProfileId = null,Object? hasEasyLogin = null,Object? easyLoginCreatedAt = freezed,Object? secret = freezed,}) {
  return _then(_ChildAccessCredentialDto(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,hasEasyLogin: null == hasEasyLogin ? _self.hasEasyLogin : hasEasyLogin // ignore: cast_nullable_to_non_nullable
as bool,easyLoginCreatedAt: freezed == easyLoginCreatedAt ? _self.easyLoginCreatedAt : easyLoginCreatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,secret: freezed == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EasyLoginSecretDto {

 String get secret; DateTime get createdAt;
/// Create a copy of EasyLoginSecretDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EasyLoginSecretDtoCopyWith<EasyLoginSecretDto> get copyWith => _$EasyLoginSecretDtoCopyWithImpl<EasyLoginSecretDto>(this as EasyLoginSecretDto, _$identity);

  /// Serializes this EasyLoginSecretDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EasyLoginSecretDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EasyLoginSecretDto&&(identical(other.secret, _this.secret) || other.secret == _this.secret)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EasyLoginSecretDto;
  return Object.hash(runtimeType,_this.secret,_this.createdAt);
}

@override
String toString() {
  final _this = this as EasyLoginSecretDto;
  return 'EasyLoginSecretDto(secret: ${_this.secret}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $EasyLoginSecretDtoCopyWith<$Res>  {
  factory $EasyLoginSecretDtoCopyWith(EasyLoginSecretDto value, $Res Function(EasyLoginSecretDto) _then) = _$EasyLoginSecretDtoCopyWithImpl;
@useResult
$Res call({
 String secret, DateTime createdAt
});




}
/// @nodoc
class _$EasyLoginSecretDtoCopyWithImpl<$Res>
    implements $EasyLoginSecretDtoCopyWith<$Res> {
  _$EasyLoginSecretDtoCopyWithImpl(this._self, this._then);

  final EasyLoginSecretDto _self;
  final $Res Function(EasyLoginSecretDto) _then;

/// Create a copy of EasyLoginSecretDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? secret = null,Object? createdAt = null,}) {
  return _then(EasyLoginSecretDto(
secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [EasyLoginSecretDto].
extension EasyLoginSecretDtoPatterns on EasyLoginSecretDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EasyLoginSecretDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EasyLoginSecretDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EasyLoginSecretDto value)  $default,){
final _that = this;
switch (_that) {
case _EasyLoginSecretDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EasyLoginSecretDto value)?  $default,){
final _that = this;
switch (_that) {
case _EasyLoginSecretDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String secret,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EasyLoginSecretDto() when $default != null:
return $default(_that.secret,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String secret,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _EasyLoginSecretDto():
return $default(_that.secret,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String secret,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _EasyLoginSecretDto() when $default != null:
return $default(_that.secret,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EasyLoginSecretDto implements EasyLoginSecretDto {
  const _EasyLoginSecretDto({required this.secret, required this.createdAt});
  factory _EasyLoginSecretDto.fromJson(Map<String, dynamic> json) => _$EasyLoginSecretDtoFromJson(json);

@override final  String secret;
@override final  DateTime createdAt;

/// Create a copy of EasyLoginSecretDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EasyLoginSecretDtoCopyWith<_EasyLoginSecretDto> get copyWith => __$EasyLoginSecretDtoCopyWithImpl<_EasyLoginSecretDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EasyLoginSecretDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EasyLoginSecretDto&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,secret,createdAt);
}

@override
String toString() {
    return 'EasyLoginSecretDto(secret: $secret, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$EasyLoginSecretDtoCopyWith<$Res> implements $EasyLoginSecretDtoCopyWith<$Res> {
  factory _$EasyLoginSecretDtoCopyWith(_EasyLoginSecretDto value, $Res Function(_EasyLoginSecretDto) _then) = __$EasyLoginSecretDtoCopyWithImpl;
@override @useResult
$Res call({
 String secret, DateTime createdAt
});




}
/// @nodoc
class __$EasyLoginSecretDtoCopyWithImpl<$Res>
    implements _$EasyLoginSecretDtoCopyWith<$Res> {
  __$EasyLoginSecretDtoCopyWithImpl(this._self, this._then);

  final _EasyLoginSecretDto _self;
  final $Res Function(_EasyLoginSecretDto) _then;

/// Create a copy of EasyLoginSecretDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? secret = null,Object? createdAt = null,}) {
  return _then(_EasyLoginSecretDto(
secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
