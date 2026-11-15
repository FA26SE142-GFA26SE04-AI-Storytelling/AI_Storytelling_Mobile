// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_interaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InteractionOption _$InteractionOptionFromJson(Map<String, dynamic> json) =>
    _InteractionOption(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
      feedback: json['feedback'] as String?,
      feedbackAudioUrl: json['feedbackAudioUrl'] as String?,
    );

Map<String, dynamic> _$InteractionOptionToJson(_InteractionOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'imageUrl': instance.imageUrl,
      'audioUrl': instance.audioUrl,
      'feedback': instance.feedback,
      'feedbackAudioUrl': instance.feedbackAudioUrl,
    };

_ReadingInteraction _$ReadingInteractionFromJson(Map<String, dynamic> json) =>
    _ReadingInteraction(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? '',
      kind: json['kind'] as String?,
      prompt: json['prompt'] as String?,
      characterName: json['characterName'] as String?,
      modelSentence: json['modelSentence'] as String?,
      modelAudioUrl: json['modelAudioUrl'] as String?,
      maskedSentence: json['maskedSentence'] as String?,
      hint: json['hint'] as String?,
      waitFeedback: json['waitFeedback'] as String?,
      revealSceneIndex: (json['revealSceneIndex'] as num?)?.toInt(),
      audioUrls:
          (json['audioUrls'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
      options:
          (json['options'] as List<dynamic>?)
              ?.map(
                (e) => InteractionOption.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <InteractionOption>[],
    );

Map<String, dynamic> _$ReadingInteractionToJson(_ReadingInteraction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'kind': instance.kind,
      'prompt': instance.prompt,
      'characterName': instance.characterName,
      'modelSentence': instance.modelSentence,
      'modelAudioUrl': instance.modelAudioUrl,
      'maskedSentence': instance.maskedSentence,
      'hint': instance.hint,
      'waitFeedback': instance.waitFeedback,
      'revealSceneIndex': instance.revealSceneIndex,
      'audioUrls': instance.audioUrls,
      'options': instance.options,
    };

_ListeningAttemptResult _$ListeningAttemptResultFromJson(
  Map<String, dynamic> json,
) => _ListeningAttemptResult(
  interactionId: (json['interactionId'] as num).toInt(),
  type: json['type'] as String? ?? '',
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

Map<String, dynamic> _$ListeningAttemptResultToJson(
  _ListeningAttemptResult instance,
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
