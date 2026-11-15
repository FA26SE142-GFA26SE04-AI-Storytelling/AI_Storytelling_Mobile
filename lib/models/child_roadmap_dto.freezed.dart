// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_roadmap_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChildRoadmapItemDto {

 int get id; int get storyId; String? get title; int get position; String get status; String get source; String? get skipReason; String? get note; int? get expectedDays; DateTime? get expectedCompletionAt; DateTime? get openedAt; DateTime? get completedAt; int? get addedByUserId; bool get isStoryAvailable;
/// Create a copy of ChildRoadmapItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildRoadmapItemDtoCopyWith<ChildRoadmapItemDto> get copyWith => _$ChildRoadmapItemDtoCopyWithImpl<ChildRoadmapItemDto>(this as ChildRoadmapItemDto, _$identity);

  /// Serializes this ChildRoadmapItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChildRoadmapItemDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildRoadmapItemDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.skipReason, _this.skipReason) || other.skipReason == _this.skipReason)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.expectedDays, _this.expectedDays) || other.expectedDays == _this.expectedDays)&&(identical(other.expectedCompletionAt, _this.expectedCompletionAt) || other.expectedCompletionAt == _this.expectedCompletionAt)&&(identical(other.openedAt, _this.openedAt) || other.openedAt == _this.openedAt)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt)&&(identical(other.addedByUserId, _this.addedByUserId) || other.addedByUserId == _this.addedByUserId)&&(identical(other.isStoryAvailable, _this.isStoryAvailable) || other.isStoryAvailable == _this.isStoryAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChildRoadmapItemDto;
  return Object.hash(runtimeType,_this.id,_this.storyId,_this.title,_this.position,_this.status,_this.source,_this.skipReason,_this.note,_this.expectedDays,_this.expectedCompletionAt,_this.openedAt,_this.completedAt,_this.addedByUserId,_this.isStoryAvailable);
}

@override
String toString() {
  final _this = this as ChildRoadmapItemDto;
  return 'ChildRoadmapItemDto(id: ${_this.id}, storyId: ${_this.storyId}, title: ${_this.title}, position: ${_this.position}, status: ${_this.status}, source: ${_this.source}, skipReason: ${_this.skipReason}, note: ${_this.note}, expectedDays: ${_this.expectedDays}, expectedCompletionAt: ${_this.expectedCompletionAt}, openedAt: ${_this.openedAt}, completedAt: ${_this.completedAt}, addedByUserId: ${_this.addedByUserId}, isStoryAvailable: ${_this.isStoryAvailable})';
}


}

