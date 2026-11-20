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
 List<ConversationAnswerDto> get conversationAnswers; String? get status; String? get startedAt; int get timeSpentSeconds; int get pagesCompleted; int get totalPages; int get readCount; int? get readOrdinal; bool get laterCompleted; int get quizRunCount; double? get quizLatestPercent; ParentReadAloudSummaryDto? get readAloud; ParentReadAloudPracticeDto? get readAloudPractice; int get readAloudRecordingCount; List<StoryEmotionDto> get emotions; ParentReflectionBriefDto? get reflection; int get expEarned; List<ParentCollectedWordDto> get wordsCollected; String? get readingMode; ParentRetellBriefDto? get retell;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentReadingFeedbackItemDto&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt)&&(identical(other.feeling, _this.feeling) || other.feeling == _this.feeling)&&(identical(other.feelingLabel, _this.feelingLabel) || other.feelingLabel == _this.feelingLabel)&&(identical(other.quizTotalQuestions, _this.quizTotalQuestions) || other.quizTotalQuestions == _this.quizTotalQuestions)&&(identical(other.quizBestPercent, _this.quizBestPercent) || other.quizBestPercent == _this.quizBestPercent)&&const DeepCollectionEquality().equals(other.conversationAnswers, _this.conversationAnswers)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.timeSpentSeconds, _this.timeSpentSeconds) || other.timeSpentSeconds == _this.timeSpentSeconds)&&(identical(other.pagesCompleted, _this.pagesCompleted) || other.pagesCompleted == _this.pagesCompleted)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages)&&(identical(other.readCount, _this.readCount) || other.readCount == _this.readCount)&&(identical(other.readOrdinal, _this.readOrdinal) || other.readOrdinal == _this.readOrdinal)&&(identical(other.laterCompleted, _this.laterCompleted) || other.laterCompleted == _this.laterCompleted)&&(identical(other.quizRunCount, _this.quizRunCount) || other.quizRunCount == _this.quizRunCount)&&(identical(other.quizLatestPercent, _this.quizLatestPercent) || other.quizLatestPercent == _this.quizLatestPercent)&&(identical(other.readAloud, _this.readAloud) || other.readAloud == _this.readAloud)&&(identical(other.readAloudPractice, _this.readAloudPractice) || other.readAloudPractice == _this.readAloudPractice)&&(identical(other.readAloudRecordingCount, _this.readAloudRecordingCount) || other.readAloudRecordingCount == _this.readAloudRecordingCount)&&const DeepCollectionEquality().equals(other.emotions, _this.emotions)&&(identical(other.reflection, _this.reflection) || other.reflection == _this.reflection)&&(identical(other.expEarned, _this.expEarned) || other.expEarned == _this.expEarned)&&const DeepCollectionEquality().equals(other.wordsCollected, _this.wordsCollected)&&(identical(other.readingMode, _this.readingMode) || other.readingMode == _this.readingMode)&&(identical(other.retell, _this.retell) || other.retell == _this.retell));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParentReadingFeedbackItemDto;
  return Object.hashAll([runtimeType,_this.sessionId,_this.storyId,_this.title,_this.completedAt,_this.feeling,_this.feelingLabel,_this.quizTotalQuestions,_this.quizBestPercent,const DeepCollectionEquality().hash(_this.conversationAnswers),_this.status,_this.startedAt,_this.timeSpentSeconds,_this.pagesCompleted,_this.totalPages,_this.readCount,_this.readOrdinal,_this.laterCompleted,_this.quizRunCount,_this.quizLatestPercent,_this.readAloud,_this.readAloudPractice,_this.readAloudRecordingCount,const DeepCollectionEquality().hash(_this.emotions),_this.reflection,_this.expEarned,const DeepCollectionEquality().hash(_this.wordsCollected),_this.readingMode,_this.retell]);
}

@override
String toString() {
  final _this = this as ParentReadingFeedbackItemDto;
  return 'ParentReadingFeedbackItemDto(sessionId: ${_this.sessionId}, storyId: ${_this.storyId}, title: ${_this.title}, completedAt: ${_this.completedAt}, feeling: ${_this.feeling}, feelingLabel: ${_this.feelingLabel}, quizTotalQuestions: ${_this.quizTotalQuestions}, quizBestPercent: ${_this.quizBestPercent}, conversationAnswers: ${_this.conversationAnswers}, status: ${_this.status}, startedAt: ${_this.startedAt}, timeSpentSeconds: ${_this.timeSpentSeconds}, pagesCompleted: ${_this.pagesCompleted}, totalPages: ${_this.totalPages}, readCount: ${_this.readCount}, readOrdinal: ${_this.readOrdinal}, laterCompleted: ${_this.laterCompleted}, quizRunCount: ${_this.quizRunCount}, quizLatestPercent: ${_this.quizLatestPercent}, readAloud: ${_this.readAloud}, readAloudPractice: ${_this.readAloudPractice}, readAloudRecordingCount: ${_this.readAloudRecordingCount}, emotions: ${_this.emotions}, reflection: ${_this.reflection}, expEarned: ${_this.expEarned}, wordsCollected: ${_this.wordsCollected}, readingMode: ${_this.readingMode}, retell: ${_this.retell})';
}


}

