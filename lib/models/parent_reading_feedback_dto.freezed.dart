// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parent_reading_feedback_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ParentReadingFeedbackItemDto {

 int get sessionId; int get storyId; String get title; DateTime? get completedAt; String? get feeling; String? get feelingLabel; int get quizTotalQuestions; double? get quizBestPercent;/// Câu bé trả lời ở các điểm dừng cảm xúc/cảm nhận trong lần đọc này.
 List<ConversationAnswerDto> get conversationAnswers;
/// Create a copy of ParentReadingFeedbackItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentReadingFeedbackItemDtoCopyWith<ParentReadingFeedbackItemDto> get copyWith => _$ParentReadingFeedbackItemDtoCopyWithImpl<ParentReadingFeedbackItemDto>(this as ParentReadingFeedbackItemDto, _$identity);

  /// Serializes this ParentReadingFeedbackItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ParentReadingFeedbackItemDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentReadingFeedbackItemDto&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt)&&(identical(other.feeling, _this.feeling) || other.feeling == _this.feeling)&&(identical(other.feelingLabel, _this.feelingLabel) || other.feelingLabel == _this.feelingLabel)&&(identical(other.quizTotalQuestions, _this.quizTotalQuestions) || other.quizTotalQuestions == _this.quizTotalQuestions)&&(identical(other.quizBestPercent, _this.quizBestPercent) || other.quizBestPercent == _this.quizBestPercent)&&const DeepCollectionEquality().equals(other.conversationAnswers, _this.conversationAnswers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParentReadingFeedbackItemDto;
  return Object.hash(runtimeType,_this.sessionId,_this.storyId,_this.title,_this.completedAt,_this.feeling,_this.feelingLabel,_this.quizTotalQuestions,_this.quizBestPercent,const DeepCollectionEquality().hash(_this.conversationAnswers));
}

@override
String toString() {
  final _this = this as ParentReadingFeedbackItemDto;
  return 'ParentReadingFeedbackItemDto(sessionId: ${_this.sessionId}, storyId: ${_this.storyId}, title: ${_this.title}, completedAt: ${_this.completedAt}, feeling: ${_this.feeling}, feelingLabel: ${_this.feelingLabel}, quizTotalQuestions: ${_this.quizTotalQuestions}, quizBestPercent: ${_this.quizBestPercent}, conversationAnswers: ${_this.conversationAnswers})';
}


}

