// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_log_entry_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuditLogEntryDto {

 int get id; int? get actorUserId; String get action; String get entityType; int get entityId; DateTime get occurredAt;
/// Create a copy of AuditLogEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditLogEntryDtoCopyWith<AuditLogEntryDto> get copyWith => _$AuditLogEntryDtoCopyWithImpl<AuditLogEntryDto>(this as AuditLogEntryDto, _$identity);

  /// Serializes this AuditLogEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AuditLogEntryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditLogEntryDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.actorUserId, _this.actorUserId) || other.actorUserId == _this.actorUserId)&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.entityType, _this.entityType) || other.entityType == _this.entityType)&&(identical(other.entityId, _this.entityId) || other.entityId == _this.entityId)&&(identical(other.occurredAt, _this.occurredAt) || other.occurredAt == _this.occurredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AuditLogEntryDto;
  return Object.hash(runtimeType,_this.id,_this.actorUserId,_this.action,_this.entityType,_this.entityId,_this.occurredAt);
}

@override
String toString() {
  final _this = this as AuditLogEntryDto;
  return 'AuditLogEntryDto(id: ${_this.id}, actorUserId: ${_this.actorUserId}, action: ${_this.action}, entityType: ${_this.entityType}, entityId: ${_this.entityId}, occurredAt: ${_this.occurredAt})';
}


}

/// @nodoc
abstract mixin class $AuditLogEntryDtoCopyWith<$Res>  {
  factory $AuditLogEntryDtoCopyWith(AuditLogEntryDto value, $Res Function(AuditLogEntryDto) _then) = _$AuditLogEntryDtoCopyWithImpl;
@useResult
$Res call({
 int id, int? actorUserId, String action, String entityType, int entityId, DateTime occurredAt
});




}
/// @nodoc
class _$AuditLogEntryDtoCopyWithImpl<$Res>
    implements $AuditLogEntryDtoCopyWith<$Res> {
  _$AuditLogEntryDtoCopyWithImpl(this._self, this._then);

  final AuditLogEntryDto _self;
  final $Res Function(AuditLogEntryDto) _then;

/// Create a copy of AuditLogEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? actorUserId = freezed,Object? action = null,Object? entityType = null,Object? entityId = null,Object? occurredAt = null,}) {
  return _then(AuditLogEntryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,actorUserId: freezed == actorUserId ? _self.actorUserId : actorUserId // ignore: cast_nullable_to_non_nullable
as int?,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as int,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AuditLogEntryDto].
extension AuditLogEntryDtoPatterns on AuditLogEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditLogEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditLogEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditLogEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _AuditLogEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditLogEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _AuditLogEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? actorUserId,  String action,  String entityType,  int entityId,  DateTime occurredAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditLogEntryDto() when $default != null:
return $default(_that.id,_that.actorUserId,_that.action,_that.entityType,_that.entityId,_that.occurredAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? actorUserId,  String action,  String entityType,  int entityId,  DateTime occurredAt)  $default,) {final _that = this;
switch (_that) {
case _AuditLogEntryDto():
return $default(_that.id,_that.actorUserId,_that.action,_that.entityType,_that.entityId,_that.occurredAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? actorUserId,  String action,  String entityType,  int entityId,  DateTime occurredAt)?  $default,) {final _that = this;
switch (_that) {
case _AuditLogEntryDto() when $default != null:
return $default(_that.id,_that.actorUserId,_that.action,_that.entityType,_that.entityId,_that.occurredAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuditLogEntryDto implements AuditLogEntryDto {
  const _AuditLogEntryDto({required this.id, this.actorUserId, required this.action, required this.entityType, required this.entityId, required this.occurredAt});
  factory _AuditLogEntryDto.fromJson(Map<String, dynamic> json) => _$AuditLogEntryDtoFromJson(json);

@override final  int id;
@override final  int? actorUserId;
@override final  String action;
@override final  String entityType;
@override final  int entityId;
@override final  DateTime occurredAt;

/// Create a copy of AuditLogEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditLogEntryDtoCopyWith<_AuditLogEntryDto> get copyWith => __$AuditLogEntryDtoCopyWithImpl<_AuditLogEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuditLogEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditLogEntryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.actorUserId, actorUserId) || other.actorUserId == actorUserId)&&(identical(other.action, action) || other.action == action)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,actorUserId,action,entityType,entityId,occurredAt);
}

@override
String toString() {
    return 'AuditLogEntryDto(id: $id, actorUserId: $actorUserId, action: $action, entityType: $entityType, entityId: $entityId, occurredAt: $occurredAt)';
}


}

/// @nodoc
abstract mixin class _$AuditLogEntryDtoCopyWith<$Res> implements $AuditLogEntryDtoCopyWith<$Res> {
  factory _$AuditLogEntryDtoCopyWith(_AuditLogEntryDto value, $Res Function(_AuditLogEntryDto) _then) = __$AuditLogEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int? actorUserId, String action, String entityType, int entityId, DateTime occurredAt
});




}
/// @nodoc
class __$AuditLogEntryDtoCopyWithImpl<$Res>
    implements _$AuditLogEntryDtoCopyWith<$Res> {
  __$AuditLogEntryDtoCopyWithImpl(this._self, this._then);

  final _AuditLogEntryDto _self;
  final $Res Function(_AuditLogEntryDto) _then;

/// Create a copy of AuditLogEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? actorUserId = freezed,Object? action = null,Object? entityType = null,Object? entityId = null,Object? occurredAt = null,}) {
  return _then(_AuditLogEntryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,actorUserId: freezed == actorUserId ? _self.actorUserId : actorUserId // ignore: cast_nullable_to_non_nullable
as int?,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as int,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
