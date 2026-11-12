// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_content_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReadingVocabularyDto _$ReadingVocabularyDtoFromJson(
  Map<String, dynamic> json,
) => _ReadingVocabularyDto(
  id: (json['id'] as num).toInt(),
  term: json['term'] as String,
);

Map<String, dynamic> _$ReadingVocabularyDtoToJson(
  _ReadingVocabularyDto instance,
) => <String, dynamic>{'id': instance.id, 'term': instance.term};

_ReadingSceneDto _$ReadingSceneDtoFromJson(
  Map<String, dynamic> json,
) => _ReadingSceneDto(
  sceneId: (json['sceneId'] as num).toInt(),
  sceneIndex: (json['sceneIndex'] as num).toInt(),
  text: json['text'] as String? ?? '',
  illustrationUrl: json['illustrationUrl'] as String?,
  illustrations:
      (json['illustrations'] as List<dynamic>?)
          ?.map((e) => SceneIllustrationDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SceneIllustrationDto>[],
  segments:
      (json['segments'] as List<dynamic>?)
          ?.map((e) => ReadingSegmentDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ReadingSegmentDto>[],
  interaction: json['interaction'] == null
      ? null
      : ReadingInteractionDto.fromJson(
          json['interaction'] as Map<String, dynamic>,
        ),
  attemptedInSession: json['attemptedInSession'] as bool? ?? false,
);

Map<String, dynamic> _$ReadingSceneDtoToJson(_ReadingSceneDto instance) =>
    <String, dynamic>{
      'sceneId': instance.sceneId,
      'sceneIndex': instance.sceneIndex,
      'text': instance.text,
      'illustrationUrl': instance.illustrationUrl,
      'illustrations': instance.illustrations,
      'segments': instance.segments,
      'interaction': instance.interaction,
      'attemptedInSession': instance.attemptedInSession,
    };

_ReadingContentDto _$ReadingContentDtoFromJson(Map<String, dynamic> json) =>
    _ReadingContentDto(
      sessionId: (json['sessionId'] as num).toInt(),
      storyId: (json['storyId'] as num).toInt(),
      title: json['title'] as String? ?? '',
      lesson: json['lesson'] as String?,
      listenOnly: json['listenOnly'] as bool? ?? false,
      scenes:
          (json['scenes'] as List<dynamic>?)
              ?.map((e) => ReadingSceneDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ReadingSceneDto>[],
      vocabulary:
          (json['vocabulary'] as List<dynamic>?)
              ?.map(
                (e) => ReadingVocabularyDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <ReadingVocabularyDto>[],
    );

Map<String, dynamic> _$ReadingContentDtoToJson(_ReadingContentDto instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'storyId': instance.storyId,
      'title': instance.title,
      'lesson': instance.lesson,
      'listenOnly': instance.listenOnly,
      'scenes': instance.scenes,
      'vocabulary': instance.vocabulary,
    };