/// @nodoc
abstract mixin class $ParentReadingFeedbackItemDtoCopyWith<$Res>  {
  factory $ParentReadingFeedbackItemDtoCopyWith(ParentReadingFeedbackItemDto value, $Res Function(ParentReadingFeedbackItemDto) _then) = _$ParentReadingFeedbackItemDtoCopyWithImpl;
@useResult
$Res call({
 int sessionId, int storyId, String title, DateTime? completedAt, String? feeling, String? feelingLabel, int quizTotalQuestions, double? quizBestPercent, List<ConversationAnswerDto> conversationAnswers
});




}
/// @nodoc
class _$ParentReadingFeedbackItemDtoCopyWithImpl<$Res>
    implements $ParentReadingFeedbackItemDtoCopyWith<$Res> {
  _$ParentReadingFeedbackItemDtoCopyWithImpl(this._self, this._then);

  final ParentReadingFeedbackItemDto _self;
  final $Res Function(ParentReadingFeedbackItemDto) _then;

/// Create a copy of ParentReadingFeedbackItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? storyId = null,Object? title = null,Object? completedAt = freezed,Object? feeling = freezed,Object? feelingLabel = freezed,Object? quizTotalQuestions = null,Object? quizBestPercent = freezed,Object? conversationAnswers = null,}) {
  return _then(ParentReadingFeedbackItemDto(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,feeling: freezed == feeling ? _self.feeling : feeling // ignore: cast_nullable_to_non_nullable
as String?,feelingLabel: freezed == feelingLabel ? _self.feelingLabel : feelingLabel // ignore: cast_nullable_to_non_nullable
as String?,quizTotalQuestions: null == quizTotalQuestions ? _self.quizTotalQuestions : quizTotalQuestions // ignore: cast_nullable_to_non_nullable
as int,quizBestPercent: freezed == quizBestPercent ? _self.quizBestPercent : quizBestPercent // ignore: cast_nullable_to_non_nullable
as double?,conversationAnswers: null == conversationAnswers ? _self.conversationAnswers : conversationAnswers // ignore: cast_nullable_to_non_nullable
as List<ConversationAnswerDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ParentReadingFeedbackItemDto].
extension ParentReadingFeedbackItemDtoPatterns on ParentReadingFeedbackItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParentReadingFeedbackItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParentReadingFeedbackItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParentReadingFeedbackItemDto value)  $default,){
final _that = this;
switch (_that) {
case _ParentReadingFeedbackItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParentReadingFeedbackItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _ParentReadingFeedbackItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionId,  int storyId,  String title,  DateTime? completedAt,  String? feeling,  String? feelingLabel,  int quizTotalQuestions,  double? quizBestPercent,  List<ConversationAnswerDto> conversationAnswers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParentReadingFeedbackItemDto() when $default != null:
return $default(_that.sessionId,_that.storyId,_that.title,_that.completedAt,_that.feeling,_that.feelingLabel,_that.quizTotalQuestions,_that.quizBestPercent,_that.conversationAnswers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionId,  int storyId,  String title,  DateTime? completedAt,  String? feeling,  String? feelingLabel,  int quizTotalQuestions,  double? quizBestPercent,  List<ConversationAnswerDto> conversationAnswers)  $default,) {final _that = this;
switch (_that) {
case _ParentReadingFeedbackItemDto():
return $default(_that.sessionId,_that.storyId,_that.title,_that.completedAt,_that.feeling,_that.feelingLabel,_that.quizTotalQuestions,_that.quizBestPercent,_that.conversationAnswers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionId,  int storyId,  String title,  DateTime? completedAt,  String? feeling,  String? feelingLabel,  int quizTotalQuestions,  double? quizBestPercent,  List<ConversationAnswerDto> conversationAnswers)?  $default,) {final _that = this;
switch (_that) {
case _ParentReadingFeedbackItemDto() when $default != null:
return $default(_that.sessionId,_that.storyId,_that.title,_that.completedAt,_that.feeling,_that.feelingLabel,_that.quizTotalQuestions,_that.quizBestPercent,_that.conversationAnswers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParentReadingFeedbackItemDto implements ParentReadingFeedbackItemDto {
  const _ParentReadingFeedbackItemDto({required this.sessionId, required this.storyId, required this.title, this.completedAt, this.feeling, this.feelingLabel, this.quizTotalQuestions = 0, this.quizBestPercent,  List<ConversationAnswerDto> conversationAnswers = const <ConversationAnswerDto>[]}): _conversationAnswers = conversationAnswers;
  factory _ParentReadingFeedbackItemDto.fromJson(Map<String, dynamic> json) => _$ParentReadingFeedbackItemDtoFromJson(json);

@override final  int sessionId;
@override final  int storyId;
@override final  String title;
@override final  DateTime? completedAt;
@override final  String? feeling;
@override final  String? feelingLabel;
@override@JsonKey() final  int quizTotalQuestions;
@override final  double? quizBestPercent;
/// Câu bé trả lời ở các điểm dừng cảm xúc/cảm nhận trong lần đọc này.
 final  List<ConversationAnswerDto> _conversationAnswers;
/// Câu bé trả lời ở các điểm dừng cảm xúc/cảm nhận trong lần đọc này.
@override@JsonKey() List<ConversationAnswerDto> get conversationAnswers {
  if (_conversationAnswers is EqualUnmodifiableListView) return _conversationAnswers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conversationAnswers);
}


/// Create a copy of ParentReadingFeedbackItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentReadingFeedbackItemDtoCopyWith<_ParentReadingFeedbackItemDto> get copyWith => __$ParentReadingFeedbackItemDtoCopyWithImpl<_ParentReadingFeedbackItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParentReadingFeedbackItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentReadingFeedbackItemDto&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.feeling, feeling) || other.feeling == feeling)&&(identical(other.feelingLabel, feelingLabel) || other.feelingLabel == feelingLabel)&&(identical(other.quizTotalQuestions, quizTotalQuestions) || other.quizTotalQuestions == quizTotalQuestions)&&(identical(other.quizBestPercent, quizBestPercent) || other.quizBestPercent == quizBestPercent)&&const DeepCollectionEquality().equals(other.conversationAnswers, _conversationAnswers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,storyId,title,completedAt,feeling,feelingLabel,quizTotalQuestions,quizBestPercent,const DeepCollectionEquality().hash(_conversationAnswers));
}

@override
String toString() {
    return 'ParentReadingFeedbackItemDto(sessionId: $sessionId, storyId: $storyId, title: $title, completedAt: $completedAt, feeling: $feeling, feelingLabel: $feelingLabel, quizTotalQuestions: $quizTotalQuestions, quizBestPercent: $quizBestPercent, conversationAnswers: $conversationAnswers)';
}


}

/// @nodoc
abstract mixin class _$ParentReadingFeedbackItemDtoCopyWith<$Res> implements $ParentReadingFeedbackItemDtoCopyWith<$Res> {
  factory _$ParentReadingFeedbackItemDtoCopyWith(_ParentReadingFeedbackItemDto value, $Res Function(_ParentReadingFeedbackItemDto) _then) = __$ParentReadingFeedbackItemDtoCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, int storyId, String title, DateTime? completedAt, String? feeling, String? feelingLabel, int quizTotalQuestions, double? quizBestPercent, List<ConversationAnswerDto> conversationAnswers
});




}
/// @nodoc
class __$ParentReadingFeedbackItemDtoCopyWithImpl<$Res>
    implements _$ParentReadingFeedbackItemDtoCopyWith<$Res> {
  __$ParentReadingFeedbackItemDtoCopyWithImpl(this._self, this._then);

  final _ParentReadingFeedbackItemDto _self;
  final $Res Function(_ParentReadingFeedbackItemDto) _then;

/// Create a copy of ParentReadingFeedbackItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? storyId = null,Object? title = null,Object? completedAt = freezed,Object? feeling = freezed,Object? feelingLabel = freezed,Object? quizTotalQuestions = null,Object? quizBestPercent = freezed,Object? conversationAnswers = null,}) {
  return _then(_ParentReadingFeedbackItemDto(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,feeling: freezed == feeling ? _self.feeling : feeling // ignore: cast_nullable_to_non_nullable
as String?,feelingLabel: freezed == feelingLabel ? _self.feelingLabel : feelingLabel // ignore: cast_nullable_to_non_nullable
as String?,quizTotalQuestions: null == quizTotalQuestions ? _self.quizTotalQuestions : quizTotalQuestions // ignore: cast_nullable_to_non_nullable
as int,quizBestPercent: freezed == quizBestPercent ? _self.quizBestPercent : quizBestPercent // ignore: cast_nullable_to_non_nullable
as double?,conversationAnswers: null == conversationAnswers ? _self._conversationAnswers : conversationAnswers // ignore: cast_nullable_to_non_nullable
as List<ConversationAnswerDto>,
  ));
}


}


