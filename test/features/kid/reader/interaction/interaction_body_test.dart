import 'package:flutter_test/flutter_test.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/interaction/interaction_body.dart';
import 'package:ai_storytelling_mobile/models/reading_interaction_dto.dart';

void main() {
  group('buildAttemptBody', () {
    test("'Checkpoint' optionId 4 -> toJson {'optionId': 4}; optionId null -> null", () {
      final q = ReadingInteractionDto.fromJson({'id': 1, 'type': 'Checkpoint', 'options': []});
      final resWithOption = buildAttemptBody(q, optionId: 4);
      expect(resWithOption?.toJson(), {'optionId': 4});

      final resNullOption = buildAttemptBody(q, optionId: null);
      expect(resNullOption, isNull);
    });

    test("'PicturePrediction' optionId 2 -> {'optionId': 2}", () {
      final q = ReadingInteractionDto.fromJson({'id': 1, 'type': 'PicturePrediction', 'options': []});
      final res = buildAttemptBody(q, optionId: 2);
      expect(res?.toJson(), {'optionId': 2});
    });

    test("'FillBlank' answer '  con ếch ' -> {'answer': 'con ếch'}; answer rỗng hoặc chỉ khoảng trắng -> null", () {
      final q = ReadingInteractionDto.fromJson({'id': 1, 'type': 'FillBlank', 'options': []});
      final resValid = buildAttemptBody(q, answer: '  con ếch ');
      expect(resValid?.toJson(), {'answer': 'con ếch'});

      final resEmpty = buildAttemptBody(q, answer: '');
      expect(resEmpty, isNull);

      final resWhitespaceOnly = buildAttemptBody(q, answer: '   ');
      expect(resWhitespaceOnly, isNull);

      final resNull = buildAttemptBody(q, answer: null);
      expect(resNull, isNull);
    });

    test("'EventOrdering' orderedOptionIds [3,1,2] -> {'orderedOptionIds': [3,1,2]}; rỗng -> null", () {
      final q = ReadingInteractionDto.fromJson({'id': 1, 'type': 'EventOrdering', 'options': []});
      final resValid = buildAttemptBody(q, orderedOptionIds: [3, 1, 2]);
      expect(resValid?.toJson(), {'orderedOptionIds': [3, 1, 2]});

      final resEmpty = buildAttemptBody(q, orderedOptionIds: []);
      expect(resEmpty, isNull);

      final resNull = buildAttemptBody(q, orderedOptionIds: null);
      expect(resNull, isNull);
    });

    test("'RolePlay' -> toJson {} (body rỗng, không null)", () {
      final q = ReadingInteractionDto.fromJson({'id': 1, 'type': 'RolePlay', 'options': []});
      final res = buildAttemptBody(q);
      expect(res, isNotNull);
      expect(res?.toJson(), <String, dynamic>{});
    });

    test("type 'Lạ' -> null", () {
      final q = ReadingInteractionDto.fromJson({'id': 1, 'type': 'Lạ', 'options': []});
      final res = buildAttemptBody(q);
      expect(res, isNull);
    });
  });
}
