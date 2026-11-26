import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/models/safety_policy_dto.dart';

void main() {
  group('SafetyPolicyDto', () {
    test('fromJson với JSON đầy đủ mọi trường', () {
      final json = <String, dynamic>{
        'childProfileId': 10,
        'parentalGateEnabled': false,
        'maxStoryLength': 500,
        'requiredApprovalMode': 'strict',
        'consentRecorded': true,
        'consentRecordedAt': '2026-11-15T10:00:00.000Z',
        'consentPolicyVersion': 2,
        'consentOutdated': false,
        'safetyScoreThreshold': 0.85,
        'readabilityScoreThreshold': 0.75,
        'comprehensionThresholdPercent': 80,
        'comprehensionWindowSize': 5,
        'storyWishesEnabled': true,
        'allowInteractiveStories': true,
        'childCreationEnabled': true,
        'childCreationMode': 'guided',
        'voiceAnswersEnabled': true,
        'voiceConsentAt': '2026-11-15T11:00:00.000Z',
        'categories': [
          {
            'contentCategoryId': 1,
            'rule': 'block',
          },
        ],
      };

      final dto = SafetyPolicyDto.fromJson(json);

      expect(dto.childProfileId, 10);
      expect(dto.parentalGateEnabled, false);
      expect(dto.maxStoryLength, 500);
      expect(dto.requiredApprovalMode, 'strict');
      expect(dto.consentRecorded, true);
      expect(dto.consentRecordedAt, DateTime.parse('2026-11-15T10:00:00.000Z'));
      expect(dto.consentPolicyVersion, 2);
      expect(dto.consentOutdated, false);
      expect(dto.safetyScoreThreshold, 0.85);
      expect(dto.readabilityScoreThreshold, 0.75);
      expect(dto.comprehensionThresholdPercent, 80);
      expect(dto.comprehensionWindowSize, 5);
      expect(dto.storyWishesEnabled, true);
      expect(dto.allowInteractiveStories, true);
      expect(dto.childCreationEnabled, true);
      expect(dto.childCreationMode, 'guided');
      expect(dto.voiceAnswersEnabled, true);
      expect(dto.voiceConsentAt, DateTime.parse('2026-11-15T11:00:00.000Z'));
      expect(dto.categories, hasLength(1));
      expect(dto.categories.first.contentCategoryId, 1);
      expect(dto.categories.first.rule, 'block');
    });

    test('JSON thiếu trường: parentalGateEnabled == true, categories isEmpty, các trường khác null', () {
      final json = <String, dynamic>{
        'childProfileId': 10,
      };

      final dto = SafetyPolicyDto.fromJson(json);

      expect(dto.childProfileId, 10);
      expect(dto.parentalGateEnabled, isTrue);
      expect(dto.categories, isEmpty);
      expect(dto.maxStoryLength, isNull);
      expect(dto.requiredApprovalMode, isNull);
      expect(dto.consentRecorded, isNull);
      expect(dto.consentRecordedAt, isNull);
      expect(dto.consentPolicyVersion, isNull);
      expect(dto.consentOutdated, isNull);
      expect(dto.safetyScoreThreshold, isNull);
      expect(dto.readabilityScoreThreshold, isNull);
      expect(dto.comprehensionThresholdPercent, isNull);
      expect(dto.comprehensionWindowSize, isNull);
      expect(dto.storyWishesEnabled, isNull);
      expect(dto.allowInteractiveStories, isNull);
      expect(dto.childCreationEnabled, isNull);
      expect(dto.childCreationMode, isNull);
      expect(dto.voiceAnswersEnabled, isNull);
      expect(dto.voiceConsentAt, isNull);
    });

    test('safetyPolicyToRequest(policy) với policy từ JSON đầy đủ', () {
      final json = <String, dynamic>{
        'childProfileId': 10,
        'parentalGateEnabled': false,
        'maxStoryLength': 500,
        'requiredApprovalMode': 'strict',
        'consentRecorded': true,
        'consentRecordedAt': '2026-11-15T10:00:00.000Z',
        'consentPolicyVersion': 2,
        'consentOutdated': false,
        'safetyScoreThreshold': 0.85,
        'readabilityScoreThreshold': 0.75,
        'comprehensionThresholdPercent': 80,
        'comprehensionWindowSize': 5,
        'storyWishesEnabled': true,
        'allowInteractiveStories': true,
        'childCreationEnabled': true,
        'childCreationMode': 'guided',
        'voiceAnswersEnabled': true,
        'voiceConsentAt': '2026-11-15T11:00:00.000Z',
        'categories': [
          {
            'contentCategoryId': 1,
            'rule': 'block',
          },
        ],
      };

      final policy = SafetyPolicyDto.fromJson(json);
      final body = safetyPolicyToRequest(policy);

      expect(body['maxStoryLength'], policy.maxStoryLength);
      expect(body['requiredApprovalMode'], policy.requiredApprovalMode);
      expect(body['parentalGateEnabled'], policy.parentalGateEnabled);
      expect(body['consentRecorded'], policy.consentRecorded);
      expect(body['safetyScoreThreshold'], policy.safetyScoreThreshold);
      expect(body['readabilityScoreThreshold'], policy.readabilityScoreThreshold);
      expect(body['comprehensionThresholdPercent'], policy.comprehensionThresholdPercent);
      expect(body['comprehensionWindowSize'], policy.comprehensionWindowSize);
      expect(body['storyWishesEnabled'], policy.storyWishesEnabled);
      expect(body['allowInteractiveStories'], policy.allowInteractiveStories);
      expect(body['childCreationEnabled'], policy.childCreationEnabled);
      expect(body['childCreationMode'], policy.childCreationMode);
      expect(body['voiceAnswersEnabled'], policy.voiceAnswersEnabled);
      expect(body['categories'], [
        {
          'contentCategoryId': 1,
          'rule': 'block',
        },
      ]);
    });

    test('Test không mất trường và giữ giá trị null', () {
      const expectedKeys = [
        'maxStoryLength',
        'requiredApprovalMode',
        'parentalGateEnabled',
        'consentRecorded',
        'safetyScoreThreshold',
        'readabilityScoreThreshold',
        'comprehensionThresholdPercent',
        'comprehensionWindowSize',
        'storyWishesEnabled',
        'allowInteractiveStories',
        'childCreationEnabled',
        'childCreationMode',
        'voiceAnswersEnabled',
        'categories',
        'storyLengthTarget',
        'applyAgePreset',
      ];

      final fullPolicy = SafetyPolicyDto.fromJson({
        'childProfileId': 10,
        'parentalGateEnabled': false,
        'maxStoryLength': 500,
        'requiredApprovalMode': 'strict',
        'consentRecorded': true,
        'consentRecordedAt': '2026-11-15T10:00:00.000Z',
        'consentPolicyVersion': 2,
        'consentOutdated': false,
        'safetyScoreThreshold': 0.85,
        'readabilityScoreThreshold': 0.75,
        'comprehensionThresholdPercent': 80,
        'comprehensionWindowSize': 5,
        'storyWishesEnabled': true,
        'allowInteractiveStories': true,
        'childCreationEnabled': true,
        'childCreationMode': 'guided',
        'voiceAnswersEnabled': true,
        'voiceConsentAt': '2026-11-15T11:00:00.000Z',
        'categories': [
          {'contentCategoryId': 1, 'rule': 'block'},
        ],
      });

      final fullBody = safetyPolicyToRequest(fullPolicy);
      expect(fullBody.keys.toSet(), containsAll(expectedKeys));
      expect(fullBody.keys.length, expectedKeys.length);

      final policyWithNullThreshold = fullPolicy.copyWith(safetyScoreThreshold: null);
      final bodyWithNull = safetyPolicyToRequest(policyWithNullThreshold);
      expect(bodyWithNull.containsKey('safetyScoreThreshold'), isTrue);
      expect(bodyWithNull['safetyScoreThreshold'], isNull);

      // Trường bool/int null không được gửi (Backend không nhận null).
      final bodyNoWishes =
          safetyPolicyToRequest(fullPolicy.copyWith(storyWishesEnabled: null));
      expect(bodyNoWishes.containsKey('storyWishesEnabled'), isFalse);
    });

    test('Test copyWith: policy.copyWith(parentalGateEnabled: false) vẫn giữ các field khác', () {
      final policy = SafetyPolicyDto(
        childProfileId: 10,
        parentalGateEnabled: true,
        maxStoryLength: 500,
        requiredApprovalMode: 'strict',
        consentRecorded: true,
        safetyScoreThreshold: 0.85,
        readabilityScoreThreshold: 0.75,
        comprehensionThresholdPercent: 80,
        comprehensionWindowSize: 5,
        storyWishesEnabled: true,
        allowInteractiveStories: true,
        childCreationEnabled: true,
        childCreationMode: 'guided',
        voiceAnswersEnabled: true,
        categories: const [
          SafetyCategoryRuleDto(contentCategoryId: 1, rule: 'block'),
        ],
      );

      final modified = policy.copyWith(parentalGateEnabled: false);
      final body = safetyPolicyToRequest(modified);

      expect(body['parentalGateEnabled'], isFalse);
      expect(body['maxStoryLength'], 500);
      expect(body['requiredApprovalMode'], 'strict');
      expect(body['consentRecorded'], isTrue);
      expect(body['safetyScoreThreshold'], 0.85);
      expect(body['readabilityScoreThreshold'], 0.75);
      expect(body['comprehensionThresholdPercent'], 80);
      expect(body['comprehensionWindowSize'], 5);
      expect(body['storyWishesEnabled'], isTrue);
      expect(body['allowInteractiveStories'], isTrue);
      expect(body['childCreationEnabled'], isTrue);
      expect(body['childCreationMode'], 'guided');
      expect(body['voiceAnswersEnabled'], isTrue);
      expect(body['categories'], [
        {'contentCategoryId': 1, 'rule': 'block'},
      ]);
    });

    test('storyLengthTarget = 1200 thì request[\'storyLengthTarget\'] == 1200', () {
      final policy = SafetyPolicyDto.fromJson({
        'childProfileId': 10,
        'storyLengthTarget': 1200,
      });
      final request = safetyPolicyToRequest(policy);
      expect(request['storyLengthTarget'], 1200);
    });

    test('storyLengthTarget = null thì request có key \'storyLengthTarget\' và giá trị null', () {
      final policy = SafetyPolicyDto.fromJson({
        'childProfileId': 10,
        'storyLengthTarget': null,
      });
      final request = safetyPolicyToRequest(policy);
      expect(request.containsKey('storyLengthTarget'), isTrue);
      expect(request['storyLengthTarget'], isNull);
    });

    test('quizEnabled/notebookEnabled/libraryBrowseEnabled/reflectionEnabled/rewardsEnabled = false thì request có đúng 5 giá trị false', () {
      final policy = SafetyPolicyDto.fromJson({
        'childProfileId': 10,
        'quizEnabled': false,
        'notebookEnabled': false,
        'libraryBrowseEnabled': false,
        'reflectionEnabled': false,
        'rewardsEnabled': false,
      });
      final request = safetyPolicyToRequest(policy);
      expect(request['quizEnabled'], isFalse);
      expect(request['notebookEnabled'], isFalse);
      expect(request['libraryBrowseEnabled'], isFalse);
      expect(request['reflectionEnabled'], isFalse);
      expect(request['rewardsEnabled'], isFalse);
    });

    test('5 cờ tính năng null thì request KHÔNG có các key này', () {
      final policy = SafetyPolicyDto.fromJson({
        'childProfileId': 10,
        'quizEnabled': null,
        'notebookEnabled': null,
        'libraryBrowseEnabled': null,
        'reflectionEnabled': null,
        'rewardsEnabled': null,
      });
      final request = safetyPolicyToRequest(policy);
      expect(request.containsKey('quizEnabled'), isFalse);
      expect(request.containsKey('notebookEnabled'), isFalse);
      expect(request.containsKey('libraryBrowseEnabled'), isFalse);
      expect(request.containsKey('reflectionEnabled'), isFalse);
      expect(request.containsKey('rewardsEnabled'), isFalse);
    });

    test('request luôn có \'applyAgePreset\' == false', () {
      final policy = SafetyPolicyDto.fromJson({
        'childProfileId': 10,
      });
      final request = safetyPolicyToRequest(policy);
      expect(request['applyAgePreset'], isFalse);
    });
  });
}
