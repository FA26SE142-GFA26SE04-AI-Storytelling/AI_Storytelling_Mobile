import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_reading_dto.freezed.dart';
part 'child_reading_dto.g.dart';

@freezed
abstract class ChildStory with _$ChildStory {
  const factory ChildStory({
    required int storyId,
    required String title,
    String? coverImageUrl,
    String? description,
    required String source,
  }) = _ChildStory;

  factory ChildStory.fromJson(Map<String, dynamic> json) =>
      _$ChildStoryFromJson(json);
}

@freezed
abstract class ChildStoryPage with _$ChildStoryPage {
  const factory ChildStoryPage({
    @Default(false) bool isLocked,
    int? unlockStoryId,
    String? message,
    @Default(<ChildStory>[]) List<ChildStory> items,
    @Default(0) int totalCount,
    @Default(0) int pageIndex,
    @Default(0) int pageSize,
  }) = _ChildStoryPage;

  factory ChildStoryPage.fromJson(Map<String, dynamic> json) =>
      _$ChildStoryPageFromJson(json);
}

/// Body gửi đi khi bắt đầu phiên đọc
@freezed
abstract class ReadingStartBody with _$ReadingStartBody {
  const factory ReadingStartBody({int? storyId, int? communitySubmissionId}) =
      _ReadingStartBody;

  factory ReadingStartBody.fromJson(Map<String, dynamic> json) =>
      _$ReadingStartBodyFromJson(json);
}

@freezed
abstract class ReadingStarted with _$ReadingStarted {
  const factory ReadingStarted({
    required int sessionId,
    required int storyId,
    @Default(false) bool resumed,
    @Default(0) int lastPage,
    String? lastReadingMode,
    @Default(false) bool isBookmarked,
    @Default(false) bool isFavorited,
    bool? listenOnly,
  }) = _ReadingStarted;

  factory ReadingStarted.fromJson(Map<String, dynamic> json) =>
      _$ReadingStartedFromJson(json);
}

@freezed
abstract class ReadingFlags with _$ReadingFlags {
  const factory ReadingFlags({
    @Default(false) bool isBookmarked,
    @Default(false) bool isFavorited,
    bool? listenOnly,
  }) = _ReadingFlags;

  factory ReadingFlags.fromJson(Map<String, dynamic> json) =>
      _$ReadingFlagsFromJson(json);
}

@freezed
abstract class ReadingContent with _$ReadingContent {
  const factory ReadingContent({
    required int sessionId,
    required int storyId,
    required String title,
    String? lesson,
    @Default(false) bool listenOnly,
    @Default(<ReadingScene>[]) List<ReadingScene> scenes,
    @Default(<ReadingVocabulary>[]) List<ReadingVocabulary> vocabulary,
  }) = _ReadingContent;

  factory ReadingContent.fromJson(Map<String, dynamic> json) =>
      _$ReadingContentFromJson(json);
}

@freezed
abstract class ReadingVocabulary with _$ReadingVocabulary {
  const factory ReadingVocabulary({required int id, required String term}) =
      _ReadingVocabulary;

  factory ReadingVocabulary.fromJson(Map<String, dynamic> json) =>
      _$ReadingVocabularyFromJson(json);
}

@freezed
abstract class ReadingScene with _$ReadingScene {
  const factory ReadingScene({
    required int sceneId,
    required int sceneIndex,
    required String text,
    String? illustrationUrl,
    List<SceneIllustration>? illustrations,
    @Default(<ReadingSegment>[]) List<ReadingSegment> segments,
    Map<String, dynamic>? interaction,
    @Default(false) bool attemptedInSession,
  }) = _ReadingScene;

  factory ReadingScene.fromJson(Map<String, dynamic> json) =>
      _$ReadingSceneFromJson(json);
}

@freezed
abstract class ReadingSegment with _$ReadingSegment {
  const factory ReadingSegment({
    required int segmentId,
    required int segmentOrder,
    int? startOffset,
    int? endOffset,
    required String text,
    String? audioUrl,
    String? wordTimingsJson,
  }) = _ReadingSegment;

  factory ReadingSegment.fromJson(Map<String, dynamic> json) =>
      _$ReadingSegmentFromJson(json);
}

@freezed
abstract class SceneIllustration with _$SceneIllustration {
  const factory SceneIllustration({
    required int beatOrder,
    required int startOffset,
    required int endOffset,
    String? url,
  }) = _SceneIllustration;

  factory SceneIllustration.fromJson(Map<String, dynamic> json) =>
      _$SceneIllustrationFromJson(json);
}

