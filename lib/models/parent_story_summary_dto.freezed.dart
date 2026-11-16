// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parent_story_summary_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ParentStorySummaryFlagDto {

 int get sceneId; int get sceneIndex; String get sceneText; String? get illustrationUrl;
/// Create a copy of ParentStorySummaryFlagDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentStorySummaryFlagDtoCopyWith<ParentStorySummaryFlagDto> get copyWith => _$ParentStorySummaryFlagDtoCopyWithImpl<ParentStorySummaryFlagDto>(this as ParentStorySummaryFlagDto, _$identity);

  /// Serializes this ParentStorySummaryFlagDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ParentStorySummaryFlagDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentStorySummaryFlagDto&&(identical(other.sceneId, _this.sceneId) || other.sceneId == _this.sceneId)&&(identical(other.sceneIndex, _this.sceneIndex) || other.sceneIndex == _this.sceneIndex)&&(identical(other.sceneText, _this.sceneText) || other.sceneText == _this.sceneText)&&(identical(other.illustrationUrl, _this.illustrationUrl) || other.illustrationUrl == _this.illustrationUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParentStorySummaryFlagDto;
  return Object.hash(runtimeType,_this.sceneId,_this.sceneIndex,_this.sceneText,_this.illustrationUrl);
}

@override
String toString() {
  final _this = this as ParentStorySummaryFlagDto;
  return 'ParentStorySummaryFlagDto(sceneId: ${_this.sceneId}, sceneIndex: ${_this.sceneIndex}, sceneText: ${_this.sceneText}, illustrationUrl: ${_this.illustrationUrl})';
}


}

