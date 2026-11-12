import 'package:freezed_annotation/freezed_annotation.dart';

import 'reading_interaction_dto.dart';
import 'reading_segment_dto.dart';

part 'reading_content_dto.freezed.dart';
part 'reading_content_dto.g.dart';

@freezed
abstract class ReadingVocabularyDto with _$ReadingVocabularyDto {
  const factory ReadingVocabularyDto({
    required int id,
    required String term,
  }) = _ReadingVocabularyDto;

  factory ReadingVocabularyDto.fromJson(Map<String, dynamic> json) =>
      _$ReadingVocabularyDtoFromJson(json);
}

@freezed
abstract class ReadingSceneDto with _$ReadingSceneDto {
  const factory ReadingSceneDto({
    required int sceneId,
    required int sceneIndex,
    @Default('') String text,
    String? illustrationUrl,
    @Default(<SceneIllustrationDto>[]) List<SceneIllustrationDto> illustrations,
    @Default(<ReadingSegmentDto>[]) List<ReadingSegmentDto> segments,
    ReadingInteractionDto? interaction,
    @Default(false) bool attemptedInSession,
  }) = _ReadingSceneDto;

  factory ReadingSceneDto.fromJson(Map<String, dynamic> json) =>
      _$ReadingSceneDtoFromJson(json);
}

@freezed
abstract class ReadingContentDto with _$ReadingContentDto {
  const factory ReadingContentDto({
    required int sessionId,
    required int storyId,
    @Default('') String title,
    String? lesson,
    @Default(false) bool listenOnly,
    @Default(<ReadingSceneDto>[]) List<ReadingSceneDto> scenes,
    @Default(<ReadingVocabularyDto>[]) List<ReadingVocabularyDto> vocabulary,
  }) = _ReadingContentDto;

  factory ReadingContentDto.fromJson(Map<String, dynamic> json) =>
      _$ReadingContentDtoFromJson(json);
}
