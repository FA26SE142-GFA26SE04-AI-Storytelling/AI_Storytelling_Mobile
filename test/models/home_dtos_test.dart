import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/models/child_roadmap_dto.dart';
import 'package:ai_storytelling_mobile/models/parent_reading_feedback_dto.dart';

void main() {
  test('ParentReadingFeedbackPageDto đọc PagedResult của /ParentReadingFeedback', () {
    // Theo ParentReadingFeedbackItemDto (Backend): quizBestPercent là decimal, có conversationAnswers.
    final dto = ParentReadingFeedbackPageDto.fromJson({
      'items': [
        {
          'sessionId': 41,
          'storyId': 908,
          'title': 'Sóc Bông',
          'completedAt': '2026-11-14T08:30:00Z',
          'feeling': 'VeryLike',
          'feelingLabel': 'Rất thích',
          'quizTotalQuestions': 5,
          'quizBestPercent': 80,
          'conversationAnswers': <dynamic>[],
        },
        {
          'sessionId': 40,
          'storyId': 911,
          'title': 'Rùa và thỏ',
          'completedAt': null,
          'feeling': null,
          'feelingLabel': null,
          'quizTotalQuestions': 0,
          'quizBestPercent': null,
        },
      ],
      'pageIndex': 1,
      'pageSize': 20,
      'totalCount': 2,
      'totalPages': 1,
      'hasNextPage': false,
      'hasPreviousPage': false,
    });

    expect(dto.items, hasLength(2));
    expect(dto.items.first.quizBestPercent, 80.0);
    expect(dto.items.first.completedAt, DateTime.utc(2026, 11, 14, 8, 30));
    expect(dto.items.last.feelingLabel, isNull);
    expect(dto.totalCount, 2);
  });

  test('ChildRoadmapDto đọc /ChildRoadmap: open có thể null, title có thể null', () {
    final dto = ChildRoadmapDto.fromJson({
      'childProfileId': 7,
      'open': {
        'id': 3,
        'storyId': 908,
        'title': null,
        'position': 1,
        'status': 'Open',
        'source': 'Parent',
        'skipReason': null,
        'note': null,
        'expectedDays': 3,
        'expectedCompletionAt': '2026-11-18T00:00:00Z',
        'openedAt': '2026-11-15T00:00:00Z',
        'completedAt': null,
        'addedByUserId': 12,
        'isStoryAvailable': false,
      },
      'waiting': <dynamic>[],
      'history': <dynamic>[],
      'completedCount': 0,
      'totalCount': 1,
    });

    expect(dto.open?.storyId, 908);
    expect(dto.open?.title, isNull);
    expect(dto.open?.isStoryAvailable, isFalse);

    final empty = ChildRoadmapDto.fromJson({
      'childProfileId': 7,
      'open': null,
      'waiting': <dynamic>[],
      'history': <dynamic>[],
      'completedCount': 0,
      'totalCount': 0,
    });
    expect(empty.open, isNull);
  });
}
