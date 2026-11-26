// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventSummaryDto _$EventSummaryDtoFromJson(Map<String, dynamic> json) =>
    _EventSummaryDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String? ?? '',
      bannerUrl: json['bannerUrl'] as String?,
      mainCategoryId: (json['mainCategoryId'] as num?)?.toInt() ?? 0,
      mainCategoryName: json['mainCategoryName'] as String?,
      targetAgeBands: json['targetAgeBands'] as String? ?? '',
      status: json['status'] as String? ?? '',
      configVersion: json['configVersion'] as String? ?? '',
      format: json['format'] as String? ?? '',
      scoringMode: json['scoringMode'] as String? ?? '',
      minVotesPerSubmission:
          (json['minVotesPerSubmission'] as num?)?.toInt() ?? 0,
      maxParentRegistrations: (json['maxParentRegistrations'] as num?)?.toInt(),
      opensAt: json['opensAt'] == null
          ? null
          : DateTime.parse(json['opensAt'] as String),
      closesAt: json['closesAt'] == null
          ? null
          : DateTime.parse(json['closesAt'] as String),
      resultsFinalizedAt: json['resultsFinalizedAt'] == null
          ? null
          : DateTime.parse(json['resultsFinalizedAt'] as String),
      budgetVnd: (json['budgetVnd'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      closedAt: json['closedAt'] == null
          ? null
          : DateTime.parse(json['closedAt'] as String),
    );

Map<String, dynamic> _$EventSummaryDtoToJson(_EventSummaryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'bannerUrl': instance.bannerUrl,
      'mainCategoryId': instance.mainCategoryId,
      'mainCategoryName': instance.mainCategoryName,
      'targetAgeBands': instance.targetAgeBands,
      'status': instance.status,
      'configVersion': instance.configVersion,
      'format': instance.format,
      'scoringMode': instance.scoringMode,
      'minVotesPerSubmission': instance.minVotesPerSubmission,
      'maxParentRegistrations': instance.maxParentRegistrations,
      'opensAt': instance.opensAt?.toIso8601String(),
      'closesAt': instance.closesAt?.toIso8601String(),
      'resultsFinalizedAt': instance.resultsFinalizedAt?.toIso8601String(),
      'budgetVnd': instance.budgetVnd,
      'createdAt': instance.createdAt?.toIso8601String(),
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'closedAt': instance.closedAt?.toIso8601String(),
    };

_EventDetailDto _$EventDetailDtoFromJson(
  Map<String, dynamic> json,
) => _EventDetailDto(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String? ?? '',
  slug: json['slug'] as String? ?? '',
  description: json['description'] as String? ?? '',
  bannerUrl: json['bannerUrl'] as String?,
  mainCategoryId: (json['mainCategoryId'] as num?)?.toInt() ?? 0,
  mainCategoryName: json['mainCategoryName'] as String?,
  targetAgeBands: json['targetAgeBands'] as String? ?? '',
  status: json['status'] as String? ?? '',
  configVersion: json['configVersion'] as String? ?? '',
  format: json['format'] as String? ?? '',
  scoringMode: json['scoringMode'] as String? ?? '',
  minVotesPerSubmission: (json['minVotesPerSubmission'] as num?)?.toInt() ?? 0,
  maxParentRegistrations: (json['maxParentRegistrations'] as num?)?.toInt(),
  opensAt: json['opensAt'] == null
      ? null
      : DateTime.parse(json['opensAt'] as String),
  closesAt: json['closesAt'] == null
      ? null
      : DateTime.parse(json['closesAt'] as String),
  resultsFinalizedAt: json['resultsFinalizedAt'] == null
      ? null
      : DateTime.parse(json['resultsFinalizedAt'] as String),
  budgetVnd: (json['budgetVnd'] as num?)?.toInt() ?? 0,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  publishedAt: json['publishedAt'] == null
      ? null
      : DateTime.parse(json['publishedAt'] as String),
  closedAt: json['closedAt'] == null
      ? null
      : DateTime.parse(json['closedAt'] as String),
  tracks:
      (json['tracks'] as List<dynamic>?)
          ?.map((e) => EventTrackDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <EventTrackDto>[],
  activities:
      (json['activities'] as List<dynamic>?)
          ?.map((e) => EventActivityDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <EventActivityDto>[],
  myActivityStates:
      (json['myActivityStates'] as List<dynamic>?)
          ?.map(
            (e) =>
                EventActivityUserStateDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <EventActivityUserStateDto>[],
  activeRule: json['activeRule'] == null
      ? null
      : EventRuleVersionDto.fromJson(
          json['activeRule'] as Map<String, dynamic>,
        ),
  awards:
      (json['awards'] as List<dynamic>?)
          ?.map((e) => EventAwardSlotDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <EventAwardSlotDto>[],
  eventStoriesCount: (json['eventStoriesCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$EventDetailDtoToJson(_EventDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'bannerUrl': instance.bannerUrl,
      'mainCategoryId': instance.mainCategoryId,
      'mainCategoryName': instance.mainCategoryName,
      'targetAgeBands': instance.targetAgeBands,
      'status': instance.status,
      'configVersion': instance.configVersion,
      'format': instance.format,
      'scoringMode': instance.scoringMode,
      'minVotesPerSubmission': instance.minVotesPerSubmission,
      'maxParentRegistrations': instance.maxParentRegistrations,
      'opensAt': instance.opensAt?.toIso8601String(),
      'closesAt': instance.closesAt?.toIso8601String(),
      'resultsFinalizedAt': instance.resultsFinalizedAt?.toIso8601String(),
      'budgetVnd': instance.budgetVnd,
      'createdAt': instance.createdAt?.toIso8601String(),
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'closedAt': instance.closedAt?.toIso8601String(),
      'tracks': instance.tracks,
      'activities': instance.activities,
      'myActivityStates': instance.myActivityStates,
      'activeRule': instance.activeRule,
      'awards': instance.awards,
      'eventStoriesCount': instance.eventStoriesCount,
    };

_EventTrackDto _$EventTrackDtoFromJson(
  Map<String, dynamic> json,
) => _EventTrackDto(
  id: (json['id'] as num).toInt(),
  trackType: json['trackType'] as String? ?? '',
  registrationStartAt: json['registrationStartAt'] == null
      ? null
      : DateTime.parse(json['registrationStartAt'] as String),
  registrationEndAt: json['registrationEndAt'] == null
      ? null
      : DateTime.parse(json['registrationEndAt'] as String),
  executionStartAt: json['executionStartAt'] == null
      ? null
      : DateTime.parse(json['executionStartAt'] as String),
  executionEndAt: json['executionEndAt'] == null
      ? null
      : DateTime.parse(json['executionEndAt'] as String),
  maxSubmissionsPerUser: (json['maxSubmissionsPerUser'] as num?)?.toInt() ?? 0,
  grantAiCredits: (json['grantAiCredits'] as num?)?.toInt() ?? 0,
  grantSubmitCredits: (json['grantSubmitCredits'] as num?)?.toInt() ?? 0,
  waiveWeeklyLibraryLimit: json['waiveWeeklyLibraryLimit'] as bool? ?? false,
  claimWindowHours: (json['claimWindowHours'] as num?)?.toInt() ?? 0,
  awardAllMissionCompleters:
      json['awardAllMissionCompleters'] as bool? ?? false,
);

Map<String, dynamic> _$EventTrackDtoToJson(_EventTrackDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'trackType': instance.trackType,
      'registrationStartAt': instance.registrationStartAt?.toIso8601String(),
      'registrationEndAt': instance.registrationEndAt?.toIso8601String(),
      'executionStartAt': instance.executionStartAt?.toIso8601String(),
      'executionEndAt': instance.executionEndAt?.toIso8601String(),
      'maxSubmissionsPerUser': instance.maxSubmissionsPerUser,
      'grantAiCredits': instance.grantAiCredits,
      'grantSubmitCredits': instance.grantSubmitCredits,
      'waiveWeeklyLibraryLimit': instance.waiveWeeklyLibraryLimit,
      'claimWindowHours': instance.claimWindowHours,
      'awardAllMissionCompleters': instance.awardAllMissionCompleters,
    };

_EventActivityDto _$EventActivityDtoFromJson(
  Map<String, dynamic> json,
) => _EventActivityDto(
  id: (json['id'] as num).toInt(),
  activityType: json['activityType'] as String? ?? '',
  allowedAudience: json['allowedAudience'] as String? ?? '',
  registrationStartAt: json['registrationStartAt'] == null
      ? null
      : DateTime.parse(json['registrationStartAt'] as String),
  registrationEndAt: json['registrationEndAt'] == null
      ? null
      : DateTime.parse(json['registrationEndAt'] as String),
  startAt: json['startAt'] == null
      ? null
      : DateTime.parse(json['startAt'] as String),
  endAt: json['endAt'] == null ? null : DateTime.parse(json['endAt'] as String),
  reviewCutoffAt: json['reviewCutoffAt'] == null
      ? null
      : DateTime.parse(json['reviewCutoffAt'] as String),
  grantAiCredits: (json['grantAiCredits'] as num?)?.toInt() ?? 0,
  maxSubmissionsPerUser: (json['maxSubmissionsPerUser'] as num?)?.toInt(),
  maxRegistrations: (json['maxRegistrations'] as num?)?.toInt(),
  waiveWeeklyLibraryLimit: json['waiveWeeklyLibraryLimit'] as bool? ?? false,
  storySource: json['storySource'] as String? ?? '',
  minVotesPerSubmission: (json['minVotesPerSubmission'] as num?)?.toInt() ?? 0,
  claimWindowHours: (json['claimWindowHours'] as num?)?.toInt() ?? 0,
  awardAllMissionCompleters:
      json['awardAllMissionCompleters'] as bool? ?? false,
);

Map<String, dynamic> _$EventActivityDtoToJson(_EventActivityDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activityType': instance.activityType,
      'allowedAudience': instance.allowedAudience,
      'registrationStartAt': instance.registrationStartAt?.toIso8601String(),
      'registrationEndAt': instance.registrationEndAt?.toIso8601String(),
      'startAt': instance.startAt?.toIso8601String(),
      'endAt': instance.endAt?.toIso8601String(),
      'reviewCutoffAt': instance.reviewCutoffAt?.toIso8601String(),
      'grantAiCredits': instance.grantAiCredits,
      'maxSubmissionsPerUser': instance.maxSubmissionsPerUser,
      'maxRegistrations': instance.maxRegistrations,
      'waiveWeeklyLibraryLimit': instance.waiveWeeklyLibraryLimit,
      'storySource': instance.storySource,
      'minVotesPerSubmission': instance.minVotesPerSubmission,
      'claimWindowHours': instance.claimWindowHours,
      'awardAllMissionCompleters': instance.awardAllMissionCompleters,
    };

_EventActivityUserStateDto _$EventActivityUserStateDtoFromJson(
  Map<String, dynamic> json,
) => _EventActivityUserStateDto(
  activityId: (json['activityId'] as num).toInt(),
  activityType: json['activityType'] as String? ?? '',
  allowedAudience: json['allowedAudience'] as String? ?? '',
  lifecycleStatus: json['lifecycleStatus'] as String? ?? 'NotOpen',
  isEligible: json['isEligible'] as bool? ?? false,
  isRegistered: json['isRegistered'] as bool? ?? false,
  participationId: (json['participationId'] as num?)?.toInt(),
  participationStatus: json['participationStatus'] as String?,
  appealDeadlineAt: json['appealDeadlineAt'] == null
      ? null
      : DateTime.parse(json['appealDeadlineAt'] as String),
  canRegister: json['canRegister'] as bool? ?? false,
  canSubmit: json['canSubmit'] as bool? ?? false,
  canDoMissions: json['canDoMissions'] as bool? ?? false,
  canVote: json['canVote'] as bool? ?? false,
  submissionsCount: (json['submissionsCount'] as num?)?.toInt() ?? 0,
  maxSubmissionsPerUser: (json['maxSubmissionsPerUser'] as num?)?.toInt(),
);

Map<String, dynamic> _$EventActivityUserStateDtoToJson(
  _EventActivityUserStateDto instance,
) => <String, dynamic>{
  'activityId': instance.activityId,
  'activityType': instance.activityType,
  'allowedAudience': instance.allowedAudience,
  'lifecycleStatus': instance.lifecycleStatus,
  'isEligible': instance.isEligible,
  'isRegistered': instance.isRegistered,
  'participationId': instance.participationId,
  'participationStatus': instance.participationStatus,
  'appealDeadlineAt': instance.appealDeadlineAt?.toIso8601String(),
  'canRegister': instance.canRegister,
  'canSubmit': instance.canSubmit,
  'canDoMissions': instance.canDoMissions,
  'canVote': instance.canVote,
  'submissionsCount': instance.submissionsCount,
  'maxSubmissionsPerUser': instance.maxSubmissionsPerUser,
};

_EventRuleVersionDto _$EventRuleVersionDtoFromJson(Map<String, dynamic> json) =>
    _EventRuleVersionDto(
      id: (json['id'] as num).toInt(),
      versionNo: (json['versionNo'] as num?)?.toInt() ?? 0,
      rulesText: json['rulesText'] as String? ?? '',
      rewardEligibilityText: json['rewardEligibilityText'] as String?,
      completionMode: json['completionMode'] as String? ?? '',
      requiredTaskCount: (json['requiredTaskCount'] as num?)?.toInt(),
      requiredPoints: (json['requiredPoints'] as num?)?.toInt(),
      isActive: json['isActive'] as bool? ?? false,
      tasks:
          (json['tasks'] as List<dynamic>?)
              ?.map(
                (e) =>
                    EventTaskDefinitionDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <EventTaskDefinitionDto>[],
    );

Map<String, dynamic> _$EventRuleVersionDtoToJson(
  _EventRuleVersionDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'versionNo': instance.versionNo,
  'rulesText': instance.rulesText,
  'rewardEligibilityText': instance.rewardEligibilityText,
  'completionMode': instance.completionMode,
  'requiredTaskCount': instance.requiredTaskCount,
  'requiredPoints': instance.requiredPoints,
  'isActive': instance.isActive,
  'tasks': instance.tasks,
};

_EventTaskDefinitionDto _$EventTaskDefinitionDtoFromJson(
  Map<String, dynamic> json,
) => _EventTaskDefinitionDto(
  id: (json['id'] as num).toInt(),
  taskCode: json['taskCode'] as String? ?? '',
  targetTrackType: json['targetTrackType'] as String?,
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  verifierType: json['verifierType'] as String? ?? '',
  targetValue: (json['targetValue'] as num?)?.toInt() ?? 0,
  configJson: json['configJson'] as String?,
  isMandatory: json['isMandatory'] as bool? ?? false,
  points: (json['points'] as num?)?.toInt() ?? 0,
  allowMultiplePerStory: json['allowMultiplePerStory'] as bool? ?? false,
);

Map<String, dynamic> _$EventTaskDefinitionDtoToJson(
  _EventTaskDefinitionDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'taskCode': instance.taskCode,
  'targetTrackType': instance.targetTrackType,
  'title': instance.title,
  'description': instance.description,
  'sortOrder': instance.sortOrder,
  'verifierType': instance.verifierType,
  'targetValue': instance.targetValue,
  'configJson': instance.configJson,
  'isMandatory': instance.isMandatory,
  'points': instance.points,
  'allowMultiplePerStory': instance.allowMultiplePerStory,
};

_EventAwardSlotDto _$EventAwardSlotDtoFromJson(Map<String, dynamic> json) =>
    _EventAwardSlotDto(
      id: (json['id'] as num).toInt(),
      trackId: (json['trackId'] as num?)?.toInt(),
      eventActivityId: (json['eventActivityId'] as num?)?.toInt(),
      activityType: json['activityType'] as String?,
      resultSource: json['resultSource'] as String?,
      targetAudience: json['targetAudience'] as String?,
      rankOrTier: json['rankOrTier'] as String? ?? '',
      slotIndex: (json['slotIndex'] as num?)?.toInt() ?? 0,
      rewardType: json['rewardType'] as String? ?? '',
      rewardName: json['rewardName'] as String? ?? '',
      unitValueVnd: (json['unitValueVnd'] as num?)?.toInt() ?? 0,
      creditGrantAmount: (json['creditGrantAmount'] as num?)?.toInt() ?? 0,
      submitCreditGrantAmount:
          (json['submitCreditGrantAmount'] as num?)?.toInt() ?? 0,
      participationId: (json['participationId'] as num?)?.toInt(),
      status: json['status'] as String? ?? '',
      claimDeadlineAt: json['claimDeadlineAt'] == null
          ? null
          : DateTime.parse(json['claimDeadlineAt'] as String),
      notificationFailed: json['notificationFailed'] as bool? ?? false,
    );

Map<String, dynamic> _$EventAwardSlotDtoToJson(_EventAwardSlotDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'trackId': instance.trackId,
      'eventActivityId': instance.eventActivityId,
      'activityType': instance.activityType,
      'resultSource': instance.resultSource,
      'targetAudience': instance.targetAudience,
      'rankOrTier': instance.rankOrTier,
      'slotIndex': instance.slotIndex,
      'rewardType': instance.rewardType,
      'rewardName': instance.rewardName,
      'unitValueVnd': instance.unitValueVnd,
      'creditGrantAmount': instance.creditGrantAmount,
      'submitCreditGrantAmount': instance.submitCreditGrantAmount,
      'participationId': instance.participationId,
      'status': instance.status,
      'claimDeadlineAt': instance.claimDeadlineAt?.toIso8601String(),
      'notificationFailed': instance.notificationFailed,
    };

_EventParticipationDto _$EventParticipationDtoFromJson(
  Map<String, dynamic> json,
) => _EventParticipationDto(
  id: (json['id'] as num).toInt(),
  eventId: (json['eventId'] as num).toInt(),
  trackId: (json['trackId'] as num?)?.toInt(),
  trackType: json['trackType'] as String? ?? '',
  eventActivityId: (json['eventActivityId'] as num?)?.toInt(),
  activityType: json['activityType'] as String?,
  userId: (json['userId'] as num?)?.toInt() ?? 0,
  acceptedRuleVersionId: (json['acceptedRuleVersionId'] as num?)?.toInt() ?? 0,
  status: json['status'] as String? ?? '',
  missionCompletedAt: json['missionCompletedAt'] == null
      ? null
      : DateTime.parse(json['missionCompletedAt'] as String),
  verifiedAt: json['verifiedAt'] == null
      ? null
      : DateTime.parse(json['verifiedAt'] as String),
  appealDeadlineAt: json['appealDeadlineAt'] == null
      ? null
      : DateTime.parse(json['appealDeadlineAt'] as String),
  safetyWarning: json['safetyWarning'] as String?,
);

Map<String, dynamic> _$EventParticipationDtoToJson(
  _EventParticipationDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'eventId': instance.eventId,
  'trackId': instance.trackId,
  'trackType': instance.trackType,
  'eventActivityId': instance.eventActivityId,
  'activityType': instance.activityType,
  'userId': instance.userId,
  'acceptedRuleVersionId': instance.acceptedRuleVersionId,
  'status': instance.status,
  'missionCompletedAt': instance.missionCompletedAt?.toIso8601String(),
  'verifiedAt': instance.verifiedAt?.toIso8601String(),
  'appealDeadlineAt': instance.appealDeadlineAt?.toIso8601String(),
  'safetyWarning': instance.safetyWarning,
};

_EventMissionDashboardDto _$EventMissionDashboardDtoFromJson(
  Map<String, dynamic> json,
) => _EventMissionDashboardDto(
  participation: json['participation'] == null
      ? null
      : EventParticipationDto.fromJson(
          json['participation'] as Map<String, dynamic>,
        ),
  completionMode: json['completionMode'] as String? ?? '',
  requiredTaskCount: (json['requiredTaskCount'] as num?)?.toInt(),
  requiredPoints: (json['requiredPoints'] as num?)?.toInt(),
  completedTasksCount: (json['completedTasksCount'] as num?)?.toInt() ?? 0,
  earnedPoints: (json['earnedPoints'] as num?)?.toInt() ?? 0,
  allRequirementsMet: json['allRequirementsMet'] as bool? ?? false,
  tasks:
      (json['tasks'] as List<dynamic>?)
          ?.map(
            (e) => EventTaskProgressItemDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <EventTaskProgressItemDto>[],
  stories:
      (json['stories'] as List<dynamic>?)
          ?.map(
            (e) => EventStoryLibraryItemDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <EventStoryLibraryItemDto>[],
  votingStories:
      (json['votingStories'] as List<dynamic>?)
          ?.map(
            (e) => EventStoryLibraryItemDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <EventStoryLibraryItemDto>[],
);

Map<String, dynamic> _$EventMissionDashboardDtoToJson(
  _EventMissionDashboardDto instance,
) => <String, dynamic>{
  'participation': instance.participation,
  'completionMode': instance.completionMode,
  'requiredTaskCount': instance.requiredTaskCount,
  'requiredPoints': instance.requiredPoints,
  'completedTasksCount': instance.completedTasksCount,
  'earnedPoints': instance.earnedPoints,
  'allRequirementsMet': instance.allRequirementsMet,
  'tasks': instance.tasks,
  'stories': instance.stories,
  'votingStories': instance.votingStories,
};

_EventTaskProgressItemDto _$EventTaskProgressItemDtoFromJson(
  Map<String, dynamic> json,
) => _EventTaskProgressItemDto(
  taskDefinitionId: (json['taskDefinitionId'] as num).toInt(),
  taskCode: json['taskCode'] as String? ?? '',
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  verifierType: json['verifierType'] as String? ?? '',
  targetValue: (json['targetValue'] as num?)?.toInt() ?? 0,
  currentValue: (json['currentValue'] as num?)?.toInt() ?? 0,
  isCompleted: json['isCompleted'] as bool? ?? false,
  isMandatory: json['isMandatory'] as bool? ?? false,
  points: (json['points'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$EventTaskProgressItemDtoToJson(
  _EventTaskProgressItemDto instance,
) => <String, dynamic>{
  'taskDefinitionId': instance.taskDefinitionId,
  'taskCode': instance.taskCode,
  'title': instance.title,
  'description': instance.description,
  'verifierType': instance.verifierType,
  'targetValue': instance.targetValue,
  'currentValue': instance.currentValue,
  'isCompleted': instance.isCompleted,
  'isMandatory': instance.isMandatory,
  'points': instance.points,
};

_EventStoryLibraryItemDto _$EventStoryLibraryItemDtoFromJson(
  Map<String, dynamic> json,
) => _EventStoryLibraryItemDto(
  storyId: (json['storyId'] as num).toInt(),
  storyVersionId: (json['storyVersionId'] as num?)?.toInt() ?? 0,
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  ageBand: json['ageBand'] as String? ?? '',
  genre: json['genre'] as String? ?? '',
  source: json['source'] as String? ?? '',
  hasFamilyRead: json['hasFamilyRead'] as bool? ?? false,
  myVoteStars: (json['myVoteStars'] as num?)?.toInt(),
);

Map<String, dynamic> _$EventStoryLibraryItemDtoToJson(
  _EventStoryLibraryItemDto instance,
) => <String, dynamic>{
  'storyId': instance.storyId,
  'storyVersionId': instance.storyVersionId,
  'title': instance.title,
  'description': instance.description,
  'ageBand': instance.ageBand,
  'genre': instance.genre,
  'source': instance.source,
  'hasFamilyRead': instance.hasFamilyRead,
  'myVoteStars': instance.myVoteStars,
};
