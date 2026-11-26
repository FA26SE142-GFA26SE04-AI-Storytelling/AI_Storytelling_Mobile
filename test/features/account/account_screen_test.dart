import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/account/account_screen.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_models.dart';
import 'package:ai_storytelling_mobile/features/notifications/data/notification_repository.dart';

import '../../support/ipad_sizes.dart';

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

Future<void> _pump(WidgetTester tester, Size size, {int unread = 0}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authControllerProvider.overrideWith(_FakeAuthController.new),
        unreadNotificationCountProvider.overrideWith((_) async => unread),
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
        'Thông báo',
        'Xoá tài khoản',
      ]) {
        expect(find.text(label), findsOneWidget, reason: label);
      }

      await tester.scrollUntilVisible(find.text('Đăng xuất'), 100);
      expect(find.text('Đăng xuất'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Dòng Thông báo hiện số chưa đọc', (tester) async {
    await _pump(tester, const Size(390, 844), unread: 5);
    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('Dòng Thông báo: nhiều hơn 99 hiện 99+', (tester) async {
    await _pump(tester, const Size(390, 844), unread: 120);
    expect(find.text('99+'), findsOneWidget);
  });

  testWidgets('Dòng Thông báo: 0 chưa đọc thì không có số', (tester) async {
    await _pump(tester, const Size(390, 844));
    expect(find.text('0'), findsNothing);
  });

  testWidgets('Bấm Đăng xuất hiện popup xác nhận', (tester) async {
    await _pump(tester, const Size(390, 844));
    await tester.scrollUntilVisible(find.text('Đăng xuất'), 100);
    await tester.tap(find.text('Đăng xuất'));
    await tester.pumpAndSettle();

    expect(find.text('Đăng xuất?'), findsOneWidget);
  });

  testWidgets('Hiện đủ các mục, không tràn lỗi trên các khổ iPad',
      (tester) async {
    for (final size in kIpadSizes.values) {
      await _pump(tester, size);

      expect(tester.takeException(), isNull);
      expect(find.textContaining('Nguyễn Văn An'), findsOneWidget);
      expect(find.text('Bảo mật'), findsOneWidget);
    }
  });

  testWidgets('Bố cục 2 cột ở khổ 1366x1024', (tester) async {
    await _pump(tester, const Size(1366, 1024));

    final namePos = tester.getTopLeft(find.textContaining('Nguyễn Văn An'));
    final securityPos = tester.getTopLeft(find.text('Bảo mật'));

    expect((securityPos.dy - namePos.dy).abs(), lessThan(100));
    expect(securityPos.dx - namePos.dx, greaterThan(300));
  });
}
