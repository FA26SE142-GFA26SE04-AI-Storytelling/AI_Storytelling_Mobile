import 'package:freezed_annotation/freezed_annotation.dart';

part 'parent_story_summary_dto.freezed.dart';
part 'parent_story_summary_dto.g.dart';

/// Một cảnh bé còn thắc mắc trong phần kể lại.
@freezed
abstract class ParentStorySummaryFlagDto with _$ParentStorySummaryFlagDto {
  const factory ParentStorySummaryFlagDto({
    required int sceneId,
    @Default(0) int sceneIndex,
    @Default('') String sceneText,
    String? illustrationUrl,
  }) = _ParentStorySummaryFlagDto;

  factory ParentStorySummaryFlagDto.fromJson(Map<String, dynamic> json) =>
      _$ParentStorySummaryFlagDtoFromJson(json);
}

/// Phần bé kể lại cuối truyện (GET /ParentStorySummary/{childId}).
@freezed
abstract class ParentStorySummaryItemDto with _$ParentStorySummaryItemDto {
  const factory ParentStorySummaryItemDto({
    required int summaryId,
    @Default(0) int sessionId,
    @Default(0) int storyId,
    @Default('') String title,
    DateTime? createdAt,
    /// Link nghe ký sẵn, hết hạn sau 15 phút; null khi bé không ghi âm.
    String? recordingUrl,
    DateTime? recordingSentAt,
    DateTime? flagsSentAt,
    @Default(<ParentStorySummaryFlagDto>[])
    List<ParentStorySummaryFlagDto> flags,
  }) = _ParentStorySummaryItemDto;

  factory ParentStorySummaryItemDto.fromJson(Map<String, dynamic> json) =>
      _$ParentStorySummaryItemDtoFromJson(json);
}

@freezed
abstract class ParentStorySummaryPageDto with _$ParentStorySummaryPageDto {
  const factory ParentStorySummaryPageDto({
    @Default(<ParentStorySummaryItemDto>[])
    List<ParentStorySummaryItemDto> items,
    @Default(0) int totalCount,
    @Default(0) int pageIndex,
    @Default(0) int pageSize,
    @Default(0) int totalPages,
    @Default(false) bool hasNextPage,
    @Default(false) bool hasPreviousPage,
  }) = _ParentStorySummaryPageDto;

  factory ParentStorySummaryPageDto.fromJson(Map<String, dynamic> json) =>
      _$ParentStorySummaryPageDtoFromJson(json);
}
