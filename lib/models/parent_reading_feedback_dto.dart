import 'package:freezed_annotation/freezed_annotation.dart';

part 'parent_reading_feedback_dto.freezed.dart';
part 'parent_reading_feedback_dto.g.dart';

@freezed
abstract class ParentReadingFeedbackItemDto with _$ParentReadingFeedbackItemDto {
  const factory ParentReadingFeedbackItemDto({
    required int sessionId,
    required int storyId,
    required String title,
    DateTime? completedAt,
    String? feeling,
    String? feelingLabel,
    @Default(0) int quizTotalQuestions,
    double? quizBestPercent,
    /// Câu bé trả lời ở các điểm dừng cảm xúc/cảm nhận trong lần đọc này.
    @Default(<ConversationAnswerDto>[])
    List<ConversationAnswerDto> conversationAnswers,
    // --- Trường mới theo type web ---
    String? status,
    String? startedAt,
    @Default(0) int timeSpentSeconds,
    @Default(0) int pagesCompleted,
    @Default(0) int totalPages,
    @Default(0) int readCount,
    int? readOrdinal,
    @Default(false) bool laterCompleted,
    @Default(0) int quizRunCount,
    double? quizLatestPercent,
    ParentReadAloudSummaryDto? readAloud,
    ParentReadAloudPracticeDto? readAloudPractice,
    @Default(0) int readAloudRecordingCount,
    @Default(<StoryEmotionDto>[]) List<StoryEmotionDto> emotions,
    ParentReflectionBriefDto? reflection,
    @Default(0) int expEarned,
    @Default(<ParentCollectedWordDto>[]) List<ParentCollectedWordDto> wordsCollected,
    String? readingMode,
    ParentRetellBriefDto? retell,
  }) = _ParentReadingFeedbackItemDto;

  factory ParentReadingFeedbackItemDto.fromJson(Map<String, dynamic> json) =>
      _$ParentReadingFeedbackItemDtoFromJson(json);
}

@freezed
abstract class ConversationAnswerDto with _$ConversationAnswerDto {
  const factory ConversationAnswerDto({
    @Default('') String question,
    /// "Emotion" hoặc "Opinion".
    @Default('') String kind,
    @Default('') String answerText,
    /// Cảnh có câu hỏi (đếm từ 0); null nếu không còn tìm thấy.
    int? sceneIndex,
    DateTime? answeredAt,
  }) = _ConversationAnswerDto;

  factory ConversationAnswerDto.fromJson(Map<String, dynamic> json) =>
      _$ConversationAnswerDtoFromJson(json);
}

@freezed
abstract class ParentReadAloudSummaryDto with _$ParentReadAloudSummaryDto {
  const factory ParentReadAloudSummaryDto({
    @Default(0) int attempts,
    @Default(0) int segmentsPracticed,
    @Default(0) int goodWords,
    @Default(0) int retryWords,
    @Default(0) int totalWords,
    @Default(0.0) double goodPercent,
  }) = _ParentReadAloudSummaryDto;

  factory ParentReadAloudSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$ParentReadAloudSummaryDtoFromJson(json);
}

@freezed
abstract class ParentReadAloudPracticeDto with _$ParentReadAloudPracticeDto {
  const factory ParentReadAloudPracticeDto({
    @Default(0) int attempts,
    @Default(0) int totalWords,
    @Default(0) int latestGoodWords,
    @Default(0.0) double latestGoodPercent,
    @Default(0.0) double bestGoodPercent,
  }) = _ParentReadAloudPracticeDto;

  factory ParentReadAloudPracticeDto.fromJson(Map<String, dynamic> json) =>
      _$ParentReadAloudPracticeDtoFromJson(json);
}

@freezed
abstract class StoryEmotionDto with _$StoryEmotionDto {
  const factory StoryEmotionDto({
    @Default('') String code,
    @Default('') String label,
  }) = _StoryEmotionDto;

  factory StoryEmotionDto.fromJson(Map<String, dynamic> json) =>
      _$StoryEmotionDtoFromJson(json);
}

@freezed
abstract class ParentReflectionBriefDto with _$ParentReflectionBriefDto {
  const factory ParentReflectionBriefDto({
    @Default(0) int favoriteSceneId,
    int? favoriteSceneIndex,
    @Default(false) bool hasNoteText,
    @Default(false) bool hasNoteRecording,
  }) = _ParentReflectionBriefDto;

  factory ParentReflectionBriefDto.fromJson(Map<String, dynamic> json) =>
      _$ParentReflectionBriefDtoFromJson(json);
}

@freezed
abstract class ParentCollectedWordDto with _$ParentCollectedWordDto {
  const factory ParentCollectedWordDto({
    @Default(0) int vocabularyId,
    @Default('') String term,
  }) = _ParentCollectedWordDto;

  factory ParentCollectedWordDto.fromJson(Map<String, dynamic> json) =>
      _$ParentCollectedWordDtoFromJson(json);
}

@freezed
abstract class ParentRetellBriefDto with _$ParentRetellBriefDto {
  const factory ParentRetellBriefDto({
    @Default(0) int summaryId,
    @Default('') String createdAt,
    @Default(false) bool hasRecording,
    @Default(0) int flagCount,
    @Default(0) int unansweredCount,
  }) = _ParentRetellBriefDto;

  factory ParentRetellBriefDto.fromJson(Map<String, dynamic> json) =>
      _$ParentRetellBriefDtoFromJson(json);
}

// --- DTO cho GET /ParentReadingFeedback/{childId}/sessions/{sessionId}/reflection ---

@freezed
abstract class ParentFavoriteSceneDto with _$ParentFavoriteSceneDto {
  const factory ParentFavoriteSceneDto({
    @Default(0) int sceneId,
    @Default(0) int sceneIndex,
    @Default('') String sceneText,
    String? illustrationUrl,
  }) = _ParentFavoriteSceneDto;

  factory ParentFavoriteSceneDto.fromJson(Map<String, dynamic> json) =>
      _$ParentFavoriteSceneDtoFromJson(json);
}

@freezed
abstract class ParentStoryReflectionDto with _$ParentStoryReflectionDto {
  const factory ParentStoryReflectionDto({
    @Default(0) int sessionId,
    @Default(<StoryEmotionDto>[]) List<StoryEmotionDto> emotions,
    ParentFavoriteSceneDto? favoriteScene,
    String? noteText,
    String? noteAudioUrl,
    String? noteSentAt,
  }) = _ParentStoryReflectionDto;

  factory ParentStoryReflectionDto.fromJson(Map<String, dynamic> json) =>
      _$ParentStoryReflectionDtoFromJson(json);
}

@freezed
abstract class ParentReadingFeedbackPageDto with _$ParentReadingFeedbackPageDto {
  const factory ParentReadingFeedbackPageDto({
    @Default(<ParentReadingFeedbackItemDto>[])
    List<ParentReadingFeedbackItemDto> items,
    @Default(0) int totalCount,
    @Default(0) int pageIndex,
    @Default(0) int pageSize,
    @Default(0) int totalPages,
    @Default(false) bool hasNextPage,
    @Default(false) bool hasPreviousPage,
  }) = _ParentReadingFeedbackPageDto;

  factory ParentReadingFeedbackPageDto.fromJson(Map<String, dynamic> json) =>
      _$ParentReadingFeedbackPageDtoFromJson(json);
}
