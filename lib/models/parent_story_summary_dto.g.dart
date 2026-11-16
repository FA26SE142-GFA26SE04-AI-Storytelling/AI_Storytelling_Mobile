// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_story_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParentStorySummaryFlagDto _$ParentStorySummaryFlagDtoFromJson(
  Map<String, dynamic> json,
) => _ParentStorySummaryFlagDto(
  sceneId: (json['sceneId'] as num).toInt(),
  sceneIndex: (json['sceneIndex'] as num?)?.toInt() ?? 0,
  sceneText: json['sceneText'] as String? ?? '',
  illustrationUrl: json['illustrationUrl'] as String?,
);

Map<String, dynamic> _$ParentStorySummaryFlagDtoToJson(
  _ParentStorySummaryFlagDto instance,
) => <String, dynamic>{
  'sceneId': instance.sceneId,
  'sceneIndex': instance.sceneIndex,
  'sceneText': instance.sceneText,
  'illustrationUrl': instance.illustrationUrl,
};

_ParentStorySummaryItemDto _$ParentStorySummaryItemDtoFromJson(
  Map<String, dynamic> json,
) => _ParentStorySummaryItemDto(
  summaryId: (json['summaryId'] as num).toInt(),
  sessionId: (json['sessionId'] as num?)?.toInt() ?? 0,
  storyId: (json['storyId'] as num?)?.toInt() ?? 0,
  title: json['title'] as String? ?? '',
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  recordingUrl: json['recordingUrl'] as String?,
  recordingSentAt: json['recordingSentAt'] == null
      ? null
      : DateTime.parse(json['recordingSentAt'] as String),
  flagsSentAt: json['flagsSentAt'] == null
      ? null
      : DateTime.parse(json['flagsSentAt'] as String),
  flags:
      (json['flags'] as List<dynamic>?)
          ?.map(
            (e) =>
                ParentStorySummaryFlagDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <ParentStorySummaryFlagDto>[],
);

Map<String, dynamic> _$ParentStorySummaryItemDtoToJson(
  _ParentStorySummaryItemDto instance,
) => <String, dynamic>{
  'summaryId': instance.summaryId,
  'sessionId': instance.sessionId,
  'storyId': instance.storyId,
  'title': instance.title,
  'createdAt': instance.createdAt?.toIso8601String(),
  'recordingUrl': instance.recordingUrl,
  'recordingSentAt': instance.recordingSentAt?.toIso8601String(),
  'flagsSentAt': instance.flagsSentAt?.toIso8601String(),
  'flags': instance.flags,
};

_ParentStorySummaryPageDto _$ParentStorySummaryPageDtoFromJson(
  Map<String, dynamic> json,
) => _ParentStorySummaryPageDto(
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) =>
                ParentStorySummaryItemDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <ParentStorySummaryItemDto>[],
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  pageIndex: (json['pageIndex'] as num?)?.toInt() ?? 0,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 0,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
  hasNextPage: json['hasNextPage'] as bool? ?? false,
  hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
);

Map<String, dynamic> _$ParentStorySummaryPageDtoToJson(
  _ParentStorySummaryPageDto instance,
) => <String, dynamic>{
  'items': instance.items,
  'totalCount': instance.totalCount,
  'pageIndex': instance.pageIndex,
  'pageSize': instance.pageSize,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPreviousPage': instance.hasPreviousPage,
};