/// @nodoc
abstract mixin class $ParentReadingFeedbackItemDtoCopyWith<$Res>  {
  factory $ParentReadingFeedbackItemDtoCopyWith(ParentReadingFeedbackItemDto value, $Res Function(ParentReadingFeedbackItemDto) _then) = _$ParentReadingFeedbackItemDtoCopyWithImpl;
@useResult
$Res call({
 int sessionId, int storyId, String title, DateTime? completedAt, String? feeling, String? feelingLabel, int quizTotalQuestions, double? quizBestPercent, List<ConversationAnswerDto> conversationAnswers, String? status, String? startedAt, int timeSpentSeconds, int pagesCompleted, int totalPages, int readCount, int? readOrdinal, bool laterCompleted, int quizRunCount, double? quizLatestPercent, ParentReadAloudSummaryDto? readAloud, ParentReadAloudPracticeDto? readAloudPractice, int readAloudRecordingCount, List<StoryEmotionDto> emotions, ParentReflectionBriefDto? reflection, int expEarned, List<ParentCollectedWordDto> wordsCollected, String? readingMode, ParentRetellBriefDto? retell
});


$ParentReadAloudSummaryDtoCopyWith<$Res>? get readAloud;$ParentReadAloudPracticeDtoCopyWith<$Res>? get readAloudPractice;$ParentReflectionBriefDtoCopyWith<$Res>? get reflection;$ParentRetellBriefDtoCopyWith<$Res>? get retell;

}
/// @nodoc
class _$ParentReadingFeedbackItemDtoCopyWithImpl<$Res>
    implements $ParentReadingFeedbackItemDtoCopyWith<$Res> {
  _$ParentReadingFeedbackItemDtoCopyWithImpl(this._self, this._then);

  final ParentReadingFeedbackItemDto _self;
  final $Res Function(ParentReadingFeedbackItemDto) _then;

/// Create a copy of ParentReadingFeedbackItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? storyId = null,Object? title = null,Object? completedAt = freezed,Object? feeling = freezed,Object? feelingLabel = freezed,Object? quizTotalQuestions = null,Object? quizBestPercent = freezed,Object? conversationAnswers = null,Object? status = freezed,Object? startedAt = freezed,Object? timeSpentSeconds = null,Object? pagesCompleted = null,Object? totalPages = null,Object? readCount = null,Object? readOrdinal = freezed,Object? laterCompleted = null,Object? quizRunCount = null,Object? quizLatestPercent = freezed,Object? readAloud = freezed,Object? readAloudPractice = freezed,Object? readAloudRecordingCount = null,Object? emotions = null,Object? reflection = freezed,Object? expEarned = null,Object? wordsCollected = null,Object? readingMode = freezed,Object? retell = freezed,}) {
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
as List<ConversationAnswerDto>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,timeSpentSeconds: null == timeSpentSeconds ? _self.timeSpentSeconds : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
as int,pagesCompleted: null == pagesCompleted ? _self.pagesCompleted : pagesCompleted // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,readCount: null == readCount ? _self.readCount : readCount // ignore: cast_nullable_to_non_nullable
as int,readOrdinal: freezed == readOrdinal ? _self.readOrdinal : readOrdinal // ignore: cast_nullable_to_non_nullable
as int?,laterCompleted: null == laterCompleted ? _self.laterCompleted : laterCompleted // ignore: cast_nullable_to_non_nullable
as bool,quizRunCount: null == quizRunCount ? _self.quizRunCount : quizRunCount // ignore: cast_nullable_to_non_nullable
as int,quizLatestPercent: freezed == quizLatestPercent ? _self.quizLatestPercent : quizLatestPercent // ignore: cast_nullable_to_non_nullable
as double?,readAloud: freezed == readAloud ? _self.readAloud : readAloud // ignore: cast_nullable_to_non_nullable
as ParentReadAloudSummaryDto?,readAloudPractice: freezed == readAloudPractice ? _self.readAloudPractice : readAloudPractice // ignore: cast_nullable_to_non_nullable
as ParentReadAloudPracticeDto?,readAloudRecordingCount: null == readAloudRecordingCount ? _self.readAloudRecordingCount : readAloudRecordingCount // ignore: cast_nullable_to_non_nullable
as int,emotions: null == emotions ? _self.emotions : emotions // ignore: cast_nullable_to_non_nullable
as List<StoryEmotionDto>,reflection: freezed == reflection ? _self.reflection : reflection // ignore: cast_nullable_to_non_nullable
as ParentReflectionBriefDto?,expEarned: null == expEarned ? _self.expEarned : expEarned // ignore: cast_nullable_to_non_nullable
as int,wordsCollected: null == wordsCollected ? _self.wordsCollected : wordsCollected // ignore: cast_nullable_to_non_nullable
as List<ParentCollectedWordDto>,readingMode: freezed == readingMode ? _self.readingMode : readingMode // ignore: cast_nullable_to_non_nullable
as String?,retell: freezed == retell ? _self.retell : retell // ignore: cast_nullable_to_non_nullable
as ParentRetellBriefDto?,
  ));
}
/// Create a copy of ParentReadingFeedbackItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParentReadAloudSummaryDtoCopyWith<$Res>? get readAloud {
    if (_self.readAloud == null) {
    return null;
  }

  return $ParentReadAloudSummaryDtoCopyWith<$Res>(_self.readAloud!, (value) {
    return _then(_self.copyWith(readAloud: value));
  });
}/// Create a copy of ParentReadingFeedbackItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParentReadAloudPracticeDtoCopyWith<$Res>? get readAloudPractice {
    if (_self.readAloudPractice == null) {
    return null;
  }

  return $ParentReadAloudPracticeDtoCopyWith<$Res>(_self.readAloudPractice!, (value) {
    return _then(_self.copyWith(readAloudPractice: value));
  });
}/// Create a copy of ParentReadingFeedbackItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParentReflectionBriefDtoCopyWith<$Res>? get reflection {
    if (_self.reflection == null) {
    return null;
  }

  return $ParentReflectionBriefDtoCopyWith<$Res>(_self.reflection!, (value) {
    return _then(_self.copyWith(reflection: value));
  });
}/// Create a copy of ParentReadingFeedbackItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParentRetellBriefDtoCopyWith<$Res>? get retell {
    if (_self.retell == null) {
    return null;
  }

  return $ParentRetellBriefDtoCopyWith<$Res>(_self.retell!, (value) {
    return _then(_self.copyWith(retell: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionId,  int storyId,  String title,  DateTime? completedAt,  String? feeling,  String? feelingLabel,  int quizTotalQuestions,  double? quizBestPercent,  List<ConversationAnswerDto> conversationAnswers,  String? status,  String? startedAt,  int timeSpentSeconds,  int pagesCompleted,  int totalPages,  int readCount,  int? readOrdinal,  bool laterCompleted,  int quizRunCount,  double? quizLatestPercent,  ParentReadAloudSummaryDto? readAloud,  ParentReadAloudPracticeDto? readAloudPractice,  int readAloudRecordingCount,  List<StoryEmotionDto> emotions,  ParentReflectionBriefDto? reflection,  int expEarned,  List<ParentCollectedWordDto> wordsCollected,  String? readingMode,  ParentRetellBriefDto? retell)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParentReadingFeedbackItemDto() when $default != null:
return $default(_that.sessionId,_that.storyId,_that.title,_that.completedAt,_that.feeling,_that.feelingLabel,_that.quizTotalQuestions,_that.quizBestPercent,_that.conversationAnswers,_that.status,_that.startedAt,_that.timeSpentSeconds,_that.pagesCompleted,_that.totalPages,_that.readCount,_that.readOrdinal,_that.laterCompleted,_that.quizRunCount,_that.quizLatestPercent,_that.readAloud,_that.readAloudPractice,_that.readAloudRecordingCount,_that.emotions,_that.reflection,_that.expEarned,_that.wordsCollected,_that.readingMode,_that.retell);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionId,  int storyId,  String title,  DateTime? completedAt,  String? feeling,  String? feelingLabel,  int quizTotalQuestions,  double? quizBestPercent,  List<ConversationAnswerDto> conversationAnswers,  String? status,  String? startedAt,  int timeSpentSeconds,  int pagesCompleted,  int totalPages,  int readCount,  int? readOrdinal,  bool laterCompleted,  int quizRunCount,  double? quizLatestPercent,  ParentReadAloudSummaryDto? readAloud,  ParentReadAloudPracticeDto? readAloudPractice,  int readAloudRecordingCount,  List<StoryEmotionDto> emotions,  ParentReflectionBriefDto? reflection,  int expEarned,  List<ParentCollectedWordDto> wordsCollected,  String? readingMode,  ParentRetellBriefDto? retell)  $default,) {final _that = this;
switch (_that) {
case _ParentReadingFeedbackItemDto():
return $default(_that.sessionId,_that.storyId,_that.title,_that.completedAt,_that.feeling,_that.feelingLabel,_that.quizTotalQuestions,_that.quizBestPercent,_that.conversationAnswers,_that.status,_that.startedAt,_that.timeSpentSeconds,_that.pagesCompleted,_that.totalPages,_that.readCount,_that.readOrdinal,_that.laterCompleted,_that.quizRunCount,_that.quizLatestPercent,_that.readAloud,_that.readAloudPractice,_that.readAloudRecordingCount,_that.emotions,_that.reflection,_that.expEarned,_that.wordsCollected,_that.readingMode,_that.retell);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionId,  int storyId,  String title,  DateTime? completedAt,  String? feeling,  String? feelingLabel,  int quizTotalQuestions,  double? quizBestPercent,  List<ConversationAnswerDto> conversationAnswers,  String? status,  String? startedAt,  int timeSpentSeconds,  int pagesCompleted,  int totalPages,  int readCount,  int? readOrdinal,  bool laterCompleted,  int quizRunCount,  double? quizLatestPercent,  ParentReadAloudSummaryDto? readAloud,  ParentReadAloudPracticeDto? readAloudPractice,  int readAloudRecordingCount,  List<StoryEmotionDto> emotions,  ParentReflectionBriefDto? reflection,  int expEarned,  List<ParentCollectedWordDto> wordsCollected,  String? readingMode,  ParentRetellBriefDto? retell)?  $default,) {final _that = this;
switch (_that) {
case _ParentReadingFeedbackItemDto() when $default != null:
return $default(_that.sessionId,_that.storyId,_that.title,_that.completedAt,_that.feeling,_that.feelingLabel,_that.quizTotalQuestions,_that.quizBestPercent,_that.conversationAnswers,_that.status,_that.startedAt,_that.timeSpentSeconds,_that.pagesCompleted,_that.totalPages,_that.readCount,_that.readOrdinal,_that.laterCompleted,_that.quizRunCount,_that.quizLatestPercent,_that.readAloud,_that.readAloudPractice,_that.readAloudRecordingCount,_that.emotions,_that.reflection,_that.expEarned,_that.wordsCollected,_that.readingMode,_that.retell);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParentReadingFeedbackItemDto implements ParentReadingFeedbackItemDto {
  const _ParentReadingFeedbackItemDto({required this.sessionId, required this.storyId, required this.title, this.completedAt, this.feeling, this.feelingLabel, this.quizTotalQuestions = 0, this.quizBestPercent,  List<ConversationAnswerDto> conversationAnswers = const <ConversationAnswerDto>[], this.status, this.startedAt, this.timeSpentSeconds = 0, this.pagesCompleted = 0, this.totalPages = 0, this.readCount = 0, this.readOrdinal, this.laterCompleted = false, this.quizRunCount = 0, this.quizLatestPercent, this.readAloud, this.readAloudPractice, this.readAloudRecordingCount = 0,  List<StoryEmotionDto> emotions = const <StoryEmotionDto>[], this.reflection, this.expEarned = 0,  List<ParentCollectedWordDto> wordsCollected = const <ParentCollectedWordDto>[], this.readingMode, this.retell}): _conversationAnswers = conversationAnswers,_emotions = emotions,_wordsCollected = wordsCollected;
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

@override final  String? status;
@override final  String? startedAt;
@override@JsonKey() final  int timeSpentSeconds;
@override@JsonKey() final  int pagesCompleted;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  int readCount;
@override final  int? readOrdinal;
@override@JsonKey() final  bool laterCompleted;
@override@JsonKey() final  int quizRunCount;
@override final  double? quizLatestPercent;
@override final  ParentReadAloudSummaryDto? readAloud;
@override final  ParentReadAloudPracticeDto? readAloudPractice;
@override@JsonKey() final  int readAloudRecordingCount;
 final  List<StoryEmotionDto> _emotions;
@override@JsonKey() List<StoryEmotionDto> get emotions {
  if (_emotions is EqualUnmodifiableListView) return _emotions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_emotions);
}

@override final  ParentReflectionBriefDto? reflection;
@override@JsonKey() final  int expEarned;
 final  List<ParentCollectedWordDto> _wordsCollected;
@override@JsonKey() List<ParentCollectedWordDto> get wordsCollected {
  if (_wordsCollected is EqualUnmodifiableListView) return _wordsCollected;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_wordsCollected);
}

@override final  String? readingMode;
@override final  ParentRetellBriefDto? retell;

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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentReadingFeedbackItemDto&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.feeling, feeling) || other.feeling == feeling)&&(identical(other.feelingLabel, feelingLabel) || other.feelingLabel == feelingLabel)&&(identical(other.quizTotalQuestions, quizTotalQuestions) || other.quizTotalQuestions == quizTotalQuestions)&&(identical(other.quizBestPercent, quizBestPercent) || other.quizBestPercent == quizBestPercent)&&const DeepCollectionEquality().equals(other.conversationAnswers, _conversationAnswers)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.timeSpentSeconds, timeSpentSeconds) || other.timeSpentSeconds == timeSpentSeconds)&&(identical(other.pagesCompleted, pagesCompleted) || other.pagesCompleted == pagesCompleted)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.readCount, readCount) || other.readCount == readCount)&&(identical(other.readOrdinal, readOrdinal) || other.readOrdinal == readOrdinal)&&(identical(other.laterCompleted, laterCompleted) || other.laterCompleted == laterCompleted)&&(identical(other.quizRunCount, quizRunCount) || other.quizRunCount == quizRunCount)&&(identical(other.quizLatestPercent, quizLatestPercent) || other.quizLatestPercent == quizLatestPercent)&&(identical(other.readAloud, readAloud) || other.readAloud == readAloud)&&(identical(other.readAloudPractice, readAloudPractice) || other.readAloudPractice == readAloudPractice)&&(identical(other.readAloudRecordingCount, readAloudRecordingCount) || other.readAloudRecordingCount == readAloudRecordingCount)&&const DeepCollectionEquality().equals(other.emotions, _emotions)&&(identical(other.reflection, reflection) || other.reflection == reflection)&&(identical(other.expEarned, expEarned) || other.expEarned == expEarned)&&const DeepCollectionEquality().equals(other.wordsCollected, _wordsCollected)&&(identical(other.readingMode, readingMode) || other.readingMode == readingMode)&&(identical(other.retell, retell) || other.retell == retell));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,sessionId,storyId,title,completedAt,feeling,feelingLabel,quizTotalQuestions,quizBestPercent,const DeepCollectionEquality().hash(_conversationAnswers),status,startedAt,timeSpentSeconds,pagesCompleted,totalPages,readCount,readOrdinal,laterCompleted,quizRunCount,quizLatestPercent,readAloud,readAloudPractice,readAloudRecordingCount,const DeepCollectionEquality().hash(_emotions),reflection,expEarned,const DeepCollectionEquality().hash(_wordsCollected),readingMode,retell]);
}

