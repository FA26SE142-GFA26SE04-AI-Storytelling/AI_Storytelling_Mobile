// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_read_aloud_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReadAloudWord _$ReadAloudWordFromJson(Map<String, dynamic> json) =>
    _ReadAloudWord(
      index: (json['index'] as num).toInt(),
      text: json['text'] as String? ?? '',
      status: json['status'] as String? ?? 'good',
      hint: json['hint'] as String?,
    );

Map<String, dynamic> _$ReadAloudWordToJson(_ReadAloudWord instance) =>
    <String, dynamic>{
      'index': instance.index,
      'text': instance.text,
      'status': instance.status,
      'hint': instance.hint,
    };

_ReadAloudResult _$ReadAloudResultFromJson(Map<String, dynamic> json) =>
    _ReadAloudResult(
      sessionId: (json['sessionId'] as num).toInt(),
      segmentId: (json['segmentId'] as num?)?.toInt(),
      interactionId: (json['interactionId'] as num?)?.toInt(),
      words:
          (json['words'] as List<dynamic>?)
              ?.map((e) => ReadAloudWord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ReadAloudWord>[],
      goodCount: (json['goodCount'] as num?)?.toInt() ?? 0,
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      skippedCount: (json['skippedCount'] as num?)?.toInt() ?? 0,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$ReadAloudResultToJson(_ReadAloudResult instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'segmentId': instance.segmentId,
      'interactionId': instance.interactionId,
      'words': instance.words,
      'goodCount': instance.goodCount,
      'retryCount': instance.retryCount,
      'skippedCount': instance.skippedCount,
      'totalCount': instance.totalCount,
      'message': instance.message,
    };
