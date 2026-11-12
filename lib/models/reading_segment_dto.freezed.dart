// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_segment_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReadingSegmentDto {

 int get segmentId; int get segmentOrder; int? get startOffset; int? get endOffset; String get text; String? get audioUrl; String? get wordTimingsJson;
/// Create a copy of ReadingSegmentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingSegmentDtoCopyWith<ReadingSegmentDto> get copyWith => _$ReadingSegmentDtoCopyWithImpl<ReadingSegmentDto>(this as ReadingSegmentDto, _$identity);

  /// Serializes this ReadingSegmentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingSegmentDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingSegmentDto&&(identical(other.segmentId, _this.segmentId) || other.segmentId == _this.segmentId)&&(identical(other.segmentOrder, _this.segmentOrder) || other.segmentOrder == _this.segmentOrder)&&(identical(other.startOffset, _this.startOffset) || other.startOffset == _this.startOffset)&&(identical(other.endOffset, _this.endOffset) || other.endOffset == _this.endOffset)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.audioUrl, _this.audioUrl) || other.audioUrl == _this.audioUrl)&&(identical(other.wordTimingsJson, _this.wordTimingsJson) || other.wordTimingsJson == _this.wordTimingsJson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingSegmentDto;
  return Object.hash(runtimeType,_this.segmentId,_this.segmentOrder,_this.startOffset,_this.endOffset,_this.text,_this.audioUrl,_this.wordTimingsJson);
}

@override
String toString() {
  final _this = this as ReadingSegmentDto;
  return 'ReadingSegmentDto(segmentId: ${_this.segmentId}, segmentOrder: ${_this.segmentOrder}, startOffset: ${_this.startOffset}, endOffset: ${_this.endOffset}, text: ${_this.text}, audioUrl: ${_this.audioUrl}, wordTimingsJson: ${_this.wordTimingsJson})';
}


}

