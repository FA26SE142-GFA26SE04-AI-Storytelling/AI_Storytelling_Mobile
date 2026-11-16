// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationDto {

 int get id; int? get childProfileId; String get type; String get group; String? get payload; String get status; DateTime? get readAt; DateTime get createdAt;
/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationDtoCopyWith<NotificationDto> get copyWith => _$NotificationDtoCopyWithImpl<NotificationDto>(this as NotificationDto, _$identity);

  /// Serializes this NotificationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NotificationDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.childProfileId, _this.childProfileId) || other.childProfileId == _this.childProfileId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.group, _this.group) || other.group == _this.group)&&(identical(other.payload, _this.payload) || other.payload == _this.payload)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.readAt, _this.readAt) || other.readAt == _this.readAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NotificationDto;
  return Object.hash(runtimeType,_this.id,_this.childProfileId,_this.type,_this.group,_this.payload,_this.status,_this.readAt,_this.createdAt);
}

@override
String toString() {
  final _this = this as NotificationDto;
  return 'NotificationDto(id: ${_this.id}, childProfileId: ${_this.childProfileId}, type: ${_this.type}, group: ${_this.group}, payload: ${_this.payload}, status: ${_this.status}, readAt: ${_this.readAt}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $NotificationDtoCopyWith<$Res>  {
  factory $NotificationDtoCopyWith(NotificationDto value, $Res Function(NotificationDto) _then) = _$NotificationDtoCopyWithImpl;
@useResult
$Res call({
 int id, int? childProfileId, String type, String group, String? payload, String status, DateTime? readAt, DateTime createdAt
});




}
/// @nodoc
class _$NotificationDtoCopyWithImpl<$Res>
    implements $NotificationDtoCopyWith<$Res> {
  _$NotificationDtoCopyWithImpl(this._self, this._then);

  final NotificationDto _self;
  final $Res Function(NotificationDto) _then;

/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? childProfileId = freezed,Object? type = null,Object? group = null,Object? payload = freezed,Object? status = null,Object? readAt = freezed,Object? createdAt = null,}) {
  return _then(NotificationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,childProfileId: freezed == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationDto].
extension NotificationDtoPatterns on NotificationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationDto value)  $default,){
final _that = this;
switch (_that) {
case _NotificationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationDto value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? childProfileId,  String type,  String group,  String? payload,  String status,  DateTime? readAt,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
return $default(_that.id,_that.childProfileId,_that.type,_that.group,_that.payload,_that.status,_that.readAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? childProfileId,  String type,  String group,  String? payload,  String status,  DateTime? readAt,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _NotificationDto():
return $default(_that.id,_that.childProfileId,_that.type,_that.group,_that.payload,_that.status,_that.readAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? childProfileId,  String type,  String group,  String? payload,  String status,  DateTime? readAt,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
return $default(_that.id,_that.childProfileId,_that.type,_that.group,_that.payload,_that.status,_that.readAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationDto extends NotificationDto {
  const _NotificationDto({required this.id, this.childProfileId, this.type = '', this.group = '', this.payload, this.status = '', this.readAt, required this.createdAt}): super._();
  factory _NotificationDto.fromJson(Map<String, dynamic> json) => _$NotificationDtoFromJson(json);

@override final  int id;
@override final  int? childProfileId;
@override@JsonKey() final  String type;
@override@JsonKey() final  String group;
@override final  String? payload;
@override@JsonKey() final  String status;
@override final  DateTime? readAt;
@override final  DateTime createdAt;

/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationDtoCopyWith<_NotificationDto> get copyWith => __$NotificationDtoCopyWithImpl<_NotificationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.childProfileId, childProfileId) || other.childProfileId == childProfileId)&&(identical(other.type, type) || other.type == type)&&(identical(other.group, group) || other.group == group)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.status, status) || other.status == status)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,childProfileId,type,group,payload,status,readAt,createdAt);
}

@override
String toString() {
    return 'NotificationDto(id: $id, childProfileId: $childProfileId, type: $type, group: $group, payload: $payload, status: $status, readAt: $readAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$NotificationDtoCopyWith<$Res> implements $NotificationDtoCopyWith<$Res> {
  factory _$NotificationDtoCopyWith(_NotificationDto value, $Res Function(_NotificationDto) _then) = __$NotificationDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int? childProfileId, String type, String group, String? payload, String status, DateTime? readAt, DateTime createdAt
});




}
/// @nodoc
class __$NotificationDtoCopyWithImpl<$Res>
    implements _$NotificationDtoCopyWith<$Res> {
  __$NotificationDtoCopyWithImpl(this._self, this._then);

  final _NotificationDto _self;
  final $Res Function(_NotificationDto) _then;

/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? childProfileId = freezed,Object? type = null,Object? group = null,Object? payload = freezed,Object? status = null,Object? readAt = freezed,Object? createdAt = null,}) {
  return _then(_NotificationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,childProfileId: freezed == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
