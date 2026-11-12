import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/app.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_repository.dart';

import 'support/fake_auth_repository.dart';

void main() {
  // Kiểm thử ứng dụng khởi động và điều hướng vào màn hình đăng nhập
  testWidgets('Ứng dụng khởi động vào màn đăng nhập', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        ],
        child: const TaleTaleApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Xác nhận màn hình đăng nhập hiển thị
    expect(find.text('Đăng nhập'), findsWidgets);
  });
}
