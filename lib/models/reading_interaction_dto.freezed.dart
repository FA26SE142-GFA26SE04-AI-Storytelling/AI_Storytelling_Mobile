// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_interaction_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InteractionOptionDto {

 int get id; String get text; String? get imageUrl; String? get audioUrl; String? get feedback; String? get feedbackAudioUrl;
/// Create a copy of InteractionOptionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InteractionOptionDtoCopyWith<InteractionOptionDto> get copyWith => _$InteractionOptionDtoCopyWithImpl<InteractionOptionDto>(this as InteractionOptionDto, _$identity);

  /// Serializes this InteractionOptionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InteractionOptionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InteractionOptionDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.audioUrl, _this.audioUrl) || other.audioUrl == _this.audioUrl)&&(identical(other.feedback, _this.feedback) || other.feedback == _this.feedback)&&(identical(other.feedbackAudioUrl, _this.feedbackAudioUrl) || other.feedbackAudioUrl == _this.feedbackAudioUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InteractionOptionDto;
  return Object.hash(runtimeType,_this.id,_this.text,_this.imageUrl,_this.audioUrl,_this.feedback,_this.feedbackAudioUrl);
}

@override
String toString() {
  final _this = this as InteractionOptionDto;
  return 'InteractionOptionDto(id: ${_this.id}, text: ${_this.text}, imageUrl: ${_this.imageUrl}, audioUrl: ${_this.audioUrl}, feedback: ${_this.feedback}, feedbackAudioUrl: ${_this.feedbackAudioUrl})';
}


}

