// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_interaction_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InteractionOption {

 int get id; String get text; String? get imageUrl; String? get audioUrl; String? get feedback; String? get feedbackAudioUrl;
/// Create a copy of InteractionOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InteractionOptionCopyWith<InteractionOption> get copyWith => _$InteractionOptionCopyWithImpl<InteractionOption>(this as InteractionOption, _$identity);

  /// Serializes this InteractionOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InteractionOption;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InteractionOption&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.audioUrl, _this.audioUrl) || other.audioUrl == _this.audioUrl)&&(identical(other.feedback, _this.feedback) || other.feedback == _this.feedback)&&(identical(other.feedbackAudioUrl, _this.feedbackAudioUrl) || other.feedbackAudioUrl == _this.feedbackAudioUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InteractionOption;
  return Object.hash(runtimeType,_this.id,_this.text,_this.imageUrl,_this.audioUrl,_this.feedback,_this.feedbackAudioUrl);
}

@override
String toString() {
  final _this = this as InteractionOption;
  return 'InteractionOption(id: ${_this.id}, text: ${_this.text}, imageUrl: ${_this.imageUrl}, audioUrl: ${_this.audioUrl}, feedback: ${_this.feedback}, feedbackAudioUrl: ${_this.feedbackAudioUrl})';
}


}

