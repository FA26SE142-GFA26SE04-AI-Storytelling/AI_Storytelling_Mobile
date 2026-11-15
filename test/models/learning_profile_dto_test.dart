import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/models/learning_profile_dto.dart';

void main() {
  group('LearningProfileDto', () {
    test('fromJson đủ trường', () {
      final json = <String, dynamic>{
        'id': 1,
        'childProfileId': 10,
        'readingLevel': 2,
        'readingMode': 'assisted',
        'comprehensionGoal': 'advanced',
        'topics': [
          {
            'topic': 'Dinosaurs',
            'relation': 'interested',
          },
        ],
      };

      final dto = LearningProfileDto.fromJson(json);

      expect(dto.id, 1);
      expect(dto.childProfileId, 10);
      expect(dto.readingLevel, 2);
      expect(dto.readingMode, 'assisted');
      expect(dto.comprehensionGoal, 'advanced');
      expect(dto.topics, hasLength(1));
      expect(dto.topics.first.topic, 'Dinosaurs');
      expect(dto.topics.first.relation, 'interested');
    });

    test('JSON không có topics: topics isEmpty', () {
      final json = <String, dynamic>{
        'id': 1,
        'childProfileId': 10,
        'readingLevel': 2,
        'readingMode': 'assisted',
        'comprehensionGoal': 'advanced',
      };

      final dto = LearningProfileDto.fromJson(json);

      expect(dto.id, 1);
      expect(dto.childProfileId, 10);
      expect(dto.readingLevel, 2);
      expect(dto.readingMode, 'assisted');
      expect(dto.comprehensionGoal, 'advanced');
      expect(dto.topics, isEmpty);
    });
  });
}
