// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_rewards_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RewardBadge _$RewardBadgeFromJson(Map<String, dynamic> json) => _RewardBadge(
  code: json['code'] as String,
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  earned: json['earned'] as bool? ?? false,
  earnedAt: json['earnedAt'] as String?,
);

Map<String, dynamic> _$RewardBadgeToJson(_RewardBadge instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'earned': instance.earned,
      'earnedAt': instance.earnedAt,
    };

_KnowledgeTree _$KnowledgeTreeFromJson(Map<String, dynamic> json) =>
    _KnowledgeTree(
      stage: json['stage'] as String,
      stageName: json['stageName'] as String,
      currentTreeExp: (json['currentTreeExp'] as num?)?.toInt() ?? 0,
      nextStageAt: (json['nextStageAt'] as num?)?.toInt(),
      flowerAt: (json['flowerAt'] as num?)?.toInt() ?? 0,
      floweredTreeCount: (json['floweredTreeCount'] as num?)?.toInt() ?? 0,
      expToWater: (json['expToWater'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$KnowledgeTreeToJson(_KnowledgeTree instance) =>
    <String, dynamic>{
      'stage': instance.stage,
      'stageName': instance.stageName,
      'currentTreeExp': instance.currentTreeExp,
      'nextStageAt': instance.nextStageAt,
      'flowerAt': instance.flowerAt,
      'floweredTreeCount': instance.floweredTreeCount,
      'expToWater': instance.expToWater,
    };

_ChildRewards _$ChildRewardsFromJson(Map<String, dynamic> json) =>
    _ChildRewards(
      expTotal: (json['expTotal'] as num?)?.toInt() ?? 0,
      streakDays: (json['streakDays'] as num?)?.toInt() ?? 0,
      knowledgeTree: KnowledgeTree.fromJson(
        json['knowledgeTree'] as Map<String, dynamic>,
      ),
      badges:
          (json['badges'] as List<dynamic>?)
              ?.map((e) => RewardBadge.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RewardBadge>[],
    );

Map<String, dynamic> _$ChildRewardsToJson(_ChildRewards instance) =>
    <String, dynamic>{
      'expTotal': instance.expTotal,
      'streakDays': instance.streakDays,
      'knowledgeTree': instance.knowledgeTree,
      'badges': instance.badges,
    };

_KnowledgeTreeWaterResult _$KnowledgeTreeWaterResultFromJson(
  Map<String, dynamic> json,
) => _KnowledgeTreeWaterResult(
  expPoured: (json['expPoured'] as num?)?.toInt() ?? 0,
  newTreePlanted: json['newTreePlanted'] as bool? ?? false,
  previousStage: json['previousStage'] as String?,
  tree: KnowledgeTree.fromJson(json['tree'] as Map<String, dynamic>),
);

Map<String, dynamic> _$KnowledgeTreeWaterResultToJson(
  _KnowledgeTreeWaterResult instance,
) => <String, dynamic>{
  'expPoured': instance.expPoured,
  'newTreePlanted': instance.newTreePlanted,
  'previousStage': instance.previousStage,
  'tree': instance.tree,
};
