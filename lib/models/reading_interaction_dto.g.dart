// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_interaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InteractionOptionDto _$InteractionOptionDtoFromJson(
  Map<String, dynamic> json,
) => _InteractionOptionDto(
  id: (json['id'] as num).toInt(),
  text: json['text'] as String,
  imageUrl: json['imageUrl'] as String?,
  audioUrl: json['audioUrl'] as String?,
  feedback: json['feedback'] as String?,
  feedbackAudioUrl: json['feedbackAudioUrl'] as String?,
);

Map<String, dynamic> _$InteractionOptionDtoToJson(
  _InteractionOptionDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'imageUrl': instance.imageUrl,
  'audioUrl': instance.audioUrl,
  'feedback': instance.feedback,
  'feedbackAudioUrl': instance.feedbackAudioUrl,
};

_ReadingInteractionDto _$ReadingInteractionDtoFromJson(
  Map<String, dynamic> json,
) => _ReadingInteractionDto(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String,
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
          ?.map((e) => InteractionOptionDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <InteractionOptionDto>[],
);

Map<String, dynamic> _$ReadingInteractionDtoToJson(
  _ReadingInteractionDto instance,
) => <String, dynamic>{
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
