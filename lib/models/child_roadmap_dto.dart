import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_roadmap_dto.freezed.dart';
part 'child_roadmap_dto.g.dart';

@freezed
abstract class ChildRoadmapItemDto with _$ChildRoadmapItemDto {
  const factory ChildRoadmapItemDto({
    required int id,
    required int storyId,
    String? title,
    @Default(0) int position,
    required String status,
    @Default('') String source,
    String? skipReason,
    String? note,
    int? expectedDays,
    DateTime? expectedCompletionAt,
    DateTime? openedAt,
    DateTime? completedAt,
    int? addedByUserId,
    @Default(true) bool isStoryAvailable,
  }) = _ChildRoadmapItemDto;

  factory ChildRoadmapItemDto.fromJson(Map<String, dynamic> json) =>
      _$ChildRoadmapItemDtoFromJson(json);
}

@freezed
abstract class ChildRoadmapDto with _$ChildRoadmapDto {
  const factory ChildRoadmapDto({
    required int childProfileId,
    ChildRoadmapItemDto? open,
    @Default(<ChildRoadmapItemDto>[]) List<ChildRoadmapItemDto> waiting,
    @Default(<ChildRoadmapItemDto>[]) List<ChildRoadmapItemDto> history,
    @Default(0) int completedCount,
    @Default(0) int totalCount,
  }) = _ChildRoadmapDto;

  // Backend đổi `open` thành danh sách `openItems` (các truyện đang mở của chặng hiện tại).
  // shortcut: chỉ lấy truyện đầu làm "Đang đọc"; chặng mở nhiều truyện thì cần hiện cả danh sách.
  factory ChildRoadmapDto.fromJson(Map<String, dynamic> json) =>
      _$ChildRoadmapDtoFromJson({
        ...json,
        if (json['open'] == null && json['openItems'] is List &&
            (json['openItems'] as List).isNotEmpty)
          'open': (json['openItems'] as List).first,
      });
}
