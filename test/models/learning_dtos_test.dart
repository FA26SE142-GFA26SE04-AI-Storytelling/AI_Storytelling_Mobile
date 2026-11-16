import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/models/parent_reading_feedback_dto.dart';
import 'package:ai_storytelling_mobile/models/parent_story_summary_dto.dart';
import 'package:ai_storytelling_mobile/models/story_wish_dto.dart';

void main() {
  group('ParentReadingFeedbackItemDto.conversationAnswers', () {
    test('đọc đủ trường câu bé trả lời', () {
      final dto = ParentReadingFeedbackItemDto.fromJson({
        'sessionId': 1,
        'storyId': 2,
        'title': 'Sóc Bông',
        'conversationAnswers': [
          {
            'question': 'Bé thấy thế nào?',
            'kind': 'Emotion',
            'answerText': 'Vui lắm',
            'sceneIndex': 3,
            'answeredAt': '2026-11-14T08:30:00Z',
          },
          {'question': 'Q', 'kind': 'Opinion', 'answerText': 'A', 'sceneIndex': null},
        ],
      });
      expect(dto.conversationAnswers, hasLength(2));
      final a = dto.conversationAnswers.first;
      expect(a.answerText, 'Vui lắm');
      expect(a.sceneIndex, 3);
      expect(a.answeredAt, DateTime.utc(2026, 11, 14, 8, 30));
      expect(dto.conversationAnswers.last.sceneIndex, isNull);
    });

    test('thiếu conversationAnswers thì là danh sách rỗng', () {
      final dto = ParentReadingFeedbackItemDto.fromJson(
        {'sessionId': 1, 'storyId': 2, 'title': 'T'},
      );
      expect(dto.conversationAnswers, isEmpty);
    });
  });

  group('ParentStorySummaryPageDto', () {
    test('đọc đủ trường, kể cả cảnh bé thắc mắc', () {
      final page = ParentStorySummaryPageDto.fromJson({
        'items': [
          {
            'summaryId': 9,
            'sessionId': 41,
            'storyId': 908,
            'title': 'Sóc Bông',
            'createdAt': '2026-11-14T08:30:00Z',
            'recordingUrl': 'https://cdn.example/rec.webm?sig=1',
            'recordingSentAt': '2026-11-14T08:31:00Z',
            'flagsSentAt': null,
            'flags': [
              {
                'sceneId': 5,
                'sceneIndex': 2,
                'sceneText': 'Sóc leo cây',
                'illustrationUrl': 'https://cdn.example/s5.png',
              },
            ],
          },
        ],
        'totalCount': 1,
        'pageIndex': 1,
        'pageSize': 20,
        'totalPages': 1,
        'hasNextPage': false,
        'hasPreviousPage': false,
      });
      final s = page.items.single;
      expect(page.totalCount, 1);
      expect(s.summaryId, 9);
      expect(s.recordingUrl, contains('rec.webm'));
      expect(s.flagsSentAt, isNull);
      expect(s.flags.single.sceneIndex, 2);
      expect(s.flags.single.illustrationUrl, isNotNull);
    });

    test('thiếu trường / null vẫn đọc được', () {
      final page = ParentStorySummaryPageDto.fromJson({
        'items': [
          {'summaryId': 1, 'recordingUrl': null},
        ],
      });
      final s = page.items.single;
      expect(s.title, '');
      expect(s.createdAt, isNull);
      expect(s.recordingUrl, isNull);
      expect(s.flags, isEmpty);
      expect(page.hasNextPage, isFalse);
      expect(ParentStorySummaryPageDto.fromJson({}).items, isEmpty);
    });
  });

  group('ParentWish', () {
    test('đọc đủ trường', () {
      final w = ParentWish.fromJson({
        'wishId': 3,
        'childProfileId': 7,
        'kind': 'Cards',
        'status': 'Pending',
        'cards': [
          {'id': 1, 'group': 'Character', 'label': 'Thỏ con', 'imageUrl': 'x.png'},
        ],
        'lessonLeftToParent': true,
        'submittedAt': '2026-11-14T08:30:00Z',
        'expiresAt': '2026-11-16T08:30:00Z',
        'declineReason': null,
        'resolutionNote': null,
        'generatedStoryId': null,
        'generationRequestId': null,
        'fulfilledStoryId': null,
        'fulfilledWithExistingStory': false,
        'resolvedAt': null,
      });
      expect(w.status, 'Pending');
      expect(w.cards.single.label, 'Thỏ con');
      expect(w.lessonLeftToParent, isTrue);
      expect(w.expiresAt, DateTime.utc(2026, 11, 16, 8, 30));
    });

    test('thiếu trường thì dùng mặc định', () {
      final w = ParentWish.fromJson({'wishId': 3});
      expect(w.status, '');
      expect(w.cards, isEmpty);
      expect(w.submittedAt, isNull);
      expect(w.fulfilledWithExistingStory, isFalse);
    });
  });
}
