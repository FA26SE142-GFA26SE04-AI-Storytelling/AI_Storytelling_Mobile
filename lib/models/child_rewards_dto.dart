import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_rewards_dto.freezed.dart';
part 'child_rewards_dto.g.dart';

/// Huy hiệu đạt được của bé trong các hoạt động đọc và câu đố
@freezed
abstract class RewardBadge with _$RewardBadge {
  const factory RewardBadge({
    required String code,
    required String name,
    @Default('') String description,
    @Default(false) bool earned,
    String? earnedAt,
  }) = _RewardBadge;

  factory RewardBadge.fromJson(Map<String, dynamic> json) =>
      _$RewardBadgeFromJson(json);
}

/// Trạng thái Cây tri thức của bé
@freezed
abstract class KnowledgeTree with _$KnowledgeTree {
  const factory KnowledgeTree({
    /// stage là mã chuỗi SEED, SPROUT, SAPLING, GROWN, FLOWERING
    required String stage,
    required String stageName,
    @Default(0) int currentTreeExp,
    int? nextStageAt,
    @Default(0) int flowerAt,
    @Default(0) int floweredTreeCount,
    @Default(0) int expToWater,
  }) = _KnowledgeTree;

  factory KnowledgeTree.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeTreeFromJson(json);
}

/// Tổng phần thưởng của bé (/child/rewards)
@freezed
abstract class ChildRewards with _$ChildRewards {
  const factory ChildRewards({
    @Default(0) int expTotal,
    @Default(0) int streakDays,
    required KnowledgeTree knowledgeTree,
    @Default(<RewardBadge>[]) List<RewardBadge> badges,
  }) = _ChildRewards;

  factory ChildRewards.fromJson(Map<String, dynamic> json) =>
      _$ChildRewardsFromJson(json);
}

/// Kết quả sau khi tưới nước cho Cây tri thức (POST /child/rewards/knowledge-tree/water)
@freezed
abstract class KnowledgeTreeWaterResult with _$KnowledgeTreeWaterResult {
  const factory KnowledgeTreeWaterResult({
    @Default(0) int expPoured,
    @Default(false) bool newTreePlanted,
    String? previousStage,
    required KnowledgeTree tree,
  }) = _KnowledgeTreeWaterResult;

  factory KnowledgeTreeWaterResult.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeTreeWaterResultFromJson(json);
}

/// Năm giai đoạn phát triển của Cây tri thức theo thứ tự backend trả về
const List<String> kTreeStageCodes = [
  'SEED',
  'SPROUT',
  'SAPLING',
  'GROWN',
  'FLOWERING',
];
