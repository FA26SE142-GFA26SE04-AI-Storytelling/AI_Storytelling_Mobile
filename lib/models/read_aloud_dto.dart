import 'package:freezed_annotation/freezed_annotation.dart';

part 'read_aloud_dto.freezed.dart';
part 'read_aloud_dto.g.dart';

@freezed
abstract class ReadAloudWordDto with _$ReadAloudWordDto {
  const factory ReadAloudWordDto({
    required int index,
    required String text,
    @Default('skipped') String status,
    String? hint,
  }) = _ReadAloudWordDto;

  factory ReadAloudWordDto.fromJson(Map<String, dynamic> json) =>
      _$ReadAloudWordDtoFromJson(json);
}

@freezed
abstract class ReadAloudResultDto with _$ReadAloudResultDto {
  const factory ReadAloudResultDto({
    required int sessionId,
    required int segmentId,
    @Default(<ReadAloudWordDto>[]) List<ReadAloudWordDto> words,
    @Default(0) int goodCount,
    @Default(0) int retryCount,
    @Default(0) int skippedCount,
    @Default(0) int totalCount,
    @Default('') String message,
  }) = _ReadAloudResultDto;

  factory ReadAloudResultDto.fromJson(Map<String, dynamic> json) =>
      _$ReadAloudResultDtoFromJson(json);
}
