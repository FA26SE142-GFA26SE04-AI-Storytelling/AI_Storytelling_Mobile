import 'package:flutter_test/flutter_test.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/kid_caption_logic.dart';

void main() {
  group('Timing and parseWordTimings', () {
    test('parse mốc hợp lệ', () {
      const json =
          '[{"word": "Xin", "start": 0.5, "end": 0.9}, {"word": "chào", "start": 1, "end": 1.5}, {"word": "bạn", "start": 2.0}]';
      final timings = parseWordTimings(json);

      expect(timings.length, equals(3));
      expect(timings[0], equals(const Timing(word: 'Xin', start: 0.5, end: 0.9)));
      expect(timings[1], equals(const Timing(word: 'chào', start: 1.0, end: 1.5)));
      expect(timings[2], equals(const Timing(word: 'bạn', start: 2.0, end: null)));
    });

    test('JSON lỗi và cấu trúc không hợp lệ', () {
      expect(parseWordTimings('not a json string'), isEmpty);
      expect(parseWordTimings('{"word": "Xin", "start": 0.5}'), isEmpty);
      expect(parseWordTimings('[{"invalid": 123}]'), isEmpty);
      expect(parseWordTimings('[{"word": 123, "start": "0.5"}]'), isEmpty);
      expect(parseWordTimings('[{"word": "ok", "start": 1.0}, "invalid item"]'),
          equals([const Timing(word: 'ok', start: 1.0, end: null)]));
    });

    test('null và chuỗi rỗng', () {
      expect(parseWordTimings(null), isEmpty);
      expect(parseWordTimings(''), isEmpty);
      expect(parseWordTimings('   \n\t  '), isEmpty);
    });
  });

  group('storyHasWordTimings', () {
    test('null, rỗng và JSON lỗi -> false', () {
      expect(storyHasWordTimings([null]), isFalse);
      expect(storyHasWordTimings(['']), isFalse);
      expect(storyHasWordTimings(['not a json string', '{"word": "Xin"}', '[{"invalid": 123}]']), isFalse);
      expect(storyHasWordTimings([null, '', '   ']), isFalse);
    });

    test('danh sách rỗng -> false', () {
      expect(storyHasWordTimings([]), isFalse);
    });

    test('danh sách có một JSON mốc hợp lệ -> true', () {
      expect(storyHasWordTimings(['[{"word":"Hà","start":0.0,"end":0.4}]']), isTrue);
      expect(
        storyHasWordTimings([null, 'invalid', '[{"word":"Hà","start":0.0,"end":0.4}]']),
        isTrue,
      );
    });
  });

  group('paceOf and charInSegment', () {
    test('paceOf tính đúng pause cho dấu câu', () {
      final res = paceOf('Xin chào, các bạn! Hết.');
      expect(res.words.length, equals(5));
      expect(res.words[0].at, equals(0));
      expect(res.words[0].start, equals(0.0));
      // 'Xin': no pause -> total += 1.0
      // 'chào,': clause pause 0.6 -> total += 1.6
      // 'các': no pause -> total += 1.0
      // 'bạn!': sentence pause 1.2 -> total += 2.2
      // 'Hết.': sentence pause 1.2 -> total += 2.2
      expect(res.total, closeTo(1.0 + 1.6 + 1.0 + 2.2 + 2.2, 0.001));
    });

    test('charInSegment khi có timings', () {
      const timings = [
        Timing(word: 'Xin', start: 0.5, end: 1.0),
        Timing(word: 'chào', start: 1.5, end: 2.0),
        Timing(word: 'bạn', start: 3.0, end: 3.5),
      ];
      const text = 'Xin chào bạn';

      expect(charInSegment(text, timings, 0.0, 4.0), equals(0));
      expect(charInSegment(text, timings, 0.8, 4.0), equals(0)); // 'Xin' at 0
      expect(charInSegment(text, timings, 2.0, 4.0), equals(4)); // 'chào' at 4
      expect(charInSegment(text, timings, 3.2, 4.0), equals(9)); // 'bạn' at 9
    });

    test('charInSegment khi không có timings hoặc duration <= 0', () {
      const text = 'Xin chào bạn nhỏ';

      expect(charInSegment(text, const [], 1.0, 0.0), equals(0));
      expect(charInSegment(text, const [], 1.0, -1.0), equals(0));
      expect(charInSegment(text, const [], 1.0, double.nan), equals(0));

      final hitStart = charInSegment(text, const [], 0.0, 10.0);
      expect(hitStart, equals(0));

      final hitEnd = charInSegment(text, const [], 10.0, 10.0);
      expect(hitEnd, greaterThanOrEqualTo(0));
    });
  });

  group('wordAt', () {
    const text = 'Bé đi học rất vui vẻ.';

    test('giữa chữ', () {
      // 'Bé' is 0..2
      final range1 = wordAt(text, 1);
      expect(range1, isNotNull);
      expect(range1!.start, equals(0));
      expect(range1.end, equals(2));
      expect(text.substring(range1.start, range1.end), equals('Bé'));

      // 'học' is 6..9
      final range2 = wordAt(text, 7);
      expect(range2, isNotNull);
      expect(range2!.start, equals(6));
      expect(range2.end, equals(9));
      expect(text.substring(range2.start, range2.end), equals('học'));
    });

    test('khoảng trắng', () {
      // Khoảng trắng giữa 'Bé' và 'đi' (offset 2) -> bỏ qua khoảng trắng tới 'đi' (3..5)
      final range = wordAt(text, 2);
      expect(range, isNotNull);
      expect(range!.start, equals(3));
      expect(range.end, equals(5));
      expect(text.substring(range.start, range.end), equals('đi'));

      // Khoảng trắng ở cuối sau từ cuối cùng -> null
      const trailing = 'Xin chào   ';
      expect(wordAt(trailing, 9), isNull);
    });

    test('ngoài phạm vi và chuỗi rỗng', () {
      expect(wordAt(text, -1), isNull);
      expect(wordAt(text, text.length), isNull);
      expect(wordAt(text, text.length + 5), isNull);
      expect(wordAt('', 0), isNull);
      expect(wordAt('    ', 1), isNull);
    });
  });

  group('splitCaptionChunks', () {
    test('tách theo câu ngắn và dấu câu', () {
      const text = 'Bé đi học. Trời mưa rất to! Nhưng bé vẫn cười.';
      final chunks = splitCaptionChunks(text);

      expect(chunks, equals([
        'Bé đi học.',
        'Trời mưa rất to!',
        'Nhưng bé vẫn cười.',
      ]));
    });

    test('đoạn dài (mỗi khúc ≤ 90 ký tự, không mất chữ)', () {
      const text =
          'Ngày xửa ngày xưa, trong một khu rừng xanh tươi nọ, có một chú thỏ trắng rất thích ca hát và nhảy múa. Chú thỏ luôn dậy sớm, tưới nước cho vườn hoa cà rốt của mình; sau đó chú chạy quanh đồi để tìm những người bạn nhỏ cùng chơi đùa thật là vui vẻ!';

      final chunks = splitCaptionChunks(text);

      expect(chunks, isNotEmpty);

      for (final chunk in chunks) {
        expect(chunk.length, lessThanOrEqualTo(90),
            reason: 'Khúc phụ đề vượt quá 90 ký tự: "$chunk" (${chunk.length})');
        expect(chunk.trim(), equals(chunk),
            reason: 'Khúc phụ đề phải được trim');
        expect(chunk, isNotEmpty);
      }

      // Chuẩn hoá khoảng trắng của văn bản gốc
      final normalizedOriginal =
          text.replaceAll(RegExp(r'\s+'), ' ').trim();
      final joinedChunks = chunks.join(' ');

      expect(joinedChunks, equals(normalizedOriginal),
          reason: 'Nối các khúc bằng khoảng trắng không được làm mất chữ nào');
    });

    test('cắt cứng khi không có dấu hoặc khoảng trắng và dài > 90', () {
      final longWord = 'A' * 120;
      final chunks = splitCaptionChunks(longWord);

      expect(chunks.length, equals(2));
      expect(chunks[0].length, equals(90));
      expect(chunks[1].length, equals(30));
    });

    test('chuỗi rỗng hoặc toàn khoảng trắng', () {
      expect(splitCaptionChunks(''), isEmpty);
      expect(splitCaptionChunks('   \n  \t  '), isEmpty);
    });
  });

  group('pickChunkIndex', () {
    final chunks = [
      'Ngày xửa ngày xưa, có một chú thỏ trắng.',
      'Chú thỏ rất thích ăn cà rốt trong vườn.',
      'Mỗi ngày chú đều chạy quanh khu rừng.',
    ];
    final text = chunks.join(' ');

    test('không có positionSec trả 0', () {
      expect(
        pickChunkIndex(chunks, timings: const [], text: text, positionSec: null),
        equals(0),
      );
    });

    test('danh sách chunks rỗng trả 0', () {
      expect(
        pickChunkIndex(
          const [],
          timings: const [],
          text: text,
          positionSec: 5.0,
        ),
        equals(0),
      );
    });

    test('có mốc timings', () {
      final timings = [
        const Timing(word: 'Ngày', start: 0.0),
        const Timing(word: 'thỏ', start: 2.0),
        const Timing(word: 'thích', start: 4.0),
        const Timing(word: 'chạy', start: 7.0),
      ];

      expect(
        pickChunkIndex(
          chunks,
          timings: timings,
          text: text,
          positionSec: 0.5,
          durationSec: 10.0,
        ),
        equals(0),
      );

      expect(
        pickChunkIndex(
          chunks,
          timings: timings,
          text: text,
          positionSec: 4.5,
          durationSec: 10.0,
        ),
        equals(1),
      );

      expect(
        pickChunkIndex(
          chunks,
          timings: timings,
          text: text,
          positionSec: 8.0,
          durationSec: 10.0,
        ),
        equals(2),
      );
    });

    test('không mốc theo tỉ lệ thời gian', () {
      const duration = 12.0;

      // Đầu audio -> chunk 0
      expect(
        pickChunkIndex(
          chunks,
          timings: const [],
          text: text,
          positionSec: 1.0,
          durationSec: duration,
        ),
        equals(0),
      );

      // Giữa audio -> chunk 1
      expect(
        pickChunkIndex(
          chunks,
          timings: const [],
          text: text,
          positionSec: 6.0,
          durationSec: duration,
        ),
        equals(1),
      );

      // Gần cuối audio -> chunk 2
      expect(
        pickChunkIndex(
          chunks,
          timings: const [],
          text: text,
          positionSec: 11.5,
          durationSec: duration,
        ),
        equals(2),
      );
    });
  });
}
