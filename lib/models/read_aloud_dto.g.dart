// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_aloud_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReadAloudWordDto _$ReadAloudWordDtoFromJson(Map<String, dynamic> json) =>
    _ReadAloudWordDto(
      index: (json['index'] as num).toInt(),
      text: json['text'] as String,
      status: json['status'] as String? ?? 'skipped',
      hint: json['hint'] as String?,
    );

Map<String, dynamic> _$ReadAloudWordDtoToJson(_ReadAloudWordDto instance) =>
    <String, dynamic>{
      'index': instance.index,
      'text': instance.text,
      'status': instance.status,
      'hint': instance.hint,
    };

_ReadAloudResultDto _$ReadAloudResultDtoFromJson(Map<String, dynamic> json) =>
    _ReadAloudResultDto(
      sessionId: (json['sessionId'] as num).toInt(),
      segmentId: (json['segmentId'] as num).toInt(),
      words:
          (json['words'] as List<dynamic>?)
              ?.map((e) => ReadAloudWordDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ReadAloudWordDto>[],
      goodCount: (json['goodCount'] as num?)?.toInt() ?? 0,
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      skippedCount: (json['skippedCount'] as num?)?.toInt() ?? 0,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$ReadAloudResultDtoToJson(_ReadAloudResultDto instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'segmentId': instance.segmentId,
      'words': instance.words,
      'goodCount': instance.goodCount,
      'retryCount': instance.retryCount,
      'skippedCount': instance.skippedCount,
      'totalCount': instance.totalCount,
      'message': instance.message,
    };
