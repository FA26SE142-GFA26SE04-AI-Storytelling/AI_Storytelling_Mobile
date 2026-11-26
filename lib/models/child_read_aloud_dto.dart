import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_read_aloud_dto.freezed.dart';
part 'child_read_aloud_dto.g.dart';

/// Một chữ đã chấm khi bé đọc to. status: good, retry, skipped; hint: tone, unclear, different hoặc null.
@freezed
abstract class ReadAloudWord with _$ReadAloudWord {
  const factory ReadAloudWord({
    required int index,
    @Default('') String text,
    @Default('good') String status,
    String? hint,
  }) = _ReadAloudWord;

  factory ReadAloudWord.fromJson(Map<String, dynamic> json) =>
      _$ReadAloudWordFromJson(json);
}

/// Kết quả chấm đọc to một đoạn (segment).
@freezed
abstract class ReadAloudResult with _$ReadAloudResult {
  const factory ReadAloudResult({
    required int sessionId,
    int? segmentId,
    int? interactionId,
    @Default(<ReadAloudWord>[]) List<ReadAloudWord> words,
    @Default(0) int goodCount,
    @Default(0) int retryCount,
    @Default(0) int skippedCount,
    @Default(0) int totalCount,
    @Default('') String message,
  }) = _ReadAloudResult;

  factory ReadAloudResult.fromJson(Map<String, dynamic> json) =>
      _$ReadAloudResultFromJson(json);
}
