// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_roadmap_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MyRoadmapOpenStoryDto {

 int get storyId; String? get title; String? get coverImageUrl; String? get note; String? get expectedBy; bool get isLocked;
/// Create a copy of MyRoadmapOpenStoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyRoadmapOpenStoryDtoCopyWith<MyRoadmapOpenStoryDto> get copyWith => _$MyRoadmapOpenStoryDtoCopyWithImpl<MyRoadmapOpenStoryDto>(this as MyRoadmapOpenStoryDto, _$identity);

  /// Serializes this MyRoadmapOpenStoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MyRoadmapOpenStoryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyRoadmapOpenStoryDto&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.expectedBy, _this.expectedBy) || other.expectedBy == _this.expectedBy)&&(identical(other.isLocked, _this.isLocked) || other.isLocked == _this.isLocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MyRoadmapOpenStoryDto;
  return Object.hash(runtimeType,_this.storyId,_this.title,_this.coverImageUrl,_this.note,_this.expectedBy,_this.isLocked);
}

@override
String toString() {
  final _this = this as MyRoadmapOpenStoryDto;
  return 'MyRoadmapOpenStoryDto(storyId: ${_this.storyId}, title: ${_this.title}, coverImageUrl: ${_this.coverImageUrl}, note: ${_this.note}, expectedBy: ${_this.expectedBy}, isLocked: ${_this.isLocked})';
}


}

