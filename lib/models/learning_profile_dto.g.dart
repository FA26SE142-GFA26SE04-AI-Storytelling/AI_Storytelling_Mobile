// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LearningTopicDto _$LearningTopicDtoFromJson(Map<String, dynamic> json) =>
    _LearningTopicDto(
      topic: json['topic'] as String,
      relation: json['relation'] as String,
    );

Map<String, dynamic> _$LearningTopicDtoToJson(_LearningTopicDto instance) =>
    <String, dynamic>{'topic': instance.topic, 'relation': instance.relation};

_LearningProfileDto _$LearningProfileDtoFromJson(Map<String, dynamic> json) =>
    _LearningProfileDto(
      id: (json['id'] as num).toInt(),
      childProfileId: (json['childProfileId'] as num).toInt(),
      readingLevel: (json['readingLevel'] as num).toInt(),
      readingMode: json['readingMode'] as String?,
      comprehensionGoal: json['comprehensionGoal'] as String?,
      topics:
          (json['topics'] as List<dynamic>?)
              ?.map((e) => LearningTopicDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LearningProfileDtoToJson(_LearningProfileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'childProfileId': instance.childProfileId,
      'readingLevel': instance.readingLevel,
      'readingMode': instance.readingMode,
      'comprehensionGoal': instance.comprehensionGoal,
      'topics': instance.topics,
    };
