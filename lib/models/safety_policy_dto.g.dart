// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safety_policy_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SafetyPolicyDto _$SafetyPolicyDtoFromJson(Map<String, dynamic> json) =>
    _SafetyPolicyDto(
      childProfileId: (json['childProfileId'] as num).toInt(),
      parentalGateEnabled: json['parentalGateEnabled'] as bool? ?? true,
      voiceAnswersEnabled: json['voiceAnswersEnabled'] as bool? ?? false,
    );

Map<String, dynamic> _$SafetyPolicyDtoToJson(_SafetyPolicyDto instance) =>
    <String, dynamic>{
      'childProfileId': instance.childProfileId,
      'parentalGateEnabled': instance.parentalGateEnabled,
      'voiceAnswersEnabled': instance.voiceAnswersEnabled,
    };
