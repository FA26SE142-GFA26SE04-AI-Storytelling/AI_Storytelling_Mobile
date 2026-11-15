import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/account/account_screen.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_models.dart';

class _FakeAuthController extends AuthController {
  @override
  AuthState build() => const AuthSignedIn(
        UserProfile(
          id: 1,
          username: 'nguyenan',
          email: 'mot-dia-chi-email-rat-dai-de-thu-tran@example.com',
          fullName: 'Nguyễn Văn An Có Một Cái Tên Rất Dài Để Thử Tràn Chữ',
          role: 'User',
          status: 'Active',
        ),
      );
}

Future<void> _pump(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authControllerProvider.overrideWith(_FakeAuthController.new),
      ],
      child: MaterialApp(theme: AppTheme.light(), home: const AccountScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  for (final size in const [Size(320, 640), Size(1024, 768)]) {
    testWidgets('Hiện đủ các mục, không tràn ở ${size.width}x${size.height}',
        (tester) async {
      await _pump(tester, size);

      expect(tester.takeException(), isNull);
      expect(find.textContaining('Nguyễn Văn An'), findsOneWidget);
      expect(find.textContaining('@example.com'), findsOneWidget);
      expect(find.byTooltip('Sửa họ tên'), findsOneWidget);
      for (final label in const [
        'Bảo mật',
        'Đổi mật khẩu',
        'Đổi email',
        'Phiên đăng nhập',
        'Lịch sử hoạt động',
        'Khác',
        'Xoá tài khoản',
      ]) {
        expect(find.text(label), findsOneWidget, reason: label);
      }

      await tester.scrollUntilVisible(find.text('Đăng xuất'), 100);
      expect(find.text('Đăng xuất'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Bấm Đăng xuất hiện popup xác nhận', (tester) async {
    await _pump(tester, const Size(390, 844));
    await tester.scrollUntilVisible(find.text('Đăng xuất'), 100);
    await tester.tap(find.text('Đăng xuất'));
    await tester.pumpAndSettle();

    expect(find.text('Đăng xuất?'), findsOneWidget);
  });
}