/// @nodoc
abstract mixin class $ChildRoadmapItemDtoCopyWith<$Res>  {
  factory $ChildRoadmapItemDtoCopyWith(ChildRoadmapItemDto value, $Res Function(ChildRoadmapItemDto) _then) = _$ChildRoadmapItemDtoCopyWithImpl;
@useResult
$Res call({
 int id, int storyId, String? title, int position, String status, String source, String? skipReason, String? note, int? expectedDays, DateTime? expectedCompletionAt, DateTime? openedAt, DateTime? completedAt, int? addedByUserId, bool isStoryAvailable
});




}
/// @nodoc
class _$ChildRoadmapItemDtoCopyWithImpl<$Res>
    implements $ChildRoadmapItemDtoCopyWith<$Res> {
  _$ChildRoadmapItemDtoCopyWithImpl(this._self, this._then);

  final ChildRoadmapItemDto _self;
  final $Res Function(ChildRoadmapItemDto) _then;

/// Create a copy of ChildRoadmapItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? storyId = null,Object? title = freezed,Object? position = null,Object? status = null,Object? source = null,Object? skipReason = freezed,Object? note = freezed,Object? expectedDays = freezed,Object? expectedCompletionAt = freezed,Object? openedAt = freezed,Object? completedAt = freezed,Object? addedByUserId = freezed,Object? isStoryAvailable = null,}) {
  return _then(ChildRoadmapItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,skipReason: freezed == skipReason ? _self.skipReason : skipReason // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,expectedDays: freezed == expectedDays ? _self.expectedDays : expectedDays // ignore: cast_nullable_to_non_nullable
as int?,expectedCompletionAt: freezed == expectedCompletionAt ? _self.expectedCompletionAt : expectedCompletionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,addedByUserId: freezed == addedByUserId ? _self.addedByUserId : addedByUserId // ignore: cast_nullable_to_non_nullable
as int?,isStoryAvailable: null == isStoryAvailable ? _self.isStoryAvailable : isStoryAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildRoadmapItemDto].
extension ChildRoadmapItemDtoPatterns on ChildRoadmapItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildRoadmapItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildRoadmapItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildRoadmapItemDto value)  $default,){
final _that = this;
switch (_that) {
case _ChildRoadmapItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildRoadmapItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChildRoadmapItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int storyId,  String? title,  int position,  String status,  String source,  String? skipReason,  String? note,  int? expectedDays,  DateTime? expectedCompletionAt,  DateTime? openedAt,  DateTime? completedAt,  int? addedByUserId,  bool isStoryAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildRoadmapItemDto() when $default != null:
return $default(_that.id,_that.storyId,_that.title,_that.position,_that.status,_that.source,_that.skipReason,_that.note,_that.expectedDays,_that.expectedCompletionAt,_that.openedAt,_that.completedAt,_that.addedByUserId,_that.isStoryAvailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int storyId,  String? title,  int position,  String status,  String source,  String? skipReason,  String? note,  int? expectedDays,  DateTime? expectedCompletionAt,  DateTime? openedAt,  DateTime? completedAt,  int? addedByUserId,  bool isStoryAvailable)  $default,) {final _that = this;
switch (_that) {
case _ChildRoadmapItemDto():
return $default(_that.id,_that.storyId,_that.title,_that.position,_that.status,_that.source,_that.skipReason,_that.note,_that.expectedDays,_that.expectedCompletionAt,_that.openedAt,_that.completedAt,_that.addedByUserId,_that.isStoryAvailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int storyId,  String? title,  int position,  String status,  String source,  String? skipReason,  String? note,  int? expectedDays,  DateTime? expectedCompletionAt,  DateTime? openedAt,  DateTime? completedAt,  int? addedByUserId,  bool isStoryAvailable)?  $default,) {final _that = this;
switch (_that) {
case _ChildRoadmapItemDto() when $default != null:
return $default(_that.id,_that.storyId,_that.title,_that.position,_that.status,_that.source,_that.skipReason,_that.note,_that.expectedDays,_that.expectedCompletionAt,_that.openedAt,_that.completedAt,_that.addedByUserId,_that.isStoryAvailable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildRoadmapItemDto implements ChildRoadmapItemDto {
  const _ChildRoadmapItemDto({required this.id, required this.storyId, this.title, this.position = 0, required this.status, this.source = '', this.skipReason, this.note, this.expectedDays, this.expectedCompletionAt, this.openedAt, this.completedAt, this.addedByUserId, this.isStoryAvailable = true});
  factory _ChildRoadmapItemDto.fromJson(Map<String, dynamic> json) => _$ChildRoadmapItemDtoFromJson(json);

@override final  int id;
@override final  int storyId;
@override final  String? title;
@override@JsonKey() final  int position;
@override final  String status;
@override@JsonKey() final  String source;
@override final  String? skipReason;
@override final  String? note;
@override final  int? expectedDays;
@override final  DateTime? expectedCompletionAt;
@override final  DateTime? openedAt;
@override final  DateTime? completedAt;
@override final  int? addedByUserId;
@override@JsonKey() final  bool isStoryAvailable;

/// Create a copy of ChildRoadmapItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildRoadmapItemDtoCopyWith<_ChildRoadmapItemDto> get copyWith => __$ChildRoadmapItemDtoCopyWithImpl<_ChildRoadmapItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildRoadmapItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildRoadmapItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.position, position) || other.position == position)&&(identical(other.status, status) || other.status == status)&&(identical(other.source, source) || other.source == source)&&(identical(other.skipReason, skipReason) || other.skipReason == skipReason)&&(identical(other.note, note) || other.note == note)&&(identical(other.expectedDays, expectedDays) || other.expectedDays == expectedDays)&&(identical(other.expectedCompletionAt, expectedCompletionAt) || other.expectedCompletionAt == expectedCompletionAt)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.addedByUserId, addedByUserId) || other.addedByUserId == addedByUserId)&&(identical(other.isStoryAvailable, isStoryAvailable) || other.isStoryAvailable == isStoryAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,storyId,title,position,status,source,skipReason,note,expectedDays,expectedCompletionAt,openedAt,completedAt,addedByUserId,isStoryAvailable);
}

@override
String toString() {
    return 'ChildRoadmapItemDto(id: $id, storyId: $storyId, title: $title, position: $position, status: $status, source: $source, skipReason: $skipReason, note: $note, expectedDays: $expectedDays, expectedCompletionAt: $expectedCompletionAt, openedAt: $openedAt, completedAt: $completedAt, addedByUserId: $addedByUserId, isStoryAvailable: $isStoryAvailable)';
}


}

/// @nodoc
abstract mixin class _$ChildRoadmapItemDtoCopyWith<$Res> implements $ChildRoadmapItemDtoCopyWith<$Res> {
  factory _$ChildRoadmapItemDtoCopyWith(_ChildRoadmapItemDto value, $Res Function(_ChildRoadmapItemDto) _then) = __$ChildRoadmapItemDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int storyId, String? title, int position, String status, String source, String? skipReason, String? note, int? expectedDays, DateTime? expectedCompletionAt, DateTime? openedAt, DateTime? completedAt, int? addedByUserId, bool isStoryAvailable
});




}
/// @nodoc
class __$ChildRoadmapItemDtoCopyWithImpl<$Res>
    implements _$ChildRoadmapItemDtoCopyWith<$Res> {
  __$ChildRoadmapItemDtoCopyWithImpl(this._self, this._then);

  final _ChildRoadmapItemDto _self;
  final $Res Function(_ChildRoadmapItemDto) _then;

/// Create a copy of ChildRoadmapItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? storyId = null,Object? title = freezed,Object? position = null,Object? status = null,Object? source = null,Object? skipReason = freezed,Object? note = freezed,Object? expectedDays = freezed,Object? expectedCompletionAt = freezed,Object? openedAt = freezed,Object? completedAt = freezed,Object? addedByUserId = freezed,Object? isStoryAvailable = null,}) {
  return _then(_ChildRoadmapItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,skipReason: freezed == skipReason ? _self.skipReason : skipReason // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,expectedDays: freezed == expectedDays ? _self.expectedDays : expectedDays // ignore: cast_nullable_to_non_nullable
as int?,expectedCompletionAt: freezed == expectedCompletionAt ? _self.expectedCompletionAt : expectedCompletionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,addedByUserId: freezed == addedByUserId ? _self.addedByUserId : addedByUserId // ignore: cast_nullable_to_non_nullable
as int?,isStoryAvailable: null == isStoryAvailable ? _self.isStoryAvailable : isStoryAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ChildRoadmapDto {

 int get childProfileId; ChildRoadmapItemDto? get open; List<ChildRoadmapItemDto> get waiting; List<ChildRoadmapItemDto> get history; int get completedCount; int get totalCount;
/// Create a copy of ChildRoadmapDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildRoadmapDtoCopyWith<ChildRoadmapDto> get copyWith => _$ChildRoadmapDtoCopyWithImpl<ChildRoadmapDto>(this as ChildRoadmapDto, _$identity);

  /// Serializes this ChildRoadmapDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChildRoadmapDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildRoadmapDto&&(identical(other.childProfileId, _this.childProfileId) || other.childProfileId == _this.childProfileId)&&(identical(other.open, _this.open) || other.open == _this.open)&&const DeepCollectionEquality().equals(other.waiting, _this.waiting)&&const DeepCollectionEquality().equals(other.history, _this.history)&&(identical(other.completedCount, _this.completedCount) || other.completedCount == _this.completedCount)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChildRoadmapDto;
  return Object.hash(runtimeType,_this.childProfileId,_this.open,const DeepCollectionEquality().hash(_this.waiting),const DeepCollectionEquality().hash(_this.history),_this.completedCount,_this.totalCount);
}

@override
String toString() {
  final _this = this as ChildRoadmapDto;
  return 'ChildRoadmapDto(childProfileId: ${_this.childProfileId}, open: ${_this.open}, waiting: ${_this.waiting}, history: ${_this.history}, completedCount: ${_this.completedCount}, totalCount: ${_this.totalCount})';
}


}

/// @nodoc
abstract mixin class $ChildRoadmapDtoCopyWith<$Res>  {
  factory $ChildRoadmapDtoCopyWith(ChildRoadmapDto value, $Res Function(ChildRoadmapDto) _then) = _$ChildRoadmapDtoCopyWithImpl;
@useResult
$Res call({
 int childProfileId, ChildRoadmapItemDto? open, List<ChildRoadmapItemDto> waiting, List<ChildRoadmapItemDto> history, int completedCount, int totalCount
});


$ChildRoadmapItemDtoCopyWith<$Res>? get open;

}
/// @nodoc
class _$ChildRoadmapDtoCopyWithImpl<$Res>
    implements $ChildRoadmapDtoCopyWith<$Res> {
  _$ChildRoadmapDtoCopyWithImpl(this._self, this._then);

  final ChildRoadmapDto _self;
  final $Res Function(ChildRoadmapDto) _then;

/// Create a copy of ChildRoadmapDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? childProfileId = null,Object? open = freezed,Object? waiting = null,Object? history = null,Object? completedCount = null,Object? totalCount = null,}) {
  return _then(ChildRoadmapDto(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,open: freezed == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as ChildRoadmapItemDto?,waiting: null == waiting ? _self.waiting : waiting // ignore: cast_nullable_to_non_nullable
as List<ChildRoadmapItemDto>,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<ChildRoadmapItemDto>,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ChildRoadmapDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChildRoadmapItemDtoCopyWith<$Res>? get open {
    if (_self.open == null) {
    return null;
  }

  return $ChildRoadmapItemDtoCopyWith<$Res>(_self.open!, (value) {
    return _then(_self.copyWith(open: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChildRoadmapDto].
extension ChildRoadmapDtoPatterns on ChildRoadmapDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildRoadmapDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildRoadmapDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildRoadmapDto value)  $default,){
final _that = this;
switch (_that) {
case _ChildRoadmapDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildRoadmapDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChildRoadmapDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int childProfileId,  ChildRoadmapItemDto? open,  List<ChildRoadmapItemDto> waiting,  List<ChildRoadmapItemDto> history,  int completedCount,  int totalCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildRoadmapDto() when $default != null:
return $default(_that.childProfileId,_that.open,_that.waiting,_that.history,_that.completedCount,_that.totalCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int childProfileId,  ChildRoadmapItemDto? open,  List<ChildRoadmapItemDto> waiting,  List<ChildRoadmapItemDto> history,  int completedCount,  int totalCount)  $default,) {final _that = this;
switch (_that) {
case _ChildRoadmapDto():
return $default(_that.childProfileId,_that.open,_that.waiting,_that.history,_that.completedCount,_that.totalCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int childProfileId,  ChildRoadmapItemDto? open,  List<ChildRoadmapItemDto> waiting,  List<ChildRoadmapItemDto> history,  int completedCount,  int totalCount)?  $default,) {final _that = this;
switch (_that) {
case _ChildRoadmapDto() when $default != null:
return $default(_that.childProfileId,_that.open,_that.waiting,_that.history,_that.completedCount,_that.totalCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildRoadmapDto implements ChildRoadmapDto {
  const _ChildRoadmapDto({required this.childProfileId, this.open,  List<ChildRoadmapItemDto> waiting = const <ChildRoadmapItemDto>[],  List<ChildRoadmapItemDto> history = const <ChildRoadmapItemDto>[], this.completedCount = 0, this.totalCount = 0}): _waiting = waiting,_history = history;
  factory _ChildRoadmapDto.fromJson(Map<String, dynamic> json) => _$ChildRoadmapDtoFromJson(json);

@override final  int childProfileId;
@override final  ChildRoadmapItemDto? open;
 final  List<ChildRoadmapItemDto> _waiting;
@override@JsonKey() List<ChildRoadmapItemDto> get waiting {
  if (_waiting is EqualUnmodifiableListView) return _waiting;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_waiting);
}

 final  List<ChildRoadmapItemDto> _history;
@override@JsonKey() List<ChildRoadmapItemDto> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

@override@JsonKey() final  int completedCount;
@override@JsonKey() final  int totalCount;

/// Create a copy of ChildRoadmapDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildRoadmapDtoCopyWith<_ChildRoadmapDto> get copyWith => __$ChildRoadmapDtoCopyWithImpl<_ChildRoadmapDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildRoadmapDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildRoadmapDto&&(identical(other.childProfileId, childProfileId) || other.childProfileId == childProfileId)&&(identical(other.open, open) || other.open == open)&&const DeepCollectionEquality().equals(other.waiting, _waiting)&&const DeepCollectionEquality().equals(other.history, _history)&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,childProfileId,open,const DeepCollectionEquality().hash(_waiting),const DeepCollectionEquality().hash(_history),completedCount,totalCount);
}

@override
String toString() {
    return 'ChildRoadmapDto(childProfileId: $childProfileId, open: $open, waiting: $waiting, history: $history, completedCount: $completedCount, totalCount: $totalCount)';
}


}

/// @nodoc
abstract mixin class _$ChildRoadmapDtoCopyWith<$Res> implements $ChildRoadmapDtoCopyWith<$Res> {
  factory _$ChildRoadmapDtoCopyWith(_ChildRoadmapDto value, $Res Function(_ChildRoadmapDto) _then) = __$ChildRoadmapDtoCopyWithImpl;
@override @useResult
$Res call({
 int childProfileId, ChildRoadmapItemDto? open, List<ChildRoadmapItemDto> waiting, List<ChildRoadmapItemDto> history, int completedCount, int totalCount
});


@override $ChildRoadmapItemDtoCopyWith<$Res>? get open;

}
/// @nodoc
class __$ChildRoadmapDtoCopyWithImpl<$Res>
    implements _$ChildRoadmapDtoCopyWith<$Res> {
  __$ChildRoadmapDtoCopyWithImpl(this._self, this._then);

  final _ChildRoadmapDto _self;
  final $Res Function(_ChildRoadmapDto) _then;

/// Create a copy of ChildRoadmapDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? childProfileId = null,Object? open = freezed,Object? waiting = null,Object? history = null,Object? completedCount = null,Object? totalCount = null,}) {
  return _then(_ChildRoadmapDto(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,open: freezed == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as ChildRoadmapItemDto?,waiting: null == waiting ? _self._waiting : waiting // ignore: cast_nullable_to_non_nullable
as List<ChildRoadmapItemDto>,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<ChildRoadmapItemDto>,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ChildRoadmapDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChildRoadmapItemDtoCopyWith<$Res>? get open {
    if (_self.open == null) {
    return null;
  }

  return $ChildRoadmapItemDtoCopyWith<$Res>(_self.open!, (value) {
    return _then(_self.copyWith(open: value));
  });
}
}

// dart format on
