import 'package:flutter_test/flutter_test.dart';
import 'package:ai_storytelling_mobile/models/reading_content_dto.dart';
import 'package:ai_storytelling_mobile/models/reading_interaction_dto.dart';
import 'package:ai_storytelling_mobile/models/reading_start_dto.dart';

void main() {
  group('Model đọc truyện', () {
    test('ReadingContentDto.fromJson với JSON đầy đủ', () {
      final json = {
        'sessionId': 101,
        'storyId': 202,
        'title': 'Truyện Cổ Tích',
        'lesson': 'Bài học yêu thương',
        'listenOnly': true,
        'scenes': [
          {
            'sceneId': 1,
            'sceneIndex': 0,
            'text': 'Đoạn một',
            'illustrationUrl': null,
            'illustrations': [
              {
                'beatOrder': 0,
                'startOffset': 0,
                'endOffset': 10,
                'url': 'https://example.com/img1.png',
              },
              {
                'beatOrder': 1,
                'startOffset': 11,
                'endOffset': 20,
                'url': 'https://example.com/img2.png',
              },
            ],
            'segments': [
              {
                'segmentId': 11,
                'segmentOrder': 1,
                'startOffset': 0,
                'endOffset': 10,
                'text': 'Đoạn một',
                'audioUrl': 'https://example.com/audio1.mp3',
              },
            ],
            'interaction': null,
            'attemptedInSession': false,
          },
          {
            'sceneId': 2,
            'sceneIndex': 1,
            'text': 'Đoạn hai',
            'illustrationUrl': 'https://example.com/cover.png',
            'illustrations': [],
            'segments': [],
            'interaction': null,
            'attemptedInSession': true,
          },
        ],
        'vocabulary': [
          {
            'id': 1,
            'term': 'dũng cảm',
          },
        ],
      };

      final dto = ReadingContentDto.fromJson(json);

      expect(dto.sessionId, 101);
      expect(dto.storyId, 202);
      expect(dto.title, 'Truyện Cổ Tích');
      expect(dto.lesson, 'Bài học yêu thương');
      expect(dto.listenOnly, isTrue);
      expect(dto.scenes.length, 2);

      final scene1 = dto.scenes[0];
      expect(scene1.sceneId, 1);
      expect(scene1.sceneIndex, 0);
      expect(scene1.text, 'Đoạn một');
      expect(scene1.illustrationUrl, isNull);
      expect(scene1.illustrations.length, 2);
      expect(scene1.illustrations[0].url, 'https://example.com/img1.png');
      expect(scene1.illustrations[1].url, 'https://example.com/img2.png');
      expect(scene1.segments.length, 1);
      expect(scene1.segments[0].audioUrl, 'https://example.com/audio1.mp3');

      final scene2 = dto.scenes[1];
      expect(scene2.sceneId, 2);
      expect(scene2.sceneIndex, 1);
      expect(scene2.text, 'Đoạn hai');
      expect(scene2.illustrationUrl, 'https://example.com/cover.png');
      expect(scene2.illustrations, isEmpty);
      expect(scene2.attemptedInSession, isTrue);

      expect(dto.vocabulary.length, 1);
      expect(dto.vocabulary[0].id, 1);
      expect(dto.vocabulary[0].term, 'dũng cảm');
    });

    test('ReadingContentDto.fromJson thiếu trường tuỳ chọn', () {
      final json = {
        'sessionId': 101,
        'storyId': 202,
        'scenes': [
          {
            'sceneId': 1,
            'sceneIndex': 0,
            'text': 'Nội dung ngắn',
          },
        ],
      };

      final dto = ReadingContentDto.fromJson(json);

      expect(dto.sessionId, 101);
      expect(dto.storyId, 202);
      expect(dto.title, '');
      expect(dto.lesson, isNull);
      expect(dto.listenOnly, isFalse);
      expect(dto.vocabulary, isEmpty);
      expect(dto.scenes.length, 1);

      final scene = dto.scenes[0];
      expect(scene.sceneId, 1);
      expect(scene.sceneIndex, 0);
      expect(scene.text, 'Nội dung ngắn');
      expect(scene.illustrations, isEmpty);
      expect(scene.segments, isEmpty);
      expect(scene.interaction, isNull);
      expect(scene.attemptedInSession, isFalse);
    });

    test('ReadingStartedDto.fromJson thiếu isBookmarked/isFavorited/resumed', () {
      final json = {
        'sessionId': 101,
        'storyId': 202,
        'lastPage': 3,
      };

      final dto = ReadingStartedDto.fromJson(json);

      expect(dto.sessionId, 101);
      expect(dto.storyId, 202);
      expect(dto.isBookmarked, isFalse);
      expect(dto.isFavorited, isFalse);
      expect(dto.resumed, isFalse);
      expect(dto.lastPage, 3);
    });

    test('ReadingCompletedDto.fromJson với newBadges và thiếu isRetake', () {
      final json = {
        'sessionId': 101,
        'storyId': 202,
        'newBadges': ['first_story'],
      };

      final dto = ReadingCompletedDto.fromJson(json);

      expect(dto.sessionId, 101);
      expect(dto.storyId, 202);
      expect(dto.isRetake, isFalse);
      expect(dto.newBadges, equals(['first_story']));
    });

    test('ReadingSignalDto.fromJson thiếu shouldExit', () {
      final json = {
        'message': 'Đã kết thúc',
      };

      final dto = ReadingSignalDto.fromJson(json);

      expect(dto.shouldExit, isFalse);
      expect(dto.message, 'Đã kết thúc');
    });

    test('ReadingInteractionDto.fromJson với options rỗng và audioUrls rỗng', () {
      final json = {
        'id': 1,
        'type': 'choice',
        'audioUrls': <String, String>{},
        'options': <dynamic>[],
      };

      final dto = ReadingInteractionDto.fromJson(json);

      expect(dto.id, 1);
      expect(dto.type, 'choice');
      expect(dto.audioUrls, isEmpty);
      expect(dto.options, isEmpty);
    });
  });
}