/// @nodoc
abstract mixin class $MyRoadmapOpenStoryDtoCopyWith<$Res>  {
  factory $MyRoadmapOpenStoryDtoCopyWith(MyRoadmapOpenStoryDto value, $Res Function(MyRoadmapOpenStoryDto) _then) = _$MyRoadmapOpenStoryDtoCopyWithImpl;
@useResult
$Res call({
 int storyId, String? title, String? coverImageUrl, String? note, String? expectedBy, bool isLocked
});




}
/// @nodoc
class _$MyRoadmapOpenStoryDtoCopyWithImpl<$Res>
    implements $MyRoadmapOpenStoryDtoCopyWith<$Res> {
  _$MyRoadmapOpenStoryDtoCopyWithImpl(this._self, this._then);

  final MyRoadmapOpenStoryDto _self;
  final $Res Function(MyRoadmapOpenStoryDto) _then;

/// Create a copy of MyRoadmapOpenStoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storyId = null,Object? title = freezed,Object? coverImageUrl = freezed,Object? note = freezed,Object? expectedBy = freezed,Object? isLocked = null,}) {
  return _then(MyRoadmapOpenStoryDto(
storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,expectedBy: freezed == expectedBy ? _self.expectedBy : expectedBy // ignore: cast_nullable_to_non_nullable
as String?,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MyRoadmapOpenStoryDto].
extension MyRoadmapOpenStoryDtoPatterns on MyRoadmapOpenStoryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyRoadmapOpenStoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyRoadmapOpenStoryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyRoadmapOpenStoryDto value)  $default,){
final _that = this;
switch (_that) {
case _MyRoadmapOpenStoryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyRoadmapOpenStoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _MyRoadmapOpenStoryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int storyId,  String? title,  String? coverImageUrl,  String? note,  String? expectedBy,  bool isLocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyRoadmapOpenStoryDto() when $default != null:
return $default(_that.storyId,_that.title,_that.coverImageUrl,_that.note,_that.expectedBy,_that.isLocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int storyId,  String? title,  String? coverImageUrl,  String? note,  String? expectedBy,  bool isLocked)  $default,) {final _that = this;
switch (_that) {
case _MyRoadmapOpenStoryDto():
return $default(_that.storyId,_that.title,_that.coverImageUrl,_that.note,_that.expectedBy,_that.isLocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int storyId,  String? title,  String? coverImageUrl,  String? note,  String? expectedBy,  bool isLocked)?  $default,) {final _that = this;
switch (_that) {
case _MyRoadmapOpenStoryDto() when $default != null:
return $default(_that.storyId,_that.title,_that.coverImageUrl,_that.note,_that.expectedBy,_that.isLocked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyRoadmapOpenStoryDto implements MyRoadmapOpenStoryDto {
  const _MyRoadmapOpenStoryDto({required this.storyId, this.title, this.coverImageUrl, this.note, this.expectedBy, this.isLocked = false});
  factory _MyRoadmapOpenStoryDto.fromJson(Map<String, dynamic> json) => _$MyRoadmapOpenStoryDtoFromJson(json);

@override final  int storyId;
@override final  String? title;
@override final  String? coverImageUrl;
@override final  String? note;
@override final  String? expectedBy;
@override@JsonKey() final  bool isLocked;

/// Create a copy of MyRoadmapOpenStoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyRoadmapOpenStoryDtoCopyWith<_MyRoadmapOpenStoryDto> get copyWith => __$MyRoadmapOpenStoryDtoCopyWithImpl<_MyRoadmapOpenStoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyRoadmapOpenStoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyRoadmapOpenStoryDto&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.note, note) || other.note == note)&&(identical(other.expectedBy, expectedBy) || other.expectedBy == expectedBy)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,storyId,title,coverImageUrl,note,expectedBy,isLocked);
}

@override
String toString() {
    return 'MyRoadmapOpenStoryDto(storyId: $storyId, title: $title, coverImageUrl: $coverImageUrl, note: $note, expectedBy: $expectedBy, isLocked: $isLocked)';
}


}

/// @nodoc
abstract mixin class _$MyRoadmapOpenStoryDtoCopyWith<$Res> implements $MyRoadmapOpenStoryDtoCopyWith<$Res> {
  factory _$MyRoadmapOpenStoryDtoCopyWith(_MyRoadmapOpenStoryDto value, $Res Function(_MyRoadmapOpenStoryDto) _then) = __$MyRoadmapOpenStoryDtoCopyWithImpl;
@override @useResult
$Res call({
 int storyId, String? title, String? coverImageUrl, String? note, String? expectedBy, bool isLocked
});




}
/// @nodoc
class __$MyRoadmapOpenStoryDtoCopyWithImpl<$Res>
    implements _$MyRoadmapOpenStoryDtoCopyWith<$Res> {
  __$MyRoadmapOpenStoryDtoCopyWithImpl(this._self, this._then);

  final _MyRoadmapOpenStoryDto _self;
  final $Res Function(_MyRoadmapOpenStoryDto) _then;

/// Create a copy of MyRoadmapOpenStoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storyId = null,Object? title = freezed,Object? coverImageUrl = freezed,Object? note = freezed,Object? expectedBy = freezed,Object? isLocked = null,}) {
  return _then(_MyRoadmapOpenStoryDto(
storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,expectedBy: freezed == expectedBy ? _self.expectedBy : expectedBy // ignore: cast_nullable_to_non_nullable
as String?,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$MyRoadmapUpcomingDto {

 int get order; int get storyId; String? get title; String? get coverImageUrl; bool get isLocked;
/// Create a copy of MyRoadmapUpcomingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyRoadmapUpcomingDtoCopyWith<MyRoadmapUpcomingDto> get copyWith => _$MyRoadmapUpcomingDtoCopyWithImpl<MyRoadmapUpcomingDto>(this as MyRoadmapUpcomingDto, _$identity);

  /// Serializes this MyRoadmapUpcomingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MyRoadmapUpcomingDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyRoadmapUpcomingDto&&(identical(other.order, _this.order) || other.order == _this.order)&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.isLocked, _this.isLocked) || other.isLocked == _this.isLocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MyRoadmapUpcomingDto;
  return Object.hash(runtimeType,_this.order,_this.storyId,_this.title,_this.coverImageUrl,_this.isLocked);
}

@override
String toString() {
  final _this = this as MyRoadmapUpcomingDto;
  return 'MyRoadmapUpcomingDto(order: ${_this.order}, storyId: ${_this.storyId}, title: ${_this.title}, coverImageUrl: ${_this.coverImageUrl}, isLocked: ${_this.isLocked})';
}


}

/// @nodoc
abstract mixin class $MyRoadmapUpcomingDtoCopyWith<$Res>  {
  factory $MyRoadmapUpcomingDtoCopyWith(MyRoadmapUpcomingDto value, $Res Function(MyRoadmapUpcomingDto) _then) = _$MyRoadmapUpcomingDtoCopyWithImpl;
@useResult
$Res call({
 int order, int storyId, String? title, String? coverImageUrl, bool isLocked
});




}
/// @nodoc
class _$MyRoadmapUpcomingDtoCopyWithImpl<$Res>
    implements $MyRoadmapUpcomingDtoCopyWith<$Res> {
  _$MyRoadmapUpcomingDtoCopyWithImpl(this._self, this._then);

  final MyRoadmapUpcomingDto _self;
  final $Res Function(MyRoadmapUpcomingDto) _then;

/// Create a copy of MyRoadmapUpcomingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? order = null,Object? storyId = null,Object? title = freezed,Object? coverImageUrl = freezed,Object? isLocked = null,}) {
  return _then(MyRoadmapUpcomingDto(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MyRoadmapUpcomingDto].
extension MyRoadmapUpcomingDtoPatterns on MyRoadmapUpcomingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyRoadmapUpcomingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyRoadmapUpcomingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyRoadmapUpcomingDto value)  $default,){
final _that = this;
switch (_that) {
case _MyRoadmapUpcomingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyRoadmapUpcomingDto value)?  $default,){
final _that = this;
switch (_that) {
case _MyRoadmapUpcomingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int order,  int storyId,  String? title,  String? coverImageUrl,  bool isLocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyRoadmapUpcomingDto() when $default != null:
return $default(_that.order,_that.storyId,_that.title,_that.coverImageUrl,_that.isLocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int order,  int storyId,  String? title,  String? coverImageUrl,  bool isLocked)  $default,) {final _that = this;
switch (_that) {
case _MyRoadmapUpcomingDto():
return $default(_that.order,_that.storyId,_that.title,_that.coverImageUrl,_that.isLocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int order,  int storyId,  String? title,  String? coverImageUrl,  bool isLocked)?  $default,) {final _that = this;
switch (_that) {
case _MyRoadmapUpcomingDto() when $default != null:
return $default(_that.order,_that.storyId,_that.title,_that.coverImageUrl,_that.isLocked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyRoadmapUpcomingDto implements MyRoadmapUpcomingDto {
  const _MyRoadmapUpcomingDto({required this.order, required this.storyId, this.title, this.coverImageUrl, this.isLocked = false});
  factory _MyRoadmapUpcomingDto.fromJson(Map<String, dynamic> json) => _$MyRoadmapUpcomingDtoFromJson(json);

@override final  int order;
@override final  int storyId;
@override final  String? title;
@override final  String? coverImageUrl;
@override@JsonKey() final  bool isLocked;

/// Create a copy of MyRoadmapUpcomingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyRoadmapUpcomingDtoCopyWith<_MyRoadmapUpcomingDto> get copyWith => __$MyRoadmapUpcomingDtoCopyWithImpl<_MyRoadmapUpcomingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyRoadmapUpcomingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyRoadmapUpcomingDto&&(identical(other.order, order) || other.order == order)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,order,storyId,title,coverImageUrl,isLocked);
}

@override
String toString() {
    return 'MyRoadmapUpcomingDto(order: $order, storyId: $storyId, title: $title, coverImageUrl: $coverImageUrl, isLocked: $isLocked)';
}


}

/// @nodoc
abstract mixin class _$MyRoadmapUpcomingDtoCopyWith<$Res> implements $MyRoadmapUpcomingDtoCopyWith<$Res> {
  factory _$MyRoadmapUpcomingDtoCopyWith(_MyRoadmapUpcomingDto value, $Res Function(_MyRoadmapUpcomingDto) _then) = __$MyRoadmapUpcomingDtoCopyWithImpl;
@override @useResult
$Res call({
 int order, int storyId, String? title, String? coverImageUrl, bool isLocked
});




}
/// @nodoc
class __$MyRoadmapUpcomingDtoCopyWithImpl<$Res>
    implements _$MyRoadmapUpcomingDtoCopyWith<$Res> {
  __$MyRoadmapUpcomingDtoCopyWithImpl(this._self, this._then);

  final _MyRoadmapUpcomingDto _self;
  final $Res Function(_MyRoadmapUpcomingDto) _then;

/// Create a copy of MyRoadmapUpcomingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? order = null,Object? storyId = null,Object? title = freezed,Object? coverImageUrl = freezed,Object? isLocked = null,}) {
  return _then(_MyRoadmapUpcomingDto(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$MyRoadmapDoneDto {

 int get storyId; String? get title; String? get coverImageUrl; String? get completedAt;
/// Create a copy of MyRoadmapDoneDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyRoadmapDoneDtoCopyWith<MyRoadmapDoneDto> get copyWith => _$MyRoadmapDoneDtoCopyWithImpl<MyRoadmapDoneDto>(this as MyRoadmapDoneDto, _$identity);

  /// Serializes this MyRoadmapDoneDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MyRoadmapDoneDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyRoadmapDoneDto&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MyRoadmapDoneDto;
  return Object.hash(runtimeType,_this.storyId,_this.title,_this.coverImageUrl,_this.completedAt);
}

@override
String toString() {
  final _this = this as MyRoadmapDoneDto;
  return 'MyRoadmapDoneDto(storyId: ${_this.storyId}, title: ${_this.title}, coverImageUrl: ${_this.coverImageUrl}, completedAt: ${_this.completedAt})';
}


}

/// @nodoc
abstract mixin class $MyRoadmapDoneDtoCopyWith<$Res>  {
  factory $MyRoadmapDoneDtoCopyWith(MyRoadmapDoneDto value, $Res Function(MyRoadmapDoneDto) _then) = _$MyRoadmapDoneDtoCopyWithImpl;
@useResult
$Res call({
 int storyId, String? title, String? coverImageUrl, String? completedAt
});




}
/// @nodoc
class _$MyRoadmapDoneDtoCopyWithImpl<$Res>
    implements $MyRoadmapDoneDtoCopyWith<$Res> {
  _$MyRoadmapDoneDtoCopyWithImpl(this._self, this._then);

  final MyRoadmapDoneDto _self;
  final $Res Function(MyRoadmapDoneDto) _then;

/// Create a copy of MyRoadmapDoneDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storyId = null,Object? title = freezed,Object? coverImageUrl = freezed,Object? completedAt = freezed,}) {
  return _then(MyRoadmapDoneDto(
storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MyRoadmapDoneDto].
extension MyRoadmapDoneDtoPatterns on MyRoadmapDoneDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyRoadmapDoneDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyRoadmapDoneDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyRoadmapDoneDto value)  $default,){
final _that = this;
switch (_that) {
case _MyRoadmapDoneDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyRoadmapDoneDto value)?  $default,){
final _that = this;
switch (_that) {
case _MyRoadmapDoneDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int storyId,  String? title,  String? coverImageUrl,  String? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyRoadmapDoneDto() when $default != null:
return $default(_that.storyId,_that.title,_that.coverImageUrl,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int storyId,  String? title,  String? coverImageUrl,  String? completedAt)  $default,) {final _that = this;
switch (_that) {
case _MyRoadmapDoneDto():
return $default(_that.storyId,_that.title,_that.coverImageUrl,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int storyId,  String? title,  String? coverImageUrl,  String? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _MyRoadmapDoneDto() when $default != null:
return $default(_that.storyId,_that.title,_that.coverImageUrl,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyRoadmapDoneDto implements MyRoadmapDoneDto {
  const _MyRoadmapDoneDto({required this.storyId, this.title, this.coverImageUrl, this.completedAt});
  factory _MyRoadmapDoneDto.fromJson(Map<String, dynamic> json) => _$MyRoadmapDoneDtoFromJson(json);

@override final  int storyId;
@override final  String? title;
@override final  String? coverImageUrl;
@override final  String? completedAt;

/// Create a copy of MyRoadmapDoneDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyRoadmapDoneDtoCopyWith<_MyRoadmapDoneDto> get copyWith => __$MyRoadmapDoneDtoCopyWithImpl<_MyRoadmapDoneDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyRoadmapDoneDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyRoadmapDoneDto&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,storyId,title,coverImageUrl,completedAt);
}

@override
String toString() {
    return 'MyRoadmapDoneDto(storyId: $storyId, title: $title, coverImageUrl: $coverImageUrl, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$MyRoadmapDoneDtoCopyWith<$Res> implements $MyRoadmapDoneDtoCopyWith<$Res> {
  factory _$MyRoadmapDoneDtoCopyWith(_MyRoadmapDoneDto value, $Res Function(_MyRoadmapDoneDto) _then) = __$MyRoadmapDoneDtoCopyWithImpl;
@override @useResult
$Res call({
 int storyId, String? title, String? coverImageUrl, String? completedAt
});




}
/// @nodoc
class __$MyRoadmapDoneDtoCopyWithImpl<$Res>
    implements _$MyRoadmapDoneDtoCopyWith<$Res> {
  __$MyRoadmapDoneDtoCopyWithImpl(this._self, this._then);

  final _MyRoadmapDoneDto _self;
  final $Res Function(_MyRoadmapDoneDto) _then;

/// Create a copy of MyRoadmapDoneDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storyId = null,Object? title = freezed,Object? coverImageUrl = freezed,Object? completedAt = freezed,}) {
  return _then(_MyRoadmapDoneDto(
storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MyRoadmapDto {

 MyRoadmapOpenStoryDto? get open; List<MyRoadmapUpcomingDto> get upcoming; List<MyRoadmapDoneDto> get done; int get completedCount; int get totalCount; bool get isFinished;
/// Create a copy of MyRoadmapDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyRoadmapDtoCopyWith<MyRoadmapDto> get copyWith => _$MyRoadmapDtoCopyWithImpl<MyRoadmapDto>(this as MyRoadmapDto, _$identity);

  /// Serializes this MyRoadmapDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MyRoadmapDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyRoadmapDto&&(identical(other.open, _this.open) || other.open == _this.open)&&const DeepCollectionEquality().equals(other.upcoming, _this.upcoming)&&const DeepCollectionEquality().equals(other.done, _this.done)&&(identical(other.completedCount, _this.completedCount) || other.completedCount == _this.completedCount)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.isFinished, _this.isFinished) || other.isFinished == _this.isFinished));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MyRoadmapDto;
  return Object.hash(runtimeType,_this.open,const DeepCollectionEquality().hash(_this.upcoming),const DeepCollectionEquality().hash(_this.done),_this.completedCount,_this.totalCount,_this.isFinished);
}

@override
String toString() {
  final _this = this as MyRoadmapDto;
  return 'MyRoadmapDto(open: ${_this.open}, upcoming: ${_this.upcoming}, done: ${_this.done}, completedCount: ${_this.completedCount}, totalCount: ${_this.totalCount}, isFinished: ${_this.isFinished})';
}


}

/// @nodoc
abstract mixin class $MyRoadmapDtoCopyWith<$Res>  {
  factory $MyRoadmapDtoCopyWith(MyRoadmapDto value, $Res Function(MyRoadmapDto) _then) = _$MyRoadmapDtoCopyWithImpl;
@useResult
$Res call({
 MyRoadmapOpenStoryDto? open, List<MyRoadmapUpcomingDto> upcoming, List<MyRoadmapDoneDto> done, int completedCount, int totalCount, bool isFinished
});


$MyRoadmapOpenStoryDtoCopyWith<$Res>? get open;

}
/// @nodoc
class _$MyRoadmapDtoCopyWithImpl<$Res>
    implements $MyRoadmapDtoCopyWith<$Res> {
  _$MyRoadmapDtoCopyWithImpl(this._self, this._then);

  final MyRoadmapDto _self;
  final $Res Function(MyRoadmapDto) _then;

/// Create a copy of MyRoadmapDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? open = freezed,Object? upcoming = null,Object? done = null,Object? completedCount = null,Object? totalCount = null,Object? isFinished = null,}) {
  return _then(MyRoadmapDto(
open: freezed == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as MyRoadmapOpenStoryDto?,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<MyRoadmapUpcomingDto>,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as List<MyRoadmapDoneDto>,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,isFinished: null == isFinished ? _self.isFinished : isFinished // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of MyRoadmapDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyRoadmapOpenStoryDtoCopyWith<$Res>? get open {
    if (_self.open == null) {
    return null;
  }

  return $MyRoadmapOpenStoryDtoCopyWith<$Res>(_self.open!, (value) {
    return _then(_self.copyWith(open: value));
  });
}
}


/// Adds pattern-matching-related methods to [MyRoadmapDto].
extension MyRoadmapDtoPatterns on MyRoadmapDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyRoadmapDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyRoadmapDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyRoadmapDto value)  $default,){
final _that = this;
switch (_that) {
case _MyRoadmapDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyRoadmapDto value)?  $default,){
final _that = this;
switch (_that) {
case _MyRoadmapDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MyRoadmapOpenStoryDto? open,  List<MyRoadmapUpcomingDto> upcoming,  List<MyRoadmapDoneDto> done,  int completedCount,  int totalCount,  bool isFinished)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyRoadmapDto() when $default != null:
return $default(_that.open,_that.upcoming,_that.done,_that.completedCount,_that.totalCount,_that.isFinished);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MyRoadmapOpenStoryDto? open,  List<MyRoadmapUpcomingDto> upcoming,  List<MyRoadmapDoneDto> done,  int completedCount,  int totalCount,  bool isFinished)  $default,) {final _that = this;
switch (_that) {
case _MyRoadmapDto():
return $default(_that.open,_that.upcoming,_that.done,_that.completedCount,_that.totalCount,_that.isFinished);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MyRoadmapOpenStoryDto? open,  List<MyRoadmapUpcomingDto> upcoming,  List<MyRoadmapDoneDto> done,  int completedCount,  int totalCount,  bool isFinished)?  $default,) {final _that = this;
switch (_that) {
case _MyRoadmapDto() when $default != null:
return $default(_that.open,_that.upcoming,_that.done,_that.completedCount,_that.totalCount,_that.isFinished);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyRoadmapDto implements MyRoadmapDto {
  const _MyRoadmapDto({this.open,  List<MyRoadmapUpcomingDto> upcoming = const <MyRoadmapUpcomingDto>[],  List<MyRoadmapDoneDto> done = const <MyRoadmapDoneDto>[], this.completedCount = 0, this.totalCount = 0, this.isFinished = false}): _upcoming = upcoming,_done = done;
  factory _MyRoadmapDto.fromJson(Map<String, dynamic> json) => _$MyRoadmapDtoFromJson(json);

@override final  MyRoadmapOpenStoryDto? open;
 final  List<MyRoadmapUpcomingDto> _upcoming;
@override@JsonKey() List<MyRoadmapUpcomingDto> get upcoming {
  if (_upcoming is EqualUnmodifiableListView) return _upcoming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcoming);
}

 final  List<MyRoadmapDoneDto> _done;
@override@JsonKey() List<MyRoadmapDoneDto> get done {
  if (_done is EqualUnmodifiableListView) return _done;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_done);
}

@override@JsonKey() final  int completedCount;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  bool isFinished;

/// Create a copy of MyRoadmapDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyRoadmapDtoCopyWith<_MyRoadmapDto> get copyWith => __$MyRoadmapDtoCopyWithImpl<_MyRoadmapDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyRoadmapDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyRoadmapDto&&(identical(other.open, open) || other.open == open)&&const DeepCollectionEquality().equals(other.upcoming, _upcoming)&&const DeepCollectionEquality().equals(other.done, _done)&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.isFinished, isFinished) || other.isFinished == isFinished));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,open,const DeepCollectionEquality().hash(_upcoming),const DeepCollectionEquality().hash(_done),completedCount,totalCount,isFinished);
}

@override
String toString() {
    return 'MyRoadmapDto(open: $open, upcoming: $upcoming, done: $done, completedCount: $completedCount, totalCount: $totalCount, isFinished: $isFinished)';
}


}

/// @nodoc
abstract mixin class _$MyRoadmapDtoCopyWith<$Res> implements $MyRoadmapDtoCopyWith<$Res> {
  factory _$MyRoadmapDtoCopyWith(_MyRoadmapDto value, $Res Function(_MyRoadmapDto) _then) = __$MyRoadmapDtoCopyWithImpl;
@override @useResult
$Res call({
 MyRoadmapOpenStoryDto? open, List<MyRoadmapUpcomingDto> upcoming, List<MyRoadmapDoneDto> done, int completedCount, int totalCount, bool isFinished
});


@override $MyRoadmapOpenStoryDtoCopyWith<$Res>? get open;

}
/// @nodoc
class __$MyRoadmapDtoCopyWithImpl<$Res>
    implements _$MyRoadmapDtoCopyWith<$Res> {
  __$MyRoadmapDtoCopyWithImpl(this._self, this._then);

  final _MyRoadmapDto _self;
  final $Res Function(_MyRoadmapDto) _then;

/// Create a copy of MyRoadmapDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? open = freezed,Object? upcoming = null,Object? done = null,Object? completedCount = null,Object? totalCount = null,Object? isFinished = null,}) {
  return _then(_MyRoadmapDto(
open: freezed == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as MyRoadmapOpenStoryDto?,upcoming: null == upcoming ? _self._upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<MyRoadmapUpcomingDto>,done: null == done ? _self._done : done // ignore: cast_nullable_to_non_nullable
as List<MyRoadmapDoneDto>,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,isFinished: null == isFinished ? _self.isFinished : isFinished // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of MyRoadmapDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyRoadmapOpenStoryDtoCopyWith<$Res>? get open {
    if (_self.open == null) {
    return null;
  }

  return $MyRoadmapOpenStoryDtoCopyWith<$Res>(_self.open!, (value) {
    return _then(_self.copyWith(open: value));
  });
}
}

// dart format on
