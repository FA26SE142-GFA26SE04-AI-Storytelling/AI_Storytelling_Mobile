// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safety_policy_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SafetyCategoryRuleDto _$SafetyCategoryRuleDtoFromJson(
  Map<String, dynamic> json,
) => _SafetyCategoryRuleDto(
  contentCategoryId: (json['contentCategoryId'] as num).toInt(),
  rule: json['rule'] as String,
);

Map<String, dynamic> _$SafetyCategoryRuleDtoToJson(
  _SafetyCategoryRuleDto instance,
) => <String, dynamic>{
  'contentCategoryId': instance.contentCategoryId,
  'rule': instance.rule,
};

_SafetyPolicyDto _$SafetyPolicyDtoFromJson(Map<String, dynamic> json) =>
    _SafetyPolicyDto(
      childProfileId: (json['childProfileId'] as num).toInt(),
      parentalGateEnabled: json['parentalGateEnabled'] as bool? ?? true,
      maxStoryLength: (json['maxStoryLength'] as num?)?.toInt(),
      requiredApprovalMode: json['requiredApprovalMode'] as String?,
      consentRecorded: json['consentRecorded'] as bool?,
      consentRecordedAt: json['consentRecordedAt'] == null
          ? null
          : DateTime.parse(json['consentRecordedAt'] as String),
      consentPolicyVersion: (json['consentPolicyVersion'] as num?)?.toInt(),
      consentOutdated: json['consentOutdated'] as bool?,
      safetyScoreThreshold: (json['safetyScoreThreshold'] as num?)?.toDouble(),
      readabilityScoreThreshold: (json['readabilityScoreThreshold'] as num?)
          ?.toDouble(),
      comprehensionThresholdPercent:
          (json['comprehensionThresholdPercent'] as num?)?.toInt(),
      comprehensionWindowSize: (json['comprehensionWindowSize'] as num?)
          ?.toInt(),
      storyWishesEnabled: json['storyWishesEnabled'] as bool?,
      allowInteractiveStories: json['allowInteractiveStories'] as bool?,
      childCreationEnabled: json['childCreationEnabled'] as bool?,
      childCreationMode: json['childCreationMode'] as String?,
      voiceAnswersEnabled: json['voiceAnswersEnabled'] as bool?,
      storyLengthTarget: (json['storyLengthTarget'] as num?)?.toInt(),
      quizEnabled: json['quizEnabled'] as bool?,
      notebookEnabled: json['notebookEnabled'] as bool?,
      libraryBrowseEnabled: json['libraryBrowseEnabled'] as bool?,
      reflectionEnabled: json['reflectionEnabled'] as bool?,
      rewardsEnabled: json['rewardsEnabled'] as bool?,
      voiceConsentAt: json['voiceConsentAt'] == null
          ? null
          : DateTime.parse(json['voiceConsentAt'] as String),
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map(
                (e) =>
                    SafetyCategoryRuleDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SafetyPolicyDtoToJson(_SafetyPolicyDto instance) =>
    <String, dynamic>{
      'childProfileId': instance.childProfileId,
      'parentalGateEnabled': instance.parentalGateEnabled,
      'maxStoryLength': instance.maxStoryLength,
      'requiredApprovalMode': instance.requiredApprovalMode,
      'consentRecorded': instance.consentRecorded,
      'consentRecordedAt': instance.consentRecordedAt?.toIso8601String(),
      'consentPolicyVersion': instance.consentPolicyVersion,
      'consentOutdated': instance.consentOutdated,
      'safetyScoreThreshold': instance.safetyScoreThreshold,
      'readabilityScoreThreshold': instance.readabilityScoreThreshold,
      'comprehensionThresholdPercent': instance.comprehensionThresholdPercent,
      'comprehensionWindowSize': instance.comprehensionWindowSize,
      'storyWishesEnabled': instance.storyWishesEnabled,
      'allowInteractiveStories': instance.allowInteractiveStories,
      'childCreationEnabled': instance.childCreationEnabled,
      'childCreationMode': instance.childCreationMode,
      'voiceAnswersEnabled': instance.voiceAnswersEnabled,
      'storyLengthTarget': instance.storyLengthTarget,
      'quizEnabled': instance.quizEnabled,
      'notebookEnabled': instance.notebookEnabled,
      'libraryBrowseEnabled': instance.libraryBrowseEnabled,
      'reflectionEnabled': instance.reflectionEnabled,
      'rewardsEnabled': instance.rewardsEnabled,
      'voiceConsentAt': instance.voiceConsentAt?.toIso8601String(),
      'categories': instance.categories,
    };
