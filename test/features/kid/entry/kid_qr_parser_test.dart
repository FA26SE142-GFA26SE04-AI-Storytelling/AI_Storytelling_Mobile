import 'package:flutter_test/flutter_test.dart';
import 'package:ai_storytelling_mobile/features/kid/entry/kid_qr_parser.dart';

void main() {
  group('parseKidSecret', () {
    test("URL có kid: 'https://app.example.com/kid?kid=abc123' -> 'abc123'", () {
      expect(parseKidSecret('https://app.example.com/kid?kid=abc123'), equals('abc123'));
    });

    test("kid được decode: 'https://app.example.com/kid?kid=a%2Bb' -> 'a+b'", () {
      expect(parseKidSecret('https://app.example.com/kid?kid=a%2Bb'), equals('a+b'));
    });

    test("kid có khoảng trắng bao quanh: '  https://x.com/kid?kid=abc  ' -> 'abc'", () {
      expect(parseKidSecret('  https://x.com/kid?kid=abc  '), equals('abc'));
    });

    test("chuỗi secret trần: 'abc123XYZ' -> 'abc123XYZ'", () {
      expect(parseKidSecret('abc123XYZ'), equals('abc123XYZ'));
    });

    test("chuỗi trần có khoảng trắng trong: 'hello world' -> null", () {
      expect(parseKidSecret('hello world'), isNull);
    });

    test("URL thiếu kid: 'https://app.example.com/login' -> null", () {
      expect(parseKidSecret('https://app.example.com/login'), isNull);
    });

    test("URL có tham số khác nhưng kid rỗng: 'https://app.example.com/kid?kid=' -> null", () {
      expect(parseKidSecret('https://app.example.com/kid?kid='), isNull);
    });

    test("rỗng: '' -> null; chỉ khoảng trắng: '   ' -> null", () {
      expect(parseKidSecret(''), isNull);
      expect(parseKidSecret('   '), isNull);
    });
  });
}
