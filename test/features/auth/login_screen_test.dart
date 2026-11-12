import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_button.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_repository.dart';
import 'package:ai_storytelling_mobile/features/auth/presentation/login_screen.dart';

import '../../support/fake_auth_repository.dart';

void main() {
  // Kiểm thử giao diện màn hình đăng nhập
  group('LoginScreen', () {
    testWidgets('bấm đăng nhập khi để trống hiện lỗi kiểm tra', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const LoginScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Bấm nút chính có chữ 'Đăng nhập'
      await tester.tap(find.widgetWithText(TtButton, 'Đăng nhập'));
      await tester.pumpAndSettle();

      // Kiểm tra thông báo lỗi kiểm tra hợp lệ
      expect(find.text('Vui lòng nhập email hoặc tên đăng nhập'), findsOneWidget);
      expect(find.text('Vui lòng nhập mật khẩu'), findsOneWidget);

      // Gõ vào thì lỗi của ô đó tự mất, không cần bấm lại
      await tester.enterText(find.byType(TextFormField).at(0), 'ph@example.com');
      await tester.pumpAndSettle();
      expect(find.text('Vui lòng nhập email hoặc tên đăng nhập'), findsNothing);
      expect(find.text('Vui lòng nhập mật khẩu'), findsOneWidget);
    });

    testWidgets('đăng nhập sai hiện thông báo lỗi', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final fakeRepo = FakeAuthRepository()
        ..loginError = const ApiException(
          statusCode: 401,
          message: 'Sai tài khoản hoặc mật khẩu.',
        );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(fakeRepo),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const LoginScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Nhập tài khoản và mật khẩu vào hai trường nhập liệu
      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.at(0), 'ph@example.com');
      await tester.enterText(textFields.at(1), '12345678');

      // Bấm nút chính để thực hiện đăng nhập
      await tester.tap(find.widgetWithText(TtButton, 'Đăng nhập'));
      await tester.pumpAndSettle();

      // Kiểm tra hiển thị thông báo lỗi
      expect(find.text('Sai tài khoản hoặc mật khẩu.'), findsOneWidget);
    });
  });
}
