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
  testWidgets('mất mạng hiện thông báo lỗi trên màn đăng nhập', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final fakeRepo = FakeAuthRepository()
      ..loginError = const ApiException(
        statusCode: 0,
        message: 'Không có kết nối mạng. Kiểm tra mạng rồi thử lại.',
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

    await tester.enterText(find.byType(TextFormField).at(0), 'ph@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), '12345678');

    await tester.tap(find.byType(TtButton).first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(
      find.text('Không có kết nối mạng. Kiểm tra mạng rồi thử lại.'),
      findsOneWidget,
    );
  });
}