/// @nodoc
mixin _$ConversationAnswerDto {

 String get question;/// "Emotion" hoặc "Opinion".
 String get kind; String get answerText;/// Cảnh có câu hỏi (đếm từ 0); null nếu không còn tìm thấy.
 int? get sceneIndex; DateTime? get answeredAt;
/// Create a copy of ConversationAnswerDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationAnswerDtoCopyWith<ConversationAnswerDto> get copyWith => _$ConversationAnswerDtoCopyWithImpl<ConversationAnswerDto>(this as ConversationAnswerDto, _$identity);

  /// Serializes this ConversationAnswerDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ConversationAnswerDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationAnswerDto&&(identical(other.question, _this.question) || other.question == _this.question)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.answerText, _this.answerText) || other.answerText == _this.answerText)&&(identical(other.sceneIndex, _this.sceneIndex) || other.sceneIndex == _this.sceneIndex)&&(identical(other.answeredAt, _this.answeredAt) || other.answeredAt == _this.answeredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ConversationAnswerDto;
  return Object.hash(runtimeType,_this.question,_this.kind,_this.answerText,_this.sceneIndex,_this.answeredAt);
}

@override
String toString() {
  final _this = this as ConversationAnswerDto;
  return 'ConversationAnswerDto(question: ${_this.question}, kind: ${_this.kind}, answerText: ${_this.answerText}, sceneIndex: ${_this.sceneIndex}, answeredAt: ${_this.answeredAt})';
}


}

