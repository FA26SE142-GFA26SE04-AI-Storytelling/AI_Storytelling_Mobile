import 'package:freezed_annotation/freezed_annotation.dart';

part 'reading_segment_dto.freezed.dart';
part 'reading_segment_dto.g.dart';

@freezed
abstract class ReadingSegmentDto with _$ReadingSegmentDto {
  const factory ReadingSegmentDto({
    required int segmentId,
    required int segmentOrder,
    int? startOffset,
    int? endOffset,
    @Default('') String text,
    String? audioUrl,
    String? wordTimingsJson,
  }) = _ReadingSegmentDto;

  factory ReadingSegmentDto.fromJson(Map<String, dynamic> json) =>
      _$ReadingSegmentDtoFromJson(json);
}

@freezed
abstract class SceneIllustrationDto with _$SceneIllustrationDto {
  const factory SceneIllustrationDto({
    @Default(0) int beatOrder,
    @Default(0) int startOffset,
    @Default(0) int endOffset,
    String? url,
  }) = _SceneIllustrationDto;

  factory SceneIllustrationDto.fromJson(Map<String, dynamic> json) =>
      _$SceneIllustrationDtoFromJson(json);
}