/// @nodoc
abstract mixin class $InteractionOptionCopyWith<$Res>  {
  factory $InteractionOptionCopyWith(InteractionOption value, $Res Function(InteractionOption) _then) = _$InteractionOptionCopyWithImpl;
@useResult
$Res call({
 int id, String text, String? imageUrl, String? audioUrl, String? feedback, String? feedbackAudioUrl
});




}
/// @nodoc
class _$InteractionOptionCopyWithImpl<$Res>
    implements $InteractionOptionCopyWith<$Res> {
  _$InteractionOptionCopyWithImpl(this._self, this._then);

  final InteractionOption _self;
  final $Res Function(InteractionOption) _then;

/// Create a copy of InteractionOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? imageUrl = freezed,Object? audioUrl = freezed,Object? feedback = freezed,Object? feedbackAudioUrl = freezed,}) {
  return _then(InteractionOption(
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


/// Adds pattern-matching-related methods to [InteractionOption].
extension InteractionOptionPatterns on InteractionOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InteractionOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InteractionOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InteractionOption value)  $default,){
final _that = this;
switch (_that) {
case _InteractionOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InteractionOption value)?  $default,){
final _that = this;
switch (_that) {
case _InteractionOption() when $default != null:
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
case _InteractionOption() when $default != null:
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
case _InteractionOption():
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
case _InteractionOption() when $default != null:
return $default(_that.id,_that.text,_that.imageUrl,_that.audioUrl,_that.feedback,_that.feedbackAudioUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InteractionOption implements InteractionOption {
  const _InteractionOption({required this.id, this.text = '', this.imageUrl, this.audioUrl, this.feedback, this.feedbackAudioUrl});
  factory _InteractionOption.fromJson(Map<String, dynamic> json) => _$InteractionOptionFromJson(json);

@override final  int id;
@override@JsonKey() final  String text;
@override final  String? imageUrl;
@override final  String? audioUrl;
@override final  String? feedback;
@override final  String? feedbackAudioUrl;

/// Create a copy of InteractionOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InteractionOptionCopyWith<_InteractionOption> get copyWith => __$InteractionOptionCopyWithImpl<_InteractionOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InteractionOptionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InteractionOption&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.feedbackAudioUrl, feedbackAudioUrl) || other.feedbackAudioUrl == feedbackAudioUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,text,imageUrl,audioUrl,feedback,feedbackAudioUrl);
}

@override
String toString() {
    return 'InteractionOption(id: $id, text: $text, imageUrl: $imageUrl, audioUrl: $audioUrl, feedback: $feedback, feedbackAudioUrl: $feedbackAudioUrl)';
}


}

/// @nodoc
abstract mixin class _$InteractionOptionCopyWith<$Res> implements $InteractionOptionCopyWith<$Res> {
  factory _$InteractionOptionCopyWith(_InteractionOption value, $Res Function(_InteractionOption) _then) = __$InteractionOptionCopyWithImpl;
@override @useResult
$Res call({
 int id, String text, String? imageUrl, String? audioUrl, String? feedback, String? feedbackAudioUrl
});




}
/// @nodoc
class __$InteractionOptionCopyWithImpl<$Res>
    implements _$InteractionOptionCopyWith<$Res> {
  __$InteractionOptionCopyWithImpl(this._self, this._then);

  final _InteractionOption _self;
  final $Res Function(_InteractionOption) _then;

/// Create a copy of InteractionOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? imageUrl = freezed,Object? audioUrl = freezed,Object? feedback = freezed,Object? feedbackAudioUrl = freezed,}) {
  return _then(_InteractionOption(
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
mixin _$ReadingInteraction {

 int get id; String get type; String? get kind; String? get prompt; String? get characterName; String? get modelSentence; String? get modelAudioUrl; String? get maskedSentence; String? get hint; String? get waitFeedback; int? get revealSceneIndex; Map<String, String> get audioUrls; List<InteractionOption> get options;
/// Create a copy of ReadingInteraction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingInteractionCopyWith<ReadingInteraction> get copyWith => _$ReadingInteractionCopyWithImpl<ReadingInteraction>(this as ReadingInteraction, _$identity);

  /// Serializes this ReadingInteraction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingInteraction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingInteraction&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&(identical(other.characterName, _this.characterName) || other.characterName == _this.characterName)&&(identical(other.modelSentence, _this.modelSentence) || other.modelSentence == _this.modelSentence)&&(identical(other.modelAudioUrl, _this.modelAudioUrl) || other.modelAudioUrl == _this.modelAudioUrl)&&(identical(other.maskedSentence, _this.maskedSentence) || other.maskedSentence == _this.maskedSentence)&&(identical(other.hint, _this.hint) || other.hint == _this.hint)&&(identical(other.waitFeedback, _this.waitFeedback) || other.waitFeedback == _this.waitFeedback)&&(identical(other.revealSceneIndex, _this.revealSceneIndex) || other.revealSceneIndex == _this.revealSceneIndex)&&const DeepCollectionEquality().equals(other.audioUrls, _this.audioUrls)&&const DeepCollectionEquality().equals(other.options, _this.options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingInteraction;
  return Object.hash(runtimeType,_this.id,_this.type,_this.kind,_this.prompt,_this.characterName,_this.modelSentence,_this.modelAudioUrl,_this.maskedSentence,_this.hint,_this.waitFeedback,_this.revealSceneIndex,const DeepCollectionEquality().hash(_this.audioUrls),const DeepCollectionEquality().hash(_this.options));
}

@override
String toString() {
  final _this = this as ReadingInteraction;
  return 'ReadingInteraction(id: ${_this.id}, type: ${_this.type}, kind: ${_this.kind}, prompt: ${_this.prompt}, characterName: ${_this.characterName}, modelSentence: ${_this.modelSentence}, modelAudioUrl: ${_this.modelAudioUrl}, maskedSentence: ${_this.maskedSentence}, hint: ${_this.hint}, waitFeedback: ${_this.waitFeedback}, revealSceneIndex: ${_this.revealSceneIndex}, audioUrls: ${_this.audioUrls}, options: ${_this.options})';
}


}

/// @nodoc
abstract mixin class $ReadingInteractionCopyWith<$Res>  {
  factory $ReadingInteractionCopyWith(ReadingInteraction value, $Res Function(ReadingInteraction) _then) = _$ReadingInteractionCopyWithImpl;
@useResult
$Res call({
 int id, String type, String? kind, String? prompt, String? characterName, String? modelSentence, String? modelAudioUrl, String? maskedSentence, String? hint, String? waitFeedback, int? revealSceneIndex, Map<String, String> audioUrls, List<InteractionOption> options
});




}
/// @nodoc
class _$ReadingInteractionCopyWithImpl<$Res>
    implements $ReadingInteractionCopyWith<$Res> {
  _$ReadingInteractionCopyWithImpl(this._self, this._then);

  final ReadingInteraction _self;
  final $Res Function(ReadingInteraction) _then;

/// Create a copy of ReadingInteraction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? kind = freezed,Object? prompt = freezed,Object? characterName = freezed,Object? modelSentence = freezed,Object? modelAudioUrl = freezed,Object? maskedSentence = freezed,Object? hint = freezed,Object? waitFeedback = freezed,Object? revealSceneIndex = freezed,Object? audioUrls = null,Object? options = null,}) {
  return _then(ReadingInteraction(
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
as List<InteractionOption>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingInteraction].
extension ReadingInteractionPatterns on ReadingInteraction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingInteraction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingInteraction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingInteraction value)  $default,){
final _that = this;
switch (_that) {
case _ReadingInteraction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingInteraction value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingInteraction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type,  String? kind,  String? prompt,  String? characterName,  String? modelSentence,  String? modelAudioUrl,  String? maskedSentence,  String? hint,  String? waitFeedback,  int? revealSceneIndex,  Map<String, String> audioUrls,  List<InteractionOption> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingInteraction() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type,  String? kind,  String? prompt,  String? characterName,  String? modelSentence,  String? modelAudioUrl,  String? maskedSentence,  String? hint,  String? waitFeedback,  int? revealSceneIndex,  Map<String, String> audioUrls,  List<InteractionOption> options)  $default,) {final _that = this;
switch (_that) {
case _ReadingInteraction():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type,  String? kind,  String? prompt,  String? characterName,  String? modelSentence,  String? modelAudioUrl,  String? maskedSentence,  String? hint,  String? waitFeedback,  int? revealSceneIndex,  Map<String, String> audioUrls,  List<InteractionOption> options)?  $default,) {final _that = this;
switch (_that) {
case _ReadingInteraction() when $default != null:
return $default(_that.id,_that.type,_that.kind,_that.prompt,_that.characterName,_that.modelSentence,_that.modelAudioUrl,_that.maskedSentence,_that.hint,_that.waitFeedback,_that.revealSceneIndex,_that.audioUrls,_that.options);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingInteraction implements ReadingInteraction {
  const _ReadingInteraction({required this.id, this.type = '', this.kind, this.prompt, this.characterName, this.modelSentence, this.modelAudioUrl, this.maskedSentence, this.hint, this.waitFeedback, this.revealSceneIndex,  Map<String, String> audioUrls = const <String, String>{},  List<InteractionOption> options = const <InteractionOption>[]}): _audioUrls = audioUrls,_options = options;
  factory _ReadingInteraction.fromJson(Map<String, dynamic> json) => _$ReadingInteractionFromJson(json);

@override final  int id;
@override@JsonKey() final  String type;
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

 final  List<InteractionOption> _options;
@override@JsonKey() List<InteractionOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of ReadingInteraction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingInteractionCopyWith<_ReadingInteraction> get copyWith => __$ReadingInteractionCopyWithImpl<_ReadingInteraction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingInteractionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingInteraction&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.characterName, characterName) || other.characterName == characterName)&&(identical(other.modelSentence, modelSentence) || other.modelSentence == modelSentence)&&(identical(other.modelAudioUrl, modelAudioUrl) || other.modelAudioUrl == modelAudioUrl)&&(identical(other.maskedSentence, maskedSentence) || other.maskedSentence == maskedSentence)&&(identical(other.hint, hint) || other.hint == hint)&&(identical(other.waitFeedback, waitFeedback) || other.waitFeedback == waitFeedback)&&(identical(other.revealSceneIndex, revealSceneIndex) || other.revealSceneIndex == revealSceneIndex)&&const DeepCollectionEquality().equals(other.audioUrls, _audioUrls)&&const DeepCollectionEquality().equals(other.options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,type,kind,prompt,characterName,modelSentence,modelAudioUrl,maskedSentence,hint,waitFeedback,revealSceneIndex,const DeepCollectionEquality().hash(_audioUrls),const DeepCollectionEquality().hash(_options));
}

@override
String toString() {
    return 'ReadingInteraction(id: $id, type: $type, kind: $kind, prompt: $prompt, characterName: $characterName, modelSentence: $modelSentence, modelAudioUrl: $modelAudioUrl, maskedSentence: $maskedSentence, hint: $hint, waitFeedback: $waitFeedback, revealSceneIndex: $revealSceneIndex, audioUrls: $audioUrls, options: $options)';
}


}

/// @nodoc
abstract mixin class _$ReadingInteractionCopyWith<$Res> implements $ReadingInteractionCopyWith<$Res> {
  factory _$ReadingInteractionCopyWith(_ReadingInteraction value, $Res Function(_ReadingInteraction) _then) = __$ReadingInteractionCopyWithImpl;
@override @useResult
$Res call({
 int id, String type, String? kind, String? prompt, String? characterName, String? modelSentence, String? modelAudioUrl, String? maskedSentence, String? hint, String? waitFeedback, int? revealSceneIndex, Map<String, String> audioUrls, List<InteractionOption> options
});




}
/// @nodoc
class __$ReadingInteractionCopyWithImpl<$Res>
    implements _$ReadingInteractionCopyWith<$Res> {
  __$ReadingInteractionCopyWithImpl(this._self, this._then);

  final _ReadingInteraction _self;
  final $Res Function(_ReadingInteraction) _then;

/// Create a copy of ReadingInteraction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? kind = freezed,Object? prompt = freezed,Object? characterName = freezed,Object? modelSentence = freezed,Object? modelAudioUrl = freezed,Object? maskedSentence = freezed,Object? hint = freezed,Object? waitFeedback = freezed,Object? revealSceneIndex = freezed,Object? audioUrls = null,Object? options = null,}) {
  return _then(_ReadingInteraction(
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
as List<InteractionOption>,
  ));
}


}


/// @nodoc
mixin _$ListeningAttemptResult {

 int get interactionId; String get type; bool? get matched; String? get feedback; String? get feedbackAudioUrl; String? get suggestedAnswer; List<int> get replaySceneIndexes; bool get revealed; List<int>? get correctOrderOptionIds;
/// Create a copy of ListeningAttemptResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListeningAttemptResultCopyWith<ListeningAttemptResult> get copyWith => _$ListeningAttemptResultCopyWithImpl<ListeningAttemptResult>(this as ListeningAttemptResult, _$identity);

  /// Serializes this ListeningAttemptResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ListeningAttemptResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListeningAttemptResult&&(identical(other.interactionId, _this.interactionId) || other.interactionId == _this.interactionId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.matched, _this.matched) || other.matched == _this.matched)&&(identical(other.feedback, _this.feedback) || other.feedback == _this.feedback)&&(identical(other.feedbackAudioUrl, _this.feedbackAudioUrl) || other.feedbackAudioUrl == _this.feedbackAudioUrl)&&(identical(other.suggestedAnswer, _this.suggestedAnswer) || other.suggestedAnswer == _this.suggestedAnswer)&&const DeepCollectionEquality().equals(other.replaySceneIndexes, _this.replaySceneIndexes)&&(identical(other.revealed, _this.revealed) || other.revealed == _this.revealed)&&const DeepCollectionEquality().equals(other.correctOrderOptionIds, _this.correctOrderOptionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ListeningAttemptResult;
  return Object.hash(runtimeType,_this.interactionId,_this.type,_this.matched,_this.feedback,_this.feedbackAudioUrl,_this.suggestedAnswer,const DeepCollectionEquality().hash(_this.replaySceneIndexes),_this.revealed,const DeepCollectionEquality().hash(_this.correctOrderOptionIds));
}

@override
String toString() {
  final _this = this as ListeningAttemptResult;
  return 'ListeningAttemptResult(interactionId: ${_this.interactionId}, type: ${_this.type}, matched: ${_this.matched}, feedback: ${_this.feedback}, feedbackAudioUrl: ${_this.feedbackAudioUrl}, suggestedAnswer: ${_this.suggestedAnswer}, replaySceneIndexes: ${_this.replaySceneIndexes}, revealed: ${_this.revealed}, correctOrderOptionIds: ${_this.correctOrderOptionIds})';
}


}

/// @nodoc
abstract mixin class $ListeningAttemptResultCopyWith<$Res>  {
  factory $ListeningAttemptResultCopyWith(ListeningAttemptResult value, $Res Function(ListeningAttemptResult) _then) = _$ListeningAttemptResultCopyWithImpl;
@useResult
$Res call({
 int interactionId, String type, bool? matched, String? feedback, String? feedbackAudioUrl, String? suggestedAnswer, List<int> replaySceneIndexes, bool revealed, List<int>? correctOrderOptionIds
});




}
/// @nodoc
class _$ListeningAttemptResultCopyWithImpl<$Res>
    implements $ListeningAttemptResultCopyWith<$Res> {
  _$ListeningAttemptResultCopyWithImpl(this._self, this._then);

  final ListeningAttemptResult _self;
  final $Res Function(ListeningAttemptResult) _then;

/// Create a copy of ListeningAttemptResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? interactionId = null,Object? type = null,Object? matched = freezed,Object? feedback = freezed,Object? feedbackAudioUrl = freezed,Object? suggestedAnswer = freezed,Object? replaySceneIndexes = null,Object? revealed = null,Object? correctOrderOptionIds = freezed,}) {
  return _then(ListeningAttemptResult(
interactionId: null == interactionId ? _self.interactionId : interactionId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,matched: freezed == matched ? _self.matched : matched // ignore: cast_nullable_to_non_nullable
as bool?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,feedbackAudioUrl: freezed == feedbackAudioUrl ? _self.feedbackAudioUrl : feedbackAudioUrl // ignore: cast_nullable_to_non_nullable
as String?,suggestedAnswer: freezed == suggestedAnswer ? _self.suggestedAnswer : suggestedAnswer // ignore: cast_nullable_to_non_nullable
as String?,replaySceneIndexes: null == replaySceneIndexes ? _self.replaySceneIndexes : replaySceneIndexes // ignore: cast_nullable_to_non_nullable
as List<int>,revealed: null == revealed ? _self.revealed : revealed // ignore: cast_nullable_to_non_nullable
as bool,correctOrderOptionIds: freezed == correctOrderOptionIds ? _self.correctOrderOptionIds : correctOrderOptionIds // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ListeningAttemptResult].
extension ListeningAttemptResultPatterns on ListeningAttemptResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListeningAttemptResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListeningAttemptResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListeningAttemptResult value)  $default,){
final _that = this;
switch (_that) {
case _ListeningAttemptResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListeningAttemptResult value)?  $default,){
final _that = this;
switch (_that) {
case _ListeningAttemptResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int interactionId,  String type,  bool? matched,  String? feedback,  String? feedbackAudioUrl,  String? suggestedAnswer,  List<int> replaySceneIndexes,  bool revealed,  List<int>? correctOrderOptionIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListeningAttemptResult() when $default != null:
return $default(_that.interactionId,_that.type,_that.matched,_that.feedback,_that.feedbackAudioUrl,_that.suggestedAnswer,_that.replaySceneIndexes,_that.revealed,_that.correctOrderOptionIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int interactionId,  String type,  bool? matched,  String? feedback,  String? feedbackAudioUrl,  String? suggestedAnswer,  List<int> replaySceneIndexes,  bool revealed,  List<int>? correctOrderOptionIds)  $default,) {final _that = this;
switch (_that) {
case _ListeningAttemptResult():
return $default(_that.interactionId,_that.type,_that.matched,_that.feedback,_that.feedbackAudioUrl,_that.suggestedAnswer,_that.replaySceneIndexes,_that.revealed,_that.correctOrderOptionIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int interactionId,  String type,  bool? matched,  String? feedback,  String? feedbackAudioUrl,  String? suggestedAnswer,  List<int> replaySceneIndexes,  bool revealed,  List<int>? correctOrderOptionIds)?  $default,) {final _that = this;
switch (_that) {
case _ListeningAttemptResult() when $default != null:
return $default(_that.interactionId,_that.type,_that.matched,_that.feedback,_that.feedbackAudioUrl,_that.suggestedAnswer,_that.replaySceneIndexes,_that.revealed,_that.correctOrderOptionIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListeningAttemptResult implements ListeningAttemptResult {
  const _ListeningAttemptResult({required this.interactionId, this.type = '', this.matched, this.feedback, this.feedbackAudioUrl, this.suggestedAnswer,  List<int> replaySceneIndexes = const <int>[], this.revealed = false,  List<int>? correctOrderOptionIds}): _replaySceneIndexes = replaySceneIndexes,_correctOrderOptionIds = correctOrderOptionIds;
  factory _ListeningAttemptResult.fromJson(Map<String, dynamic> json) => _$ListeningAttemptResultFromJson(json);

@override final  int interactionId;
@override@JsonKey() final  String type;
@override final  bool? matched;
@override final  String? feedback;
@override final  String? feedbackAudioUrl;
@override final  String? suggestedAnswer;
 final  List<int> _replaySceneIndexes;
@override@JsonKey() List<int> get replaySceneIndexes {
  if (_replaySceneIndexes is EqualUnmodifiableListView) return _replaySceneIndexes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replaySceneIndexes);
}

@override@JsonKey() final  bool revealed;
 final  List<int>? _correctOrderOptionIds;
@override List<int>? get correctOrderOptionIds {
  final value = _correctOrderOptionIds;
  if (value == null) return null;
  if (_correctOrderOptionIds is EqualUnmodifiableListView) return _correctOrderOptionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ListeningAttemptResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListeningAttemptResultCopyWith<_ListeningAttemptResult> get copyWith => __$ListeningAttemptResultCopyWithImpl<_ListeningAttemptResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListeningAttemptResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListeningAttemptResult&&(identical(other.interactionId, interactionId) || other.interactionId == interactionId)&&(identical(other.type, type) || other.type == type)&&(identical(other.matched, matched) || other.matched == matched)&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.feedbackAudioUrl, feedbackAudioUrl) || other.feedbackAudioUrl == feedbackAudioUrl)&&(identical(other.suggestedAnswer, suggestedAnswer) || other.suggestedAnswer == suggestedAnswer)&&const DeepCollectionEquality().equals(other.replaySceneIndexes, _replaySceneIndexes)&&(identical(other.revealed, revealed) || other.revealed == revealed)&&const DeepCollectionEquality().equals(other.correctOrderOptionIds, _correctOrderOptionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,interactionId,type,matched,feedback,feedbackAudioUrl,suggestedAnswer,const DeepCollectionEquality().hash(_replaySceneIndexes),revealed,const DeepCollectionEquality().hash(_correctOrderOptionIds));
}

@override
String toString() {
    return 'ListeningAttemptResult(interactionId: $interactionId, type: $type, matched: $matched, feedback: $feedback, feedbackAudioUrl: $feedbackAudioUrl, suggestedAnswer: $suggestedAnswer, replaySceneIndexes: $replaySceneIndexes, revealed: $revealed, correctOrderOptionIds: $correctOrderOptionIds)';
}


}

/// @nodoc
abstract mixin class _$ListeningAttemptResultCopyWith<$Res> implements $ListeningAttemptResultCopyWith<$Res> {
  factory _$ListeningAttemptResultCopyWith(_ListeningAttemptResult value, $Res Function(_ListeningAttemptResult) _then) = __$ListeningAttemptResultCopyWithImpl;
@override @useResult
$Res call({
 int interactionId, String type, bool? matched, String? feedback, String? feedbackAudioUrl, String? suggestedAnswer, List<int> replaySceneIndexes, bool revealed, List<int>? correctOrderOptionIds
});




}
/// @nodoc
class __$ListeningAttemptResultCopyWithImpl<$Res>
    implements _$ListeningAttemptResultCopyWith<$Res> {
  __$ListeningAttemptResultCopyWithImpl(this._self, this._then);

  final _ListeningAttemptResult _self;
  final $Res Function(_ListeningAttemptResult) _then;

/// Create a copy of ListeningAttemptResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? interactionId = null,Object? type = null,Object? matched = freezed,Object? feedback = freezed,Object? feedbackAudioUrl = freezed,Object? suggestedAnswer = freezed,Object? replaySceneIndexes = null,Object? revealed = null,Object? correctOrderOptionIds = freezed,}) {
  return _then(_ListeningAttemptResult(
interactionId: null == interactionId ? _self.interactionId : interactionId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,matched: freezed == matched ? _self.matched : matched // ignore: cast_nullable_to_non_nullable
as bool?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,feedbackAudioUrl: freezed == feedbackAudioUrl ? _self.feedbackAudioUrl : feedbackAudioUrl // ignore: cast_nullable_to_non_nullable
as String?,suggestedAnswer: freezed == suggestedAnswer ? _self.suggestedAnswer : suggestedAnswer // ignore: cast_nullable_to_non_nullable
as String?,replaySceneIndexes: null == replaySceneIndexes ? _self._replaySceneIndexes : replaySceneIndexes // ignore: cast_nullable_to_non_nullable
as List<int>,revealed: null == revealed ? _self.revealed : revealed // ignore: cast_nullable_to_non_nullable
as bool,correctOrderOptionIds: freezed == correctOrderOptionIds ? _self._correctOrderOptionIds : correctOrderOptionIds // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}


}

// dart format on
