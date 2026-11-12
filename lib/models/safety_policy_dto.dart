import 'package:freezed_annotation/freezed_annotation.dart';

part 'safety_policy_dto.freezed.dart';
part 'safety_policy_dto.g.dart';

@freezed
abstract class SafetyPolicyDto with _$SafetyPolicyDto {
  const factory SafetyPolicyDto({
    required int childProfileId,
    @Default(true) bool parentalGateEnabled,
    @Default(false) bool voiceAnswersEnabled,
  }) = _SafetyPolicyDto;

  factory SafetyPolicyDto.fromJson(Map<String, dynamic> json) =>
      _$SafetyPolicyDtoFromJson(json);
}
