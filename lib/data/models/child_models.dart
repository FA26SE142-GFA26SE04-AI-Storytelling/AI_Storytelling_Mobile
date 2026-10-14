import '../json.dart';

/// Hồ sơ bé (GET /ChildProfile/mine). Mobile chỉ dùng scope Personal.
class ChildProfile {
  const ChildProfile({
    required this.id,
    required this.ownerUserId,
    required this.nickname,
    required this.ageBand,
    required this.language,
    required this.status,
    required this.createdAt,
  });

  factory ChildProfile.fromJson(Json json) => ChildProfile(
    id: asInt(json['id']),
    ownerUserId: asInt(json['ownerUserId']),
    nickname: json['nickname'] as String,
    ageBand: json['ageBand'] as String,
    language: json['language'] as String? ?? 'vi',
    status: json['status'] as String? ?? '',
    createdAt: asDate(json['createdAt']),
  );

  final int id;
  final int ownerUserId;
  final String nickname;

  /// 'Age_6_8' | 'Age_9_12' | …
  final String ageBand;
  final String language;

  /// 'Active' | 'PendingParentConsent' | 'Archived' | …
  final String status;
  final DateTime createdAt;

  bool get isActive => status.toLowerCase() == 'active';
  bool get isArchived => status.toLowerCase() == 'archived';

  Json toJson() => {
    'id': id,
    'ownerUserId': ownerUserId,
    'nickname': nickname,
    'ageBand': ageBand,
    'language': language,
    'status': status,
    'scope': 'Personal',
    'createdAt': createdAt.toIso8601String(),
  };
}

/// Nhóm nội dung để đặt quy tắc an toàn (GET /ContentCategory).
class ContentCategory {
  const ContentCategory({required this.id, required this.code, required this.displayName, this.isActive = true});

  factory ContentCategory.fromJson(Json json) => ContentCategory(
    id: asInt(json['id']),
    code: json['code'] as String,
    displayName: json['displayName'] as String,
    isActive: json['isActive'] as bool? ?? true,
  );

  final int id;
  final String code;
  final String displayName;
  final bool isActive;
}

enum ApprovalMode {
  alwaysManual('AlwaysManual'),
  autoPublishOnThreshold('AutoPublishOnThreshold');

  const ApprovalMode(this.apiValue);
  final String apiValue;

  static ApprovalMode parse(String? v) => v == autoPublishOnThreshold.apiValue ? autoPublishOnThreshold : alwaysManual;
}

enum CategoryRule {
  allowed('Allowed', 'Cho phép'),
  restricted('Restricted', 'Hạn chế'),
  blocked('Blocked', 'Chặn');

  const CategoryRule(this.apiValue, this.label);
  final String apiValue;
  final String label;

  static CategoryRule parse(String? v) => values.firstWhere((r) => r.apiValue == v, orElse: () => allowed);
}

/// Chính sách an toàn của một bé (GET/PUT /SafetyPolicy/{childProfileId}).
class SafetyPolicy {
  const SafetyPolicy({
    required this.childProfileId,
    required this.maxStoryLength,
    required this.approvalMode,
    required this.parentalGateEnabled,
    required this.consentRecorded,
    this.id,
    this.rules = const {},
  });

  factory SafetyPolicy.fromJson(Json json) => SafetyPolicy(
    id: asIntOrNull(json['id']),
    childProfileId: asInt(json['childProfileId']),
    maxStoryLength: asInt(json['maxStoryLength']),
    approvalMode: ApprovalMode.parse(json['requiredApprovalMode'] as String?),
    parentalGateEnabled: json['parentalGateEnabled'] as bool? ?? true,
    consentRecorded: json['consentRecorded'] as bool? ?? false,
    rules: {for (final c in asList(json['categories'], (j) => j)) asInt(c['contentCategoryId']): CategoryRule.parse(c['rule'] as String?)},
  );

  final int? id;
  final int childProfileId;
  final int maxStoryLength;
  final ApprovalMode approvalMode;
  final bool parentalGateEnabled;
  final bool consentRecorded;

  /// Quy tắc theo id nhóm nội dung. Nhóm không có trong map coi như "Cho phép".
  final Map<int, CategoryRule> rules;

  CategoryRule ruleOf(int categoryId) => rules[categoryId] ?? CategoryRule.allowed;

  SafetyPolicy copyWith({int? maxStoryLength, ApprovalMode? approvalMode, bool? parentalGateEnabled, bool? consentRecorded, Map<int, CategoryRule>? rules}) =>
      SafetyPolicy(
        id: id,
        childProfileId: childProfileId,
        maxStoryLength: maxStoryLength ?? this.maxStoryLength,
        approvalMode: approvalMode ?? this.approvalMode,
        parentalGateEnabled: parentalGateEnabled ?? this.parentalGateEnabled,
        consentRecorded: consentRecorded ?? this.consentRecorded,
        rules: rules ?? this.rules,
      );

  /// Thân request PUT /SafetyPolicy/{childProfileId}.
  Json toRequestJson() => {
    'maxStoryLength': maxStoryLength,
    'requiredApprovalMode': approvalMode.apiValue,
    'parentalGateEnabled': parentalGateEnabled,
    'consentRecorded': consentRecorded,
    'categories': [
      for (final e in rules.entries) {'contentCategoryId': e.key, 'rule': e.value.apiValue},
    ],
  };

  Json toJson() => {'id': id, 'childProfileId': childProfileId, ...toRequestJson()};
}
