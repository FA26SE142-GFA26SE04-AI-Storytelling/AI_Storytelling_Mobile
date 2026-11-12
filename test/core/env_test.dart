import 'package:flutter_test/flutter_test.dart';
import 'package:ai_storytelling_mobile/core/config/env.dart';

void main() {
  test('Env.normalizeApiBaseUrl normalizes URLs correctly', () {
    expect(
      Env.normalizeApiBaseUrl('https://api.taletale.site'),
      equals('https://api.taletale.site/api/v1'),
    );
    expect(
      Env.normalizeApiBaseUrl('https://api.taletale.site/api/v1/'),
      equals('https://api.taletale.site/api/v1'),
    );
    expect(
      Env.normalizeApiBaseUrl('https://x.test/swagger/index.html'),
      equals('https://x.test/api/v1'),
    );
    expect(
      Env.normalizeApiBaseUrl('   '),
      equals('https://api.taletale.site/api/v1'),
    );
    expect(
      Env.normalizeApiBaseUrl('   https://x.test/api/v1   '),
      equals('https://x.test/api/v1'),
    );
  });
}
