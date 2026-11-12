import 'package:freezed_annotation/freezed_annotation.dart';

part 'listening_dto.freezed.dart';
part 'listening_dto.g.dart';

class ListeningAttemptRequestDto {
  const ListeningAttemptRequestDto({
    this.optionId,
    this.answer,
    this.orderedOptionIds,
  });

  final int? optionId;
  final String? answer;
  final List<int>? orderedOptionIds;

  Map<String, dynamic> toJson() => {
    if (optionId != null) 'optionId': optionId,
    if (answer != null) 'answer': answer,
    if (orderedOptionIds != null) 'orderedOptionIds': orderedOptionIds,
  };
}

@freezed
abstract class ListeningAttemptResultDto with _$ListeningAttemptResultDto {
  const factory ListeningAttemptResultDto({
    required int interactionId,
    required String type,
    bool? matched,
    String? feedback,
    String? feedbackAudioUrl,
    String? suggestedAnswer,
    @Default(<int>[]) List<int> replaySceneIndexes,
    @Default(false) bool revealed,
    List<int>? correctOrderOptionIds,
  }) = _ListeningAttemptResultDto;

  factory ListeningAttemptResultDto.fromJson(Map<String, dynamic> json) =>
      _$ListeningAttemptResultDtoFromJson(json);
}
