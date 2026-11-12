// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_content_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReadingVocabularyDto {

 int get id; String get term;
/// Create a copy of ReadingVocabularyDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingVocabularyDtoCopyWith<ReadingVocabularyDto> get copyWith => _$ReadingVocabularyDtoCopyWithImpl<ReadingVocabularyDto>(this as ReadingVocabularyDto, _$identity);

  /// Serializes this ReadingVocabularyDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingVocabularyDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingVocabularyDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.term, _this.term) || other.term == _this.term));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingVocabularyDto;
  return Object.hash(runtimeType,_this.id,_this.term);
}

@override
String toString() {
  final _this = this as ReadingVocabularyDto;
  return 'ReadingVocabularyDto(id: ${_this.id}, term: ${_this.term})';
}


}

/// @nodoc
abstract mixin class $ReadingVocabularyDtoCopyWith<$Res>  {
  factory $ReadingVocabularyDtoCopyWith(ReadingVocabularyDto value, $Res Function(ReadingVocabularyDto) _then) = _$ReadingVocabularyDtoCopyWithImpl;
@useResult
$Res call({
 int id, String term
});




}
/// @nodoc
class _$ReadingVocabularyDtoCopyWithImpl<$Res>
    implements $ReadingVocabularyDtoCopyWith<$Res> {
  _$ReadingVocabularyDtoCopyWithImpl(this._self, this._then);

  final ReadingVocabularyDto _self;
  final $Res Function(ReadingVocabularyDto) _then;

/// Create a copy of ReadingVocabularyDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? term = null,}) {
  return _then(ReadingVocabularyDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingVocabularyDto].
extension ReadingVocabularyDtoPatterns on ReadingVocabularyDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingVocabularyDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingVocabularyDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingVocabularyDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadingVocabularyDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingVocabularyDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingVocabularyDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String term)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingVocabularyDto() when $default != null:
return $default(_that.id,_that.term);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String term)  $default,) {final _that = this;
switch (_that) {
case _ReadingVocabularyDto():
return $default(_that.id,_that.term);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String term)?  $default,) {final _that = this;
switch (_that) {
case _ReadingVocabularyDto() when $default != null:
return $default(_that.id,_that.term);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingVocabularyDto implements ReadingVocabularyDto {
  const _ReadingVocabularyDto({required this.id, required this.term});
  factory _ReadingVocabularyDto.fromJson(Map<String, dynamic> json) => _$ReadingVocabularyDtoFromJson(json);

@override final  int id;
@override final  String term;

/// Create a copy of ReadingVocabularyDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingVocabularyDtoCopyWith<_ReadingVocabularyDto> get copyWith => __$ReadingVocabularyDtoCopyWithImpl<_ReadingVocabularyDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingVocabularyDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingVocabularyDto&&(identical(other.id, id) || other.id == id)&&(identical(other.term, term) || other.term == term));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,term);
}

@override
String toString() {
    return 'ReadingVocabularyDto(id: $id, term: $term)';
}


}

/// @nodoc
abstract mixin class _$ReadingVocabularyDtoCopyWith<$Res> implements $ReadingVocabularyDtoCopyWith<$Res> {
  factory _$ReadingVocabularyDtoCopyWith(_ReadingVocabularyDto value, $Res Function(_ReadingVocabularyDto) _then) = __$ReadingVocabularyDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String term
});




}
/// @nodoc
class __$ReadingVocabularyDtoCopyWithImpl<$Res>
    implements _$ReadingVocabularyDtoCopyWith<$Res> {
  __$ReadingVocabularyDtoCopyWithImpl(this._self, this._then);

  final _ReadingVocabularyDto _self;
  final $Res Function(_ReadingVocabularyDto) _then;

/// Create a copy of ReadingVocabularyDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? term = null,}) {
  return _then(_ReadingVocabularyDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ReadingSceneDto {

 int get sceneId; int get sceneIndex; String get text; String? get illustrationUrl; List<SceneIllustrationDto> get illustrations; List<ReadingSegmentDto> get segments; ReadingInteractionDto? get interaction; bool get attemptedInSession;
/// Create a copy of ReadingSceneDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingSceneDtoCopyWith<ReadingSceneDto> get copyWith => _$ReadingSceneDtoCopyWithImpl<ReadingSceneDto>(this as ReadingSceneDto, _$identity);

  /// Serializes this ReadingSceneDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingSceneDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingSceneDto&&(identical(other.sceneId, _this.sceneId) || other.sceneId == _this.sceneId)&&(identical(other.sceneIndex, _this.sceneIndex) || other.sceneIndex == _this.sceneIndex)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.illustrationUrl, _this.illustrationUrl) || other.illustrationUrl == _this.illustrationUrl)&&const DeepCollectionEquality().equals(other.illustrations, _this.illustrations)&&const DeepCollectionEquality().equals(other.segments, _this.segments)&&(identical(other.interaction, _this.interaction) || other.interaction == _this.interaction)&&(identical(other.attemptedInSession, _this.attemptedInSession) || other.attemptedInSession == _this.attemptedInSession));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingSceneDto;
  return Object.hash(runtimeType,_this.sceneId,_this.sceneIndex,_this.text,_this.illustrationUrl,const DeepCollectionEquality().hash(_this.illustrations),const DeepCollectionEquality().hash(_this.segments),_this.interaction,_this.attemptedInSession);
}

@override
String toString() {
  final _this = this as ReadingSceneDto;
  return 'ReadingSceneDto(sceneId: ${_this.sceneId}, sceneIndex: ${_this.sceneIndex}, text: ${_this.text}, illustrationUrl: ${_this.illustrationUrl}, illustrations: ${_this.illustrations}, segments: ${_this.segments}, interaction: ${_this.interaction}, attemptedInSession: ${_this.attemptedInSession})';
}


}

/// @nodoc
abstract mixin class $ReadingSceneDtoCopyWith<$Res>  {
  factory $ReadingSceneDtoCopyWith(ReadingSceneDto value, $Res Function(ReadingSceneDto) _then) = _$ReadingSceneDtoCopyWithImpl;
@useResult
$Res call({
 int sceneId, int sceneIndex, String text, String? illustrationUrl, List<SceneIllustrationDto> illustrations, List<ReadingSegmentDto> segments, ReadingInteractionDto? interaction, bool attemptedInSession
});


$ReadingInteractionDtoCopyWith<$Res>? get interaction;

}
/// @nodoc
class _$ReadingSceneDtoCopyWithImpl<$Res>
    implements $ReadingSceneDtoCopyWith<$Res> {
  _$ReadingSceneDtoCopyWithImpl(this._self, this._then);

  final ReadingSceneDto _self;
  final $Res Function(ReadingSceneDto) _then;

/// Create a copy of ReadingSceneDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sceneId = null,Object? sceneIndex = null,Object? text = null,Object? illustrationUrl = freezed,Object? illustrations = null,Object? segments = null,Object? interaction = freezed,Object? attemptedInSession = null,}) {
  return _then(ReadingSceneDto(
sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as int,sceneIndex: null == sceneIndex ? _self.sceneIndex : sceneIndex // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,illustrationUrl: freezed == illustrationUrl ? _self.illustrationUrl : illustrationUrl // ignore: cast_nullable_to_non_nullable
as String?,illustrations: null == illustrations ? _self.illustrations : illustrations // ignore: cast_nullable_to_non_nullable
as List<SceneIllustrationDto>,segments: null == segments ? _self.segments : segments // ignore: cast_nullable_to_non_nullable
as List<ReadingSegmentDto>,interaction: freezed == interaction ? _self.interaction : interaction // ignore: cast_nullable_to_non_nullable
as ReadingInteractionDto?,attemptedInSession: null == attemptedInSession ? _self.attemptedInSession : attemptedInSession // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ReadingSceneDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReadingInteractionDtoCopyWith<$Res>? get interaction {
    if (_self.interaction == null) {
    return null;
  }

  return $ReadingInteractionDtoCopyWith<$Res>(_self.interaction!, (value) {
    return _then(_self.copyWith(interaction: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReadingSceneDto].
extension ReadingSceneDtoPatterns on ReadingSceneDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingSceneDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingSceneDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingSceneDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadingSceneDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingSceneDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingSceneDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sceneId,  int sceneIndex,  String text,  String? illustrationUrl,  List<SceneIllustrationDto> illustrations,  List<ReadingSegmentDto> segments,  ReadingInteractionDto? interaction,  bool attemptedInSession)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingSceneDto() when $default != null:
return $default(_that.sceneId,_that.sceneIndex,_that.text,_that.illustrationUrl,_that.illustrations,_that.segments,_that.interaction,_that.attemptedInSession);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sceneId,  int sceneIndex,  String text,  String? illustrationUrl,  List<SceneIllustrationDto> illustrations,  List<ReadingSegmentDto> segments,  ReadingInteractionDto? interaction,  bool attemptedInSession)  $default,) {final _that = this;
switch (_that) {
case _ReadingSceneDto():
return $default(_that.sceneId,_that.sceneIndex,_that.text,_that.illustrationUrl,_that.illustrations,_that.segments,_that.interaction,_that.attemptedInSession);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sceneId,  int sceneIndex,  String text,  String? illustrationUrl,  List<SceneIllustrationDto> illustrations,  List<ReadingSegmentDto> segments,  ReadingInteractionDto? interaction,  bool attemptedInSession)?  $default,) {final _that = this;
switch (_that) {
case _ReadingSceneDto() when $default != null:
return $default(_that.sceneId,_that.sceneIndex,_that.text,_that.illustrationUrl,_that.illustrations,_that.segments,_that.interaction,_that.attemptedInSession);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingSceneDto implements ReadingSceneDto {
  const _ReadingSceneDto({required this.sceneId, required this.sceneIndex, this.text = '', this.illustrationUrl,  List<SceneIllustrationDto> illustrations = const <SceneIllustrationDto>[],  List<ReadingSegmentDto> segments = const <ReadingSegmentDto>[], this.interaction, this.attemptedInSession = false}): _illustrations = illustrations,_segments = segments;
  factory _ReadingSceneDto.fromJson(Map<String, dynamic> json) => _$ReadingSceneDtoFromJson(json);

@override final  int sceneId;
@override final  int sceneIndex;
@override@JsonKey() final  String text;
@override final  String? illustrationUrl;
 final  List<SceneIllustrationDto> _illustrations;
@override@JsonKey() List<SceneIllustrationDto> get illustrations {
  if (_illustrations is EqualUnmodifiableListView) return _illustrations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_illustrations);
}

 final  List<ReadingSegmentDto> _segments;
@override@JsonKey() List<ReadingSegmentDto> get segments {
  if (_segments is EqualUnmodifiableListView) return _segments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_segments);
}

@override final  ReadingInteractionDto? interaction;
@override@JsonKey() final  bool attemptedInSession;

/// Create a copy of ReadingSceneDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingSceneDtoCopyWith<_ReadingSceneDto> get copyWith => __$ReadingSceneDtoCopyWithImpl<_ReadingSceneDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingSceneDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingSceneDto&&(identical(other.sceneId, sceneId) || other.sceneId == sceneId)&&(identical(other.sceneIndex, sceneIndex) || other.sceneIndex == sceneIndex)&&(identical(other.text, text) || other.text == text)&&(identical(other.illustrationUrl, illustrationUrl) || other.illustrationUrl == illustrationUrl)&&const DeepCollectionEquality().equals(other.illustrations, _illustrations)&&const DeepCollectionEquality().equals(other.segments, _segments)&&(identical(other.interaction, interaction) || other.interaction == interaction)&&(identical(other.attemptedInSession, attemptedInSession) || other.attemptedInSession == attemptedInSession));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sceneId,sceneIndex,text,illustrationUrl,const DeepCollectionEquality().hash(_illustrations),const DeepCollectionEquality().hash(_segments),interaction,attemptedInSession);
}

@override
String toString() {
    return 'ReadingSceneDto(sceneId: $sceneId, sceneIndex: $sceneIndex, text: $text, illustrationUrl: $illustrationUrl, illustrations: $illustrations, segments: $segments, interaction: $interaction, attemptedInSession: $attemptedInSession)';
}


}

/// @nodoc
abstract mixin class _$ReadingSceneDtoCopyWith<$Res> implements $ReadingSceneDtoCopyWith<$Res> {
  factory _$ReadingSceneDtoCopyWith(_ReadingSceneDto value, $Res Function(_ReadingSceneDto) _then) = __$ReadingSceneDtoCopyWithImpl;
@override @useResult
$Res call({
 int sceneId, int sceneIndex, String text, String? illustrationUrl, List<SceneIllustrationDto> illustrations, List<ReadingSegmentDto> segments, ReadingInteractionDto? interaction, bool attemptedInSession
});


@override $ReadingInteractionDtoCopyWith<$Res>? get interaction;

}
/// @nodoc
class __$ReadingSceneDtoCopyWithImpl<$Res>
    implements _$ReadingSceneDtoCopyWith<$Res> {
  __$ReadingSceneDtoCopyWithImpl(this._self, this._then);

  final _ReadingSceneDto _self;
  final $Res Function(_ReadingSceneDto) _then;

/// Create a copy of ReadingSceneDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sceneId = null,Object? sceneIndex = null,Object? text = null,Object? illustrationUrl = freezed,Object? illustrations = null,Object? segments = null,Object? interaction = freezed,Object? attemptedInSession = null,}) {
  return _then(_ReadingSceneDto(
sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as int,sceneIndex: null == sceneIndex ? _self.sceneIndex : sceneIndex // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,illustrationUrl: freezed == illustrationUrl ? _self.illustrationUrl : illustrationUrl // ignore: cast_nullable_to_non_nullable
as String?,illustrations: null == illustrations ? _self._illustrations : illustrations // ignore: cast_nullable_to_non_nullable
as List<SceneIllustrationDto>,segments: null == segments ? _self._segments : segments // ignore: cast_nullable_to_non_nullable
as List<ReadingSegmentDto>,interaction: freezed == interaction ? _self.interaction : interaction // ignore: cast_nullable_to_non_nullable
as ReadingInteractionDto?,attemptedInSession: null == attemptedInSession ? _self.attemptedInSession : attemptedInSession // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ReadingSceneDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReadingInteractionDtoCopyWith<$Res>? get interaction {
    if (_self.interaction == null) {
    return null;
  }

  return $ReadingInteractionDtoCopyWith<$Res>(_self.interaction!, (value) {
    return _then(_self.copyWith(interaction: value));
  });
}
}


/// @nodoc
mixin _$ReadingContentDto {

 int get sessionId; int get storyId; String get title; String? get lesson; bool get listenOnly; List<ReadingSceneDto> get scenes; List<ReadingVocabularyDto> get vocabulary;
/// Create a copy of ReadingContentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingContentDtoCopyWith<ReadingContentDto> get copyWith => _$ReadingContentDtoCopyWithImpl<ReadingContentDto>(this as ReadingContentDto, _$identity);

  /// Serializes this ReadingContentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingContentDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingContentDto&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.lesson, _this.lesson) || other.lesson == _this.lesson)&&(identical(other.listenOnly, _this.listenOnly) || other.listenOnly == _this.listenOnly)&&const DeepCollectionEquality().equals(other.scenes, _this.scenes)&&const DeepCollectionEquality().equals(other.vocabulary, _this.vocabulary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingContentDto;
  return Object.hash(runtimeType,_this.sessionId,_this.storyId,_this.title,_this.lesson,_this.listenOnly,const DeepCollectionEquality().hash(_this.scenes),const DeepCollectionEquality().hash(_this.vocabulary));
}

@override
String toString() {
  final _this = this as ReadingContentDto;
  return 'ReadingContentDto(sessionId: ${_this.sessionId}, storyId: ${_this.storyId}, title: ${_this.title}, lesson: ${_this.lesson}, listenOnly: ${_this.listenOnly}, scenes: ${_this.scenes}, vocabulary: ${_this.vocabulary})';
}


}

/// @nodoc
abstract mixin class $ReadingContentDtoCopyWith<$Res>  {
  factory $ReadingContentDtoCopyWith(ReadingContentDto value, $Res Function(ReadingContentDto) _then) = _$ReadingContentDtoCopyWithImpl;
@useResult
$Res call({
 int sessionId, int storyId, String title, String? lesson, bool listenOnly, List<ReadingSceneDto> scenes, List<ReadingVocabularyDto> vocabulary
});




}
/// @nodoc
class _$ReadingContentDtoCopyWithImpl<$Res>
    implements $ReadingContentDtoCopyWith<$Res> {
  _$ReadingContentDtoCopyWithImpl(this._self, this._then);

  final ReadingContentDto _self;
  final $Res Function(ReadingContentDto) _then;

/// Create a copy of ReadingContentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? storyId = null,Object? title = null,Object? lesson = freezed,Object? listenOnly = null,Object? scenes = null,Object? vocabulary = null,}) {
  return _then(ReadingContentDto(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,lesson: freezed == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as String?,listenOnly: null == listenOnly ? _self.listenOnly : listenOnly // ignore: cast_nullable_to_non_nullable
as bool,scenes: null == scenes ? _self.scenes : scenes // ignore: cast_nullable_to_non_nullable
as List<ReadingSceneDto>,vocabulary: null == vocabulary ? _self.vocabulary : vocabulary // ignore: cast_nullable_to_non_nullable
as List<ReadingVocabularyDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingContentDto].
extension ReadingContentDtoPatterns on ReadingContentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingContentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingContentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingContentDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadingContentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingContentDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingContentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionId,  int storyId,  String title,  String? lesson,  bool listenOnly,  List<ReadingSceneDto> scenes,  List<ReadingVocabularyDto> vocabulary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingContentDto() when $default != null:
return $default(_that.sessionId,_that.storyId,_that.title,_that.lesson,_that.listenOnly,_that.scenes,_that.vocabulary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionId,  int storyId,  String title,  String? lesson,  bool listenOnly,  List<ReadingSceneDto> scenes,  List<ReadingVocabularyDto> vocabulary)  $default,) {final _that = this;
switch (_that) {
case _ReadingContentDto():
return $default(_that.sessionId,_that.storyId,_that.title,_that.lesson,_that.listenOnly,_that.scenes,_that.vocabulary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionId,  int storyId,  String title,  String? lesson,  bool listenOnly,  List<ReadingSceneDto> scenes,  List<ReadingVocabularyDto> vocabulary)?  $default,) {final _that = this;
switch (_that) {
case _ReadingContentDto() when $default != null:
return $default(_that.sessionId,_that.storyId,_that.title,_that.lesson,_that.listenOnly,_that.scenes,_that.vocabulary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingContentDto implements ReadingContentDto {
  const _ReadingContentDto({required this.sessionId, required this.storyId, this.title = '', this.lesson, this.listenOnly = false,  List<ReadingSceneDto> scenes = const <ReadingSceneDto>[],  List<ReadingVocabularyDto> vocabulary = const <ReadingVocabularyDto>[]}): _scenes = scenes,_vocabulary = vocabulary;
  factory _ReadingContentDto.fromJson(Map<String, dynamic> json) => _$ReadingContentDtoFromJson(json);

@override final  int sessionId;
@override final  int storyId;
@override@JsonKey() final  String title;
@override final  String? lesson;
@override@JsonKey() final  bool listenOnly;
 final  List<ReadingSceneDto> _scenes;
@override@JsonKey() List<ReadingSceneDto> get scenes {
  if (_scenes is EqualUnmodifiableListView) return _scenes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scenes);
}

 final  List<ReadingVocabularyDto> _vocabulary;
@override@JsonKey() List<ReadingVocabularyDto> get vocabulary {
  if (_vocabulary is EqualUnmodifiableListView) return _vocabulary;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vocabulary);
}


/// Create a copy of ReadingContentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingContentDtoCopyWith<_ReadingContentDto> get copyWith => __$ReadingContentDtoCopyWithImpl<_ReadingContentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingContentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingContentDto&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.listenOnly, listenOnly) || other.listenOnly == listenOnly)&&const DeepCollectionEquality().equals(other.scenes, _scenes)&&const DeepCollectionEquality().equals(other.vocabulary, _vocabulary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,storyId,title,lesson,listenOnly,const DeepCollectionEquality().hash(_scenes),const DeepCollectionEquality().hash(_vocabulary));
}

@override
String toString() {
    return 'ReadingContentDto(sessionId: $sessionId, storyId: $storyId, title: $title, lesson: $lesson, listenOnly: $listenOnly, scenes: $scenes, vocabulary: $vocabulary)';
}


}

/// @nodoc
abstract mixin class _$ReadingContentDtoCopyWith<$Res> implements $ReadingContentDtoCopyWith<$Res> {
  factory _$ReadingContentDtoCopyWith(_ReadingContentDto value, $Res Function(_ReadingContentDto) _then) = __$ReadingContentDtoCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, int storyId, String title, String? lesson, bool listenOnly, List<ReadingSceneDto> scenes, List<ReadingVocabularyDto> vocabulary
});




}
/// @nodoc
class __$ReadingContentDtoCopyWithImpl<$Res>
    implements _$ReadingContentDtoCopyWith<$Res> {
  __$ReadingContentDtoCopyWithImpl(this._self, this._then);

  final _ReadingContentDto _self;
  final $Res Function(_ReadingContentDto) _then;

/// Create a copy of ReadingContentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? storyId = null,Object? title = null,Object? lesson = freezed,Object? listenOnly = null,Object? scenes = null,Object? vocabulary = null,}) {
  return _then(_ReadingContentDto(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,lesson: freezed == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as String?,listenOnly: null == listenOnly ? _self.listenOnly : listenOnly // ignore: cast_nullable_to_non_nullable
as bool,scenes: null == scenes ? _self._scenes : scenes // ignore: cast_nullable_to_non_nullable
as List<ReadingSceneDto>,vocabulary: null == vocabulary ? _self._vocabulary : vocabulary // ignore: cast_nullable_to_non_nullable
as List<ReadingVocabularyDto>,
  ));
}


}

// dart format on
