import 'package:ai_storytelling_mobile/app/router.dart';
import 'package:ai_storytelling_mobile/data/auth/auth_models.dart';
import 'package:ai_storytelling_mobile/data/auth/mock_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const AsyncValue<UserProfile?> loading = AsyncLoading();
  const AsyncValue<UserProfile?> signedOut = AsyncData(null);
  const AsyncValue<UserProfile?> signedIn = AsyncData(mockUser);

  String? go(AsyncValue<UserProfile?> auth, String location) => authRedirect(auth, Uri.parse(location));

  group('authRedirect', () {
    test('đang khôi phục phiên thì chờ ở /splash và nhớ đích đến', () {
      expect(go(loading, '/splash'), isNull);
      expect(Uri.parse(go(loading, '/library')!).queryParameters['from'], '/library');
    });

    test('chưa đăng nhập thì về /login', () {
      expect(go(signedOut, '/home'), '/login');
      expect(go(signedOut, '/splash?from=%2Fhome'), '/login');
      expect(go(signedOut, '/login'), isNull);
    });

    test('đã đăng nhập thì rời /login và /splash, giữ đích đến đã nhớ', () {
      expect(go(signedIn, '/login'), '/home');
      expect(go(signedIn, '/splash?from=%2Flibrary'), '/library');
      expect(go(signedIn, '/review'), isNull);
    });

    test('link đặt lại mật khẩu sống sót qua màn chờ', () {
      final splash = go(loading, '/?auth=reset&token=abc&email=a%40b.vn')!;
      final login = Uri.parse(go(signedOut, splash)!);
      expect(login.path, '/login');
      expect(login.queryParameters, {'mode': 'reset', 'email': 'a@b.vn', 'token': 'abc'});
      expect(go(signedOut, login.toString()), isNull);
    });
  });

  group('emailLinkToLogin', () {
    test('ánh xạ tham số auth sang chế độ của màn đăng nhập', () {
      expect(emailLinkToLogin(Uri.parse('/?auth=signup')).queryParameters['mode'], 'register');
      expect(emailLinkToLogin(Uri.parse('/?auth=forgot')).queryParameters['mode'], 'forgot');
      expect(emailLinkToLogin(Uri.parse('/?resetToken=t')).queryParameters, {'mode': 'reset', 'token': 't'});
    });

    test('không đổi đường dẫn khác', () {
      expect(emailLinkToLogin(Uri.parse('/home?auth=signup')).toString(), '/home?auth=signup');
      expect(emailLinkToLogin(Uri.parse('/')).toString(), '/');
    });
  });
}
