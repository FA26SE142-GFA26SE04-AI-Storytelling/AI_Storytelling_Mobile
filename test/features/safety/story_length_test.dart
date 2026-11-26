import 'package:flutter_test/flutter_test.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/child_age_presets.dart';

void main() {
  group('Độ dài truyện và giới hạn an toàn', () {
    test('storyLengthUpperBound tính đúng trần 110%', () {
      expect(storyLengthUpperBound(900), 990);
    });

    test('storyLengthBounds trả về khoảng min max chuẩn', () {
      final bounds = storyLengthBounds(900);
      expect(bounds.min, 810);
      expect(bounds.max, 990);
    });

    test('effectiveStoryLength trả về độ dài theo mức đọc mặc định', () {
      final result = effectiveStoryLength('Age_6_8', 1, null, null);
      expect(result.value, 900);
      expect(result.custom, false);
    });

    test('effectiveStoryLength ưu tiên storyLengthTarget tùy chỉnh', () {
      final result = effectiveStoryLength('Age_6_8', 1, 1200, null);
      expect(result.value, 1200);
      expect(result.custom, true);
    });

    test('storyLengthAdvice cảnh báo khi truyện dài hơn 110%', () {
      final advice = storyLengthAdvice('Age_6_8', 1, 1000);
      expect(advice, isNotNull);
      expect(advice!.veryLong, false);
    });

    test('storyLengthAdvice cảnh báo rất dài khi vượt quá 150%', () {
      final advice = storyLengthAdvice('Age_6_8', 1, 1400);
      expect(advice, isNotNull);
      expect(advice!.veryLong, true);
    });

    test('storyLengthAdvice trả null khi độ dài phù hợp', () {
      final advice = storyLengthAdvice('Age_6_8', 1, 900);
      expect(advice, isNull);
    });
  });
}
