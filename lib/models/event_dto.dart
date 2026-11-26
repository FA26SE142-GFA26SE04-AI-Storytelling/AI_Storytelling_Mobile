import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_dto.freezed.dart';
part 'event_dto.g.dart';

// DTO sự kiện theo Backend `Features/Events/DTOs/EventDtos.cs`. Enum Backend
// trả dạng chuỗi (JsonStringEnumConverter) nên giữ String, xem nhãn ở
// `features/events/data/event_logic.dart`.

/// GET /events: một sự kiện trong danh sách.
@freezed
abstract class EventSummaryDto with _$EventSummaryDto {
  const factory EventSummaryDto({
    required int id,
    @Default('') String title,
    @Default('') String slug,
    @Default('') String description,
    String? bannerUrl,
    @Default(0) int mainCategoryId,
    String? mainCategoryName,
    @Default('') String targetAgeBands,
    @Default('') String status,
    @Default('') String configVersion,
    @Default('') String format,
    @Default('') String scoringMode,
    @Default(0) int minVotesPerSubmission,
    int? maxParentRegistrations,
    DateTime? opensAt,
    DateTime? closesAt,
    DateTime? resultsFinalizedAt,
    @Default(0) int budgetVnd,
    DateTime? createdAt,
    DateTime? publishedAt,
    DateTime? closedAt,
  }) = _EventSummaryDto;

  factory EventSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$EventSummaryDtoFromJson(json);
}

/// GET /events/{id}. Backend kế thừa [EventSummaryDto] nên lặp lại các trường.
@freezed
abstract class EventDetailDto with _$EventDetailDto {
  const factory EventDetailDto({
    required int id,
    @Default('') String title,
    @Default('') String slug,
    @Default('') String description,
    String? bannerUrl,
    @Default(0) int mainCategoryId,
    String? mainCategoryName,
    @Default('') String targetAgeBands,
    @Default('') String status,
    @Default('') String configVersion,
    @Default('') String format,
    @Default('') String scoringMode,
    @Default(0) int minVotesPerSubmission,
    int? maxParentRegistrations,
    DateTime? opensAt,
    DateTime? closesAt,
    DateTime? resultsFinalizedAt,
    @Default(0) int budgetVnd,
    DateTime? createdAt,
    DateTime? publishedAt,
    DateTime? closedAt,
    @Default(<EventTrackDto>[]) List<EventTrackDto> tracks,
    @Default(<EventActivityDto>[]) List<EventActivityDto> activities,
    @Default(<EventActivityUserStateDto>[])
    List<EventActivityUserStateDto> myActivityStates,
    EventRuleVersionDto? activeRule,
    @Default(<EventAwardSlotDto>[]) List<EventAwardSlotDto> awards,
    @Default(0) int eventStoriesCount,
  }) = _EventDetailDto;

  factory EventDetailDto.fromJson(Map<String, dynamic> json) =>
      _$EventDetailDtoFromJson(json);
}

/// Nhánh tham gia kiểu cũ (LegacyRoleBased): Creator / Parent.
@freezed
abstract class EventTrackDto with _$EventTrackDto {
  const factory EventTrackDto({
    required int id,
    @Default('') String trackType,
    DateTime? registrationStartAt,
    DateTime? registrationEndAt,
    DateTime? executionStartAt,
    DateTime? executionEndAt,
    @Default(0) int maxSubmissionsPerUser,
    @Default(0) int grantAiCredits,
    @Default(0) int grantSubmitCredits,
    @Default(false) bool waiveWeeklyLibraryLimit,
    @Default(0) int claimWindowHours,
    @Default(false) bool awardAllMissionCompleters,
  }) = _EventTrackDto;

  factory EventTrackDto.fromJson(Map<String, dynamic> json) =>
      _$EventTrackDtoFromJson(json);
}

/// Hoạt động của sự kiện kiểu mới (ActivityBased).
@freezed
abstract class EventActivityDto with _$EventActivityDto {
  const factory EventActivityDto({
    required int id,
    @Default('') String activityType,
    @Default('') String allowedAudience,
    DateTime? registrationStartAt,
    DateTime? registrationEndAt,
    DateTime? startAt,
    DateTime? endAt,
    DateTime? reviewCutoffAt,
    @Default(0) int grantAiCredits,
    int? maxSubmissionsPerUser,
    int? maxRegistrations,
    @Default(false) bool waiveWeeklyLibraryLimit,
    @Default('') String storySource,
    @Default(0) int minVotesPerSubmission,
    @Default(0) int claimWindowHours,
    @Default(false) bool awardAllMissionCompleters,
  }) = _EventActivityDto;

  factory EventActivityDto.fromJson(Map<String, dynamic> json) =>
      _$EventActivityDtoFromJson(json);
}

/// Trạng thái của người đang xem với từng hoạt động.
@freezed
abstract class EventActivityUserStateDto with _$EventActivityUserStateDto {
  const factory EventActivityUserStateDto({
    required int activityId,
    @Default('') String activityType,
    @Default('') String allowedAudience,

    /// NotOpen | Open | Ended
    @Default('NotOpen') String lifecycleStatus,
    @Default(false) bool isEligible,
    @Default(false) bool isRegistered,
    int? participationId,
    String? participationStatus,
    DateTime? appealDeadlineAt,
    @Default(false) bool canRegister,
    @Default(false) bool canSubmit,
    @Default(false) bool canDoMissions,
    @Default(false) bool canVote,
    @Default(0) int submissionsCount,
    int? maxSubmissionsPerUser,
  }) = _EventActivityUserStateDto;

