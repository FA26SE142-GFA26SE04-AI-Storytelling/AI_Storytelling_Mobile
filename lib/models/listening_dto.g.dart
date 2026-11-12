// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listening_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListeningAttemptResultDto _$ListeningAttemptResultDtoFromJson(
  Map<String, dynamic> json,
) => _ListeningAttemptResultDto(
  interactionId: (json['interactionId'] as num).toInt(),
  type: json['type'] as String,
  matched: json['matched'] as bool?,
  feedback: json['feedback'] as String?,
  feedbackAudioUrl: json['feedbackAudioUrl'] as String?,
  suggestedAnswer: json['suggestedAnswer'] as String?,
  replaySceneIndexes:
      (json['replaySceneIndexes'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
  revealed: json['revealed'] as bool? ?? false,
  correctOrderOptionIds: (json['correctOrderOptionIds'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$ListeningAttemptResultDtoToJson(
  _ListeningAttemptResultDto instance,
) => <String, dynamic>{
  'interactionId': instance.interactionId,
  'type': instance.type,
  'matched': instance.matched,
  'feedback': instance.feedback,
  'feedbackAudioUrl': instance.feedbackAudioUrl,
  'suggestedAnswer': instance.suggestedAnswer,
  'replaySceneIndexes': instance.replaySceneIndexes,
  'revealed': instance.revealed,
  'correctOrderOptionIds': instance.correctOrderOptionIds,
};
