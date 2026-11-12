// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_segment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReadingSegmentDto _$ReadingSegmentDtoFromJson(Map<String, dynamic> json) =>
    _ReadingSegmentDto(
      segmentId: (json['segmentId'] as num).toInt(),
      segmentOrder: (json['segmentOrder'] as num).toInt(),
      startOffset: (json['startOffset'] as num?)?.toInt(),
      endOffset: (json['endOffset'] as num?)?.toInt(),
      text: json['text'] as String? ?? '',
      audioUrl: json['audioUrl'] as String?,
      wordTimingsJson: json['wordTimingsJson'] as String?,
    );

Map<String, dynamic> _$ReadingSegmentDtoToJson(_ReadingSegmentDto instance) =>
    <String, dynamic>{
      'segmentId': instance.segmentId,
      'segmentOrder': instance.segmentOrder,
      'startOffset': instance.startOffset,
      'endOffset': instance.endOffset,
      'text': instance.text,
      'audioUrl': instance.audioUrl,
      'wordTimingsJson': instance.wordTimingsJson,
    };

_SceneIllustrationDto _$SceneIllustrationDtoFromJson(
  Map<String, dynamic> json,
) => _SceneIllustrationDto(
  beatOrder: (json['beatOrder'] as num?)?.toInt() ?? 0,
  startOffset: (json['startOffset'] as num?)?.toInt() ?? 0,
  endOffset: (json['endOffset'] as num?)?.toInt() ?? 0,
  url: json['url'] as String?,
);

Map<String, dynamic> _$SceneIllustrationDtoToJson(
  _SceneIllustrationDto instance,
) => <String, dynamic>{
  'beatOrder': instance.beatOrder,
  'startOffset': instance.startOffset,
  'endOffset': instance.endOffset,
  'url': instance.url,
};