@override
String toString() {
    return 'ParentReadingFeedbackItemDto(sessionId: $sessionId, storyId: $storyId, title: $title, completedAt: $completedAt, feeling: $feeling, feelingLabel: $feelingLabel, quizTotalQuestions: $quizTotalQuestions, quizBestPercent: $quizBestPercent, conversationAnswers: $conversationAnswers, status: $status, startedAt: $startedAt, timeSpentSeconds: $timeSpentSeconds, pagesCompleted: $pagesCompleted, totalPages: $totalPages, readCount: $readCount, readOrdinal: $readOrdinal, laterCompleted: $laterCompleted, quizRunCount: $quizRunCount, quizLatestPercent: $quizLatestPercent, readAloud: $readAloud, readAloudPractice: $readAloudPractice, readAloudRecordingCount: $readAloudRecordingCount, emotions: $emotions, reflection: $reflection, expEarned: $expEarned, wordsCollected: $wordsCollected, readingMode: $readingMode, retell: $retell)';
}


}

/// @nodoc
abstract mixin class _$ParentReadingFeedbackItemDtoCopyWith<$Res> implements $ParentReadingFeedbackItemDtoCopyWith<$Res> {
  factory _$ParentReadingFeedbackItemDtoCopyWith(_ParentReadingFeedbackItemDto value, $Res Function(_ParentReadingFeedbackItemDto) _then) = __$ParentReadingFeedbackItemDtoCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, int storyId, String title, DateTime? completedAt, String? feeling, String? feelingLabel, int quizTotalQuestions, double? quizBestPercent, List<ConversationAnswerDto> conversationAnswers, String? status, String? startedAt, int timeSpentSeconds, int pagesCompleted, int totalPages, int readCount, int? readOrdinal, bool laterCompleted, int quizRunCount, double? quizLatestPercent, ParentReadAloudSummaryDto? readAloud, ParentReadAloudPracticeDto? readAloudPractice, int readAloudRecordingCount, List<StoryEmotionDto> emotions, ParentReflectionBriefDto? reflection, int expEarned, List<ParentCollectedWordDto> wordsCollected, String? readingMode, ParentRetellBriefDto? retell
});


@override $ParentReadAloudSummaryDtoCopyWith<$Res>? get readAloud;@override $ParentReadAloudPracticeDtoCopyWith<$Res>? get readAloudPractice;@override $ParentReflectionBriefDtoCopyWith<$Res>? get reflection;@override $ParentRetellBriefDtoCopyWith<$Res>? get retell;

}
/// @nodoc
class __$ParentReadingFeedbackItemDtoCopyWithImpl<$Res>
    implements _$ParentReadingFeedbackItemDtoCopyWith<$Res> {
  __$ParentReadingFeedbackItemDtoCopyWithImpl(this._self, this._then);

  final _ParentReadingFeedbackItemDto _self;
  final $Res Function(_ParentReadingFeedbackItemDto) _then;

/// Create a copy of ParentReadingFeedbackItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? storyId = null,Object? title = null,Object? completedAt = freezed,Object? feeling = freezed,Object? feelingLabel = freezed,Object? quizTotalQuestions = null,Object? quizBestPercent = freezed,Object? conversationAnswers = null,Object? status = freezed,Object? startedAt = freezed,Object? timeSpentSeconds = null,Object? pagesCompleted = null,Object? totalPages = null,Object? readCount = null,Object? readOrdinal = freezed,Object? laterCompleted = null,Object? quizRunCount = null,Object? quizLatestPercent = freezed,Object? readAloud = freezed,Object? readAloudPractice = freezed,Object? readAloudRecordingCount = null,Object? emotions = null,Object? reflection = freezed,Object? expEarned = null,Object? wordsCollected = null,Object? readingMode = freezed,Object? retell = freezed,}) {
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
as List<ConversationAnswerDto>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,timeSpentSeconds: null == timeSpentSeconds ? _self.timeSpentSeconds : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
as int,pagesCompleted: null == pagesCompleted ? _self.pagesCompleted : pagesCompleted // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,readCount: null == readCount ? _self.readCount : readCount // ignore: cast_nullable_to_non_nullable
as int,readOrdinal: freezed == readOrdinal ? _self.readOrdinal : readOrdinal // ignore: cast_nullable_to_non_nullable
as int?,laterCompleted: null == laterCompleted ? _self.laterCompleted : laterCompleted // ignore: cast_nullable_to_non_nullable
as bool,quizRunCount: null == quizRunCount ? _self.quizRunCount : quizRunCount // ignore: cast_nullable_to_non_nullable
as int,quizLatestPercent: freezed == quizLatestPercent ? _self.quizLatestPercent : quizLatestPercent // ignore: cast_nullable_to_non_nullable
as double?,readAloud: freezed == readAloud ? _self.readAloud : readAloud // ignore: cast_nullable_to_non_nullable
as ParentReadAloudSummaryDto?,readAloudPractice: freezed == readAloudPractice ? _self.readAloudPractice : readAloudPractice // ignore: cast_nullable_to_non_nullable
as ParentReadAloudPracticeDto?,readAloudRecordingCount: null == readAloudRecordingCount ? _self.readAloudRecordingCount : readAloudRecordingCount // ignore: cast_nullable_to_non_nullable
as int,emotions: null == emotions ? _self._emotions : emotions // ignore: cast_nullable_to_non_nullable
as List<StoryEmotionDto>,reflection: freezed == reflection ? _self.reflection : reflection // ignore: cast_nullable_to_non_nullable
as ParentReflectionBriefDto?,expEarned: null == expEarned ? _self.expEarned : expEarned // ignore: cast_nullable_to_non_nullable
as int,wordsCollected: null == wordsCollected ? _self._wordsCollected : wordsCollected // ignore: cast_nullable_to_non_nullable
as List<ParentCollectedWordDto>,readingMode: freezed == readingMode ? _self.readingMode : readingMode // ignore: cast_nullable_to_non_nullable
as String?,retell: freezed == retell ? _self.retell : retell // ignore: cast_nullable_to_non_nullable
as ParentRetellBriefDto?,
  ));
}

/// Create a copy of ParentReadingFeedbackItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParentReadAloudSummaryDtoCopyWith<$Res>? get readAloud {
    if (_self.readAloud == null) {
    return null;
  }

  return $ParentReadAloudSummaryDtoCopyWith<$Res>(_self.readAloud!, (value) {
    return _then(_self.copyWith(readAloud: value));
  });
}/// Create a copy of ParentReadingFeedbackItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParentReadAloudPracticeDtoCopyWith<$Res>? get readAloudPractice {
    if (_self.readAloudPractice == null) {
    return null;
  }

  return $ParentReadAloudPracticeDtoCopyWith<$Res>(_self.readAloudPractice!, (value) {
    return _then(_self.copyWith(readAloudPractice: value));
  });
}/// Create a copy of ParentReadingFeedbackItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParentReflectionBriefDtoCopyWith<$Res>? get reflection {
    if (_self.reflection == null) {
    return null;
  }

  return $ParentReflectionBriefDtoCopyWith<$Res>(_self.reflection!, (value) {
    return _then(_self.copyWith(reflection: value));
  });
}/// Create a copy of ParentReadingFeedbackItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParentRetellBriefDtoCopyWith<$Res>? get retell {
    if (_self.retell == null) {
    return null;
  }

  return $ParentRetellBriefDtoCopyWith<$Res>(_self.retell!, (value) {
    return _then(_self.copyWith(retell: value));
  });
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
mixin _$ParentReadAloudSummaryDto {

 int get attempts; int get segmentsPracticed; int get goodWords; int get retryWords; int get totalWords; double get goodPercent;
/// Create a copy of ParentReadAloudSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentReadAloudSummaryDtoCopyWith<ParentReadAloudSummaryDto> get copyWith => _$ParentReadAloudSummaryDtoCopyWithImpl<ParentReadAloudSummaryDto>(this as ParentReadAloudSummaryDto, _$identity);

  /// Serializes this ParentReadAloudSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ParentReadAloudSummaryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentReadAloudSummaryDto&&(identical(other.attempts, _this.attempts) || other.attempts == _this.attempts)&&(identical(other.segmentsPracticed, _this.segmentsPracticed) || other.segmentsPracticed == _this.segmentsPracticed)&&(identical(other.goodWords, _this.goodWords) || other.goodWords == _this.goodWords)&&(identical(other.retryWords, _this.retryWords) || other.retryWords == _this.retryWords)&&(identical(other.totalWords, _this.totalWords) || other.totalWords == _this.totalWords)&&(identical(other.goodPercent, _this.goodPercent) || other.goodPercent == _this.goodPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParentReadAloudSummaryDto;
  return Object.hash(runtimeType,_this.attempts,_this.segmentsPracticed,_this.goodWords,_this.retryWords,_this.totalWords,_this.goodPercent);
}

@override
String toString() {
  final _this = this as ParentReadAloudSummaryDto;
  return 'ParentReadAloudSummaryDto(attempts: ${_this.attempts}, segmentsPracticed: ${_this.segmentsPracticed}, goodWords: ${_this.goodWords}, retryWords: ${_this.retryWords}, totalWords: ${_this.totalWords}, goodPercent: ${_this.goodPercent})';
}


}

