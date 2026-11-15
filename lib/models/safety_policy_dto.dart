import 'package:freezed_annotation/freezed_annotation.dart';

part 'safety_policy_dto.freezed.dart';
part 'safety_policy_dto.g.dart';

@freezed
abstract class SafetyCategoryRuleDto with _$SafetyCategoryRuleDto {
  const factory SafetyCategoryRuleDto({
    required int contentCategoryId,
    required String rule,
  }) = _SafetyCategoryRuleDto;

  factory SafetyCategoryRuleDto.fromJson(Map<String, dynamic> json) =>
      _$SafetyCategoryRuleDtoFromJson(json);
}

@freezed
abstract class SafetyPolicyDto with _$SafetyPolicyDto {
  const factory SafetyPolicyDto({
    required int childProfileId,
    @Default(true) bool parentalGateEnabled,
    int? maxStoryLength,
    String? requiredApprovalMode,
    bool? consentRecorded,
    DateTime? consentRecordedAt,
    int? consentPolicyVersion,
    bool? consentOutdated,
    double? safetyScoreThreshold,
    double? readabilityScoreThreshold,
    int? comprehensionThresholdPercent,
    int? comprehensionWindowSize,
    bool? storyWishesEnabled,
    bool? allowInteractiveStories,
    bool? childCreationEnabled,
    String? childCreationMode,
    bool? voiceAnswersEnabled,
    DateTime? voiceConsentAt,
    @Default([]) List<SafetyCategoryRuleDto> categories,
  }) = _SafetyPolicyDto;

  factory SafetyPolicyDto.fromJson(Map<String, dynamic> json) =>
      _$SafetyPolicyDtoFromJson(json);
}

Map<String, dynamic> safetyPolicyToRequest(SafetyPolicyDto p) {
  return <String, dynamic>{
    'maxStoryLength': p.maxStoryLength,
    'requiredApprovalMode': p.requiredApprovalMode,
    'parentalGateEnabled': p.parentalGateEnabled,
    'consentRecorded': p.consentRecorded,
    'safetyScoreThreshold': p.safetyScoreThreshold,
    'readabilityScoreThreshold': p.readabilityScoreThreshold,
    'comprehensionThresholdPercent': p.comprehensionThresholdPercent,
    'comprehensionWindowSize': p.comprehensionWindowSize,
    'storyWishesEnabled': p.storyWishesEnabled,
    'allowInteractiveStories': p.allowInteractiveStories,
    'childCreationEnabled': p.childCreationEnabled,
    'childCreationMode': p.childCreationMode,
    'voiceAnswersEnabled': p.voiceAnswersEnabled,
    'categories': p.categories
        .map((c) => <String, dynamic>{
              'contentCategoryId': c.contentCategoryId,
              'rule': c.rule,
            })
        .toList(),
  }
    // Backend khai bool/int không nhận null (trả 400); chỉ hai ngưỡng điểm được phép null.
    ..removeWhere((k, v) => v == null && !k.endsWith('ScoreThreshold'));
}