@freezed
abstract class ReadingProgress with _$ReadingProgress {
  const factory ReadingProgress({
    required int sessionId,
    required int page,
    String? readingMode,
    @Default(0) int timeSpentSeconds,
  }) = _ReadingProgress;

  factory ReadingProgress.fromJson(Map<String, dynamic> json) =>
      _$ReadingProgressFromJson(json);
}

@freezed
abstract class ReadingCompleted with _$ReadingCompleted {
  const factory ReadingCompleted({
    required int sessionId,
    required int storyId,
    @Default(false) bool isRetake,
    @Default(false) bool roadmapStepCompleted,
    @Default(0) int expGained,
    @Default(<String>[]) List<String> newBadges,
  }) = _ReadingCompleted;

  factory ReadingCompleted.fromJson(Map<String, dynamic> json) =>
      _$ReadingCompletedFromJson(json);
}

@freezed
abstract class ReadingSignal with _$ReadingSignal {
  const factory ReadingSignal({
    @Default(false) bool shouldExit,
    String? returnTo,
    String? message,
    required String sessionStatus,
  }) = _ReadingSignal;

  factory ReadingSignal.fromJson(Map<String, dynamic> json) =>
      _$ReadingSignalFromJson(json);
}

@freezed
abstract class VocabularyDefinition with _$VocabularyDefinition {
  const factory VocabularyDefinition({
    required int vocabularyId,
    required String term,
    required String definition,
    @Default(false) bool isCollected,
  }) = _VocabularyDefinition;

  factory VocabularyDefinition.fromJson(Map<String, dynamic> json) =>
      _$VocabularyDefinitionFromJson(json);
}

@freezed
abstract class NotebookEntry with _$NotebookEntry {
  const factory NotebookEntry({
    required int entryId,
    required int vocabularyId,
    required String term,
    required String definition,
    required int storyId,
    required String storyTitle,
    int? sceneIndex,
    required String collectedAt,
  }) = _NotebookEntry;

  factory NotebookEntry.fromJson(Map<String, dynamic> json) =>
      _$NotebookEntryFromJson(json);
}

@freezed
abstract class ReadingFeelingResult with _$ReadingFeelingResult {
  const factory ReadingFeelingResult({
    required int sessionId,
    required String feeling,
    required String label,
  }) = _ReadingFeelingResult;

  factory ReadingFeelingResult.fromJson(Map<String, dynamic> json) =>
      _$ReadingFeelingResultFromJson(json);
}

@freezed
abstract class ChildQuizItem with _$ChildQuizItem {
  const factory ChildQuizItem({
    required int quizItemId,
    @Default('MultipleChoice') String type,
    required String question,
    List<String>? choices,
  }) = _ChildQuizItem;

  factory ChildQuizItem.fromJson(Map<String, dynamic> json) =>
      _$ChildQuizItemFromJson(json);
}

@freezed
abstract class ChildQuiz with _$ChildQuiz {
  const factory ChildQuiz({
    required int sessionId,
    @Default(0) int totalQuestions,
    int? bestPercent,
    @Default(<ChildQuizItem>[]) List<ChildQuizItem> questions,
  }) = _ChildQuiz;

  factory ChildQuiz.fromJson(Map<String, dynamic> json) =>
      _$ChildQuizFromJson(json);
}

@freezed
abstract class QuizAnswerResult with _$QuizAnswerResult {
  const factory QuizAnswerResult({
    required int quizItemId,
    @Default(false) bool isCorrect,
    required String feedback,
    @Default(0) int expGained,
    @Default(<String>[]) List<String> newBadges,
    @Default(false) bool runCompleted,
    @Default(0) int currentPercent,
    int? bestPercent,
  }) = _QuizAnswerResult;

  factory QuizAnswerResult.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerResultFromJson(json);
}

@freezed
abstract class ChildQuizResult with _$ChildQuizResult {
  const factory ChildQuizResult({
    required int sessionId,
    @Default(0) int totalQuestions,
    @Default(0) int answered,
    @Default(0) int correct,
    @Default(0) int currentPercent,
    int? bestPercent,
    @Default(false) bool runCompleted,
  }) = _ChildQuizResult;

  factory ChildQuizResult.fromJson(Map<String, dynamic> json) =>
      _$ChildQuizResultFromJson(json);
}

@freezed
abstract class StorySummarySent with _$StorySummarySent {
  const factory StorySummarySent({
    required int summaryId,
    required String message,
  }) = _StorySummarySent;

  factory StorySummarySent.fromJson(Map<String, dynamic> json) =>
      _$StorySummarySentFromJson(json);
}

const int kSummaryMaxBytes = 3000000;
const int kSummaryMaxFlags = 5;
