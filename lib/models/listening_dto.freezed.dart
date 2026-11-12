// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listening_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListeningAttemptResultDto {

 int get interactionId; String get type; bool? get matched; String? get feedback; String? get feedbackAudioUrl; String? get suggestedAnswer; List<int> get replaySceneIndexes; bool get revealed; List<int>? get correctOrderOptionIds;
/// Create a copy of ListeningAttemptResultDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListeningAttemptResultDtoCopyWith<ListeningAttemptResultDto> get copyWith => _$ListeningAttemptResultDtoCopyWithImpl<ListeningAttemptResultDto>(this as ListeningAttemptResultDto, _$identity);

  /// Serializes this ListeningAttemptResultDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ListeningAttemptResultDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListeningAttemptResultDto&&(identical(other.interactionId, _this.interactionId) || other.interactionId == _this.interactionId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.matched, _this.matched) || other.matched == _this.matched)&&(identical(other.feedback, _this.feedback) || other.feedback == _this.feedback)&&(identical(other.feedbackAudioUrl, _this.feedbackAudioUrl) || other.feedbackAudioUrl == _this.feedbackAudioUrl)&&(identical(other.suggestedAnswer, _this.suggestedAnswer) || other.suggestedAnswer == _this.suggestedAnswer)&&const DeepCollectionEquality().equals(other.replaySceneIndexes, _this.replaySceneIndexes)&&(identical(other.revealed, _this.revealed) || other.revealed == _this.revealed)&&const DeepCollectionEquality().equals(other.correctOrderOptionIds, _this.correctOrderOptionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ListeningAttemptResultDto;
  return Object.hash(runtimeType,_this.interactionId,_this.type,_this.matched,_this.feedback,_this.feedbackAudioUrl,_this.suggestedAnswer,const DeepCollectionEquality().hash(_this.replaySceneIndexes),_this.revealed,const DeepCollectionEquality().hash(_this.correctOrderOptionIds));
}

@override
String toString() {
  final _this = this as ListeningAttemptResultDto;
  return 'ListeningAttemptResultDto(interactionId: ${_this.interactionId}, type: ${_this.type}, matched: ${_this.matched}, feedback: ${_this.feedback}, feedbackAudioUrl: ${_this.feedbackAudioUrl}, suggestedAnswer: ${_this.suggestedAnswer}, replaySceneIndexes: ${_this.replaySceneIndexes}, revealed: ${_this.revealed}, correctOrderOptionIds: ${_this.correctOrderOptionIds})';
}


}

