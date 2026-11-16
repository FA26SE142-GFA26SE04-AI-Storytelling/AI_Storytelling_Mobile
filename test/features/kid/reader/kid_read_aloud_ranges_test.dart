import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/features/kid/reader/kid_read_aloud_ranges.dart';
import 'package:ai_storytelling_mobile/models/child_read_aloud_dto.dart';

void main() {
  group('readAloudWordRanges', () {
    test(
      'khớp đúng 4 ranges cho "Bé Na, đi học!" với 4 words và không chứa dấu câu',
      () {
        const segmentText = 'Bé Na, đi học!';
        const words = [
          ReadAloudWord(index: 0, text: 'Bé', status: 'good'),
          ReadAloudWord(index: 1, text: 'Na', status: 'good'),
          ReadAloudWord(index: 2, text: 'đi', status: 'good'),
          ReadAloudWord(index: 3, text: 'học', status: 'good'),
        ];

        final ranges = readAloudWordRanges(segmentText, words);

        expect(ranges.length, 4);

        // Range đầu: start=0, end=2 ("Bé")
        expect(ranges[0].start, 0);
        expect(ranges[0].end, 2);
        expect(segmentText.substring(ranges[0].start, ranges[0].end), 'Bé');

        // Range 2: word "đi"
        expect(segmentText.substring(ranges[2].start, ranges[2].end), 'đi');
        expect(
          segmentText.substring(ranges[2].start, ranges[2].end),
          words[2].text,
        );

        // Substring của mỗi range khớp text word và không chứa ',' hoặc '!'
        for (var i = 0; i < ranges.length; i++) {
          final rangeText = segmentText.substring(
            ranges[i].start,
            ranges[i].end,
          );
          expect(rangeText, words[i].text);
          expect(rangeText.contains(','), isFalse);
          expect(rangeText.contains('!'), isFalse);
        }
      },
    );

    test('số words ít hơn số chữ: 4 chữ, 2 words -> trả về đúng 2 ranges', () {
      const segmentText = 'Bé Na đi học';
      const words = [
        ReadAloudWord(index: 0, text: 'Bé', status: 'good'),
        ReadAloudWord(index: 1, text: 'Na', status: 'good'),
      ];

      final ranges = readAloudWordRanges(segmentText, words);

      expect(ranges.length, 2);
      expect(segmentText.substring(ranges[0].start, ranges[0].end), 'Bé');
      expect(segmentText.substring(ranges[1].start, ranges[1].end), 'Na');
    });

    test(
      'số words nhiều hơn số chữ: 2 chữ ("Mèo ăn"), 4 words -> trả về đúng 2 ranges',
      () {
        const segmentText = 'Mèo ăn';
        const words = [
          ReadAloudWord(index: 0, text: 'Mèo', status: 'good'),
          ReadAloudWord(index: 1, text: 'ăn', status: 'good'),
          ReadAloudWord(index: 2, text: 'cá', status: 'good'),
          ReadAloudWord(index: 3, text: 'rán', status: 'good'),
        ];

        final ranges = readAloudWordRanges(segmentText, words);

        expect(ranges.length, 2);
        expect(segmentText.substring(ranges[0].start, ranges[0].end), 'Mèo');
        expect(segmentText.substring(ranges[1].start, ranges[1].end), 'ăn');
      },
    );

    test(
      'words rỗng, segmentText rỗng, hoặc text chỉ có dấu câu "!!!" -> list rỗng',
      () {
        // words rỗng -> list rỗng
        expect(
          readAloudWordRanges('Bé Na đi học', []),
          isEmpty,
        );

        // segmentText rỗng -> list rỗng
        expect(
          readAloudWordRanges('', [
            const ReadAloudWord(index: 0, text: 'Bé', status: 'good'),
          ]),
          isEmpty,
        );

        // Text chỉ có dấu câu "!!!" với 1 word -> list rỗng
        expect(
          readAloudWordRanges('!!!', [
            const ReadAloudWord(index: 0, text: 'Bé', status: 'good'),
          ]),
          isEmpty,
        );
      },
    );

    test(
      'words không sắp theo index (đảo thứ tự list) -> ghép status đúng theo index',
      () {
        const segmentText = 'Bé đi học';
        // Danh sách đảo thứ tự: index 1 đứng trước index 0
        const words = [
          ReadAloudWord(index: 1, text: 'đi', status: 'retry'),
          ReadAloudWord(index: 0, text: 'Bé', status: 'good'),
          ReadAloudWord(index: 2, text: 'học', status: 'skipped'),
        ];

        final ranges = readAloudWordRanges(segmentText, words);

        expect(ranges.length, 3);
        // Range đầu là chữ "Bé" (index 0) và có status của word index 0 ('good')
        expect(segmentText.substring(ranges[0].start, ranges[0].end), 'Bé');
        expect(ranges[0].status, 'good');

        // Range tiếp theo là chữ "đi" (index 1) với status 'retry'
        expect(segmentText.substring(ranges[1].start, ranges[1].end), 'đi');
        expect(ranges[1].status, 'retry');

        // Range cuối là chữ "học" (index 2) với status 'skipped'
        expect(segmentText.substring(ranges[2].start, ranges[2].end), 'học');
        expect(ranges[2].status, 'skipped');
      },
    );

    test('mang hint của từng word vào range', () {
      const segmentText = 'Bé Na';
      const words = [
        ReadAloudWord(index: 0, text: 'Bé', status: 'good', hint: null),
        ReadAloudWord(index: 1, text: 'Na', status: 'retry', hint: 'tone'),
      ];

      final ranges = readAloudWordRanges(segmentText, words);

      expect(ranges[1].hint, 'tone');
      expect(ranges[0].hint, isNull);
    });
  });
}
