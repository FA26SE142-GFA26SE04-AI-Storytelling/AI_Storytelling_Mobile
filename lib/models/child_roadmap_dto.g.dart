// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_roadmap_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChildRoadmapItemDto _$ChildRoadmapItemDtoFromJson(Map<String, dynamic> json) =>
    _ChildRoadmapItemDto(
      id: (json['id'] as num).toInt(),
      storyId: (json['storyId'] as num).toInt(),
      title: json['title'] as String?,
      position: (json['position'] as num?)?.toInt() ?? 0,
      status: json['status'] as String,
      source: json['source'] as String? ?? '',
      skipReason: json['skipReason'] as String?,
      note: json['note'] as String?,
      expectedDays: (json['expectedDays'] as num?)?.toInt(),
      expectedCompletionAt: json['expectedCompletionAt'] == null
          ? null
          : DateTime.parse(json['expectedCompletionAt'] as String),
      openedAt: json['openedAt'] == null
          ? null
          : DateTime.parse(json['openedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      addedByUserId: (json['addedByUserId'] as num?)?.toInt(),
      isStoryAvailable: json['isStoryAvailable'] as bool? ?? true,
    );

Map<String, dynamic> _$ChildRoadmapItemDtoToJson(
  _ChildRoadmapItemDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'storyId': instance.storyId,
  'title': instance.title,
  'position': instance.position,
  'status': instance.status,
  'source': instance.source,
  'skipReason': instance.skipReason,
  'note': instance.note,
  'expectedDays': instance.expectedDays,
  'expectedCompletionAt': instance.expectedCompletionAt?.toIso8601String(),
  'openedAt': instance.openedAt?.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'addedByUserId': instance.addedByUserId,
  'isStoryAvailable': instance.isStoryAvailable,
};

_ChildRoadmapDto _$ChildRoadmapDtoFromJson(
  Map<String, dynamic> json,
) => _ChildRoadmapDto(
  childProfileId: (json['childProfileId'] as num).toInt(),
  open: json['open'] == null
      ? null
      : ChildRoadmapItemDto.fromJson(json['open'] as Map<String, dynamic>),
  waiting:
      (json['waiting'] as List<dynamic>?)
          ?.map((e) => ChildRoadmapItemDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ChildRoadmapItemDto>[],
  history:
      (json['history'] as List<dynamic>?)
          ?.map((e) => ChildRoadmapItemDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ChildRoadmapItemDto>[],
  completedCount: (json['completedCount'] as num?)?.toInt() ?? 0,
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ChildRoadmapDtoToJson(_ChildRoadmapDto instance) =>
    <String, dynamic>{
      'childProfileId': instance.childProfileId,
      'open': instance.open,
      'waiting': instance.waiting,
      'history': instance.history,
      'completedCount': instance.completedCount,
      'totalCount': instance.totalCount,
    };
