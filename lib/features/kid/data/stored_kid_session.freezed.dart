// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stored_kid_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoredKidSession {

 int get childProfileId; String get accessToken; int get expiresAtMs; KidSessionVia get via; bool get parentalGateEnabled;
/// Create a copy of StoredKidSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoredKidSessionCopyWith<StoredKidSession> get copyWith => _$StoredKidSessionCopyWithImpl<StoredKidSession>(this as StoredKidSession, _$identity);

  /// Serializes this StoredKidSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StoredKidSession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoredKidSession&&(identical(other.childProfileId, _this.childProfileId) || other.childProfileId == _this.childProfileId)&&(identical(other.accessToken, _this.accessToken) || other.accessToken == _this.accessToken)&&(identical(other.expiresAtMs, _this.expiresAtMs) || other.expiresAtMs == _this.expiresAtMs)&&(identical(other.via, _this.via) || other.via == _this.via)&&(identical(other.parentalGateEnabled, _this.parentalGateEnabled) || other.parentalGateEnabled == _this.parentalGateEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StoredKidSession;
  return Object.hash(runtimeType,_this.childProfileId,_this.accessToken,_this.expiresAtMs,_this.via,_this.parentalGateEnabled);
}

@override
String toString() {
  final _this = this as StoredKidSession;
  return 'StoredKidSession(childProfileId: ${_this.childProfileId}, accessToken: ${_this.accessToken}, expiresAtMs: ${_this.expiresAtMs}, via: ${_this.via}, parentalGateEnabled: ${_this.parentalGateEnabled})';
}


}

/// @nodoc
abstract mixin class $StoredKidSessionCopyWith<$Res>  {
  factory $StoredKidSessionCopyWith(StoredKidSession value, $Res Function(StoredKidSession) _then) = _$StoredKidSessionCopyWithImpl;
@useResult
$Res call({
 int childProfileId, String accessToken, int expiresAtMs, KidSessionVia via, bool parentalGateEnabled
});




}
/// @nodoc
class _$StoredKidSessionCopyWithImpl<$Res>
    implements $StoredKidSessionCopyWith<$Res> {
  _$StoredKidSessionCopyWithImpl(this._self, this._then);

  final StoredKidSession _self;
  final $Res Function(StoredKidSession) _then;

/// Create a copy of StoredKidSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? childProfileId = null,Object? accessToken = null,Object? expiresAtMs = null,Object? via = null,Object? parentalGateEnabled = null,}) {
  return _then(StoredKidSession(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,expiresAtMs: null == expiresAtMs ? _self.expiresAtMs : expiresAtMs // ignore: cast_nullable_to_non_nullable
as int,via: null == via ? _self.via : via // ignore: cast_nullable_to_non_nullable
as KidSessionVia,parentalGateEnabled: null == parentalGateEnabled ? _self.parentalGateEnabled : parentalGateEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StoredKidSession].
extension StoredKidSessionPatterns on StoredKidSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoredKidSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoredKidSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoredKidSession value)  $default,){
final _that = this;
switch (_that) {
case _StoredKidSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoredKidSession value)?  $default,){
final _that = this;
switch (_that) {
case _StoredKidSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int childProfileId,  String accessToken,  int expiresAtMs,  KidSessionVia via,  bool parentalGateEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoredKidSession() when $default != null:
return $default(_that.childProfileId,_that.accessToken,_that.expiresAtMs,_that.via,_that.parentalGateEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int childProfileId,  String accessToken,  int expiresAtMs,  KidSessionVia via,  bool parentalGateEnabled)  $default,) {final _that = this;
switch (_that) {
case _StoredKidSession():
return $default(_that.childProfileId,_that.accessToken,_that.expiresAtMs,_that.via,_that.parentalGateEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int childProfileId,  String accessToken,  int expiresAtMs,  KidSessionVia via,  bool parentalGateEnabled)?  $default,) {final _that = this;
switch (_that) {
case _StoredKidSession() when $default != null:
return $default(_that.childProfileId,_that.accessToken,_that.expiresAtMs,_that.via,_that.parentalGateEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoredKidSession extends StoredKidSession {
  const _StoredKidSession({required this.childProfileId, required this.accessToken, required this.expiresAtMs, required this.via, this.parentalGateEnabled = true}): super._();
  factory _StoredKidSession.fromJson(Map<String, dynamic> json) => _$StoredKidSessionFromJson(json);

@override final  int childProfileId;
@override final  String accessToken;
@override final  int expiresAtMs;
@override final  KidSessionVia via;
@override@JsonKey() final  bool parentalGateEnabled;

/// Create a copy of StoredKidSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoredKidSessionCopyWith<_StoredKidSession> get copyWith => __$StoredKidSessionCopyWithImpl<_StoredKidSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoredKidSessionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoredKidSession&&(identical(other.childProfileId, childProfileId) || other.childProfileId == childProfileId)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.expiresAtMs, expiresAtMs) || other.expiresAtMs == expiresAtMs)&&(identical(other.via, via) || other.via == via)&&(identical(other.parentalGateEnabled, parentalGateEnabled) || other.parentalGateEnabled == parentalGateEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,childProfileId,accessToken,expiresAtMs,via,parentalGateEnabled);
}

@override
String toString() {
    return 'StoredKidSession(childProfileId: $childProfileId, accessToken: $accessToken, expiresAtMs: $expiresAtMs, via: $via, parentalGateEnabled: $parentalGateEnabled)';
}


}

/// @nodoc
abstract mixin class _$StoredKidSessionCopyWith<$Res> implements $StoredKidSessionCopyWith<$Res> {
  factory _$StoredKidSessionCopyWith(_StoredKidSession value, $Res Function(_StoredKidSession) _then) = __$StoredKidSessionCopyWithImpl;
@override @useResult
$Res call({
 int childProfileId, String accessToken, int expiresAtMs, KidSessionVia via, bool parentalGateEnabled
});




}
/// @nodoc
class __$StoredKidSessionCopyWithImpl<$Res>
    implements _$StoredKidSessionCopyWith<$Res> {
  __$StoredKidSessionCopyWithImpl(this._self, this._then);

  final _StoredKidSession _self;
  final $Res Function(_StoredKidSession) _then;

/// Create a copy of StoredKidSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? childProfileId = null,Object? accessToken = null,Object? expiresAtMs = null,Object? via = null,Object? parentalGateEnabled = null,}) {
  return _then(_StoredKidSession(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,expiresAtMs: null == expiresAtMs ? _self.expiresAtMs : expiresAtMs // ignore: cast_nullable_to_non_nullable
as int,via: null == via ? _self.via : via // ignore: cast_nullable_to_non_nullable
as KidSessionVia,parentalGateEnabled: null == parentalGateEnabled ? _self.parentalGateEnabled : parentalGateEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
