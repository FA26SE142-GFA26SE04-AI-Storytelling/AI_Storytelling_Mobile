// Test cho hàm authRedirect – kiểm tra logic điều hướng theo trạng thái xác thực
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/core/router/app_router.dart';
import '../../support/fake_auth_repository.dart';

void main() {
  group('authRedirect', () {
    // --- AuthChecking ---
    group('AuthChecking', () {
      test('/home -> /splash (đang kiểm tra session, chuyển về splash)', () {
        expect(
          authRedirect(const AuthChecking(), '/home'),
          equals('/splash'),
        );
      });

      test('/splash -> null (đã ở splash, không cần redirect)', () {
        expect(
          authRedirect(const AuthChecking(), '/splash'),
          isNull,
        );
      });
    });

    // --- AuthSignedOut ---
    group('AuthSignedOut', () {
      test('/home -> /login (chưa đăng nhập, không được vào trang chính)', () {
        expect(
          authRedirect(const AuthSignedOut(), '/home'),
          equals('/login'),
        );
      });

      test('/register -> null (trang công khai, không cần redirect)', () {
        expect(
          authRedirect(const AuthSignedOut(), '/register'),
          isNull,
        );
      });

      test('/reset-password -> null (trang công khai, không cần redirect)', () {
        expect(
          authRedirect(const AuthSignedOut(), '/reset-password'),
          isNull,
        );
      });
    });

    // --- AuthBlocked ---
    group('AuthBlocked', () {
      test('/home -> /blocked (tài khoản bị chặn)', () {
        expect(
          authRedirect(AuthBlocked(fakeUser(role: 'Moderator')), '/home'),
          equals('/blocked'),
        );
      });

      test('/blocked -> null (đã ở trang blocked, không cần redirect)', () {
        expect(
          authRedirect(AuthBlocked(fakeUser(role: 'Moderator')), '/blocked'),
          isNull,
        );
      });
    });

    // --- AuthSignedIn ---
    group('AuthSignedIn', () {
      test('/login -> /home (đã đăng nhập, không cần ở trang login)', () {
        expect(
          authRedirect(AuthSignedIn(fakeUser()), '/login'),
          equals('/home'),
        );
      });

      test('/splash -> /home (đã đăng nhập, rời splash về home)', () {
        expect(
          authRedirect(AuthSignedIn(fakeUser()), '/splash'),
          equals('/home'),
        );
      });

      test('/home -> null (đã đăng nhập, ở home bình thường)', () {
        expect(
          authRedirect(AuthSignedIn(fakeUser()), '/home'),
          isNull,
        );
      });

      test('/library -> null (đã đăng nhập, truy cập trang nội dung bình thường)', () {
        expect(
          authRedirect(AuthSignedIn(fakeUser()), '/library'),
          isNull,
        );
      });
    });
  });
}
