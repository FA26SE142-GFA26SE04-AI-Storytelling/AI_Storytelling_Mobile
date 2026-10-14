import 'package:ai_storytelling_mobile/core/env.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normalizeBaseUrl', () {
    test('rỗng thì dùng địa chỉ mặc định', () {
      expect(normalizeBaseUrl('  '), 'https://api.taletale.site/api/v1');
    });

    test('thêm /api/v1 và bỏ dấu / ở cuối', () {
      expect(normalizeBaseUrl('http://10.0.2.2:5000/'), 'http://10.0.2.2:5000/api/v1');
      expect(normalizeBaseUrl('https://x.dev/api/v1/'), 'https://x.dev/api/v1');
    });

    test('bỏ đuôi swagger và index.html', () {
      expect(normalizeBaseUrl('https://x.dev/swagger/index.html'), 'https://x.dev/api/v1');
      expect(normalizeBaseUrl('https://x.dev/swagger'), 'https://x.dev/api/v1');
    });
  });
}