/// @nodoc
abstract mixin class $InteractionOptionDtoCopyWith<$Res>  {
  factory $InteractionOptionDtoCopyWith(InteractionOptionDto value, $Res Function(InteractionOptionDto) _then) = _$InteractionOptionDtoCopyWithImpl;
@useResult
$Res call({
 int id, String text, String? imageUrl, String? audioUrl, String? feedback, String? feedbackAudioUrl
});




}
/// @nodoc
class _$InteractionOptionDtoCopyWithImpl<$Res>
    implements $InteractionOptionDtoCopyWith<$Res> {
  _$InteractionOptionDtoCopyWithImpl(this._self, this._then);

  final InteractionOptionDto _self;
  final $Res Function(InteractionOptionDto) _then;

/// Create a copy of InteractionOptionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? imageUrl = freezed,Object? audioUrl = freezed,Object? feedback = freezed,Object? feedbackAudioUrl = freezed,}) {
  return _then(InteractionOptionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,feedbackAudioUrl: freezed == feedbackAudioUrl ? _self.feedbackAudioUrl : feedbackAudioUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InteractionOptionDto].
extension InteractionOptionDtoPatterns on InteractionOptionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InteractionOptionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InteractionOptionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InteractionOptionDto value)  $default,){
final _that = this;
switch (_that) {
case _InteractionOptionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InteractionOptionDto value)?  $default,){
final _that = this;
switch (_that) {
case _InteractionOptionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String text,  String? imageUrl,  String? audioUrl,  String? feedback,  String? feedbackAudioUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InteractionOptionDto() when $default != null:
return $default(_that.id,_that.text,_that.imageUrl,_that.audioUrl,_that.feedback,_that.feedbackAudioUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String text,  String? imageUrl,  String? audioUrl,  String? feedback,  String? feedbackAudioUrl)  $default,) {final _that = this;
switch (_that) {
case _InteractionOptionDto():
return $default(_that.id,_that.text,_that.imageUrl,_that.audioUrl,_that.feedback,_that.feedbackAudioUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String text,  String? imageUrl,  String? audioUrl,  String? feedback,  String? feedbackAudioUrl)?  $default,) {final _that = this;
switch (_that) {
case _InteractionOptionDto() when $default != null:
return $default(_that.id,_that.text,_that.imageUrl,_that.audioUrl,_that.feedback,_that.feedbackAudioUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InteractionOptionDto implements InteractionOptionDto {
  const _InteractionOptionDto({required this.id, required this.text, this.imageUrl, this.audioUrl, this.feedback, this.feedbackAudioUrl});
  factory _InteractionOptionDto.fromJson(Map<String, dynamic> json) => _$InteractionOptionDtoFromJson(json);

@override final  int id;
@override final  String text;
@override final  String? imageUrl;
@override final  String? audioUrl;
@override final  String? feedback;
@override final  String? feedbackAudioUrl;

/// Create a copy of InteractionOptionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InteractionOptionDtoCopyWith<_InteractionOptionDto> get copyWith => __$InteractionOptionDtoCopyWithImpl<_InteractionOptionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InteractionOptionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InteractionOptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.feedbackAudioUrl, feedbackAudioUrl) || other.feedbackAudioUrl == feedbackAudioUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,text,imageUrl,audioUrl,feedback,feedbackAudioUrl);
}

@override
String toString() {
    return 'InteractionOptionDto(id: $id, text: $text, imageUrl: $imageUrl, audioUrl: $audioUrl, feedback: $feedback, feedbackAudioUrl: $feedbackAudioUrl)';
}


}

/// @nodoc
abstract mixin class _$InteractionOptionDtoCopyWith<$Res> implements $InteractionOptionDtoCopyWith<$Res> {
  factory _$InteractionOptionDtoCopyWith(_InteractionOptionDto value, $Res Function(_InteractionOptionDto) _then) = __$InteractionOptionDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String text, String? imageUrl, String? audioUrl, String? feedback, String? feedbackAudioUrl
});




}
/// @nodoc
class __$InteractionOptionDtoCopyWithImpl<$Res>
    implements _$InteractionOptionDtoCopyWith<$Res> {
  __$InteractionOptionDtoCopyWithImpl(this._self, this._then);

  final _InteractionOptionDto _self;
  final $Res Function(_InteractionOptionDto) _then;

/// Create a copy of InteractionOptionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? imageUrl = freezed,Object? audioUrl = freezed,Object? feedback = freezed,Object? feedbackAudioUrl = freezed,}) {
  return _then(_InteractionOptionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,feedbackAudioUrl: freezed == feedbackAudioUrl ? _self.feedbackAudioUrl : feedbackAudioUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ReadingInteractionDto {

 int get id; String get type; String? get kind; String? get prompt; String? get characterName; String? get modelSentence; String? get modelAudioUrl; String? get maskedSentence; String? get hint; String? get waitFeedback; int? get revealSceneIndex; Map<String, String> get audioUrls; List<InteractionOptionDto> get options;
/// Create a copy of ReadingInteractionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingInteractionDtoCopyWith<ReadingInteractionDto> get copyWith => _$ReadingInteractionDtoCopyWithImpl<ReadingInteractionDto>(this as ReadingInteractionDto, _$identity);

  /// Serializes this ReadingInteractionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingInteractionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingInteractionDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&(identical(other.characterName, _this.characterName) || other.characterName == _this.characterName)&&(identical(other.modelSentence, _this.modelSentence) || other.modelSentence == _this.modelSentence)&&(identical(other.modelAudioUrl, _this.modelAudioUrl) || other.modelAudioUrl == _this.modelAudioUrl)&&(identical(other.maskedSentence, _this.maskedSentence) || other.maskedSentence == _this.maskedSentence)&&(identical(other.hint, _this.hint) || other.hint == _this.hint)&&(identical(other.waitFeedback, _this.waitFeedback) || other.waitFeedback == _this.waitFeedback)&&(identical(other.revealSceneIndex, _this.revealSceneIndex) || other.revealSceneIndex == _this.revealSceneIndex)&&const DeepCollectionEquality().equals(other.audioUrls, _this.audioUrls)&&const DeepCollectionEquality().equals(other.options, _this.options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingInteractionDto;
  return Object.hash(runtimeType,_this.id,_this.type,_this.kind,_this.prompt,_this.characterName,_this.modelSentence,_this.modelAudioUrl,_this.maskedSentence,_this.hint,_this.waitFeedback,_this.revealSceneIndex,const DeepCollectionEquality().hash(_this.audioUrls),const DeepCollectionEquality().hash(_this.options));
}

@override
String toString() {
  final _this = this as ReadingInteractionDto;
  return 'ReadingInteractionDto(id: ${_this.id}, type: ${_this.type}, kind: ${_this.kind}, prompt: ${_this.prompt}, characterName: ${_this.characterName}, modelSentence: ${_this.modelSentence}, modelAudioUrl: ${_this.modelAudioUrl}, maskedSentence: ${_this.maskedSentence}, hint: ${_this.hint}, waitFeedback: ${_this.waitFeedback}, revealSceneIndex: ${_this.revealSceneIndex}, audioUrls: ${_this.audioUrls}, options: ${_this.options})';
}


}

/// @nodoc
abstract mixin class $ReadingInteractionDtoCopyWith<$Res>  {
  factory $ReadingInteractionDtoCopyWith(ReadingInteractionDto value, $Res Function(ReadingInteractionDto) _then) = _$ReadingInteractionDtoCopyWithImpl;
@useResult
$Res call({
 int id, String type, String? kind, String? prompt, String? characterName, String? modelSentence, String? modelAudioUrl, String? maskedSentence, String? hint, String? waitFeedback, int? revealSceneIndex, Map<String, String> audioUrls, List<InteractionOptionDto> options
});




}
/// @nodoc
class _$ReadingInteractionDtoCopyWithImpl<$Res>
    implements $ReadingInteractionDtoCopyWith<$Res> {
  _$ReadingInteractionDtoCopyWithImpl(this._self, this._then);

  final ReadingInteractionDto _self;
  final $Res Function(ReadingInteractionDto) _then;

/// Create a copy of ReadingInteractionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? kind = freezed,Object? prompt = freezed,Object? characterName = freezed,Object? modelSentence = freezed,Object? modelAudioUrl = freezed,Object? maskedSentence = freezed,Object? hint = freezed,Object? waitFeedback = freezed,Object? revealSceneIndex = freezed,Object? audioUrls = null,Object? options = null,}) {
  return _then(ReadingInteractionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,kind: freezed == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String?,prompt: freezed == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String?,characterName: freezed == characterName ? _self.characterName : characterName // ignore: cast_nullable_to_non_nullable
as String?,modelSentence: freezed == modelSentence ? _self.modelSentence : modelSentence // ignore: cast_nullable_to_non_nullable
as String?,modelAudioUrl: freezed == modelAudioUrl ? _self.modelAudioUrl : modelAudioUrl // ignore: cast_nullable_to_non_nullable
as String?,maskedSentence: freezed == maskedSentence ? _self.maskedSentence : maskedSentence // ignore: cast_nullable_to_non_nullable
as String?,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,waitFeedback: freezed == waitFeedback ? _self.waitFeedback : waitFeedback // ignore: cast_nullable_to_non_nullable
as String?,revealSceneIndex: freezed == revealSceneIndex ? _self.revealSceneIndex : revealSceneIndex // ignore: cast_nullable_to_non_nullable
as int?,audioUrls: null == audioUrls ? _self.audioUrls : audioUrls // ignore: cast_nullable_to_non_nullable
as Map<String, String>,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<InteractionOptionDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingInteractionDto].
extension ReadingInteractionDtoPatterns on ReadingInteractionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingInteractionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingInteractionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingInteractionDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadingInteractionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingInteractionDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingInteractionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type,  String? kind,  String? prompt,  String? characterName,  String? modelSentence,  String? modelAudioUrl,  String? maskedSentence,  String? hint,  String? waitFeedback,  int? revealSceneIndex,  Map<String, String> audioUrls,  List<InteractionOptionDto> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingInteractionDto() when $default != null:
return $default(_that.id,_that.type,_that.kind,_that.prompt,_that.characterName,_that.modelSentence,_that.modelAudioUrl,_that.maskedSentence,_that.hint,_that.waitFeedback,_that.revealSceneIndex,_that.audioUrls,_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type,  String? kind,  String? prompt,  String? characterName,  String? modelSentence,  String? modelAudioUrl,  String? maskedSentence,  String? hint,  String? waitFeedback,  int? revealSceneIndex,  Map<String, String> audioUrls,  List<InteractionOptionDto> options)  $default,) {final _that = this;
switch (_that) {
case _ReadingInteractionDto():
return $default(_that.id,_that.type,_that.kind,_that.prompt,_that.characterName,_that.modelSentence,_that.modelAudioUrl,_that.maskedSentence,_that.hint,_that.waitFeedback,_that.revealSceneIndex,_that.audioUrls,_that.options);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type,  String? kind,  String? prompt,  String? characterName,  String? modelSentence,  String? modelAudioUrl,  String? maskedSentence,  String? hint,  String? waitFeedback,  int? revealSceneIndex,  Map<String, String> audioUrls,  List<InteractionOptionDto> options)?  $default,) {final _that = this;
switch (_that) {
case _ReadingInteractionDto() when $default != null:
return $default(_that.id,_that.type,_that.kind,_that.prompt,_that.characterName,_that.modelSentence,_that.modelAudioUrl,_that.maskedSentence,_that.hint,_that.waitFeedback,_that.revealSceneIndex,_that.audioUrls,_that.options);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingInteractionDto implements ReadingInteractionDto {
  const _ReadingInteractionDto({required this.id, required this.type, this.kind, this.prompt, this.characterName, this.modelSentence, this.modelAudioUrl, this.maskedSentence, this.hint, this.waitFeedback, this.revealSceneIndex,  Map<String, String> audioUrls = const <String, String>{},  List<InteractionOptionDto> options = const <InteractionOptionDto>[]}): _audioUrls = audioUrls,_options = options;
  factory _ReadingInteractionDto.fromJson(Map<String, dynamic> json) => _$ReadingInteractionDtoFromJson(json);

@override final  int id;
@override final  String type;
@override final  String? kind;
@override final  String? prompt;
@override final  String? characterName;
@override final  String? modelSentence;
@override final  String? modelAudioUrl;
@override final  String? maskedSentence;
@override final  String? hint;
@override final  String? waitFeedback;
@override final  int? revealSceneIndex;
 final  Map<String, String> _audioUrls;
@override@JsonKey() Map<String, String> get audioUrls {
  if (_audioUrls is EqualUnmodifiableMapView) return _audioUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_audioUrls);
}

 final  List<InteractionOptionDto> _options;
@override@JsonKey() List<InteractionOptionDto> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of ReadingInteractionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingInteractionDtoCopyWith<_ReadingInteractionDto> get copyWith => __$ReadingInteractionDtoCopyWithImpl<_ReadingInteractionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingInteractionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingInteractionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.characterName, characterName) || other.characterName == characterName)&&(identical(other.modelSentence, modelSentence) || other.modelSentence == modelSentence)&&(identical(other.modelAudioUrl, modelAudioUrl) || other.modelAudioUrl == modelAudioUrl)&&(identical(other.maskedSentence, maskedSentence) || other.maskedSentence == maskedSentence)&&(identical(other.hint, hint) || other.hint == hint)&&(identical(other.waitFeedback, waitFeedback) || other.waitFeedback == waitFeedback)&&(identical(other.revealSceneIndex, revealSceneIndex) || other.revealSceneIndex == revealSceneIndex)&&const DeepCollectionEquality().equals(other.audioUrls, _audioUrls)&&const DeepCollectionEquality().equals(other.options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,type,kind,prompt,characterName,modelSentence,modelAudioUrl,maskedSentence,hint,waitFeedback,revealSceneIndex,const DeepCollectionEquality().hash(_audioUrls),const DeepCollectionEquality().hash(_options));
}

@override
String toString() {
    return 'ReadingInteractionDto(id: $id, type: $type, kind: $kind, prompt: $prompt, characterName: $characterName, modelSentence: $modelSentence, modelAudioUrl: $modelAudioUrl, maskedSentence: $maskedSentence, hint: $hint, waitFeedback: $waitFeedback, revealSceneIndex: $revealSceneIndex, audioUrls: $audioUrls, options: $options)';
}


}

/// @nodoc
abstract mixin class _$ReadingInteractionDtoCopyWith<$Res> implements $ReadingInteractionDtoCopyWith<$Res> {
  factory _$ReadingInteractionDtoCopyWith(_ReadingInteractionDto value, $Res Function(_ReadingInteractionDto) _then) = __$ReadingInteractionDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String type, String? kind, String? prompt, String? characterName, String? modelSentence, String? modelAudioUrl, String? maskedSentence, String? hint, String? waitFeedback, int? revealSceneIndex, Map<String, String> audioUrls, List<InteractionOptionDto> options
});




}
/// @nodoc
class __$ReadingInteractionDtoCopyWithImpl<$Res>
    implements _$ReadingInteractionDtoCopyWith<$Res> {
  __$ReadingInteractionDtoCopyWithImpl(this._self, this._then);

  final _ReadingInteractionDto _self;
  final $Res Function(_ReadingInteractionDto) _then;

/// Create a copy of ReadingInteractionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? kind = freezed,Object? prompt = freezed,Object? characterName = freezed,Object? modelSentence = freezed,Object? modelAudioUrl = freezed,Object? maskedSentence = freezed,Object? hint = freezed,Object? waitFeedback = freezed,Object? revealSceneIndex = freezed,Object? audioUrls = null,Object? options = null,}) {
  return _then(_ReadingInteractionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,kind: freezed == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String?,prompt: freezed == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String?,characterName: freezed == characterName ? _self.characterName : characterName // ignore: cast_nullable_to_non_nullable
as String?,modelSentence: freezed == modelSentence ? _self.modelSentence : modelSentence // ignore: cast_nullable_to_non_nullable
as String?,modelAudioUrl: freezed == modelAudioUrl ? _self.modelAudioUrl : modelAudioUrl // ignore: cast_nullable_to_non_nullable
as String?,maskedSentence: freezed == maskedSentence ? _self.maskedSentence : maskedSentence // ignore: cast_nullable_to_non_nullable
as String?,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,waitFeedback: freezed == waitFeedback ? _self.waitFeedback : waitFeedback // ignore: cast_nullable_to_non_nullable
as String?,revealSceneIndex: freezed == revealSceneIndex ? _self.revealSceneIndex : revealSceneIndex // ignore: cast_nullable_to_non_nullable
as int?,audioUrls: null == audioUrls ? _self._audioUrls : audioUrls // ignore: cast_nullable_to_non_nullable
as Map<String, String>,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<InteractionOptionDto>,
  ));
}


}

// dart format on
