import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/account/data/account_repository.dart';
import 'package:ai_storytelling_mobile/features/account/presentation/account_email_dialog.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_models.dart';

class _FakeRepo implements AccountRepository {
  @override
  Future<void> requestEmailChange({
    required String currentPassword,
    required String newEmail,
  }) async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

const _user = UserProfile(
  id: 1,
  username: 'an',
  email: 'an@example.com',
  fullName: 'An',
  role: 'User',
  status: 'Active',
);

Future<void> _pump(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [accountRepositoryProvider.overrideWithValue(_FakeRepo())],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(body: ChangeEmailDialog(user: _user)),
      ),
    ),
  );
}

void main() {
  testWidgets('Bấm Tiếp tục khi trống thì hiện lỗi dưới ô', (tester) async {
    await _pump(tester);
    await tester.tap(find.text('Tiếp tục'));
    await tester.pump();

    expect(find.text('Vui lòng nhập mật khẩu'), findsOneWidget);
    expect(find.text('Vui lòng nhập email mới'), findsOneWidget);
  });

  testWidgets('Ô OTP chỉ giữ số, tối đa 6 ký tự', (tester) async {
    await _pump(tester);
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'matkhau123');
    await tester.enterText(fields.at(1), 'moi@example.com');
    await tester.tap(find.text('Tiếp tục'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'ab12c3456789');
    await tester.pump();

    final otp = tester.widget<TextField>(find.byType(TextField));
    expect(otp.controller!.text, '123456');
  });
}