/// @nodoc
abstract mixin class $ParentReadAloudSummaryDtoCopyWith<$Res>  {
  factory $ParentReadAloudSummaryDtoCopyWith(ParentReadAloudSummaryDto value, $Res Function(ParentReadAloudSummaryDto) _then) = _$ParentReadAloudSummaryDtoCopyWithImpl;
@useResult
$Res call({
 int attempts, int segmentsPracticed, int goodWords, int retryWords, int totalWords, double goodPercent
});




}
/// @nodoc
class _$ParentReadAloudSummaryDtoCopyWithImpl<$Res>
    implements $ParentReadAloudSummaryDtoCopyWith<$Res> {
  _$ParentReadAloudSummaryDtoCopyWithImpl(this._self, this._then);

  final ParentReadAloudSummaryDto _self;
  final $Res Function(ParentReadAloudSummaryDto) _then;

/// Create a copy of ParentReadAloudSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attempts = null,Object? segmentsPracticed = null,Object? goodWords = null,Object? retryWords = null,Object? totalWords = null,Object? goodPercent = null,}) {
  return _then(ParentReadAloudSummaryDto(
attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,segmentsPracticed: null == segmentsPracticed ? _self.segmentsPracticed : segmentsPracticed // ignore: cast_nullable_to_non_nullable
as int,goodWords: null == goodWords ? _self.goodWords : goodWords // ignore: cast_nullable_to_non_nullable
as int,retryWords: null == retryWords ? _self.retryWords : retryWords // ignore: cast_nullable_to_non_nullable
as int,totalWords: null == totalWords ? _self.totalWords : totalWords // ignore: cast_nullable_to_non_nullable
as int,goodPercent: null == goodPercent ? _self.goodPercent : goodPercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ParentReadAloudSummaryDto].
extension ParentReadAloudSummaryDtoPatterns on ParentReadAloudSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParentReadAloudSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParentReadAloudSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParentReadAloudSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _ParentReadAloudSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParentReadAloudSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _ParentReadAloudSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int attempts,  int segmentsPracticed,  int goodWords,  int retryWords,  int totalWords,  double goodPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParentReadAloudSummaryDto() when $default != null:
return $default(_that.attempts,_that.segmentsPracticed,_that.goodWords,_that.retryWords,_that.totalWords,_that.goodPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int attempts,  int segmentsPracticed,  int goodWords,  int retryWords,  int totalWords,  double goodPercent)  $default,) {final _that = this;
switch (_that) {
case _ParentReadAloudSummaryDto():
return $default(_that.attempts,_that.segmentsPracticed,_that.goodWords,_that.retryWords,_that.totalWords,_that.goodPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int attempts,  int segmentsPracticed,  int goodWords,  int retryWords,  int totalWords,  double goodPercent)?  $default,) {final _that = this;
switch (_that) {
case _ParentReadAloudSummaryDto() when $default != null:
return $default(_that.attempts,_that.segmentsPracticed,_that.goodWords,_that.retryWords,_that.totalWords,_that.goodPercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParentReadAloudSummaryDto implements ParentReadAloudSummaryDto {
  const _ParentReadAloudSummaryDto({this.attempts = 0, this.segmentsPracticed = 0, this.goodWords = 0, this.retryWords = 0, this.totalWords = 0, this.goodPercent = 0.0});
  factory _ParentReadAloudSummaryDto.fromJson(Map<String, dynamic> json) => _$ParentReadAloudSummaryDtoFromJson(json);

@override@JsonKey() final  int attempts;
@override@JsonKey() final  int segmentsPracticed;
@override@JsonKey() final  int goodWords;
@override@JsonKey() final  int retryWords;
@override@JsonKey() final  int totalWords;
@override@JsonKey() final  double goodPercent;

/// Create a copy of ParentReadAloudSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentReadAloudSummaryDtoCopyWith<_ParentReadAloudSummaryDto> get copyWith => __$ParentReadAloudSummaryDtoCopyWithImpl<_ParentReadAloudSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParentReadAloudSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentReadAloudSummaryDto&&(identical(other.attempts, attempts) || other.attempts == attempts)&&(identical(other.segmentsPracticed, segmentsPracticed) || other.segmentsPracticed == segmentsPracticed)&&(identical(other.goodWords, goodWords) || other.goodWords == goodWords)&&(identical(other.retryWords, retryWords) || other.retryWords == retryWords)&&(identical(other.totalWords, totalWords) || other.totalWords == totalWords)&&(identical(other.goodPercent, goodPercent) || other.goodPercent == goodPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,attempts,segmentsPracticed,goodWords,retryWords,totalWords,goodPercent);
}

@override
String toString() {
    return 'ParentReadAloudSummaryDto(attempts: $attempts, segmentsPracticed: $segmentsPracticed, goodWords: $goodWords, retryWords: $retryWords, totalWords: $totalWords, goodPercent: $goodPercent)';
}


}

/// @nodoc
abstract mixin class _$ParentReadAloudSummaryDtoCopyWith<$Res> implements $ParentReadAloudSummaryDtoCopyWith<$Res> {
  factory _$ParentReadAloudSummaryDtoCopyWith(_ParentReadAloudSummaryDto value, $Res Function(_ParentReadAloudSummaryDto) _then) = __$ParentReadAloudSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 int attempts, int segmentsPracticed, int goodWords, int retryWords, int totalWords, double goodPercent
});




}
/// @nodoc
class __$ParentReadAloudSummaryDtoCopyWithImpl<$Res>
    implements _$ParentReadAloudSummaryDtoCopyWith<$Res> {
  __$ParentReadAloudSummaryDtoCopyWithImpl(this._self, this._then);

  final _ParentReadAloudSummaryDto _self;
  final $Res Function(_ParentReadAloudSummaryDto) _then;

/// Create a copy of ParentReadAloudSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attempts = null,Object? segmentsPracticed = null,Object? goodWords = null,Object? retryWords = null,Object? totalWords = null,Object? goodPercent = null,}) {
  return _then(_ParentReadAloudSummaryDto(
attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,segmentsPracticed: null == segmentsPracticed ? _self.segmentsPracticed : segmentsPracticed // ignore: cast_nullable_to_non_nullable
as int,goodWords: null == goodWords ? _self.goodWords : goodWords // ignore: cast_nullable_to_non_nullable
as int,retryWords: null == retryWords ? _self.retryWords : retryWords // ignore: cast_nullable_to_non_nullable
as int,totalWords: null == totalWords ? _self.totalWords : totalWords // ignore: cast_nullable_to_non_nullable
as int,goodPercent: null == goodPercent ? _self.goodPercent : goodPercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ParentReadAloudPracticeDto {

 int get attempts; int get totalWords; int get latestGoodWords; double get latestGoodPercent; double get bestGoodPercent;
/// Create a copy of ParentReadAloudPracticeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentReadAloudPracticeDtoCopyWith<ParentReadAloudPracticeDto> get copyWith => _$ParentReadAloudPracticeDtoCopyWithImpl<ParentReadAloudPracticeDto>(this as ParentReadAloudPracticeDto, _$identity);

  /// Serializes this ParentReadAloudPracticeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ParentReadAloudPracticeDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentReadAloudPracticeDto&&(identical(other.attempts, _this.attempts) || other.attempts == _this.attempts)&&(identical(other.totalWords, _this.totalWords) || other.totalWords == _this.totalWords)&&(identical(other.latestGoodWords, _this.latestGoodWords) || other.latestGoodWords == _this.latestGoodWords)&&(identical(other.latestGoodPercent, _this.latestGoodPercent) || other.latestGoodPercent == _this.latestGoodPercent)&&(identical(other.bestGoodPercent, _this.bestGoodPercent) || other.bestGoodPercent == _this.bestGoodPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParentReadAloudPracticeDto;
  return Object.hash(runtimeType,_this.attempts,_this.totalWords,_this.latestGoodWords,_this.latestGoodPercent,_this.bestGoodPercent);
}

@override
String toString() {
  final _this = this as ParentReadAloudPracticeDto;
  return 'ParentReadAloudPracticeDto(attempts: ${_this.attempts}, totalWords: ${_this.totalWords}, latestGoodWords: ${_this.latestGoodWords}, latestGoodPercent: ${_this.latestGoodPercent}, bestGoodPercent: ${_this.bestGoodPercent})';
}


}

/// @nodoc
abstract mixin class $ParentReadAloudPracticeDtoCopyWith<$Res>  {
  factory $ParentReadAloudPracticeDtoCopyWith(ParentReadAloudPracticeDto value, $Res Function(ParentReadAloudPracticeDto) _then) = _$ParentReadAloudPracticeDtoCopyWithImpl;
@useResult
$Res call({
 int attempts, int totalWords, int latestGoodWords, double latestGoodPercent, double bestGoodPercent
});




}
/// @nodoc
class _$ParentReadAloudPracticeDtoCopyWithImpl<$Res>
    implements $ParentReadAloudPracticeDtoCopyWith<$Res> {
  _$ParentReadAloudPracticeDtoCopyWithImpl(this._self, this._then);

  final ParentReadAloudPracticeDto _self;
  final $Res Function(ParentReadAloudPracticeDto) _then;

/// Create a copy of ParentReadAloudPracticeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attempts = null,Object? totalWords = null,Object? latestGoodWords = null,Object? latestGoodPercent = null,Object? bestGoodPercent = null,}) {
  return _then(ParentReadAloudPracticeDto(
attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,totalWords: null == totalWords ? _self.totalWords : totalWords // ignore: cast_nullable_to_non_nullable
as int,latestGoodWords: null == latestGoodWords ? _self.latestGoodWords : latestGoodWords // ignore: cast_nullable_to_non_nullable
as int,latestGoodPercent: null == latestGoodPercent ? _self.latestGoodPercent : latestGoodPercent // ignore: cast_nullable_to_non_nullable
as double,bestGoodPercent: null == bestGoodPercent ? _self.bestGoodPercent : bestGoodPercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ParentReadAloudPracticeDto].
extension ParentReadAloudPracticeDtoPatterns on ParentReadAloudPracticeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParentReadAloudPracticeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParentReadAloudPracticeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParentReadAloudPracticeDto value)  $default,){
final _that = this;
switch (_that) {
case _ParentReadAloudPracticeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParentReadAloudPracticeDto value)?  $default,){
final _that = this;
switch (_that) {
case _ParentReadAloudPracticeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int attempts,  int totalWords,  int latestGoodWords,  double latestGoodPercent,  double bestGoodPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParentReadAloudPracticeDto() when $default != null:
return $default(_that.attempts,_that.totalWords,_that.latestGoodWords,_that.latestGoodPercent,_that.bestGoodPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int attempts,  int totalWords,  int latestGoodWords,  double latestGoodPercent,  double bestGoodPercent)  $default,) {final _that = this;
switch (_that) {
case _ParentReadAloudPracticeDto():
return $default(_that.attempts,_that.totalWords,_that.latestGoodWords,_that.latestGoodPercent,_that.bestGoodPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int attempts,  int totalWords,  int latestGoodWords,  double latestGoodPercent,  double bestGoodPercent)?  $default,) {final _that = this;
switch (_that) {
case _ParentReadAloudPracticeDto() when $default != null:
return $default(_that.attempts,_that.totalWords,_that.latestGoodWords,_that.latestGoodPercent,_that.bestGoodPercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParentReadAloudPracticeDto implements ParentReadAloudPracticeDto {
  const _ParentReadAloudPracticeDto({this.attempts = 0, this.totalWords = 0, this.latestGoodWords = 0, this.latestGoodPercent = 0.0, this.bestGoodPercent = 0.0});
  factory _ParentReadAloudPracticeDto.fromJson(Map<String, dynamic> json) => _$ParentReadAloudPracticeDtoFromJson(json);

@override@JsonKey() final  int attempts;
@override@JsonKey() final  int totalWords;
@override@JsonKey() final  int latestGoodWords;
@override@JsonKey() final  double latestGoodPercent;
@override@JsonKey() final  double bestGoodPercent;

/// Create a copy of ParentReadAloudPracticeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentReadAloudPracticeDtoCopyWith<_ParentReadAloudPracticeDto> get copyWith => __$ParentReadAloudPracticeDtoCopyWithImpl<_ParentReadAloudPracticeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParentReadAloudPracticeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentReadAloudPracticeDto&&(identical(other.attempts, attempts) || other.attempts == attempts)&&(identical(other.totalWords, totalWords) || other.totalWords == totalWords)&&(identical(other.latestGoodWords, latestGoodWords) || other.latestGoodWords == latestGoodWords)&&(identical(other.latestGoodPercent, latestGoodPercent) || other.latestGoodPercent == latestGoodPercent)&&(identical(other.bestGoodPercent, bestGoodPercent) || other.bestGoodPercent == bestGoodPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,attempts,totalWords,latestGoodWords,latestGoodPercent,bestGoodPercent);
}

@override
String toString() {
    return 'ParentReadAloudPracticeDto(attempts: $attempts, totalWords: $totalWords, latestGoodWords: $latestGoodWords, latestGoodPercent: $latestGoodPercent, bestGoodPercent: $bestGoodPercent)';
}


}

/// @nodoc
abstract mixin class _$ParentReadAloudPracticeDtoCopyWith<$Res> implements $ParentReadAloudPracticeDtoCopyWith<$Res> {
  factory _$ParentReadAloudPracticeDtoCopyWith(_ParentReadAloudPracticeDto value, $Res Function(_ParentReadAloudPracticeDto) _then) = __$ParentReadAloudPracticeDtoCopyWithImpl;
@override @useResult
$Res call({
 int attempts, int totalWords, int latestGoodWords, double latestGoodPercent, double bestGoodPercent
});




}
/// @nodoc
class __$ParentReadAloudPracticeDtoCopyWithImpl<$Res>
    implements _$ParentReadAloudPracticeDtoCopyWith<$Res> {
  __$ParentReadAloudPracticeDtoCopyWithImpl(this._self, this._then);

  final _ParentReadAloudPracticeDto _self;
  final $Res Function(_ParentReadAloudPracticeDto) _then;

/// Create a copy of ParentReadAloudPracticeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attempts = null,Object? totalWords = null,Object? latestGoodWords = null,Object? latestGoodPercent = null,Object? bestGoodPercent = null,}) {
  return _then(_ParentReadAloudPracticeDto(
attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,totalWords: null == totalWords ? _self.totalWords : totalWords // ignore: cast_nullable_to_non_nullable
as int,latestGoodWords: null == latestGoodWords ? _self.latestGoodWords : latestGoodWords // ignore: cast_nullable_to_non_nullable
as int,latestGoodPercent: null == latestGoodPercent ? _self.latestGoodPercent : latestGoodPercent // ignore: cast_nullable_to_non_nullable
as double,bestGoodPercent: null == bestGoodPercent ? _self.bestGoodPercent : bestGoodPercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$StoryEmotionDto {

 String get code; String get label;
/// Create a copy of StoryEmotionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryEmotionDtoCopyWith<StoryEmotionDto> get copyWith => _$StoryEmotionDtoCopyWithImpl<StoryEmotionDto>(this as StoryEmotionDto, _$identity);

  /// Serializes this StoryEmotionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StoryEmotionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryEmotionDto&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.label, _this.label) || other.label == _this.label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StoryEmotionDto;
  return Object.hash(runtimeType,_this.code,_this.label);
}

@override
String toString() {
  final _this = this as StoryEmotionDto;
  return 'StoryEmotionDto(code: ${_this.code}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $StoryEmotionDtoCopyWith<$Res>  {
  factory $StoryEmotionDtoCopyWith(StoryEmotionDto value, $Res Function(StoryEmotionDto) _then) = _$StoryEmotionDtoCopyWithImpl;
@useResult
$Res call({
 String code, String label
});




}
/// @nodoc
class _$StoryEmotionDtoCopyWithImpl<$Res>
    implements $StoryEmotionDtoCopyWith<$Res> {
  _$StoryEmotionDtoCopyWithImpl(this._self, this._then);

  final StoryEmotionDto _self;
  final $Res Function(StoryEmotionDto) _then;

/// Create a copy of StoryEmotionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? label = null,}) {
  return _then(StoryEmotionDto(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StoryEmotionDto].
extension StoryEmotionDtoPatterns on StoryEmotionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoryEmotionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoryEmotionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoryEmotionDto value)  $default,){
final _that = this;
switch (_that) {
case _StoryEmotionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoryEmotionDto value)?  $default,){
final _that = this;
switch (_that) {
case _StoryEmotionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoryEmotionDto() when $default != null:
return $default(_that.code,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String label)  $default,) {final _that = this;
switch (_that) {
case _StoryEmotionDto():
return $default(_that.code,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String label)?  $default,) {final _that = this;
switch (_that) {
case _StoryEmotionDto() when $default != null:
return $default(_that.code,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoryEmotionDto implements StoryEmotionDto {
  const _StoryEmotionDto({this.code = '', this.label = ''});
  factory _StoryEmotionDto.fromJson(Map<String, dynamic> json) => _$StoryEmotionDtoFromJson(json);

@override@JsonKey() final  String code;
@override@JsonKey() final  String label;

/// Create a copy of StoryEmotionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoryEmotionDtoCopyWith<_StoryEmotionDto> get copyWith => __$StoryEmotionDtoCopyWithImpl<_StoryEmotionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoryEmotionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoryEmotionDto&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,label);
}

@override
String toString() {
    return 'StoryEmotionDto(code: $code, label: $label)';
}


}

/// @nodoc
abstract mixin class _$StoryEmotionDtoCopyWith<$Res> implements $StoryEmotionDtoCopyWith<$Res> {
  factory _$StoryEmotionDtoCopyWith(_StoryEmotionDto value, $Res Function(_StoryEmotionDto) _then) = __$StoryEmotionDtoCopyWithImpl;
@override @useResult
$Res call({
 String code, String label
});




}
/// @nodoc
class __$StoryEmotionDtoCopyWithImpl<$Res>
    implements _$StoryEmotionDtoCopyWith<$Res> {
  __$StoryEmotionDtoCopyWithImpl(this._self, this._then);

  final _StoryEmotionDto _self;
  final $Res Function(_StoryEmotionDto) _then;

/// Create a copy of StoryEmotionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? label = null,}) {
  return _then(_StoryEmotionDto(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ParentReflectionBriefDto {

 int get favoriteSceneId; int? get favoriteSceneIndex; bool get hasNoteText; bool get hasNoteRecording;
/// Create a copy of ParentReflectionBriefDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentReflectionBriefDtoCopyWith<ParentReflectionBriefDto> get copyWith => _$ParentReflectionBriefDtoCopyWithImpl<ParentReflectionBriefDto>(this as ParentReflectionBriefDto, _$identity);

  /// Serializes this ParentReflectionBriefDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ParentReflectionBriefDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentReflectionBriefDto&&(identical(other.favoriteSceneId, _this.favoriteSceneId) || other.favoriteSceneId == _this.favoriteSceneId)&&(identical(other.favoriteSceneIndex, _this.favoriteSceneIndex) || other.favoriteSceneIndex == _this.favoriteSceneIndex)&&(identical(other.hasNoteText, _this.hasNoteText) || other.hasNoteText == _this.hasNoteText)&&(identical(other.hasNoteRecording, _this.hasNoteRecording) || other.hasNoteRecording == _this.hasNoteRecording));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParentReflectionBriefDto;
  return Object.hash(runtimeType,_this.favoriteSceneId,_this.favoriteSceneIndex,_this.hasNoteText,_this.hasNoteRecording);
}

@override
String toString() {
  final _this = this as ParentReflectionBriefDto;
  return 'ParentReflectionBriefDto(favoriteSceneId: ${_this.favoriteSceneId}, favoriteSceneIndex: ${_this.favoriteSceneIndex}, hasNoteText: ${_this.hasNoteText}, hasNoteRecording: ${_this.hasNoteRecording})';
}


}

/// @nodoc
abstract mixin class $ParentReflectionBriefDtoCopyWith<$Res>  {
  factory $ParentReflectionBriefDtoCopyWith(ParentReflectionBriefDto value, $Res Function(ParentReflectionBriefDto) _then) = _$ParentReflectionBriefDtoCopyWithImpl;
@useResult
$Res call({
 int favoriteSceneId, int? favoriteSceneIndex, bool hasNoteText, bool hasNoteRecording
});




}
/// @nodoc
class _$ParentReflectionBriefDtoCopyWithImpl<$Res>
    implements $ParentReflectionBriefDtoCopyWith<$Res> {
  _$ParentReflectionBriefDtoCopyWithImpl(this._self, this._then);

  final ParentReflectionBriefDto _self;
  final $Res Function(ParentReflectionBriefDto) _then;

/// Create a copy of ParentReflectionBriefDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? favoriteSceneId = null,Object? favoriteSceneIndex = freezed,Object? hasNoteText = null,Object? hasNoteRecording = null,}) {
  return _then(ParentReflectionBriefDto(
favoriteSceneId: null == favoriteSceneId ? _self.favoriteSceneId : favoriteSceneId // ignore: cast_nullable_to_non_nullable
as int,favoriteSceneIndex: freezed == favoriteSceneIndex ? _self.favoriteSceneIndex : favoriteSceneIndex // ignore: cast_nullable_to_non_nullable
as int?,hasNoteText: null == hasNoteText ? _self.hasNoteText : hasNoteText // ignore: cast_nullable_to_non_nullable
as bool,hasNoteRecording: null == hasNoteRecording ? _self.hasNoteRecording : hasNoteRecording // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ParentReflectionBriefDto].
extension ParentReflectionBriefDtoPatterns on ParentReflectionBriefDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParentReflectionBriefDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParentReflectionBriefDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParentReflectionBriefDto value)  $default,){
final _that = this;
switch (_that) {
case _ParentReflectionBriefDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParentReflectionBriefDto value)?  $default,){
final _that = this;
switch (_that) {
case _ParentReflectionBriefDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int favoriteSceneId,  int? favoriteSceneIndex,  bool hasNoteText,  bool hasNoteRecording)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParentReflectionBriefDto() when $default != null:
return $default(_that.favoriteSceneId,_that.favoriteSceneIndex,_that.hasNoteText,_that.hasNoteRecording);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int favoriteSceneId,  int? favoriteSceneIndex,  bool hasNoteText,  bool hasNoteRecording)  $default,) {final _that = this;
switch (_that) {
case _ParentReflectionBriefDto():
return $default(_that.favoriteSceneId,_that.favoriteSceneIndex,_that.hasNoteText,_that.hasNoteRecording);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int favoriteSceneId,  int? favoriteSceneIndex,  bool hasNoteText,  bool hasNoteRecording)?  $default,) {final _that = this;
switch (_that) {
case _ParentReflectionBriefDto() when $default != null:
return $default(_that.favoriteSceneId,_that.favoriteSceneIndex,_that.hasNoteText,_that.hasNoteRecording);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParentReflectionBriefDto implements ParentReflectionBriefDto {
  const _ParentReflectionBriefDto({this.favoriteSceneId = 0, this.favoriteSceneIndex, this.hasNoteText = false, this.hasNoteRecording = false});
  factory _ParentReflectionBriefDto.fromJson(Map<String, dynamic> json) => _$ParentReflectionBriefDtoFromJson(json);

@override@JsonKey() final  int favoriteSceneId;
@override final  int? favoriteSceneIndex;
@override@JsonKey() final  bool hasNoteText;
@override@JsonKey() final  bool hasNoteRecording;

/// Create a copy of ParentReflectionBriefDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentReflectionBriefDtoCopyWith<_ParentReflectionBriefDto> get copyWith => __$ParentReflectionBriefDtoCopyWithImpl<_ParentReflectionBriefDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParentReflectionBriefDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentReflectionBriefDto&&(identical(other.favoriteSceneId, favoriteSceneId) || other.favoriteSceneId == favoriteSceneId)&&(identical(other.favoriteSceneIndex, favoriteSceneIndex) || other.favoriteSceneIndex == favoriteSceneIndex)&&(identical(other.hasNoteText, hasNoteText) || other.hasNoteText == hasNoteText)&&(identical(other.hasNoteRecording, hasNoteRecording) || other.hasNoteRecording == hasNoteRecording));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,favoriteSceneId,favoriteSceneIndex,hasNoteText,hasNoteRecording);
}

@override
String toString() {
    return 'ParentReflectionBriefDto(favoriteSceneId: $favoriteSceneId, favoriteSceneIndex: $favoriteSceneIndex, hasNoteText: $hasNoteText, hasNoteRecording: $hasNoteRecording)';
}


}

/// @nodoc
abstract mixin class _$ParentReflectionBriefDtoCopyWith<$Res> implements $ParentReflectionBriefDtoCopyWith<$Res> {
  factory _$ParentReflectionBriefDtoCopyWith(_ParentReflectionBriefDto value, $Res Function(_ParentReflectionBriefDto) _then) = __$ParentReflectionBriefDtoCopyWithImpl;
@override @useResult
$Res call({
 int favoriteSceneId, int? favoriteSceneIndex, bool hasNoteText, bool hasNoteRecording
});




}
/// @nodoc
class __$ParentReflectionBriefDtoCopyWithImpl<$Res>
    implements _$ParentReflectionBriefDtoCopyWith<$Res> {
  __$ParentReflectionBriefDtoCopyWithImpl(this._self, this._then);

  final _ParentReflectionBriefDto _self;
  final $Res Function(_ParentReflectionBriefDto) _then;

/// Create a copy of ParentReflectionBriefDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? favoriteSceneId = null,Object? favoriteSceneIndex = freezed,Object? hasNoteText = null,Object? hasNoteRecording = null,}) {
  return _then(_ParentReflectionBriefDto(
favoriteSceneId: null == favoriteSceneId ? _self.favoriteSceneId : favoriteSceneId // ignore: cast_nullable_to_non_nullable
as int,favoriteSceneIndex: freezed == favoriteSceneIndex ? _self.favoriteSceneIndex : favoriteSceneIndex // ignore: cast_nullable_to_non_nullable
as int?,hasNoteText: null == hasNoteText ? _self.hasNoteText : hasNoteText // ignore: cast_nullable_to_non_nullable
as bool,hasNoteRecording: null == hasNoteRecording ? _self.hasNoteRecording : hasNoteRecording // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ParentCollectedWordDto {

 int get vocabularyId; String get term;
/// Create a copy of ParentCollectedWordDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentCollectedWordDtoCopyWith<ParentCollectedWordDto> get copyWith => _$ParentCollectedWordDtoCopyWithImpl<ParentCollectedWordDto>(this as ParentCollectedWordDto, _$identity);

  /// Serializes this ParentCollectedWordDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ParentCollectedWordDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentCollectedWordDto&&(identical(other.vocabularyId, _this.vocabularyId) || other.vocabularyId == _this.vocabularyId)&&(identical(other.term, _this.term) || other.term == _this.term));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParentCollectedWordDto;
  return Object.hash(runtimeType,_this.vocabularyId,_this.term);
}

@override
String toString() {
  final _this = this as ParentCollectedWordDto;
  return 'ParentCollectedWordDto(vocabularyId: ${_this.vocabularyId}, term: ${_this.term})';
}


}

/// @nodoc
abstract mixin class $ParentCollectedWordDtoCopyWith<$Res>  {
  factory $ParentCollectedWordDtoCopyWith(ParentCollectedWordDto value, $Res Function(ParentCollectedWordDto) _then) = _$ParentCollectedWordDtoCopyWithImpl;
@useResult
$Res call({
 int vocabularyId, String term
});




}
/// @nodoc
class _$ParentCollectedWordDtoCopyWithImpl<$Res>
    implements $ParentCollectedWordDtoCopyWith<$Res> {
  _$ParentCollectedWordDtoCopyWithImpl(this._self, this._then);

  final ParentCollectedWordDto _self;
  final $Res Function(ParentCollectedWordDto) _then;

/// Create a copy of ParentCollectedWordDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vocabularyId = null,Object? term = null,}) {
  return _then(ParentCollectedWordDto(
vocabularyId: null == vocabularyId ? _self.vocabularyId : vocabularyId // ignore: cast_nullable_to_non_nullable
as int,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ParentCollectedWordDto].
extension ParentCollectedWordDtoPatterns on ParentCollectedWordDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParentCollectedWordDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParentCollectedWordDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParentCollectedWordDto value)  $default,){
final _that = this;
switch (_that) {
case _ParentCollectedWordDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParentCollectedWordDto value)?  $default,){
final _that = this;
switch (_that) {
case _ParentCollectedWordDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int vocabularyId,  String term)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParentCollectedWordDto() when $default != null:
return $default(_that.vocabularyId,_that.term);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int vocabularyId,  String term)  $default,) {final _that = this;
switch (_that) {
case _ParentCollectedWordDto():
return $default(_that.vocabularyId,_that.term);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int vocabularyId,  String term)?  $default,) {final _that = this;
switch (_that) {
case _ParentCollectedWordDto() when $default != null:
return $default(_that.vocabularyId,_that.term);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParentCollectedWordDto implements ParentCollectedWordDto {
  const _ParentCollectedWordDto({this.vocabularyId = 0, this.term = ''});
  factory _ParentCollectedWordDto.fromJson(Map<String, dynamic> json) => _$ParentCollectedWordDtoFromJson(json);

@override@JsonKey() final  int vocabularyId;
@override@JsonKey() final  String term;

/// Create a copy of ParentCollectedWordDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentCollectedWordDtoCopyWith<_ParentCollectedWordDto> get copyWith => __$ParentCollectedWordDtoCopyWithImpl<_ParentCollectedWordDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParentCollectedWordDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentCollectedWordDto&&(identical(other.vocabularyId, vocabularyId) || other.vocabularyId == vocabularyId)&&(identical(other.term, term) || other.term == term));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,vocabularyId,term);
}

@override
String toString() {
    return 'ParentCollectedWordDto(vocabularyId: $vocabularyId, term: $term)';
}


}

/// @nodoc
abstract mixin class _$ParentCollectedWordDtoCopyWith<$Res> implements $ParentCollectedWordDtoCopyWith<$Res> {
  factory _$ParentCollectedWordDtoCopyWith(_ParentCollectedWordDto value, $Res Function(_ParentCollectedWordDto) _then) = __$ParentCollectedWordDtoCopyWithImpl;
@override @useResult
$Res call({
 int vocabularyId, String term
});




}
/// @nodoc
class __$ParentCollectedWordDtoCopyWithImpl<$Res>
    implements _$ParentCollectedWordDtoCopyWith<$Res> {
  __$ParentCollectedWordDtoCopyWithImpl(this._self, this._then);

  final _ParentCollectedWordDto _self;
  final $Res Function(_ParentCollectedWordDto) _then;

/// Create a copy of ParentCollectedWordDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vocabularyId = null,Object? term = null,}) {
  return _then(_ParentCollectedWordDto(
vocabularyId: null == vocabularyId ? _self.vocabularyId : vocabularyId // ignore: cast_nullable_to_non_nullable
as int,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ParentRetellBriefDto {

 int get summaryId; String get createdAt; bool get hasRecording; int get flagCount; int get unansweredCount;
/// Create a copy of ParentRetellBriefDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentRetellBriefDtoCopyWith<ParentRetellBriefDto> get copyWith => _$ParentRetellBriefDtoCopyWithImpl<ParentRetellBriefDto>(this as ParentRetellBriefDto, _$identity);

  /// Serializes this ParentRetellBriefDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ParentRetellBriefDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentRetellBriefDto&&(identical(other.summaryId, _this.summaryId) || other.summaryId == _this.summaryId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.hasRecording, _this.hasRecording) || other.hasRecording == _this.hasRecording)&&(identical(other.flagCount, _this.flagCount) || other.flagCount == _this.flagCount)&&(identical(other.unansweredCount, _this.unansweredCount) || other.unansweredCount == _this.unansweredCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParentRetellBriefDto;
  return Object.hash(runtimeType,_this.summaryId,_this.createdAt,_this.hasRecording,_this.flagCount,_this.unansweredCount);
}

@override
String toString() {
  final _this = this as ParentRetellBriefDto;
  return 'ParentRetellBriefDto(summaryId: ${_this.summaryId}, createdAt: ${_this.createdAt}, hasRecording: ${_this.hasRecording}, flagCount: ${_this.flagCount}, unansweredCount: ${_this.unansweredCount})';
}


}

/// @nodoc
abstract mixin class $ParentRetellBriefDtoCopyWith<$Res>  {
  factory $ParentRetellBriefDtoCopyWith(ParentRetellBriefDto value, $Res Function(ParentRetellBriefDto) _then) = _$ParentRetellBriefDtoCopyWithImpl;
@useResult
$Res call({
 int summaryId, String createdAt, bool hasRecording, int flagCount, int unansweredCount
});




}
/// @nodoc
class _$ParentRetellBriefDtoCopyWithImpl<$Res>
    implements $ParentRetellBriefDtoCopyWith<$Res> {
  _$ParentRetellBriefDtoCopyWithImpl(this._self, this._then);

  final ParentRetellBriefDto _self;
  final $Res Function(ParentRetellBriefDto) _then;

/// Create a copy of ParentRetellBriefDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summaryId = null,Object? createdAt = null,Object? hasRecording = null,Object? flagCount = null,Object? unansweredCount = null,}) {
  return _then(ParentRetellBriefDto(
summaryId: null == summaryId ? _self.summaryId : summaryId // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,hasRecording: null == hasRecording ? _self.hasRecording : hasRecording // ignore: cast_nullable_to_non_nullable
as bool,flagCount: null == flagCount ? _self.flagCount : flagCount // ignore: cast_nullable_to_non_nullable
as int,unansweredCount: null == unansweredCount ? _self.unansweredCount : unansweredCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ParentRetellBriefDto].
extension ParentRetellBriefDtoPatterns on ParentRetellBriefDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParentRetellBriefDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParentRetellBriefDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParentRetellBriefDto value)  $default,){
final _that = this;
switch (_that) {
case _ParentRetellBriefDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParentRetellBriefDto value)?  $default,){
final _that = this;
switch (_that) {
case _ParentRetellBriefDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int summaryId,  String createdAt,  bool hasRecording,  int flagCount,  int unansweredCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParentRetellBriefDto() when $default != null:
return $default(_that.summaryId,_that.createdAt,_that.hasRecording,_that.flagCount,_that.unansweredCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int summaryId,  String createdAt,  bool hasRecording,  int flagCount,  int unansweredCount)  $default,) {final _that = this;
switch (_that) {
case _ParentRetellBriefDto():
return $default(_that.summaryId,_that.createdAt,_that.hasRecording,_that.flagCount,_that.unansweredCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int summaryId,  String createdAt,  bool hasRecording,  int flagCount,  int unansweredCount)?  $default,) {final _that = this;
switch (_that) {
case _ParentRetellBriefDto() when $default != null:
return $default(_that.summaryId,_that.createdAt,_that.hasRecording,_that.flagCount,_that.unansweredCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParentRetellBriefDto implements ParentRetellBriefDto {
  const _ParentRetellBriefDto({this.summaryId = 0, this.createdAt = '', this.hasRecording = false, this.flagCount = 0, this.unansweredCount = 0});
  factory _ParentRetellBriefDto.fromJson(Map<String, dynamic> json) => _$ParentRetellBriefDtoFromJson(json);

@override@JsonKey() final  int summaryId;
@override@JsonKey() final  String createdAt;
@override@JsonKey() final  bool hasRecording;
@override@JsonKey() final  int flagCount;
@override@JsonKey() final  int unansweredCount;

/// Create a copy of ParentRetellBriefDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentRetellBriefDtoCopyWith<_ParentRetellBriefDto> get copyWith => __$ParentRetellBriefDtoCopyWithImpl<_ParentRetellBriefDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParentRetellBriefDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentRetellBriefDto&&(identical(other.summaryId, summaryId) || other.summaryId == summaryId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.hasRecording, hasRecording) || other.hasRecording == hasRecording)&&(identical(other.flagCount, flagCount) || other.flagCount == flagCount)&&(identical(other.unansweredCount, unansweredCount) || other.unansweredCount == unansweredCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,summaryId,createdAt,hasRecording,flagCount,unansweredCount);
}

@override
String toString() {
    return 'ParentRetellBriefDto(summaryId: $summaryId, createdAt: $createdAt, hasRecording: $hasRecording, flagCount: $flagCount, unansweredCount: $unansweredCount)';
}


}

/// @nodoc
abstract mixin class _$ParentRetellBriefDtoCopyWith<$Res> implements $ParentRetellBriefDtoCopyWith<$Res> {
  factory _$ParentRetellBriefDtoCopyWith(_ParentRetellBriefDto value, $Res Function(_ParentRetellBriefDto) _then) = __$ParentRetellBriefDtoCopyWithImpl;
@override @useResult
$Res call({
 int summaryId, String createdAt, bool hasRecording, int flagCount, int unansweredCount
});




}
/// @nodoc
class __$ParentRetellBriefDtoCopyWithImpl<$Res>
    implements _$ParentRetellBriefDtoCopyWith<$Res> {
  __$ParentRetellBriefDtoCopyWithImpl(this._self, this._then);

  final _ParentRetellBriefDto _self;
  final $Res Function(_ParentRetellBriefDto) _then;

/// Create a copy of ParentRetellBriefDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summaryId = null,Object? createdAt = null,Object? hasRecording = null,Object? flagCount = null,Object? unansweredCount = null,}) {
  return _then(_ParentRetellBriefDto(
summaryId: null == summaryId ? _self.summaryId : summaryId // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,hasRecording: null == hasRecording ? _self.hasRecording : hasRecording // ignore: cast_nullable_to_non_nullable
as bool,flagCount: null == flagCount ? _self.flagCount : flagCount // ignore: cast_nullable_to_non_nullable
as int,unansweredCount: null == unansweredCount ? _self.unansweredCount : unansweredCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ParentFavoriteSceneDto {

 int get sceneId; int get sceneIndex; String get sceneText; String? get illustrationUrl;
/// Create a copy of ParentFavoriteSceneDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentFavoriteSceneDtoCopyWith<ParentFavoriteSceneDto> get copyWith => _$ParentFavoriteSceneDtoCopyWithImpl<ParentFavoriteSceneDto>(this as ParentFavoriteSceneDto, _$identity);

  /// Serializes this ParentFavoriteSceneDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ParentFavoriteSceneDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentFavoriteSceneDto&&(identical(other.sceneId, _this.sceneId) || other.sceneId == _this.sceneId)&&(identical(other.sceneIndex, _this.sceneIndex) || other.sceneIndex == _this.sceneIndex)&&(identical(other.sceneText, _this.sceneText) || other.sceneText == _this.sceneText)&&(identical(other.illustrationUrl, _this.illustrationUrl) || other.illustrationUrl == _this.illustrationUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParentFavoriteSceneDto;
  return Object.hash(runtimeType,_this.sceneId,_this.sceneIndex,_this.sceneText,_this.illustrationUrl);
}

@override
String toString() {
  final _this = this as ParentFavoriteSceneDto;
  return 'ParentFavoriteSceneDto(sceneId: ${_this.sceneId}, sceneIndex: ${_this.sceneIndex}, sceneText: ${_this.sceneText}, illustrationUrl: ${_this.illustrationUrl})';
}


}

/// @nodoc
abstract mixin class $ParentFavoriteSceneDtoCopyWith<$Res>  {
  factory $ParentFavoriteSceneDtoCopyWith(ParentFavoriteSceneDto value, $Res Function(ParentFavoriteSceneDto) _then) = _$ParentFavoriteSceneDtoCopyWithImpl;
@useResult
$Res call({
 int sceneId, int sceneIndex, String sceneText, String? illustrationUrl
});




}
/// @nodoc
class _$ParentFavoriteSceneDtoCopyWithImpl<$Res>
    implements $ParentFavoriteSceneDtoCopyWith<$Res> {
  _$ParentFavoriteSceneDtoCopyWithImpl(this._self, this._then);

  final ParentFavoriteSceneDto _self;
  final $Res Function(ParentFavoriteSceneDto) _then;

/// Create a copy of ParentFavoriteSceneDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sceneId = null,Object? sceneIndex = null,Object? sceneText = null,Object? illustrationUrl = freezed,}) {
  return _then(ParentFavoriteSceneDto(
sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as int,sceneIndex: null == sceneIndex ? _self.sceneIndex : sceneIndex // ignore: cast_nullable_to_non_nullable
as int,sceneText: null == sceneText ? _self.sceneText : sceneText // ignore: cast_nullable_to_non_nullable
as String,illustrationUrl: freezed == illustrationUrl ? _self.illustrationUrl : illustrationUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ParentFavoriteSceneDto].
extension ParentFavoriteSceneDtoPatterns on ParentFavoriteSceneDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParentFavoriteSceneDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParentFavoriteSceneDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParentFavoriteSceneDto value)  $default,){
final _that = this;
switch (_that) {
case _ParentFavoriteSceneDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParentFavoriteSceneDto value)?  $default,){
final _that = this;
switch (_that) {
case _ParentFavoriteSceneDto() when $default != null:
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
case _ParentFavoriteSceneDto() when $default != null:
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
case _ParentFavoriteSceneDto():
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
case _ParentFavoriteSceneDto() when $default != null:
return $default(_that.sceneId,_that.sceneIndex,_that.sceneText,_that.illustrationUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParentFavoriteSceneDto implements ParentFavoriteSceneDto {
  const _ParentFavoriteSceneDto({this.sceneId = 0, this.sceneIndex = 0, this.sceneText = '', this.illustrationUrl});
  factory _ParentFavoriteSceneDto.fromJson(Map<String, dynamic> json) => _$ParentFavoriteSceneDtoFromJson(json);

@override@JsonKey() final  int sceneId;
@override@JsonKey() final  int sceneIndex;
@override@JsonKey() final  String sceneText;
@override final  String? illustrationUrl;

/// Create a copy of ParentFavoriteSceneDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentFavoriteSceneDtoCopyWith<_ParentFavoriteSceneDto> get copyWith => __$ParentFavoriteSceneDtoCopyWithImpl<_ParentFavoriteSceneDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParentFavoriteSceneDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentFavoriteSceneDto&&(identical(other.sceneId, sceneId) || other.sceneId == sceneId)&&(identical(other.sceneIndex, sceneIndex) || other.sceneIndex == sceneIndex)&&(identical(other.sceneText, sceneText) || other.sceneText == sceneText)&&(identical(other.illustrationUrl, illustrationUrl) || other.illustrationUrl == illustrationUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sceneId,sceneIndex,sceneText,illustrationUrl);
}

@override
String toString() {
    return 'ParentFavoriteSceneDto(sceneId: $sceneId, sceneIndex: $sceneIndex, sceneText: $sceneText, illustrationUrl: $illustrationUrl)';
}


}

/// @nodoc
abstract mixin class _$ParentFavoriteSceneDtoCopyWith<$Res> implements $ParentFavoriteSceneDtoCopyWith<$Res> {
  factory _$ParentFavoriteSceneDtoCopyWith(_ParentFavoriteSceneDto value, $Res Function(_ParentFavoriteSceneDto) _then) = __$ParentFavoriteSceneDtoCopyWithImpl;
@override @useResult
$Res call({
 int sceneId, int sceneIndex, String sceneText, String? illustrationUrl
});




}
/// @nodoc
class __$ParentFavoriteSceneDtoCopyWithImpl<$Res>
    implements _$ParentFavoriteSceneDtoCopyWith<$Res> {
  __$ParentFavoriteSceneDtoCopyWithImpl(this._self, this._then);

  final _ParentFavoriteSceneDto _self;
  final $Res Function(_ParentFavoriteSceneDto) _then;

/// Create a copy of ParentFavoriteSceneDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sceneId = null,Object? sceneIndex = null,Object? sceneText = null,Object? illustrationUrl = freezed,}) {
  return _then(_ParentFavoriteSceneDto(
sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as int,sceneIndex: null == sceneIndex ? _self.sceneIndex : sceneIndex // ignore: cast_nullable_to_non_nullable
as int,sceneText: null == sceneText ? _self.sceneText : sceneText // ignore: cast_nullable_to_non_nullable
as String,illustrationUrl: freezed == illustrationUrl ? _self.illustrationUrl : illustrationUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ParentStoryReflectionDto {

 int get sessionId; List<StoryEmotionDto> get emotions; ParentFavoriteSceneDto? get favoriteScene; String? get noteText; String? get noteAudioUrl; String? get noteSentAt;
/// Create a copy of ParentStoryReflectionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentStoryReflectionDtoCopyWith<ParentStoryReflectionDto> get copyWith => _$ParentStoryReflectionDtoCopyWithImpl<ParentStoryReflectionDto>(this as ParentStoryReflectionDto, _$identity);

  /// Serializes this ParentStoryReflectionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ParentStoryReflectionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentStoryReflectionDto&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&const DeepCollectionEquality().equals(other.emotions, _this.emotions)&&(identical(other.favoriteScene, _this.favoriteScene) || other.favoriteScene == _this.favoriteScene)&&(identical(other.noteText, _this.noteText) || other.noteText == _this.noteText)&&(identical(other.noteAudioUrl, _this.noteAudioUrl) || other.noteAudioUrl == _this.noteAudioUrl)&&(identical(other.noteSentAt, _this.noteSentAt) || other.noteSentAt == _this.noteSentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ParentStoryReflectionDto;
  return Object.hash(runtimeType,_this.sessionId,const DeepCollectionEquality().hash(_this.emotions),_this.favoriteScene,_this.noteText,_this.noteAudioUrl,_this.noteSentAt);
}

@override
String toString() {
  final _this = this as ParentStoryReflectionDto;
  return 'ParentStoryReflectionDto(sessionId: ${_this.sessionId}, emotions: ${_this.emotions}, favoriteScene: ${_this.favoriteScene}, noteText: ${_this.noteText}, noteAudioUrl: ${_this.noteAudioUrl}, noteSentAt: ${_this.noteSentAt})';
}


}

/// @nodoc
abstract mixin class $ParentStoryReflectionDtoCopyWith<$Res>  {
  factory $ParentStoryReflectionDtoCopyWith(ParentStoryReflectionDto value, $Res Function(ParentStoryReflectionDto) _then) = _$ParentStoryReflectionDtoCopyWithImpl;
@useResult
$Res call({
 int sessionId, List<StoryEmotionDto> emotions, ParentFavoriteSceneDto? favoriteScene, String? noteText, String? noteAudioUrl, String? noteSentAt
});


$ParentFavoriteSceneDtoCopyWith<$Res>? get favoriteScene;

}
/// @nodoc
class _$ParentStoryReflectionDtoCopyWithImpl<$Res>
    implements $ParentStoryReflectionDtoCopyWith<$Res> {
  _$ParentStoryReflectionDtoCopyWithImpl(this._self, this._then);

  final ParentStoryReflectionDto _self;
  final $Res Function(ParentStoryReflectionDto) _then;

/// Create a copy of ParentStoryReflectionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? emotions = null,Object? favoriteScene = freezed,Object? noteText = freezed,Object? noteAudioUrl = freezed,Object? noteSentAt = freezed,}) {
  return _then(ParentStoryReflectionDto(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,emotions: null == emotions ? _self.emotions : emotions // ignore: cast_nullable_to_non_nullable
as List<StoryEmotionDto>,favoriteScene: freezed == favoriteScene ? _self.favoriteScene : favoriteScene // ignore: cast_nullable_to_non_nullable
as ParentFavoriteSceneDto?,noteText: freezed == noteText ? _self.noteText : noteText // ignore: cast_nullable_to_non_nullable
as String?,noteAudioUrl: freezed == noteAudioUrl ? _self.noteAudioUrl : noteAudioUrl // ignore: cast_nullable_to_non_nullable
as String?,noteSentAt: freezed == noteSentAt ? _self.noteSentAt : noteSentAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ParentStoryReflectionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParentFavoriteSceneDtoCopyWith<$Res>? get favoriteScene {
    if (_self.favoriteScene == null) {
    return null;
  }

  return $ParentFavoriteSceneDtoCopyWith<$Res>(_self.favoriteScene!, (value) {
    return _then(_self.copyWith(favoriteScene: value));
  });
}
}


/// Adds pattern-matching-related methods to [ParentStoryReflectionDto].
extension ParentStoryReflectionDtoPatterns on ParentStoryReflectionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParentStoryReflectionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParentStoryReflectionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParentStoryReflectionDto value)  $default,){
final _that = this;
switch (_that) {
case _ParentStoryReflectionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParentStoryReflectionDto value)?  $default,){
final _that = this;
switch (_that) {
case _ParentStoryReflectionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionId,  List<StoryEmotionDto> emotions,  ParentFavoriteSceneDto? favoriteScene,  String? noteText,  String? noteAudioUrl,  String? noteSentAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParentStoryReflectionDto() when $default != null:
return $default(_that.sessionId,_that.emotions,_that.favoriteScene,_that.noteText,_that.noteAudioUrl,_that.noteSentAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionId,  List<StoryEmotionDto> emotions,  ParentFavoriteSceneDto? favoriteScene,  String? noteText,  String? noteAudioUrl,  String? noteSentAt)  $default,) {final _that = this;
switch (_that) {
case _ParentStoryReflectionDto():
return $default(_that.sessionId,_that.emotions,_that.favoriteScene,_that.noteText,_that.noteAudioUrl,_that.noteSentAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionId,  List<StoryEmotionDto> emotions,  ParentFavoriteSceneDto? favoriteScene,  String? noteText,  String? noteAudioUrl,  String? noteSentAt)?  $default,) {final _that = this;
switch (_that) {
case _ParentStoryReflectionDto() when $default != null:
return $default(_that.sessionId,_that.emotions,_that.favoriteScene,_that.noteText,_that.noteAudioUrl,_that.noteSentAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParentStoryReflectionDto implements ParentStoryReflectionDto {
  const _ParentStoryReflectionDto({this.sessionId = 0,  List<StoryEmotionDto> emotions = const <StoryEmotionDto>[], this.favoriteScene, this.noteText, this.noteAudioUrl, this.noteSentAt}): _emotions = emotions;
  factory _ParentStoryReflectionDto.fromJson(Map<String, dynamic> json) => _$ParentStoryReflectionDtoFromJson(json);

@override@JsonKey() final  int sessionId;
 final  List<StoryEmotionDto> _emotions;
@override@JsonKey() List<StoryEmotionDto> get emotions {
  if (_emotions is EqualUnmodifiableListView) return _emotions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_emotions);
}

@override final  ParentFavoriteSceneDto? favoriteScene;
@override final  String? noteText;
@override final  String? noteAudioUrl;
@override final  String? noteSentAt;

/// Create a copy of ParentStoryReflectionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParentStoryReflectionDtoCopyWith<_ParentStoryReflectionDto> get copyWith => __$ParentStoryReflectionDtoCopyWithImpl<_ParentStoryReflectionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParentStoryReflectionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParentStoryReflectionDto&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&const DeepCollectionEquality().equals(other.emotions, _emotions)&&(identical(other.favoriteScene, favoriteScene) || other.favoriteScene == favoriteScene)&&(identical(other.noteText, noteText) || other.noteText == noteText)&&(identical(other.noteAudioUrl, noteAudioUrl) || other.noteAudioUrl == noteAudioUrl)&&(identical(other.noteSentAt, noteSentAt) || other.noteSentAt == noteSentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,const DeepCollectionEquality().hash(_emotions),favoriteScene,noteText,noteAudioUrl,noteSentAt);
}

@override
String toString() {
    return 'ParentStoryReflectionDto(sessionId: $sessionId, emotions: $emotions, favoriteScene: $favoriteScene, noteText: $noteText, noteAudioUrl: $noteAudioUrl, noteSentAt: $noteSentAt)';
}


}

/// @nodoc
abstract mixin class _$ParentStoryReflectionDtoCopyWith<$Res> implements $ParentStoryReflectionDtoCopyWith<$Res> {
  factory _$ParentStoryReflectionDtoCopyWith(_ParentStoryReflectionDto value, $Res Function(_ParentStoryReflectionDto) _then) = __$ParentStoryReflectionDtoCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, List<StoryEmotionDto> emotions, ParentFavoriteSceneDto? favoriteScene, String? noteText, String? noteAudioUrl, String? noteSentAt
});


@override $ParentFavoriteSceneDtoCopyWith<$Res>? get favoriteScene;

}
/// @nodoc
class __$ParentStoryReflectionDtoCopyWithImpl<$Res>
    implements _$ParentStoryReflectionDtoCopyWith<$Res> {
  __$ParentStoryReflectionDtoCopyWithImpl(this._self, this._then);

  final _ParentStoryReflectionDto _self;
  final $Res Function(_ParentStoryReflectionDto) _then;

/// Create a copy of ParentStoryReflectionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? emotions = null,Object? favoriteScene = freezed,Object? noteText = freezed,Object? noteAudioUrl = freezed,Object? noteSentAt = freezed,}) {
  return _then(_ParentStoryReflectionDto(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,emotions: null == emotions ? _self._emotions : emotions // ignore: cast_nullable_to_non_nullable
as List<StoryEmotionDto>,favoriteScene: freezed == favoriteScene ? _self.favoriteScene : favoriteScene // ignore: cast_nullable_to_non_nullable
as ParentFavoriteSceneDto?,noteText: freezed == noteText ? _self.noteText : noteText // ignore: cast_nullable_to_non_nullable
as String?,noteAudioUrl: freezed == noteAudioUrl ? _self.noteAudioUrl : noteAudioUrl // ignore: cast_nullable_to_non_nullable
as String?,noteSentAt: freezed == noteSentAt ? _self.noteSentAt : noteSentAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ParentStoryReflectionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParentFavoriteSceneDtoCopyWith<$Res>? get favoriteScene {
    if (_self.favoriteScene == null) {
    return null;
  }

  return $ParentFavoriteSceneDtoCopyWith<$Res>(_self.favoriteScene!, (value) {
    return _then(_self.copyWith(favoriteScene: value));
  });
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
