import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/models/event_dto.dart';

void main() {
  test('EventSummaryDto đọc đủ trường, null không crash', () {
    final dto = EventSummaryDto.fromJson({
      'opensAt': null,
      'closesAt': '2026-12-31T16:59:59Z',
      'id': 3,
      'title': 'Mùa đọc sen',
      'slug': 'mua-doc-sen',
      'description': 'Đọc cùng con',
      'bannerUrl': null,
      'mainCategoryId': 2,
      'mainCategoryName': null,
      'targetAgeBands': '4-6',
      'status': 'Published',
      'configVersion': 'ActivityBased',
      'format': 'Standard',
      'scoringMode': 'MissionCompletion',
      'minVotesPerSubmission': 5,
      'maxParentRegistrations': null,
      'creatorVotingSchedule': null,
      'budgetVnd': 5000000000,
      'createdAt': '2026-11-20T01:00:00Z',
      'publishedAt': '2026-11-21T01:00:00Z',
      'closedAt': null,
    });
    expect(dto.title, 'Mùa đọc sen');
    expect(dto.status, 'Published');
    expect(dto.opensAt, isNull);
    expect(dto.closesAt, DateTime.utc(2026, 12, 31, 16, 59, 59));
    expect(dto.budgetVnd, 5000000000);
  });

  test('EventSummaryDto chỉ có id vẫn đọc được', () {
    final dto = EventSummaryDto.fromJson({'id': 1});
    expect(dto.title, '');
    expect(dto.status, '');
    expect(dto.createdAt, isNull);
  });

  test('EventDetailDto có tracks, activities, myActivityStates, activeRule.tasks, awards', () {
    final dto = EventDetailDto.fromJson({
      'id': 7,
      'title': 'Ngày hội',
      'status': 'Published',
      'canManageEvent': null,
      'assistantModeratorIds': null,
      'tracks': [
        {
          'id': 1,
          'trackType': 'Parent',
          'registrationStartAt': '2026-11-01T00:00:00Z',
          'registrationEndAt': '2026-11-10T00:00:00Z',
          'executionStartAt': '2026-11-01T00:00:00Z',
          'executionEndAt': '2026-11-30T00:00:00Z',
          'maxSubmissionsPerUser': 0,
          'grantAiCredits': 2,
          'grantSubmitCredits': 0,
          'waiveWeeklyLibraryLimit': true,
          'claimWindowHours': 72,
          'maxReallocationRounds': 1,
          'awardAllMissionCompleters': false,
        },
      ],
      'activities': [
        {
          'id': 11,
          'activityType': 'ReadingMissions',
          'allowedAudience': 'Parent',
          'registrationStartAt': '2026-11-01T00:00:00Z',
          'registrationEndAt': '2026-11-10T00:00:00Z',
          'startAt': '2026-11-01T00:00:00Z',
          'endAt': '2026-11-30T00:00:00Z',
          'reviewCutoffAt': null,
          'grantAiCredits': 0,
          'maxSubmissionsPerUser': null,
          'maxRegistrations': 100,
          'waiveWeeklyLibraryLimit': false,
          'storySource': 'Both',
          'minVotesPerSubmission': 5,
          'claimWindowHours': 72,
          'maxReallocationRounds': 1,
          'awardAllMissionCompleters': true,
          'configJson': null,
        },
      ],
      'myActivityStates': [
        {
          'activityId': 11,
          'activityType': 'ReadingMissions',
          'allowedAudience': 'Parent',
          'lifecycleStatus': 'Open',
          'isEligible': true,
          'isRegistered': true,
          'participationId': 5,
          'participationStatus': 'Registered',
          'appealDeadlineAt': null,
          'canRegister': false,
          'canSubmit': false,
          'canDoMissions': true,
          'canVote': false,
          'submissionsCount': 0,
          'maxSubmissionsPerUser': null,
        },
      ],
      'activeRule': {
        'id': 2,
        'versionNo': 1,
        'contentHash': 'abc',
        'rulesText': 'Đọc 3 truyện',
        'rewardEligibilityText': null,
        'completionMode': 'AllMandatory',
        'requiredTaskCount': null,
        'requiredPoints': null,
        'isActive': true,
        'tasks': [
          {
            'id': 21,
            'taskCode': 'READ_3',
            'targetTrackType': null,
            'title': 'Đọc 3 truyện',
            'description': '',
            'sortOrder': 1,
            'verifierType': 'ReadEventStories',
            'targetValue': 3,
            'configJson': null,
            'isMandatory': true,
            'points': 10,
            'allowMultiplePerStory': false,
          },
        ],
      },
      'awards': [
        {
          'id': 31,
          'rewardType': 'PhysicalGift',
          'rewardName': 'Gấu bông',
          'status': 'AwardApproved',
        },
      ],
      'eventStoriesCount': 12,
    });
    expect(dto.tracks.single.executionEndAt, DateTime.utc(2026, 11, 30));
    expect(dto.activities.single.awardAllMissionCompleters, isTrue);
    expect(dto.activities.single.reviewCutoffAt, isNull);
    expect(dto.myActivityStates.single.canDoMissions, isTrue);
    expect(dto.myActivityStates.single.participationStatus, 'Registered');
    expect(dto.activeRule!.tasks.single.verifierType, 'ReadEventStories');
    expect(dto.awards.single.rewardName, 'Gấu bông');
    expect(dto.eventStoriesCount, 12);
  });

  test('EventDetailDto thiếu danh sách và activeRule vẫn đọc được', () {
    final dto = EventDetailDto.fromJson({'id': 1, 'activeRule': null});
    expect(dto.tracks, isEmpty);
    expect(dto.activities, isEmpty);
    expect(dto.myActivityStates, isEmpty);
    expect(dto.awards, isEmpty);
    expect(dto.activeRule, isNull);
  });

  test('EventMissionDashboardDto có tasks và stories', () {
    final dto = EventMissionDashboardDto.fromJson({
      'participation': {
        'id': 5,
        'eventId': 7,
        'trackId': null,
        'trackType': 'Parent',
        'eventActivityId': 11,
        'activityType': 'ReadingMissions',
        'userId': 9,
        'acceptedRuleVersionId': 2,
        'status': 'Registered',
        'missionCompletedAt': null,
        'verificationNotesJson': null,
        'safetyWarning': null,
      },
      'completionMode': 'MinimumTasksCount',
      'requiredTaskCount': 2,
      'requiredPoints': null,
      'completedTasksCount': 1,
      'earnedPoints': 10,
      'allRequirementsMet': false,
      'tasks': [
        {
          'taskDefinitionId': 21,
          'taskCode': 'READ_3',
          'title': 'Đọc 3 truyện',
          'description': '',
          'verifierType': 'ReadEventStories',
          'targetValue': 3,
          'currentValue': 1,
          'isCompleted': false,
          'isMandatory': true,
          'points': 10,
        },
      ],
      'stories': [
        {
          'storyId': 100,
          'storyVersionId': 101,
          'title': 'Ếch con',
          'description': '',
          'ageBand': '4-6',
          'genre': 'Cổ tích',
          'source': 'ModeratorSeed',
          'hasFamilyRead': true,
          'votingText': null,
          'myVoteStars': null,
          'myVoteComment': null,
        },
      ],
      'votingStories': [],
    });
    expect(dto.participation!.eventActivityId, 11);
    expect(dto.requiredTaskCount, 2);
    expect(dto.tasks.single.currentValue, 1);
    expect(dto.stories.single.hasFamilyRead, isTrue);
    expect(dto.votingStories, isEmpty);
  });

  test('EventAwardSlotDto của my-rewards', () {
    final dto = EventAwardSlotDto.fromJson({
      'notificationFailed': false,
      'id': 31,
      'trackId': null,
      'eventActivityId': 11,
      'activityType': 'ReadingMissions',
      'resultSource': 'MissionCompletion',
      'targetAudience': 'Parent',
      'rankOrTier': 'Hoàn thành',
      'slotIndex': 0,
      'rewardType': 'CashTransfer',
      'rewardName': 'Tiền thưởng',
      'unitValueVnd': 200000,
      'creditGrantAmount': 0,
      'submitCreditGrantAmount': 0,
      'participationId': 5,
      'status': 'AwaitingClaim',
      'claimDeadlineAt': '2026-12-01T00:00:00Z',
    });
    expect(dto.rewardType, 'CashTransfer');
    expect(dto.unitValueVnd, 200000);
    expect(dto.claimDeadlineAt, DateTime.utc(2026, 12));
    expect(EventAwardSlotDto.fromJson({'id': 1}).claimDeadlineAt, isNull);
  });
}
