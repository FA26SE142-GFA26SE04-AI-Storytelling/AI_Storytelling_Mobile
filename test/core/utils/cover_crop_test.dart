import 'package:flutter_test/flutter_test.dart';
import 'package:ai_storytelling_mobile/core/utils/cover_crop.dart';

void main() {
  group('parseCoverUrl', () {
    test('null -> null; \'\' và \'   \' -> null', () {
      expect(parseCoverUrl(null), isNull);
      expect(parseCoverUrl(''), isNull);
      expect(parseCoverUrl('   '), isNull);
    });

    test('\'https://x.com/a.jpg\' -> src \'https://x.com/a.jpg\', crop null', () {
      final res = parseCoverUrl('https://x.com/a.jpg');
      expect(res, isNotNull);
      expect(res!.src, 'https://x.com/a.jpg');
      expect(res.crop, isNull);
    });

    test('\'https://x.com/a.jpg#crop=0.1,0.05,0.6,0.8\' -> src \'https://x.com/a.jpg\', crop x 0.1, y 0.05, w 0.6, h 0.8', () {
      final res = parseCoverUrl('https://x.com/a.jpg#crop=0.1,0.05,0.6,0.8');
      expect(res, isNotNull);
      expect(res!.src, 'https://x.com/a.jpg');
      expect(res.crop, isNotNull);
      expect(res.crop!.x, 0.1);
      expect(res.crop!.y, 0.05);
      expect(res.crop!.w, 0.6);
      expect(res.crop!.h, 0.8);
    });

    test('\'https://x.com/a.jpg#crop=-0.5,0,2,1\' -> x 0 (kẹp), w 1 (kẹp)', () {
      final res = parseCoverUrl('https://x.com/a.jpg#crop=-0.5,0,2,1');
      expect(res, isNotNull);
      expect(res!.src, 'https://x.com/a.jpg');
      expect(res.crop, isNotNull);
      expect(res.crop!.x, 0.0);
      expect(res.crop!.y, 0.0);
      expect(res.crop!.w, 1.0);
      expect(res.crop!.h, 1.0);
    });

    test('\'https://x.com/a.jpg#crop=0.1,0.1,0,0.5\' -> crop null (w = 0)', () {
      final res = parseCoverUrl('https://x.com/a.jpg#crop=0.1,0.1,0,0.5');
      expect(res, isNotNull);
      expect(res!.src, 'https://x.com/a.jpg');
      expect(res.crop, isNull);
    });

    test('chỉ có \'#crop=0.1,0.1,0.5,0.5\' (không có src) -> null', () {
      expect(parseCoverUrl('#crop=0.1,0.1,0.5,0.5'), isNull);
    });
  });
}
