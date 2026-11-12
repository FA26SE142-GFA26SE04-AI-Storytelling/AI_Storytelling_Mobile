import 'package:freezed_annotation/freezed_annotation.dart';

part 'reading_start_dto.freezed.dart';
part 'reading_start_dto.g.dart';

@freezed
abstract class ReadingStartedDto with _$ReadingStartedDto {
  const factory ReadingStartedDto({
    required int sessionId,
    required int storyId,
    @Default(false) bool resumed,
    @Default(1) int lastPage,
    String? lastReadingMode,
    @Default(false) bool isBookmarked,
    @Default(false) bool isFavorited,
    bool? listenOnly,
  }) = _ReadingStartedDto;

  factory ReadingStartedDto.fromJson(Map<String, dynamic> json) =>
      _$ReadingStartedDtoFromJson(json);
}

@freezed
abstract class ReadingFlagsDto with _$ReadingFlagsDto {
  const factory ReadingFlagsDto({
    @Default(false) bool isBookmarked,
    @Default(false) bool isFavorited,
    bool? listenOnly,
  }) = _ReadingFlagsDto;

  factory ReadingFlagsDto.fromJson(Map<String, dynamic> json) =>
      _$ReadingFlagsDtoFromJson(json);
}

@freezed
abstract class ReadingProgressDto with _$ReadingProgressDto {
  const factory ReadingProgressDto({
    required int sessionId,
    required int page,
    String? readingMode,
    @Default(0) int timeSpentSeconds,
  }) = _ReadingProgressDto;

  factory ReadingProgressDto.fromJson(Map<String, dynamic> json) =>
      _$ReadingProgressDtoFromJson(json);
}

@freezed
abstract class ReadingCompletedDto with _$ReadingCompletedDto {
  const factory ReadingCompletedDto({
    required int sessionId,
    required int storyId,
    @Default(false) bool isRetake,
    @Default(false) bool roadmapStepCompleted,
    @Default(0) int expGained,
    @Default(<String>[]) List<String> newBadges,
  }) = _ReadingCompletedDto;

  factory ReadingCompletedDto.fromJson(Map<String, dynamic> json) =>
      _$ReadingCompletedDtoFromJson(json);
}

@freezed
abstract class ReadingSignalDto with _$ReadingSignalDto {
  const factory ReadingSignalDto({
    @Default(false) bool shouldExit,
    String? returnTo,
    String? message,
    String? sessionStatus,
  }) = _ReadingSignalDto;

  factory ReadingSignalDto.fromJson(Map<String, dynamic> json) =>
      _$ReadingSignalDtoFromJson(json);
}

@freezed
abstract class VocabularyDefinitionDto with _$VocabularyDefinitionDto {
  const factory VocabularyDefinitionDto({
    required int vocabularyId,
    required String term,
    @Default('') String definition,
    @Default(false) bool isCollected,
  }) = _VocabularyDefinitionDto;

  factory VocabularyDefinitionDto.fromJson(Map<String, dynamic> json) =>
      _$VocabularyDefinitionDtoFromJson(json);
}
