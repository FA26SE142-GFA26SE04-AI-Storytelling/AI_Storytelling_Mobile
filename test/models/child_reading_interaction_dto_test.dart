import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/models/child_reading_dto.dart';
import 'package:ai_storytelling_mobile/models/child_interaction_dto.dart';
import 'package:ai_storytelling_mobile/models/child_read_aloud_dto.dart';

void main() {
  group('reading interaction DTOs', () {
    test('ReadingScene.fromJson với interaction là đối tượng đầy đủ', () {
      final json = {
        "sceneId": 5,
        "sceneIndex": 0,
        "text": "Mèo ngồi trên thảm.",
        "illustrationUrl": null,
        "segments": [],
        "attemptedInSession": false,
        "interaction": {
          "id": 9,
          "type": "PicturePrediction",
          "kind": null,
          "prompt": "Bạn đoán mèo sẽ làm gì?",
          "characterName": null,
          "modelSentence": null,
          "modelAudioUrl": null,
          "maskedSentence": null,
          "hint": null,
          "waitFeedback": "Hay quá!",
          "revealSceneIndex": 1,
          "audioUrls": {"prompt": "https://x/p.mp3"},
          "options": [
            {
              "id": 31,
              "text": "Ngủ",
              "imageUrl": "https://x/a.png",
              "audioUrl": null,
              "feedback": "Đúng rồi!",
              "feedbackAudioUrl": null
            }
          ]
        }
      };

      final scene = ReadingScene.fromJson(json);

      expect(scene.interaction!.type, 'PicturePrediction');
      expect(scene.interaction!.options.first.id, 31);
      expect(scene.interaction!.audioUrls['prompt'], 'https://x/p.mp3');
      expect(scene.interaction!.revealSceneIndex, 1);
    });

    test('ReadingScene.fromJson với interaction là null', () {
      final json = {
        "sceneId": 5,
        "sceneIndex": 0,
        "text": "Mèo ngồi trên thảm.",
        "illustrationUrl": null,
        "segments": [],
        "attemptedInSession": false,
        "interaction": null,
      };

      final scene = ReadingScene.fromJson(json);

      expect(scene.interaction, isNull);
    });

    test('ListeningAttemptResult.fromJson với kết quả tương tác nghe hiểu', () {
      final json = {
        "interactionId": 9,
        "type": "EventOrdering",
        "matched": false,
        "feedback": "Nghe lại nhé",
        "feedbackAudioUrl": null,
        "suggestedAnswer": null,
        "replaySceneIndexes": [0, 2],
        "revealed": false,
        "correctOrderOptionIds": null
      };

      final result = ListeningAttemptResult.fromJson(json);

      expect(result.matched, false);
      expect(result.replaySceneIndexes, [0, 2]);
      expect(result.revealed, false);
      expect(result.correctOrderOptionIds, isNull);
    });

    test('ReadAloudResult.fromJson với kết quả đọc to', () {
      final json = {
        "sessionId": 3,
        "segmentId": 7,
        "words": [
          {"index": 0, "text": "Mèo", "status": "good", "hint": null},
          {"index": 1, "text": "ngồi", "status": "retry", "hint": "unclear"}
        ],
        "goodCount": 1,
        "retryCount": 1,
        "skippedCount": 0,
        "totalCount": 2,
        "message": "Em đọc hay lắm!"
      };

      final result = ReadAloudResult.fromJson(json);

      expect(result.words.length, 2);
      expect(result.words[1].status, 'retry');
      expect(result.words[1].hint, 'unclear');
      expect(result.goodCount, 1);
      expect(result.totalCount, 2);
    });
  });
}