/// @nodoc
abstract mixin class $ConversationAnswerDtoCopyWith<$Res>  {
  factory $ConversationAnswerDtoCopyWith(ConversationAnswerDto value, $Res Function(ConversationAnswerDto) _then) = _$ConversationAnswerDtoCopyWithImpl;
@useResult
$Res call({
 String question, String kind, String answerText, int? sceneIndex, DateTime? answeredAt
});




}
/// @nodoc
class _$ConversationAnswerDtoCopyWithImpl<$Res>
    implements $ConversationAnswerDtoCopyWith<$Res> {
  _$ConversationAnswerDtoCopyWithImpl(this._self, this._then);

  final ConversationAnswerDto _self;
  final $Res Function(ConversationAnswerDto) _then;

/// Create a copy of ConversationAnswerDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? kind = null,Object? answerText = null,Object? sceneIndex = freezed,Object? answeredAt = freezed,}) {
  return _then(ConversationAnswerDto(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,answerText: null == answerText ? _self.answerText : answerText // ignore: cast_nullable_to_non_nullable
as String,sceneIndex: freezed == sceneIndex ? _self.sceneIndex : sceneIndex // ignore: cast_nullable_to_non_nullable
as int?,answeredAt: freezed == answeredAt ? _self.answeredAt : answeredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConversationAnswerDto].
extension ConversationAnswerDtoPatterns on ConversationAnswerDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationAnswerDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationAnswerDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationAnswerDto value)  $default,){
final _that = this;
switch (_that) {
case _ConversationAnswerDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationAnswerDto value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationAnswerDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String question,  String kind,  String answerText,  int? sceneIndex,  DateTime? answeredAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationAnswerDto() when $default != null:
return $default(_that.question,_that.kind,_that.answerText,_that.sceneIndex,_that.answeredAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String question,  String kind,  String answerText,  int? sceneIndex,  DateTime? answeredAt)  $default,) {final _that = this;
switch (_that) {
case _ConversationAnswerDto():
return $default(_that.question,_that.kind,_that.answerText,_that.sceneIndex,_that.answeredAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String question,  String kind,  String answerText,  int? sceneIndex,  DateTime? answeredAt)?  $default,) {final _that = this;
switch (_that) {
case _ConversationAnswerDto() when $default != null:
return $default(_that.question,_that.kind,_that.answerText,_that.sceneIndex,_that.answeredAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConversationAnswerDto implements ConversationAnswerDto {
  const _ConversationAnswerDto({this.question = '', this.kind = '', this.answerText = '', this.sceneIndex, this.answeredAt});
  factory _ConversationAnswerDto.fromJson(Map<String, dynamic> json) => _$ConversationAnswerDtoFromJson(json);

@override@JsonKey() final  String question;
/// "Emotion" hoặc "Opinion".
@override@JsonKey() final  String kind;
@override@JsonKey() final  String answerText;
/// Cảnh có câu hỏi (đếm từ 0); null nếu không còn tìm thấy.
@override final  int? sceneIndex;
@override final  DateTime? answeredAt;

/// Create a copy of ConversationAnswerDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationAnswerDtoCopyWith<_ConversationAnswerDto> get copyWith => __$ConversationAnswerDtoCopyWithImpl<_ConversationAnswerDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversationAnswerDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationAnswerDto&&(identical(other.question, question) || other.question == question)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.answerText, answerText) || other.answerText == answerText)&&(identical(other.sceneIndex, sceneIndex) || other.sceneIndex == sceneIndex)&&(identical(other.answeredAt, answeredAt) || other.answeredAt == answeredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,question,kind,answerText,sceneIndex,answeredAt);
}

@override
String toString() {
    return 'ConversationAnswerDto(question: $question, kind: $kind, answerText: $answerText, sceneIndex: $sceneIndex, answeredAt: $answeredAt)';
}


}

/// @nodoc
abstract mixin class _$ConversationAnswerDtoCopyWith<$Res> implements $ConversationAnswerDtoCopyWith<$Res> {
  factory _$ConversationAnswerDtoCopyWith(_ConversationAnswerDto value, $Res Function(_ConversationAnswerDto) _then) = __$ConversationAnswerDtoCopyWithImpl;
@override @useResult
$Res call({
 String question, String kind, String answerText, int? sceneIndex, DateTime? answeredAt
});




}
/// @nodoc
class __$ConversationAnswerDtoCopyWithImpl<$Res>
    implements _$ConversationAnswerDtoCopyWith<$Res> {
  __$ConversationAnswerDtoCopyWithImpl(this._self, this._then);

  final _ConversationAnswerDto _self;
  final $Res Function(_ConversationAnswerDto) _then;

/// Create a copy of ConversationAnswerDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? kind = null,Object? answerText = null,Object? sceneIndex = freezed,Object? answeredAt = freezed,}) {
  return _then(_ConversationAnswerDto(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,answerText: null == answerText ? _self.answerText : answerText // ignore: cast_nullable_to_non_nullable
as String,sceneIndex: freezed == sceneIndex ? _self.sceneIndex : sceneIndex // ignore: cast_nullable_to_non_nullable
as int?,answeredAt: freezed == answeredAt ? _self.answeredAt : answeredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ParentReadingFeedbackPageDto {

 List<ParentReadingFeedbackItemDto> get items; int get totalCount; int get pageIndex; int get pageSize; int get totalPages; bool get hasNextPage; bool get hasPreviousPage;
/// Create a copy of ParentReadingFeedbackPageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentReadingFeedbackPageDtoCopyWith<ParentReadingFeedbackPageDto> get copyWith => _$ParentReadingFeedbackPageDtoCopyWithImpl<ParentReadingFeedbackPageDto>(this as ParentReadingFeedbackPageDto, _$identity);

  /// Serializes this ParentReadingFeedbackPageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ParentReadingFeedbackPageDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentReadingFeedbackPageDto&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.pageIndex, _this.pageIndex) || other.pageIndex == _this.pageIndex)&&(identical(other.pageSize, _this.pageSize) || other.pageSize == _this.pageSize)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages)&&(identical(other.hasNextPage, _this.hasNextPage) || other.hasNextPage == _this.hasNextPage)&&(identical(other.hasPreviousPage, _this.hasPreviousPage) || other.hasPreviousPage == _this.hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParentReadingFeedbackPageDto;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.totalCount,_this.pageIndex,_this.pageSize,_this.totalPages,_this.hasNextPage,_this.hasPreviousPage);
}

@override
String toString() {
  final _this = this as ParentReadingFeedbackPageDto;
  return 'ParentReadingFeedbackPageDto(items: ${_this.items}, totalCount: ${_this.totalCount}, pageIndex: ${_this.pageIndex}, pageSize: ${_this.pageSize}, totalPages: ${_this.totalPages}, hasNextPage: ${_this.hasNextPage}, hasPreviousPage: ${_this.hasPreviousPage})';
}


}

/// @nodoc
abstract mixin class $ParentReadingFeedbackPageDtoCopyWith<$Res>  {
  factory $ParentReadingFeedbackPageDtoCopyWith(ParentReadingFeedbackPageDto value, $Res Function(ParentReadingFeedbackPageDto) _then) = _$ParentReadingFeedbackPageDtoCopyWithImpl;
@useResult
$Res call({
 List<ParentReadingFeedbackItemDto> items, int totalCount, int pageIndex, int pageSize, int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class _$ParentReadingFeedbackPageDtoCopyWithImpl<$Res>
    implements $ParentReadingFeedbackPageDtoCopyWith<$Res> {
  _$ParentReadingFeedbackPageDtoCopyWithImpl(this._self, this._then);

  final ParentReadingFeedbackPageDto _self;
  final $Res Function(ParentReadingFeedbackPageDto) _then;

/// Create a copy of ParentReadingFeedbackPageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? totalCount = null,Object? pageIndex = null,Object? pageSize = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(ParentReadingFeedbackPageDto(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ParentReadingFeedbackItemDto>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,pageIndex: null == pageIndex ? _self.pageIndex : pageIndex // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ParentReadingFeedbackPageDto].
extension ParentReadingFeedbackPageDtoPatterns on ParentReadingFeedbackPageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParentReadingFeedbackPageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParentReadingFeedbackPageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParentReadingFeedbackPageDto value)  $default,){
final _that = this;
switch (_that) {
case _ParentReadingFeedbackPageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParentReadingFeedbackPageDto value)?  $default,){
final _that = this;
switch (_that) {
case _ParentReadingFeedbackPageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ParentReadingFeedbackItemDto> items,  int totalCount,  int pageIndex,  int pageSize,  int totalPages,  bool hasNextPage,  bool hasPreviousPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParentReadingFeedbackPageDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ParentReadingFeedbackItemDto> items,  int totalCount,  int pageIndex,  int pageSize,  int totalPages,  bool hasNextPage,  bool hasPreviousPage)  $default,) {final _that = this;
switch (_that) {
case _ParentReadingFeedbackPageDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ParentReadingFeedbackItemDto> items,  int totalCount,  int pageIndex,  int pageSize,  int totalPages,  bool hasNextPage,  bool hasPreviousPage)?  $default,) {final _that = this;
switch (_that) {
case _ParentReadingFeedbackPageDto() when $default != null:
return $default(_that.items,_that.totalCount,_that.pageIndex,_that.pageSize,_that.totalPages,_that.hasNextPage,_that.hasPreviousPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParentReadingFeedbackPageDto implements ParentReadingFeedbackPageDto {
  const _ParentReadingFeedbackPageDto({ List<ParentReadingFeedbackItemDto> items = const <ParentReadingFeedbackItemDto>[], this.totalCount = 0, this.pageIndex = 0, this.pageSize = 0, this.totalPages = 0, this.hasNextPage = false, this.hasPreviousPage = false}): _items = items;
  factory _ParentReadingFeedbackPageDto.fromJson(Map<String, dynamic> json) => _$ParentReadingFeedbackPageDtoFromJson(json);

 final  List<ParentReadingFeedbackItemDto> _items;
@override@JsonKey() List<ParentReadingFeedbackItemDto> get items {
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

/// Create a copy of ParentReadingFeedbackPageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentReadingFeedbackPageDtoCopyWith<_ParentReadingFeedbackPageDto> get copyWith => __$ParentReadingFeedbackPageDtoCopyWithImpl<_ParentReadingFeedbackPageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParentReadingFeedbackPageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentReadingFeedbackPageDto&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.pageIndex, pageIndex) || other.pageIndex == pageIndex)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalCount,pageIndex,pageSize,totalPages,hasNextPage,hasPreviousPage);
}

@override
String toString() {
    return 'ParentReadingFeedbackPageDto(items: $items, totalCount: $totalCount, pageIndex: $pageIndex, pageSize: $pageSize, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage)';
}


}

/// @nodoc
abstract mixin class _$ParentReadingFeedbackPageDtoCopyWith<$Res> implements $ParentReadingFeedbackPageDtoCopyWith<$Res> {
  factory _$ParentReadingFeedbackPageDtoCopyWith(_ParentReadingFeedbackPageDto value, $Res Function(_ParentReadingFeedbackPageDto) _then) = __$ParentReadingFeedbackPageDtoCopyWithImpl;
@override @useResult
$Res call({
 List<ParentReadingFeedbackItemDto> items, int totalCount, int pageIndex, int pageSize, int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class __$ParentReadingFeedbackPageDtoCopyWithImpl<$Res>
    implements _$ParentReadingFeedbackPageDtoCopyWith<$Res> {
  __$ParentReadingFeedbackPageDtoCopyWithImpl(this._self, this._then);

  final _ParentReadingFeedbackPageDto _self;
  final $Res Function(_ParentReadingFeedbackPageDto) _then;

/// Create a copy of ParentReadingFeedbackPageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalCount = null,Object? pageIndex = null,Object? pageSize = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(_ParentReadingFeedbackPageDto(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ParentReadingFeedbackItemDto>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
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