  factory EventActivityUserStateDto.fromJson(Map<String, dynamic> json) =>
      _$EventActivityUserStateDtoFromJson(json);
}

@freezed
abstract class EventRuleVersionDto with _$EventRuleVersionDto {
  const factory EventRuleVersionDto({
    required int id,
    @Default(0) int versionNo,
    @Default('') String rulesText,
    String? rewardEligibilityText,
    @Default('') String completionMode,
    int? requiredTaskCount,
    int? requiredPoints,
    @Default(false) bool isActive,
    @Default(<EventTaskDefinitionDto>[]) List<EventTaskDefinitionDto> tasks,
  }) = _EventRuleVersionDto;

  factory EventRuleVersionDto.fromJson(Map<String, dynamic> json) =>
      _$EventRuleVersionDtoFromJson(json);
}

@freezed
abstract class EventTaskDefinitionDto with _$EventTaskDefinitionDto {
  const factory EventTaskDefinitionDto({
    required int id,
    @Default('') String taskCode,
    String? targetTrackType,
    @Default('') String title,
    @Default('') String description,
    @Default(0) int sortOrder,
    @Default('') String verifierType,
    @Default(0) int targetValue,
    String? configJson,
    @Default(false) bool isMandatory,
    @Default(0) int points,
    @Default(false) bool allowMultiplePerStory,
  }) = _EventTaskDefinitionDto;

  factory EventTaskDefinitionDto.fromJson(Map<String, dynamic> json) =>
      _$EventTaskDefinitionDtoFromJson(json);
}

/// Một suất giải (GET /events/{id} → awards, GET /events/my-rewards).
@freezed
abstract class EventAwardSlotDto with _$EventAwardSlotDto {
  const factory EventAwardSlotDto({
    required int id,
    int? trackId,
    int? eventActivityId,
    String? activityType,
    String? resultSource,
    String? targetAudience,
    @Default('') String rankOrTier,
    @Default(0) int slotIndex,
    @Default('') String rewardType,
    @Default('') String rewardName,
    @Default(0) int unitValueVnd,
    @Default(0) int creditGrantAmount,
    @Default(0) int submitCreditGrantAmount,
    int? participationId,
    @Default('') String status,
    DateTime? claimDeadlineAt,
    @Default(false) bool notificationFailed,
  }) = _EventAwardSlotDto;

  factory EventAwardSlotDto.fromJson(Map<String, dynamic> json) =>
      _$EventAwardSlotDtoFromJson(json);
}

/// POST /events/{id}/register, GET /events/my-participations.
@freezed
abstract class EventParticipationDto with _$EventParticipationDto {
  const factory EventParticipationDto({
    required int id,
    required int eventId,
    int? trackId,
    @Default('') String trackType,
    int? eventActivityId,
    String? activityType,
    @Default(0) int userId,
    @Default(0) int acceptedRuleVersionId,
    @Default('') String status,
    DateTime? missionCompletedAt,
    DateTime? verifiedAt,
    DateTime? appealDeadlineAt,
    String? safetyWarning,
  }) = _EventParticipationDto;

  factory EventParticipationDto.fromJson(Map<String, dynamic> json) =>
      _$EventParticipationDtoFromJson(json);
}

/// GET /events/{id}/mission-dashboard, POST .../tasks/{taskId}/complete.
@freezed
abstract class EventMissionDashboardDto with _$EventMissionDashboardDto {
  const factory EventMissionDashboardDto({
    EventParticipationDto? participation,
    @Default('') String completionMode,
    int? requiredTaskCount,
    int? requiredPoints,
    @Default(0) int completedTasksCount,
    @Default(0) int earnedPoints,
    @Default(false) bool allRequirementsMet,
    @Default(<EventTaskProgressItemDto>[]) List<EventTaskProgressItemDto> tasks,
    @Default(<EventStoryLibraryItemDto>[])
    List<EventStoryLibraryItemDto> stories,
    @Default(<EventStoryLibraryItemDto>[])
    List<EventStoryLibraryItemDto> votingStories,
  }) = _EventMissionDashboardDto;

  factory EventMissionDashboardDto.fromJson(Map<String, dynamic> json) =>
      _$EventMissionDashboardDtoFromJson(json);
}

@freezed
abstract class EventTaskProgressItemDto with _$EventTaskProgressItemDto {
  const factory EventTaskProgressItemDto({
    required int taskDefinitionId,
    @Default('') String taskCode,
    @Default('') String title,
    @Default('') String description,
    @Default('') String verifierType,
    @Default(0) int targetValue,
    @Default(0) int currentValue,
    @Default(false) bool isCompleted,
    @Default(false) bool isMandatory,
    @Default(0) int points,
  }) = _EventTaskProgressItemDto;

  factory EventTaskProgressItemDto.fromJson(Map<String, dynamic> json) =>
      _$EventTaskProgressItemDtoFromJson(json);
}

@freezed
abstract class EventStoryLibraryItemDto with _$EventStoryLibraryItemDto {
  const factory EventStoryLibraryItemDto({
    required int storyId,
    @Default(0) int storyVersionId,
    @Default('') String title,
    @Default('') String description,
    @Default('') String ageBand,
    @Default('') String genre,
    @Default('') String source,
    @Default(false) bool hasFamilyRead,
    int? myVoteStars,
  }) = _EventStoryLibraryItemDto;

  factory EventStoryLibraryItemDto.fromJson(Map<String, dynamic> json) =>
      _$EventStoryLibraryItemDtoFromJson(json);
}