/// @nodoc
abstract mixin class $ListeningAttemptResultDtoCopyWith<$Res>  {
  factory $ListeningAttemptResultDtoCopyWith(ListeningAttemptResultDto value, $Res Function(ListeningAttemptResultDto) _then) = _$ListeningAttemptResultDtoCopyWithImpl;
@useResult
$Res call({
 int interactionId, String type, bool? matched, String? feedback, String? feedbackAudioUrl, String? suggestedAnswer, List<int> replaySceneIndexes, bool revealed, List<int>? correctOrderOptionIds
});




}
/// @nodoc
class _$ListeningAttemptResultDtoCopyWithImpl<$Res>
    implements $ListeningAttemptResultDtoCopyWith<$Res> {
  _$ListeningAttemptResultDtoCopyWithImpl(this._self, this._then);

  final ListeningAttemptResultDto _self;
  final $Res Function(ListeningAttemptResultDto) _then;

/// Create a copy of ListeningAttemptResultDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? interactionId = null,Object? type = null,Object? matched = freezed,Object? feedback = freezed,Object? feedbackAudioUrl = freezed,Object? suggestedAnswer = freezed,Object? replaySceneIndexes = null,Object? revealed = null,Object? correctOrderOptionIds = freezed,}) {
  return _then(ListeningAttemptResultDto(
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


/// Adds pattern-matching-related methods to [ListeningAttemptResultDto].
extension ListeningAttemptResultDtoPatterns on ListeningAttemptResultDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListeningAttemptResultDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListeningAttemptResultDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListeningAttemptResultDto value)  $default,){
final _that = this;
switch (_that) {
case _ListeningAttemptResultDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListeningAttemptResultDto value)?  $default,){
final _that = this;
switch (_that) {
case _ListeningAttemptResultDto() when $default != null:
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
case _ListeningAttemptResultDto() when $default != null:
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
case _ListeningAttemptResultDto():
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
case _ListeningAttemptResultDto() when $default != null:
return $default(_that.interactionId,_that.type,_that.matched,_that.feedback,_that.feedbackAudioUrl,_that.suggestedAnswer,_that.replaySceneIndexes,_that.revealed,_that.correctOrderOptionIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListeningAttemptResultDto implements ListeningAttemptResultDto {
  const _ListeningAttemptResultDto({required this.interactionId, required this.type, this.matched, this.feedback, this.feedbackAudioUrl, this.suggestedAnswer,  List<int> replaySceneIndexes = const <int>[], this.revealed = false,  List<int>? correctOrderOptionIds}): _replaySceneIndexes = replaySceneIndexes,_correctOrderOptionIds = correctOrderOptionIds;
  factory _ListeningAttemptResultDto.fromJson(Map<String, dynamic> json) => _$ListeningAttemptResultDtoFromJson(json);

@override final  int interactionId;
@override final  String type;
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


/// Create a copy of ListeningAttemptResultDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListeningAttemptResultDtoCopyWith<_ListeningAttemptResultDto> get copyWith => __$ListeningAttemptResultDtoCopyWithImpl<_ListeningAttemptResultDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListeningAttemptResultDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListeningAttemptResultDto&&(identical(other.interactionId, interactionId) || other.interactionId == interactionId)&&(identical(other.type, type) || other.type == type)&&(identical(other.matched, matched) || other.matched == matched)&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.feedbackAudioUrl, feedbackAudioUrl) || other.feedbackAudioUrl == feedbackAudioUrl)&&(identical(other.suggestedAnswer, suggestedAnswer) || other.suggestedAnswer == suggestedAnswer)&&const DeepCollectionEquality().equals(other.replaySceneIndexes, _replaySceneIndexes)&&(identical(other.revealed, revealed) || other.revealed == revealed)&&const DeepCollectionEquality().equals(other.correctOrderOptionIds, _correctOrderOptionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,interactionId,type,matched,feedback,feedbackAudioUrl,suggestedAnswer,const DeepCollectionEquality().hash(_replaySceneIndexes),revealed,const DeepCollectionEquality().hash(_correctOrderOptionIds));
}

@override
String toString() {
    return 'ListeningAttemptResultDto(interactionId: $interactionId, type: $type, matched: $matched, feedback: $feedback, feedbackAudioUrl: $feedbackAudioUrl, suggestedAnswer: $suggestedAnswer, replaySceneIndexes: $replaySceneIndexes, revealed: $revealed, correctOrderOptionIds: $correctOrderOptionIds)';
}


}

/// @nodoc
abstract mixin class _$ListeningAttemptResultDtoCopyWith<$Res> implements $ListeningAttemptResultDtoCopyWith<$Res> {
  factory _$ListeningAttemptResultDtoCopyWith(_ListeningAttemptResultDto value, $Res Function(_ListeningAttemptResultDto) _then) = __$ListeningAttemptResultDtoCopyWithImpl;
@override @useResult
$Res call({
 int interactionId, String type, bool? matched, String? feedback, String? feedbackAudioUrl, String? suggestedAnswer, List<int> replaySceneIndexes, bool revealed, List<int>? correctOrderOptionIds
});




}
/// @nodoc
class __$ListeningAttemptResultDtoCopyWithImpl<$Res>
    implements _$ListeningAttemptResultDtoCopyWith<$Res> {
  __$ListeningAttemptResultDtoCopyWithImpl(this._self, this._then);

  final _ListeningAttemptResultDto _self;
  final $Res Function(_ListeningAttemptResultDto) _then;

/// Create a copy of ListeningAttemptResultDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? interactionId = null,Object? type = null,Object? matched = freezed,Object? feedback = freezed,Object? feedbackAudioUrl = freezed,Object? suggestedAnswer = freezed,Object? replaySceneIndexes = null,Object? revealed = null,Object? correctOrderOptionIds = freezed,}) {
  return _then(_ListeningAttemptResultDto(
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
