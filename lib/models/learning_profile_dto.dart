import 'package:freezed_annotation/freezed_annotation.dart';

part 'learning_profile_dto.freezed.dart';
part 'learning_profile_dto.g.dart';

@freezed
abstract class LearningTopicDto with _$LearningTopicDto {
  const factory LearningTopicDto({
    required String topic,
    required String relation,
  }) = _LearningTopicDto;

  factory LearningTopicDto.fromJson(Map<String, dynamic> json) =>
      _$LearningTopicDtoFromJson(json);
}

@freezed
abstract class LearningProfileDto with _$LearningProfileDto {
  const factory LearningProfileDto({
    required int id,
    required int childProfileId,
    required int readingLevel,
    String? readingMode,
    String? comprehensionGoal,
    @Default([]) List<LearningTopicDto> topics,
  }) = _LearningProfileDto;

  factory LearningProfileDto.fromJson(Map<String, dynamic> json) =>
      _$LearningProfileDtoFromJson(json);
}
