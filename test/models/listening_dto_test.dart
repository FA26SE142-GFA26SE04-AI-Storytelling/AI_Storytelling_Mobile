import 'package:flutter_test/flutter_test.dart';
import 'package:ai_storytelling_mobile/models/listening_dto.dart';
import 'package:ai_storytelling_mobile/models/read_aloud_dto.dart';

void main() {
  group('Tương tác khi nghe và đọc to', () {
    test('ListeningAttemptResultDto.fromJson với JSON thiếu matched/feedback/...', () {
      final json = {
        'interactionId': 10,
        'type': 'Checkpoint',
      };
      final dto = ListeningAttemptResultDto.fromJson(json);

      expect(dto.matched, isNull);
      expect(dto.feedback, isNull);
      expect(dto.feedbackAudioUrl, isNull);
      expect(dto.suggestedAnswer, isNull);
      expect(dto.replaySceneIndexes, <int>[]);
      expect(dto.revealed, false);
      expect(dto.correctOrderOptionIds, isNull);
    });

    test('ListeningAttemptResultDto.fromJson đầy đủ', () {
      final json = {
        'interactionId': 10,
        'type': 'Checkpoint',
        'matched': true,
        'feedback': 'Giỏi quá',
        'feedbackAudioUrl': 'https://example.com/audio.mp3',
        'suggestedAnswer': 'Đáp án gợi ý',
        'replaySceneIndexes': [0, 2],
        'revealed': true,
        'correctOrderOptionIds': [1, 2, 3],
      };
      final dto = ListeningAttemptResultDto.fromJson(json);

      expect(dto.matched, true);
      expect(dto.replaySceneIndexes, [0, 2]);
    });

    test('ReadAloudResultDto.fromJson thiếu words/goodCount/message', () {
      final json = {
        'sessionId': 1,
        'segmentId': 2,
      };
      final dto = ReadAloudResultDto.fromJson(json);

      expect(dto.words, <ReadAloudWordDto>[]);
      expect(dto.goodCount, 0);
      expect(dto.message, '');
    });

    test('ReadAloudResultDto.fromJson đầy đủ 2 words', () {
      final json = {
        'sessionId': 1,
        'segmentId': 2,
        'words': [
          {
            'index': 0,
            'text': 'xin',
            'status': 'good',
          },
          {
            'index': 1,
            'text': 'chào',
            'status': 'retry',
            'hint': 'tone',
          },
        ],
        'goodCount': 1,
        'retryCount': 1,
        'skippedCount': 0,
        'totalCount': 2,
        'message': 'Cố lên!',
      };
      final dto = ReadAloudResultDto.fromJson(json);

      expect(dto.words.length, 2);
      expect(dto.words[0].status, 'good');
      expect(dto.words[1].status, 'retry');
      expect(dto.words[1].hint, 'tone');
    });

    test('ListeningAttemptRequestDto serialization', () {
      expect(const ListeningAttemptRequestDto().toJson(), isEmpty);
      expect(
        const ListeningAttemptRequestDto(optionId: 3).toJson(),
        {'optionId': 3},
      );
      expect(
        const ListeningAttemptRequestDto(orderedOptionIds: [2, 1]).toJson(),
        {
          'orderedOptionIds': [2, 1],
        },
      );
    });
  });
}
