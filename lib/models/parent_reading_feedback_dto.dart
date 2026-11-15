import 'package:freezed_annotation/freezed_annotation.dart';

part 'parent_reading_feedback_dto.freezed.dart';
part 'parent_reading_feedback_dto.g.dart';

@freezed
abstract class ParentReadingFeedbackItemDto with _$ParentReadingFeedbackItemDto {
  const factory ParentReadingFeedbackItemDto({
    required int sessionId,
    required int storyId,
    required String title,
    DateTime? completedAt,
    String? feeling,
    String? feelingLabel,
    @Default(0) int quizTotalQuestions,
    double? quizBestPercent,
  }) = _ParentReadingFeedbackItemDto;

  factory ParentReadingFeedbackItemDto.fromJson(Map<String, dynamic> json) =>
      _$ParentReadingFeedbackItemDtoFromJson(json);
}

@freezed
abstract class ParentReadingFeedbackPageDto with _$ParentReadingFeedbackPageDto {
  const factory ParentReadingFeedbackPageDto({
    @Default(<ParentReadingFeedbackItemDto>[])
    List<ParentReadingFeedbackItemDto> items,
    @Default(0) int totalCount,
    @Default(0) int pageIndex,
    @Default(0) int pageSize,
    @Default(0) int totalPages,
    @Default(false) bool hasNextPage,
    @Default(false) bool hasPreviousPage,
  }) = _ParentReadingFeedbackPageDto;

  factory ParentReadingFeedbackPageDto.fromJson(Map<String, dynamic> json) =>
      _$ParentReadingFeedbackPageDtoFromJson(json);
}
