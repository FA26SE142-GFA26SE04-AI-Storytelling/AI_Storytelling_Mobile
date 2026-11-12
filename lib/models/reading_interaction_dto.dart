import 'package:freezed_annotation/freezed_annotation.dart';

part 'reading_interaction_dto.freezed.dart';
part 'reading_interaction_dto.g.dart';

@freezed
abstract class InteractionOptionDto with _$InteractionOptionDto {
  const factory InteractionOptionDto({
    required int id,
    required String text,
    String? imageUrl,
    String? audioUrl,
    String? feedback,
    String? feedbackAudioUrl,
  }) = _InteractionOptionDto;

  factory InteractionOptionDto.fromJson(Map<String, dynamic> json) =>
      _$InteractionOptionDtoFromJson(json);
}

@freezed
abstract class ReadingInteractionDto with _$ReadingInteractionDto {
  const factory ReadingInteractionDto({
    required int id,
    required String type,
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
    @Default(<InteractionOptionDto>[]) List<InteractionOptionDto> options,
  }) = _ReadingInteractionDto;

  factory ReadingInteractionDto.fromJson(Map<String, dynamic> json) =>
      _$ReadingInteractionDtoFromJson(json);
}
