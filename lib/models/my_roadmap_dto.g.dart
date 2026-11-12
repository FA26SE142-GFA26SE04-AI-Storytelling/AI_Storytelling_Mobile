// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_roadmap_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MyRoadmapOpenStoryDto _$MyRoadmapOpenStoryDtoFromJson(
  Map<String, dynamic> json,
) => _MyRoadmapOpenStoryDto(
  storyId: (json['storyId'] as num).toInt(),
  title: json['title'] as String?,
  coverImageUrl: json['coverImageUrl'] as String?,
  note: json['note'] as String?,
  expectedBy: json['expectedBy'] as String?,
  isLocked: json['isLocked'] as bool? ?? false,
);

Map<String, dynamic> _$MyRoadmapOpenStoryDtoToJson(
  _MyRoadmapOpenStoryDto instance,
) => <String, dynamic>{
  'storyId': instance.storyId,
  'title': instance.title,
  'coverImageUrl': instance.coverImageUrl,
  'note': instance.note,
  'expectedBy': instance.expectedBy,
  'isLocked': instance.isLocked,
};

_MyRoadmapUpcomingDto _$MyRoadmapUpcomingDtoFromJson(
  Map<String, dynamic> json,
) => _MyRoadmapUpcomingDto(
  order: (json['order'] as num).toInt(),
  storyId: (json['storyId'] as num).toInt(),
  title: json['title'] as String?,
  coverImageUrl: json['coverImageUrl'] as String?,
  isLocked: json['isLocked'] as bool? ?? false,
);

Map<String, dynamic> _$MyRoadmapUpcomingDtoToJson(
  _MyRoadmapUpcomingDto instance,
) => <String, dynamic>{
  'order': instance.order,
  'storyId': instance.storyId,
  'title': instance.title,
  'coverImageUrl': instance.coverImageUrl,
  'isLocked': instance.isLocked,
};

_MyRoadmapDoneDto _$MyRoadmapDoneDtoFromJson(Map<String, dynamic> json) =>
    _MyRoadmapDoneDto(
      storyId: (json['storyId'] as num).toInt(),
      title: json['title'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      completedAt: json['completedAt'] as String?,
    );

Map<String, dynamic> _$MyRoadmapDoneDtoToJson(_MyRoadmapDoneDto instance) =>
    <String, dynamic>{
      'storyId': instance.storyId,
      'title': instance.title,
      'coverImageUrl': instance.coverImageUrl,
      'completedAt': instance.completedAt,
    };

_MyRoadmapDto _$MyRoadmapDtoFromJson(
  Map<String, dynamic> json,
) => _MyRoadmapDto(
  open: json['open'] == null
      ? null
      : MyRoadmapOpenStoryDto.fromJson(json['open'] as Map<String, dynamic>),
  upcoming:
      (json['upcoming'] as List<dynamic>?)
          ?.map((e) => MyRoadmapUpcomingDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MyRoadmapUpcomingDto>[],
  done:
      (json['done'] as List<dynamic>?)
          ?.map((e) => MyRoadmapDoneDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MyRoadmapDoneDto>[],
  completedCount: (json['completedCount'] as num?)?.toInt() ?? 0,
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  isFinished: json['isFinished'] as bool? ?? false,
);

Map<String, dynamic> _$MyRoadmapDtoToJson(_MyRoadmapDto instance) =>
    <String, dynamic>{
      'open': instance.open,
      'upcoming': instance.upcoming,
      'done': instance.done,
      'completedCount': instance.completedCount,
      'totalCount': instance.totalCount,
      'isFinished': instance.isFinished,
    };