/// @nodoc
abstract mixin class $ParentStorySummaryFlagDtoCopyWith<$Res>  {
  factory $ParentStorySummaryFlagDtoCopyWith(ParentStorySummaryFlagDto value, $Res Function(ParentStorySummaryFlagDto) _then) = _$ParentStorySummaryFlagDtoCopyWithImpl;
@useResult
$Res call({
 int sceneId, int sceneIndex, String sceneText, String? illustrationUrl
});




}
/// @nodoc
class _$ParentStorySummaryFlagDtoCopyWithImpl<$Res>
    implements $ParentStorySummaryFlagDtoCopyWith<$Res> {
  _$ParentStorySummaryFlagDtoCopyWithImpl(this._self, this._then);

  final ParentStorySummaryFlagDto _self;
  final $Res Function(ParentStorySummaryFlagDto) _then;

/// Create a copy of ParentStorySummaryFlagDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sceneId = null,Object? sceneIndex = null,Object? sceneText = null,Object? illustrationUrl = freezed,}) {
  return _then(ParentStorySummaryFlagDto(
sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as int,sceneIndex: null == sceneIndex ? _self.sceneIndex : sceneIndex // ignore: cast_nullable_to_non_nullable
as int,sceneText: null == sceneText ? _self.sceneText : sceneText // ignore: cast_nullable_to_non_nullable
as String,illustrationUrl: freezed == illustrationUrl ? _self.illustrationUrl : illustrationUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ParentStorySummaryFlagDto].
extension ParentStorySummaryFlagDtoPatterns on ParentStorySummaryFlagDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParentStorySummaryFlagDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParentStorySummaryFlagDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParentStorySummaryFlagDto value)  $default,){
final _that = this;
switch (_that) {
case _ParentStorySummaryFlagDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParentStorySummaryFlagDto value)?  $default,){
final _that = this;
switch (_that) {
case _ParentStorySummaryFlagDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sceneId,  int sceneIndex,  String sceneText,  String? illustrationUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParentStorySummaryFlagDto() when $default != null:
return $default(_that.sceneId,_that.sceneIndex,_that.sceneText,_that.illustrationUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sceneId,  int sceneIndex,  String sceneText,  String? illustrationUrl)  $default,) {final _that = this;
switch (_that) {
case _ParentStorySummaryFlagDto():
return $default(_that.sceneId,_that.sceneIndex,_that.sceneText,_that.illustrationUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sceneId,  int sceneIndex,  String sceneText,  String? illustrationUrl)?  $default,) {final _that = this;
switch (_that) {
case _ParentStorySummaryFlagDto() when $default != null:
return $default(_that.sceneId,_that.sceneIndex,_that.sceneText,_that.illustrationUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParentStorySummaryFlagDto implements ParentStorySummaryFlagDto {
  const _ParentStorySummaryFlagDto({required this.sceneId, this.sceneIndex = 0, this.sceneText = '', this.illustrationUrl});
  factory _ParentStorySummaryFlagDto.fromJson(Map<String, dynamic> json) => _$ParentStorySummaryFlagDtoFromJson(json);

@override final  int sceneId;
@override@JsonKey() final  int sceneIndex;
@override@JsonKey() final  String sceneText;
@override final  String? illustrationUrl;

/// Create a copy of ParentStorySummaryFlagDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentStorySummaryFlagDtoCopyWith<_ParentStorySummaryFlagDto> get copyWith => __$ParentStorySummaryFlagDtoCopyWithImpl<_ParentStorySummaryFlagDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParentStorySummaryFlagDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentStorySummaryFlagDto&&(identical(other.sceneId, sceneId) || other.sceneId == sceneId)&&(identical(other.sceneIndex, sceneIndex) || other.sceneIndex == sceneIndex)&&(identical(other.sceneText, sceneText) || other.sceneText == sceneText)&&(identical(other.illustrationUrl, illustrationUrl) || other.illustrationUrl == illustrationUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sceneId,sceneIndex,sceneText,illustrationUrl);
}

@override
String toString() {
    return 'ParentStorySummaryFlagDto(sceneId: $sceneId, sceneIndex: $sceneIndex, sceneText: $sceneText, illustrationUrl: $illustrationUrl)';
}


}

/// @nodoc
abstract mixin class _$ParentStorySummaryFlagDtoCopyWith<$Res> implements $ParentStorySummaryFlagDtoCopyWith<$Res> {
  factory _$ParentStorySummaryFlagDtoCopyWith(_ParentStorySummaryFlagDto value, $Res Function(_ParentStorySummaryFlagDto) _then) = __$ParentStorySummaryFlagDtoCopyWithImpl;
@override @useResult
$Res call({
 int sceneId, int sceneIndex, String sceneText, String? illustrationUrl
});




}
/// @nodoc
class __$ParentStorySummaryFlagDtoCopyWithImpl<$Res>
    implements _$ParentStorySummaryFlagDtoCopyWith<$Res> {
  __$ParentStorySummaryFlagDtoCopyWithImpl(this._self, this._then);

  final _ParentStorySummaryFlagDto _self;
  final $Res Function(_ParentStorySummaryFlagDto) _then;

/// Create a copy of ParentStorySummaryFlagDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sceneId = null,Object? sceneIndex = null,Object? sceneText = null,Object? illustrationUrl = freezed,}) {
  return _then(_ParentStorySummaryFlagDto(
sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as int,sceneIndex: null == sceneIndex ? _self.sceneIndex : sceneIndex // ignore: cast_nullable_to_non_nullable
as int,sceneText: null == sceneText ? _self.sceneText : sceneText // ignore: cast_nullable_to_non_nullable
as String,illustrationUrl: freezed == illustrationUrl ? _self.illustrationUrl : illustrationUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ParentStorySummaryItemDto {

 int get summaryId; int get sessionId; int get storyId; String get title; DateTime? get createdAt;/// Link nghe ký sẵn, hết hạn sau 15 phút; null khi bé không ghi âm.
 String? get recordingUrl; DateTime? get recordingSentAt; DateTime? get flagsSentAt; List<ParentStorySummaryFlagDto> get flags;
/// Create a copy of ParentStorySummaryItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentStorySummaryItemDtoCopyWith<ParentStorySummaryItemDto> get copyWith => _$ParentStorySummaryItemDtoCopyWithImpl<ParentStorySummaryItemDto>(this as ParentStorySummaryItemDto, _$identity);

  /// Serializes this ParentStorySummaryItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ParentStorySummaryItemDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentStorySummaryItemDto&&(identical(other.summaryId, _this.summaryId) || other.summaryId == _this.summaryId)&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.recordingUrl, _this.recordingUrl) || other.recordingUrl == _this.recordingUrl)&&(identical(other.recordingSentAt, _this.recordingSentAt) || other.recordingSentAt == _this.recordingSentAt)&&(identical(other.flagsSentAt, _this.flagsSentAt) || other.flagsSentAt == _this.flagsSentAt)&&const DeepCollectionEquality().equals(other.flags, _this.flags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParentStorySummaryItemDto;
  return Object.hash(runtimeType,_this.summaryId,_this.sessionId,_this.storyId,_this.title,_this.createdAt,_this.recordingUrl,_this.recordingSentAt,_this.flagsSentAt,const DeepCollectionEquality().hash(_this.flags));
}

@override
String toString() {
  final _this = this as ParentStorySummaryItemDto;
  return 'ParentStorySummaryItemDto(summaryId: ${_this.summaryId}, sessionId: ${_this.sessionId}, storyId: ${_this.storyId}, title: ${_this.title}, createdAt: ${_this.createdAt}, recordingUrl: ${_this.recordingUrl}, recordingSentAt: ${_this.recordingSentAt}, flagsSentAt: ${_this.flagsSentAt}, flags: ${_this.flags})';
}


}

/// @nodoc
abstract mixin class $ParentStorySummaryItemDtoCopyWith<$Res>  {
  factory $ParentStorySummaryItemDtoCopyWith(ParentStorySummaryItemDto value, $Res Function(ParentStorySummaryItemDto) _then) = _$ParentStorySummaryItemDtoCopyWithImpl;
@useResult
$Res call({
 int summaryId, int sessionId, int storyId, String title, DateTime? createdAt, String? recordingUrl, DateTime? recordingSentAt, DateTime? flagsSentAt, List<ParentStorySummaryFlagDto> flags
});




}
/// @nodoc
class _$ParentStorySummaryItemDtoCopyWithImpl<$Res>
    implements $ParentStorySummaryItemDtoCopyWith<$Res> {
  _$ParentStorySummaryItemDtoCopyWithImpl(this._self, this._then);

  final ParentStorySummaryItemDto _self;
  final $Res Function(ParentStorySummaryItemDto) _then;

/// Create a copy of ParentStorySummaryItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summaryId = null,Object? sessionId = null,Object? storyId = null,Object? title = null,Object? createdAt = freezed,Object? recordingUrl = freezed,Object? recordingSentAt = freezed,Object? flagsSentAt = freezed,Object? flags = null,}) {
  return _then(ParentStorySummaryItemDto(
summaryId: null == summaryId ? _self.summaryId : summaryId // ignore: cast_nullable_to_non_nullable
as int,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,recordingUrl: freezed == recordingUrl ? _self.recordingUrl : recordingUrl // ignore: cast_nullable_to_non_nullable
as String?,recordingSentAt: freezed == recordingSentAt ? _self.recordingSentAt : recordingSentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,flagsSentAt: freezed == flagsSentAt ? _self.flagsSentAt : flagsSentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as List<ParentStorySummaryFlagDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ParentStorySummaryItemDto].
extension ParentStorySummaryItemDtoPatterns on ParentStorySummaryItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParentStorySummaryItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParentStorySummaryItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParentStorySummaryItemDto value)  $default,){
final _that = this;
switch (_that) {
case _ParentStorySummaryItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParentStorySummaryItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _ParentStorySummaryItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int summaryId,  int sessionId,  int storyId,  String title,  DateTime? createdAt,  String? recordingUrl,  DateTime? recordingSentAt,  DateTime? flagsSentAt,  List<ParentStorySummaryFlagDto> flags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParentStorySummaryItemDto() when $default != null:
return $default(_that.summaryId,_that.sessionId,_that.storyId,_that.title,_that.createdAt,_that.recordingUrl,_that.recordingSentAt,_that.flagsSentAt,_that.flags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int summaryId,  int sessionId,  int storyId,  String title,  DateTime? createdAt,  String? recordingUrl,  DateTime? recordingSentAt,  DateTime? flagsSentAt,  List<ParentStorySummaryFlagDto> flags)  $default,) {final _that = this;
switch (_that) {
case _ParentStorySummaryItemDto():
return $default(_that.summaryId,_that.sessionId,_that.storyId,_that.title,_that.createdAt,_that.recordingUrl,_that.recordingSentAt,_that.flagsSentAt,_that.flags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int summaryId,  int sessionId,  int storyId,  String title,  DateTime? createdAt,  String? recordingUrl,  DateTime? recordingSentAt,  DateTime? flagsSentAt,  List<ParentStorySummaryFlagDto> flags)?  $default,) {final _that = this;
switch (_that) {
case _ParentStorySummaryItemDto() when $default != null:
return $default(_that.summaryId,_that.sessionId,_that.storyId,_that.title,_that.createdAt,_that.recordingUrl,_that.recordingSentAt,_that.flagsSentAt,_that.flags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParentStorySummaryItemDto implements ParentStorySummaryItemDto {
  const _ParentStorySummaryItemDto({required this.summaryId, this.sessionId = 0, this.storyId = 0, this.title = '', this.createdAt, this.recordingUrl, this.recordingSentAt, this.flagsSentAt,  List<ParentStorySummaryFlagDto> flags = const <ParentStorySummaryFlagDto>[]}): _flags = flags;
  factory _ParentStorySummaryItemDto.fromJson(Map<String, dynamic> json) => _$ParentStorySummaryItemDtoFromJson(json);

@override final  int summaryId;
@override@JsonKey() final  int sessionId;
@override@JsonKey() final  int storyId;
@override@JsonKey() final  String title;
@override final  DateTime? createdAt;
/// Link nghe ký sẵn, hết hạn sau 15 phút; null khi bé không ghi âm.
@override final  String? recordingUrl;
@override final  DateTime? recordingSentAt;
@override final  DateTime? flagsSentAt;
 final  List<ParentStorySummaryFlagDto> _flags;
@override@JsonKey() List<ParentStorySummaryFlagDto> get flags {
  if (_flags is EqualUnmodifiableListView) return _flags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flags);
}


/// Create a copy of ParentStorySummaryItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentStorySummaryItemDtoCopyWith<_ParentStorySummaryItemDto> get copyWith => __$ParentStorySummaryItemDtoCopyWithImpl<_ParentStorySummaryItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParentStorySummaryItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentStorySummaryItemDto&&(identical(other.summaryId, summaryId) || other.summaryId == summaryId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.recordingUrl, recordingUrl) || other.recordingUrl == recordingUrl)&&(identical(other.recordingSentAt, recordingSentAt) || other.recordingSentAt == recordingSentAt)&&(identical(other.flagsSentAt, flagsSentAt) || other.flagsSentAt == flagsSentAt)&&const DeepCollectionEquality().equals(other.flags, _flags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,summaryId,sessionId,storyId,title,createdAt,recordingUrl,recordingSentAt,flagsSentAt,const DeepCollectionEquality().hash(_flags));
}

@override
String toString() {
    return 'ParentStorySummaryItemDto(summaryId: $summaryId, sessionId: $sessionId, storyId: $storyId, title: $title, createdAt: $createdAt, recordingUrl: $recordingUrl, recordingSentAt: $recordingSentAt, flagsSentAt: $flagsSentAt, flags: $flags)';
}


}

/// @nodoc
abstract mixin class _$ParentStorySummaryItemDtoCopyWith<$Res> implements $ParentStorySummaryItemDtoCopyWith<$Res> {
  factory _$ParentStorySummaryItemDtoCopyWith(_ParentStorySummaryItemDto value, $Res Function(_ParentStorySummaryItemDto) _then) = __$ParentStorySummaryItemDtoCopyWithImpl;
@override @useResult
$Res call({
 int summaryId, int sessionId, int storyId, String title, DateTime? createdAt, String? recordingUrl, DateTime? recordingSentAt, DateTime? flagsSentAt, List<ParentStorySummaryFlagDto> flags
});




}
/// @nodoc
class __$ParentStorySummaryItemDtoCopyWithImpl<$Res>
    implements _$ParentStorySummaryItemDtoCopyWith<$Res> {
  __$ParentStorySummaryItemDtoCopyWithImpl(this._self, this._then);

  final _ParentStorySummaryItemDto _self;
  final $Res Function(_ParentStorySummaryItemDto) _then;

/// Create a copy of ParentStorySummaryItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summaryId = null,Object? sessionId = null,Object? storyId = null,Object? title = null,Object? createdAt = freezed,Object? recordingUrl = freezed,Object? recordingSentAt = freezed,Object? flagsSentAt = freezed,Object? flags = null,}) {
  return _then(_ParentStorySummaryItemDto(
summaryId: null == summaryId ? _self.summaryId : summaryId // ignore: cast_nullable_to_non_nullable
as int,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,recordingUrl: freezed == recordingUrl ? _self.recordingUrl : recordingUrl // ignore: cast_nullable_to_non_nullable
as String?,recordingSentAt: freezed == recordingSentAt ? _self.recordingSentAt : recordingSentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,flagsSentAt: freezed == flagsSentAt ? _self.flagsSentAt : flagsSentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,flags: null == flags ? _self._flags : flags // ignore: cast_nullable_to_non_nullable
as List<ParentStorySummaryFlagDto>,
  ));
}


}


/// @nodoc
mixin _$ParentStorySummaryPageDto {

 List<ParentStorySummaryItemDto> get items; int get totalCount; int get pageIndex; int get pageSize; int get totalPages; bool get hasNextPage; bool get hasPreviousPage;
/// Create a copy of ParentStorySummaryPageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentStorySummaryPageDtoCopyWith<ParentStorySummaryPageDto> get copyWith => _$ParentStorySummaryPageDtoCopyWithImpl<ParentStorySummaryPageDto>(this as ParentStorySummaryPageDto, _$identity);

  /// Serializes this ParentStorySummaryPageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ParentStorySummaryPageDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentStorySummaryPageDto&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.pageIndex, _this.pageIndex) || other.pageIndex == _this.pageIndex)&&(identical(other.pageSize, _this.pageSize) || other.pageSize == _this.pageSize)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages)&&(identical(other.hasNextPage, _this.hasNextPage) || other.hasNextPage == _this.hasNextPage)&&(identical(other.hasPreviousPage, _this.hasPreviousPage) || other.hasPreviousPage == _this.hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParentStorySummaryPageDto;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.totalCount,_this.pageIndex,_this.pageSize,_this.totalPages,_this.hasNextPage,_this.hasPreviousPage);
}

@override
String toString() {
  final _this = this as ParentStorySummaryPageDto;
  return 'ParentStorySummaryPageDto(items: ${_this.items}, totalCount: ${_this.totalCount}, pageIndex: ${_this.pageIndex}, pageSize: ${_this.pageSize}, totalPages: ${_this.totalPages}, hasNextPage: ${_this.hasNextPage}, hasPreviousPage: ${_this.hasPreviousPage})';
}


}

/// @nodoc
abstract mixin class $ParentStorySummaryPageDtoCopyWith<$Res>  {
  factory $ParentStorySummaryPageDtoCopyWith(ParentStorySummaryPageDto value, $Res Function(ParentStorySummaryPageDto) _then) = _$ParentStorySummaryPageDtoCopyWithImpl;
@useResult
$Res call({
 List<ParentStorySummaryItemDto> items, int totalCount, int pageIndex, int pageSize, int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class _$ParentStorySummaryPageDtoCopyWithImpl<$Res>
    implements $ParentStorySummaryPageDtoCopyWith<$Res> {
  _$ParentStorySummaryPageDtoCopyWithImpl(this._self, this._then);

  final ParentStorySummaryPageDto _self;
  final $Res Function(ParentStorySummaryPageDto) _then;

/// Create a copy of ParentStorySummaryPageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? totalCount = null,Object? pageIndex = null,Object? pageSize = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(ParentStorySummaryPageDto(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ParentStorySummaryItemDto>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,pageIndex: null == pageIndex ? _self.pageIndex : pageIndex // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ParentStorySummaryPageDto].
extension ParentStorySummaryPageDtoPatterns on ParentStorySummaryPageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParentStorySummaryPageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParentStorySummaryPageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParentStorySummaryPageDto value)  $default,){
final _that = this;
switch (_that) {
case _ParentStorySummaryPageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParentStorySummaryPageDto value)?  $default,){
final _that = this;
switch (_that) {
case _ParentStorySummaryPageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ParentStorySummaryItemDto> items,  int totalCount,  int pageIndex,  int pageSize,  int totalPages,  bool hasNextPage,  bool hasPreviousPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParentStorySummaryPageDto() when $default != null:
return $default(_that.items,_that.totalCount,_that.pageIndex,_that.pageSize,_that.totalPages,_that.hasNextPage,_that.hasPreviousPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ParentStorySummaryItemDto> items,  int totalCount,  int pageIndex,  int pageSize,  int totalPages,  bool hasNextPage,  bool hasPreviousPage)  $default,) {final _that = this;
switch (_that) {
case _ParentStorySummaryPageDto():
return $default(_that.items,_that.totalCount,_that.pageIndex,_that.pageSize,_that.totalPages,_that.hasNextPage,_that.hasPreviousPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ParentStorySummaryItemDto> items,  int totalCount,  int pageIndex,  int pageSize,  int totalPages,  bool hasNextPage,  bool hasPreviousPage)?  $default,) {final _that = this;
switch (_that) {
case _ParentStorySummaryPageDto() when $default != null:
return $default(_that.items,_that.totalCount,_that.pageIndex,_that.pageSize,_that.totalPages,_that.hasNextPage,_that.hasPreviousPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParentStorySummaryPageDto implements ParentStorySummaryPageDto {
  const _ParentStorySummaryPageDto({ List<ParentStorySummaryItemDto> items = const <ParentStorySummaryItemDto>[], this.totalCount = 0, this.pageIndex = 0, this.pageSize = 0, this.totalPages = 0, this.hasNextPage = false, this.hasPreviousPage = false}): _items = items;
  factory _ParentStorySummaryPageDto.fromJson(Map<String, dynamic> json) => _$ParentStorySummaryPageDtoFromJson(json);

 final  List<ParentStorySummaryItemDto> _items;
@override@JsonKey() List<ParentStorySummaryItemDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int totalCount;
@override@JsonKey() final  int pageIndex;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  bool hasNextPage;
@override@JsonKey() final  bool hasPreviousPage;

/// Create a copy of ParentStorySummaryPageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentStorySummaryPageDtoCopyWith<_ParentStorySummaryPageDto> get copyWith => __$ParentStorySummaryPageDtoCopyWithImpl<_ParentStorySummaryPageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParentStorySummaryPageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentStorySummaryPageDto&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.pageIndex, pageIndex) || other.pageIndex == pageIndex)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalCount,pageIndex,pageSize,totalPages,hasNextPage,hasPreviousPage);
}

@override
String toString() {
    return 'ParentStorySummaryPageDto(items: $items, totalCount: $totalCount, pageIndex: $pageIndex, pageSize: $pageSize, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage)';
}


}

/// @nodoc
abstract mixin class _$ParentStorySummaryPageDtoCopyWith<$Res> implements $ParentStorySummaryPageDtoCopyWith<$Res> {
  factory _$ParentStorySummaryPageDtoCopyWith(_ParentStorySummaryPageDto value, $Res Function(_ParentStorySummaryPageDto) _then) = __$ParentStorySummaryPageDtoCopyWithImpl;
@override @useResult
$Res call({
 List<ParentStorySummaryItemDto> items, int totalCount, int pageIndex, int pageSize, int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class __$ParentStorySummaryPageDtoCopyWithImpl<$Res>
    implements _$ParentStorySummaryPageDtoCopyWith<$Res> {
  __$ParentStorySummaryPageDtoCopyWithImpl(this._self, this._then);

  final _ParentStorySummaryPageDto _self;
  final $Res Function(_ParentStorySummaryPageDto) _then;

/// Create a copy of ParentStorySummaryPageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalCount = null,Object? pageIndex = null,Object? pageSize = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(_ParentStorySummaryPageDto(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ParentStorySummaryItemDto>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,pageIndex: null == pageIndex ? _self.pageIndex : pageIndex // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
