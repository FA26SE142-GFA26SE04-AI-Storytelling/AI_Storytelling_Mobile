import 'package:ai_storytelling_mobile/core/storage/session_storage.dart';
import 'package:ai_storytelling_mobile/data/auth/mock_auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/app_harness.dart';
import '../helpers/fakes.dart';

void main() {
  late MemorySecureStore store;

  Future<void> pumpApp(WidgetTester tester, {Size size = const Size(390, 844)}) => pumpTaletale(tester, store: store, size: size);

  setUp(() => store = MemorySecureStore());

  testWidgets('chưa đăng nhập → đăng nhập → vào Trang chủ → đăng xuất', (tester) async {
    await pumpApp(tester);
    expect(find.text('Chào mừng trở lại'), findsOneWidget);

    // Bỏ trống thì báo lỗi, không gửi.
    await tester.tap(find.widgetWithText(InkWell, 'Đăng nhập'));
    await tester.pumpAndSettle();
    expect(find.text('Vui lòng nhập mật khẩu'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'thuha');
    await tester.enterText(find.byType(TextFormField).at(1), 'matkhau');
    await tester.tap(find.widgetWithText(InkWell, 'Đăng nhập'));
    await tester.pumpAndSettle();

    expect(find.text('Chào Hà'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(store.values[SessionStorage.accessKey], 'mock-access-token');

    await tester.tap(find.text('Bé'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(InkWell, 'Đăng xuất'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Đăng xuất'));
    await tester.pumpAndSettle();

    expect(find.text('Chào mừng trở lại'), findsOneWidget);
    expect(store.values, isEmpty);
  });

  testWidgets('phiên đã lưu thì mở thẳng vào app', (tester) async {
    store.values[SessionStorage.accessKey] = 'mock-access-token';
    store.values[SessionStorage.refreshKey] = 'mock-refresh-token';
    await pumpApp(tester);

    expect(find.text('Chào ${mockUser.givenName}'), findsOneWidget);
  });

  testWidgets('nút Tạo truyện ở giữa thanh đáy mở Studio toàn màn hình', (tester) async {
    store.values[SessionStorage.refreshKey] = 'mock-refresh-token';
    await pumpApp(tester);

    await tester.tap(find.text('Tạo truyện'));
    await tester.pumpAndSettle();
    expect(find.text('Bắt đầu một câu chuyện mới'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);

    await tester.tap(find.byTooltip('Đóng'));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('máy tính bảng dùng NavigationRail thay cho thanh đáy', (tester) async {
    store.values[SessionStorage.refreshKey] = 'mock-refresh-token';
    await pumpApp(tester, size: const Size(1024, 768));

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('chuyển sang Đăng ký và Quên mật khẩu', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Tạo tài khoản'));
    await tester.pumpAndSettle();
    expect(find.text('Tạo tài khoản Taletale'), findsOneWidget);
    expect(find.text('Nhập lại mật khẩu'), findsOneWidget);

    // Form đăng ký dài hơn màn hình: cuộn tới link trước khi chạm.
    await tester.ensureVisible(find.text('Quay lại đăng nhập'));
    await tester.tap(find.text('Quay lại đăng nhập'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Quên mật khẩu?'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'a@b.vn');
    await tester.tap(find.widgetWithText(InkWell, 'Gửi hướng dẫn'));
    await tester.pumpAndSettle();
    expect(find.text('Đã gửi hướng dẫn đặt lại mật khẩu qua email.'), findsOneWidget);
  });
}
