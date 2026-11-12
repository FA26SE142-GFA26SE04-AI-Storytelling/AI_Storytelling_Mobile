import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_roadmap_dto.freezed.dart';
part 'my_roadmap_dto.g.dart';

@freezed
abstract class MyRoadmapOpenStoryDto with _$MyRoadmapOpenStoryDto {
  const factory MyRoadmapOpenStoryDto({
    required int storyId,
    String? title,
    String? coverImageUrl,
    String? note,
    String? expectedBy,
    @Default(false) bool isLocked,
  }) = _MyRoadmapOpenStoryDto;

  factory MyRoadmapOpenStoryDto.fromJson(Map<String, dynamic> json) =>
      _$MyRoadmapOpenStoryDtoFromJson(json);
}

@freezed
abstract class MyRoadmapUpcomingDto with _$MyRoadmapUpcomingDto {
  const factory MyRoadmapUpcomingDto({
    required int order,
    required int storyId,
    String? title,
    String? coverImageUrl,
    @Default(false) bool isLocked,
  }) = _MyRoadmapUpcomingDto;

  factory MyRoadmapUpcomingDto.fromJson(Map<String, dynamic> json) =>
      _$MyRoadmapUpcomingDtoFromJson(json);
}

@freezed
abstract class MyRoadmapDoneDto with _$MyRoadmapDoneDto {
  const factory MyRoadmapDoneDto({
    required int storyId,
    String? title,
    String? coverImageUrl,
    String? completedAt,
  }) = _MyRoadmapDoneDto;

  factory MyRoadmapDoneDto.fromJson(Map<String, dynamic> json) =>
      _$MyRoadmapDoneDtoFromJson(json);
}

@freezed
abstract class MyRoadmapDto with _$MyRoadmapDto {
  const factory MyRoadmapDto({
    MyRoadmapOpenStoryDto? open,
    @Default(<MyRoadmapUpcomingDto>[]) List<MyRoadmapUpcomingDto> upcoming,
    @Default(<MyRoadmapDoneDto>[]) List<MyRoadmapDoneDto> done,
    @Default(0) int completedCount,
    @Default(0) int totalCount,
    @Default(false) bool isFinished,
  }) = _MyRoadmapDto;

  factory MyRoadmapDto.fromJson(Map<String, dynamic> json) =>
      _$MyRoadmapDtoFromJson(json);
}