/// @nodoc
abstract mixin class $ReadingSegmentDtoCopyWith<$Res>  {
  factory $ReadingSegmentDtoCopyWith(ReadingSegmentDto value, $Res Function(ReadingSegmentDto) _then) = _$ReadingSegmentDtoCopyWithImpl;
@useResult
$Res call({
 int segmentId, int segmentOrder, int? startOffset, int? endOffset, String text, String? audioUrl, String? wordTimingsJson
});




}
/// @nodoc
class _$ReadingSegmentDtoCopyWithImpl<$Res>
    implements $ReadingSegmentDtoCopyWith<$Res> {
  _$ReadingSegmentDtoCopyWithImpl(this._self, this._then);

  final ReadingSegmentDto _self;
  final $Res Function(ReadingSegmentDto) _then;

/// Create a copy of ReadingSegmentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? segmentId = null,Object? segmentOrder = null,Object? startOffset = freezed,Object? endOffset = freezed,Object? text = null,Object? audioUrl = freezed,Object? wordTimingsJson = freezed,}) {
  return _then(ReadingSegmentDto(
segmentId: null == segmentId ? _self.segmentId : segmentId // ignore: cast_nullable_to_non_nullable
as int,segmentOrder: null == segmentOrder ? _self.segmentOrder : segmentOrder // ignore: cast_nullable_to_non_nullable
as int,startOffset: freezed == startOffset ? _self.startOffset : startOffset // ignore: cast_nullable_to_non_nullable
as int?,endOffset: freezed == endOffset ? _self.endOffset : endOffset // ignore: cast_nullable_to_non_nullable
as int?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,wordTimingsJson: freezed == wordTimingsJson ? _self.wordTimingsJson : wordTimingsJson // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingSegmentDto].
extension ReadingSegmentDtoPatterns on ReadingSegmentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingSegmentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingSegmentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingSegmentDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadingSegmentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingSegmentDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingSegmentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int segmentId,  int segmentOrder,  int? startOffset,  int? endOffset,  String text,  String? audioUrl,  String? wordTimingsJson)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingSegmentDto() when $default != null:
return $default(_that.segmentId,_that.segmentOrder,_that.startOffset,_that.endOffset,_that.text,_that.audioUrl,_that.wordTimingsJson);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int segmentId,  int segmentOrder,  int? startOffset,  int? endOffset,  String text,  String? audioUrl,  String? wordTimingsJson)  $default,) {final _that = this;
switch (_that) {
case _ReadingSegmentDto():
return $default(_that.segmentId,_that.segmentOrder,_that.startOffset,_that.endOffset,_that.text,_that.audioUrl,_that.wordTimingsJson);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int segmentId,  int segmentOrder,  int? startOffset,  int? endOffset,  String text,  String? audioUrl,  String? wordTimingsJson)?  $default,) {final _that = this;
switch (_that) {
case _ReadingSegmentDto() when $default != null:
return $default(_that.segmentId,_that.segmentOrder,_that.startOffset,_that.endOffset,_that.text,_that.audioUrl,_that.wordTimingsJson);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingSegmentDto implements ReadingSegmentDto {
  const _ReadingSegmentDto({required this.segmentId, required this.segmentOrder, this.startOffset, this.endOffset, this.text = '', this.audioUrl, this.wordTimingsJson});
  factory _ReadingSegmentDto.fromJson(Map<String, dynamic> json) => _$ReadingSegmentDtoFromJson(json);

@override final  int segmentId;
@override final  int segmentOrder;
@override final  int? startOffset;
@override final  int? endOffset;
@override@JsonKey() final  String text;
@override final  String? audioUrl;
@override final  String? wordTimingsJson;

/// Create a copy of ReadingSegmentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingSegmentDtoCopyWith<_ReadingSegmentDto> get copyWith => __$ReadingSegmentDtoCopyWithImpl<_ReadingSegmentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingSegmentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingSegmentDto&&(identical(other.segmentId, segmentId) || other.segmentId == segmentId)&&(identical(other.segmentOrder, segmentOrder) || other.segmentOrder == segmentOrder)&&(identical(other.startOffset, startOffset) || other.startOffset == startOffset)&&(identical(other.endOffset, endOffset) || other.endOffset == endOffset)&&(identical(other.text, text) || other.text == text)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.wordTimingsJson, wordTimingsJson) || other.wordTimingsJson == wordTimingsJson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,segmentId,segmentOrder,startOffset,endOffset,text,audioUrl,wordTimingsJson);
}

@override
String toString() {
    return 'ReadingSegmentDto(segmentId: $segmentId, segmentOrder: $segmentOrder, startOffset: $startOffset, endOffset: $endOffset, text: $text, audioUrl: $audioUrl, wordTimingsJson: $wordTimingsJson)';
}


}

/// @nodoc
abstract mixin class _$ReadingSegmentDtoCopyWith<$Res> implements $ReadingSegmentDtoCopyWith<$Res> {
  factory _$ReadingSegmentDtoCopyWith(_ReadingSegmentDto value, $Res Function(_ReadingSegmentDto) _then) = __$ReadingSegmentDtoCopyWithImpl;
@override @useResult
$Res call({
 int segmentId, int segmentOrder, int? startOffset, int? endOffset, String text, String? audioUrl, String? wordTimingsJson
});




}
/// @nodoc
class __$ReadingSegmentDtoCopyWithImpl<$Res>
    implements _$ReadingSegmentDtoCopyWith<$Res> {
  __$ReadingSegmentDtoCopyWithImpl(this._self, this._then);

  final _ReadingSegmentDto _self;
  final $Res Function(_ReadingSegmentDto) _then;

/// Create a copy of ReadingSegmentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? segmentId = null,Object? segmentOrder = null,Object? startOffset = freezed,Object? endOffset = freezed,Object? text = null,Object? audioUrl = freezed,Object? wordTimingsJson = freezed,}) {
  return _then(_ReadingSegmentDto(
segmentId: null == segmentId ? _self.segmentId : segmentId // ignore: cast_nullable_to_non_nullable
as int,segmentOrder: null == segmentOrder ? _self.segmentOrder : segmentOrder // ignore: cast_nullable_to_non_nullable
as int,startOffset: freezed == startOffset ? _self.startOffset : startOffset // ignore: cast_nullable_to_non_nullable
as int?,endOffset: freezed == endOffset ? _self.endOffset : endOffset // ignore: cast_nullable_to_non_nullable
as int?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,wordTimingsJson: freezed == wordTimingsJson ? _self.wordTimingsJson : wordTimingsJson // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SceneIllustrationDto {

 int get beatOrder; int get startOffset; int get endOffset; String? get url;
/// Create a copy of SceneIllustrationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SceneIllustrationDtoCopyWith<SceneIllustrationDto> get copyWith => _$SceneIllustrationDtoCopyWithImpl<SceneIllustrationDto>(this as SceneIllustrationDto, _$identity);

  /// Serializes this SceneIllustrationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SceneIllustrationDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SceneIllustrationDto&&(identical(other.beatOrder, _this.beatOrder) || other.beatOrder == _this.beatOrder)&&(identical(other.startOffset, _this.startOffset) || other.startOffset == _this.startOffset)&&(identical(other.endOffset, _this.endOffset) || other.endOffset == _this.endOffset)&&(identical(other.url, _this.url) || other.url == _this.url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SceneIllustrationDto;
  return Object.hash(runtimeType,_this.beatOrder,_this.startOffset,_this.endOffset,_this.url);
}

@override
String toString() {
  final _this = this as SceneIllustrationDto;
  return 'SceneIllustrationDto(beatOrder: ${_this.beatOrder}, startOffset: ${_this.startOffset}, endOffset: ${_this.endOffset}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $SceneIllustrationDtoCopyWith<$Res>  {
  factory $SceneIllustrationDtoCopyWith(SceneIllustrationDto value, $Res Function(SceneIllustrationDto) _then) = _$SceneIllustrationDtoCopyWithImpl;
@useResult
$Res call({
 int beatOrder, int startOffset, int endOffset, String? url
});




}
/// @nodoc
class _$SceneIllustrationDtoCopyWithImpl<$Res>
    implements $SceneIllustrationDtoCopyWith<$Res> {
  _$SceneIllustrationDtoCopyWithImpl(this._self, this._then);

  final SceneIllustrationDto _self;
  final $Res Function(SceneIllustrationDto) _then;

/// Create a copy of SceneIllustrationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? beatOrder = null,Object? startOffset = null,Object? endOffset = null,Object? url = freezed,}) {
  return _then(SceneIllustrationDto(
beatOrder: null == beatOrder ? _self.beatOrder : beatOrder // ignore: cast_nullable_to_non_nullable
as int,startOffset: null == startOffset ? _self.startOffset : startOffset // ignore: cast_nullable_to_non_nullable
as int,endOffset: null == endOffset ? _self.endOffset : endOffset // ignore: cast_nullable_to_non_nullable
as int,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SceneIllustrationDto].
extension SceneIllustrationDtoPatterns on SceneIllustrationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SceneIllustrationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SceneIllustrationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SceneIllustrationDto value)  $default,){
final _that = this;
switch (_that) {
case _SceneIllustrationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SceneIllustrationDto value)?  $default,){
final _that = this;
switch (_that) {
case _SceneIllustrationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int beatOrder,  int startOffset,  int endOffset,  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SceneIllustrationDto() when $default != null:
return $default(_that.beatOrder,_that.startOffset,_that.endOffset,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int beatOrder,  int startOffset,  int endOffset,  String? url)  $default,) {final _that = this;
switch (_that) {
case _SceneIllustrationDto():
return $default(_that.beatOrder,_that.startOffset,_that.endOffset,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int beatOrder,  int startOffset,  int endOffset,  String? url)?  $default,) {final _that = this;
switch (_that) {
case _SceneIllustrationDto() when $default != null:
return $default(_that.beatOrder,_that.startOffset,_that.endOffset,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SceneIllustrationDto implements SceneIllustrationDto {
  const _SceneIllustrationDto({this.beatOrder = 0, this.startOffset = 0, this.endOffset = 0, this.url});
  factory _SceneIllustrationDto.fromJson(Map<String, dynamic> json) => _$SceneIllustrationDtoFromJson(json);

@override@JsonKey() final  int beatOrder;
@override@JsonKey() final  int startOffset;
@override@JsonKey() final  int endOffset;
@override final  String? url;

/// Create a copy of SceneIllustrationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SceneIllustrationDtoCopyWith<_SceneIllustrationDto> get copyWith => __$SceneIllustrationDtoCopyWithImpl<_SceneIllustrationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SceneIllustrationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SceneIllustrationDto&&(identical(other.beatOrder, beatOrder) || other.beatOrder == beatOrder)&&(identical(other.startOffset, startOffset) || other.startOffset == startOffset)&&(identical(other.endOffset, endOffset) || other.endOffset == endOffset)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,beatOrder,startOffset,endOffset,url);
}

@override
String toString() {
    return 'SceneIllustrationDto(beatOrder: $beatOrder, startOffset: $startOffset, endOffset: $endOffset, url: $url)';
}


}

/// @nodoc
abstract mixin class _$SceneIllustrationDtoCopyWith<$Res> implements $SceneIllustrationDtoCopyWith<$Res> {
  factory _$SceneIllustrationDtoCopyWith(_SceneIllustrationDto value, $Res Function(_SceneIllustrationDto) _then) = __$SceneIllustrationDtoCopyWithImpl;
@override @useResult
$Res call({
 int beatOrder, int startOffset, int endOffset, String? url
});




}
/// @nodoc
class __$SceneIllustrationDtoCopyWithImpl<$Res>
    implements _$SceneIllustrationDtoCopyWith<$Res> {
  __$SceneIllustrationDtoCopyWithImpl(this._self, this._then);

  final _SceneIllustrationDto _self;
  final $Res Function(_SceneIllustrationDto) _then;

/// Create a copy of SceneIllustrationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? beatOrder = null,Object? startOffset = null,Object? endOffset = null,Object? url = freezed,}) {
  return _then(_SceneIllustrationDto(
beatOrder: null == beatOrder ? _self.beatOrder : beatOrder // ignore: cast_nullable_to_non_nullable
as int,startOffset: null == startOffset ? _self.startOffset : startOffset // ignore: cast_nullable_to_non_nullable
as int,endOffset: null == endOffset ? _self.endOffset : endOffset // ignore: cast_nullable_to_non_nullable
as int,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
