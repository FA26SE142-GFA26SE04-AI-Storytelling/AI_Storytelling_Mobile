import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_interaction_dto.freezed.dart';
part 'child_interaction_dto.g.dart';

/// Thẻ đáp án của tương tác lúc nghe (Backend không trả đáp án đúng).
@freezed
abstract class InteractionOption with _$InteractionOption {
  const factory InteractionOption({
    required int id,
    @Default('') String text,
    String? imageUrl,
    String? audioUrl,
    String? feedback,
    String? feedbackAudioUrl,
  }) = _InteractionOption;

  factory InteractionOption.fromJson(Map<String, dynamic> json) =>
      _$InteractionOptionFromJson(json);
}

/// Tương tác hiện khi nghe hết cảnh. type: Checkpoint, RolePlay, FillBlank, EventOrdering, PicturePrediction.
@freezed
abstract class ReadingInteraction with _$ReadingInteraction {
  const factory ReadingInteraction({
    required int id,
    @Default('') String type,
    String? kind,
    String? prompt,
    String? characterName,
    String? modelSentence,
    String? modelAudioUrl,
    String? maskedSentence,
    String? hint,
    String? waitFeedback,
    int? revealSceneIndex,
    @Default(<String, String>{}) Map<String, String> audioUrls,
    @Default(<InteractionOption>[]) List<InteractionOption> options,
  }) = _ReadingInteraction;

  factory ReadingInteraction.fromJson(Map<String, dynamic> json) =>
      _$ReadingInteractionFromJson(json);
}

/// Kết quả Backend trả sau khi bé trả lời một tương tác.
@freezed
abstract class ListeningAttemptResult with _$ListeningAttemptResult {
  const factory ListeningAttemptResult({
    required int interactionId,
    @Default('') String type,
    bool? matched,
    String? feedback,
    String? feedbackAudioUrl,
    String? suggestedAnswer,
    @Default(<int>[]) List<int> replaySceneIndexes,
    @Default(false) bool revealed,
    List<int>? correctOrderOptionIds,
  }) = _ListeningAttemptResult;

  factory ListeningAttemptResult.fromJson(Map<String, dynamic> json) =>
      _$ListeningAttemptResultFromJson(json);
}
