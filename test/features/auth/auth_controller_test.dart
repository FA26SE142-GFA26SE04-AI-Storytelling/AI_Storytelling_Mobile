// Test cho AuthController – kiểm tra các trạng thái xác thực
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_repository.dart';
import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import '../../support/fake_auth_repository.dart';

void main() {
  group('AuthController', () {
    late FakeAuthRepository fake;
    late ProviderContainer container;

    setUp(() {
      fake = FakeAuthRepository();
      container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(fake),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    // a) Không có session -> AuthSignedOut
    test('a) hasSession false -> restore -> AuthSignedOut', () async {
      fake.hasSession = false;
      container.read(authControllerProvider); // kích hoạt build()
      await Future<void>.delayed(Duration.zero);
      fake.logoutCalls = 0;
      await container.read(authControllerProvider.notifier).restore();
      expect(container.read(authControllerProvider), isA<AuthSignedOut>());
    });

    // b) Có session, fetchMe trả User -> AuthSignedIn
    test('b) hasSession true, meUser = fakeUser() -> restore -> AuthSignedIn',
        () async {
      fake.hasSession = true;
      fake.meUser = fakeUser();
      container.read(authControllerProvider);
      await Future<void>.delayed(Duration.zero);
      fake.logoutCalls = 0;
      await container.read(authControllerProvider.notifier).restore();
      expect(container.read(authControllerProvider), isA<AuthSignedIn>());
    });

    // c) Có session, role Moderator -> AuthBlocked
    test(
        'c) hasSession true, meUser Moderator -> restore -> AuthBlocked',
        () async {
      fake.hasSession = true;
      fake.meUser = fakeUser(role: 'Moderator');
      container.read(authControllerProvider);
      await Future<void>.delayed(Duration.zero);
      fake.logoutCalls = 0;
      await container.read(authControllerProvider.notifier).restore();
      expect(container.read(authControllerProvider), isA<AuthBlocked>());
    });

    // d) fetchMe ném 401 -> AuthSignedOut và logout được gọi 1 lần
    test(
        'd) hasSession true, meError 401 -> restore -> AuthSignedOut, logoutCalls==1',
        () async {
      fake.hasSession = true;
      fake.meError = ApiException(statusCode: 401, message: 'x');
      container.read(authControllerProvider);
      await Future<void>.delayed(Duration.zero);
      fake.logoutCalls = 0;
      await container.read(authControllerProvider.notifier).restore();
      expect(container.read(authControllerProvider), isA<AuthSignedOut>());
      expect(fake.logoutCalls, equals(1));
    });

    // e) fetchMe ném 500 -> AuthSignedOut nhưng logout KHÔNG được gọi
    test(
        'e) hasSession true, meError 500 -> restore -> AuthSignedOut, logoutCalls==0',
        () async {
      fake.hasSession = true;
      fake.meError = ApiException(statusCode: 500, message: 'x');
      container.read(authControllerProvider);
      await Future<void>.delayed(Duration.zero);
      fake.logoutCalls = 0;
      await container.read(authControllerProvider.notifier).restore();
      expect(container.read(authControllerProvider), isA<AuthSignedOut>());
      expect(fake.logoutCalls, equals(0));
    });

    // f) login thành công: User -> AuthSignedIn; ContentCreator -> AuthBlocked
    test('f) login User -> AuthSignedIn; ContentCreator -> AuthBlocked',
        () async {
      // User thường
      fake.loginUser = fakeUser();
      container.read(authControllerProvider);
      await Future<void>.delayed(Duration.zero);
      fake.logoutCalls = 0;
      await container
          .read(authControllerProvider.notifier)
          .login(identifier: 'phuhuynh', password: '123456');
      expect(container.read(authControllerProvider), isA<AuthSignedIn>());

      // ContentCreator bị blocked
      fake.loginUser = fakeUser(role: 'ContentCreator');
      await container
          .read(authControllerProvider.notifier)
          .login(identifier: 'phuhuynh', password: '123456');
      expect(container.read(authControllerProvider), isA<AuthBlocked>());
    });

    // g) login thất bại -> ném ApiException, state không phải AuthSignedIn
    test('g) login với loginError -> throwsA ApiException, state != AuthSignedIn',
        () async {
      fake.loginError = ApiException(statusCode: 401, message: 'Sai mật khẩu');
      container.read(authControllerProvider);
      await Future<void>.delayed(Duration.zero);
      fake.logoutCalls = 0;
      expect(
        () => container
            .read(authControllerProvider.notifier)
            .login(identifier: 'phuhuynh', password: 'wrong'),
        throwsA(isA<ApiException>()),
      );
      // Chờ microtask hoàn thành
      await Future<void>.value();
      expect(
        container.read(authControllerProvider),
        isNot(isA<AuthSignedIn>()),
      );
    });

    // h) sessionExpired -> AuthSignedOut(sessionExpired==true); acknowledgeSessionExpired -> false
    test('h) sessionExpired và acknowledgeSessionExpired', () async {
      fake.hasSession = true;
      fake.meUser = fakeUser();
      container.read(authControllerProvider);
      await Future<void>.delayed(Duration.zero);
      fake.logoutCalls = 0;
      await container.read(authControllerProvider.notifier).restore();

      container.read(authControllerProvider.notifier).sessionExpired();
      final stateAfterExpiry = container.read(authControllerProvider);
      expect(stateAfterExpiry, isA<AuthSignedOut>());
      expect((stateAfterExpiry as AuthSignedOut).sessionExpired, isTrue);

      container.read(authControllerProvider.notifier).acknowledgeSessionExpired();
      final stateAfterAck = container.read(authControllerProvider);
      expect(stateAfterAck, isA<AuthSignedOut>());
      expect((stateAfterAck as AuthSignedOut).sessionExpired, isFalse);
    });

    // i) login thành công rồi logout -> AuthSignedOut, logoutCalls==1
    test('i) login rồi logout -> AuthSignedOut, logoutCalls==1', () async {
      fake.loginUser = fakeUser();
      container.read(authControllerProvider);
      await Future<void>.delayed(Duration.zero);
      fake.logoutCalls = 0;
      await container
          .read(authControllerProvider.notifier)
          .login(identifier: 'phuhuynh', password: '123456');
      expect(container.read(authControllerProvider), isA<AuthSignedIn>());

      await container.read(authControllerProvider.notifier).logout();
      expect(container.read(authControllerProvider), isA<AuthSignedOut>());
      expect(fake.logoutCalls, equals(1));
    });
  });
}
