import 'package:ai_storytelling_mobile/features/library/library_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/app_harness.dart';
import '../helpers/fakes.dart';

void main() {
  late MemorySecureStore store;
  setUp(() => store = MemorySecureStore());

  Finder badge(String n) => find.descendant(of: find.byType(Badge), matching: find.text(n));

  testWidgets('Trang chủ hiện truyện của bé đang chọn, việc cần làm và badge chờ duyệt', (tester) async {
    await pumpTaletale(tester, store: store, signedIn: true);

    expect(find.text('Chào Hà'), findsOneWidget);
    expect(find.textContaining('Bé Na (6–8 tuổi) có 3 truyện, 2 truyện đã sẵn sàng'), findsOneWidget);
    expect(find.text('Cho Bé Na đọc'), findsOneWidget);
    expect(find.text('1 truyện chờ duyệt'), findsOneWidget);
    expect(find.text('Rùa Bông và chiếc đèn lồng trăng'), findsWidgets);
    expect(badge('1'), findsOneWidget);
  });

  testWidgets('đổi bé trên thanh tiêu đề thì đổi truyện, và nhớ lựa chọn', (tester) async {
    await pumpTaletale(tester, store: store, signedIn: true);

    await tester.tap(find.bySemanticsLabel(RegExp('Đang xem Bé Na')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bin'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Bin (9–12 tuổi) có 2 truyện'), findsOneWidget);
    expect(find.text('Robot nhỏ dọn biển'), findsWidgets);
  });

  testWidgets('mở lại app vẫn là bé đã chọn lần trước', (tester) async {
    await pumpTaletale(tester, store: store, signedIn: true, prefs: {'taletale-child-id': 2});

    expect(find.textContaining('Bin (9–12 tuổi)'), findsOneWidget);
  });

  testWidgets('Thư viện: tìm kiếm, lọc và mở chi tiết truyện', (tester) async {
    await pumpTaletale(tester, store: store, signedIn: true);
    await tester.tap(find.text('Thư viện'));
    await tester.pumpAndSettle();

    expect(find.byType(StoryCard), findsNWidgets(3));

    await tester.enterText(find.byType(TextField), 'gấu');
    await tester.pumpAndSettle();
    expect(find.byType(StoryCard), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'không có truyện này');
    await tester.pumpAndSettle();
    expect(find.text('Không tìm thấy truyện phù hợp'), findsOneWidget);

    await tester.tap(find.byTooltip('Xoá tìm kiếm'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(StoryCard, 'Chú gấu và tổ ong ngọt'));
    await tester.pumpAndSettle();

    expect(find.text('biết chia sẻ'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Trang 1'), 300);
    expect(find.text('Trang 1'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget, reason: 'chi tiết mở trong tab, vẫn giữ thanh đáy');

    // Nút back hệ thống (pageBack() của flutter_test chưa nhận BackButton của material_ui).
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(StoryCard), findsNWidgets(3));
  });

  testWidgets('Duyệt: hàng chờ dẫn tới chi tiết truyện đang chờ duyệt', (tester) async {
    await pumpTaletale(tester, store: store, signedIn: true);
    await tester.tap(find.text('Duyệt'));
    await tester.pumpAndSettle();

    expect(find.textContaining('AI đã viết xong 1 truyện'), findsOneWidget);
    await tester.tap(find.text('Rùa Bông và chiếc đèn lồng trăng'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Truyện đang chờ bạn duyệt'), 300);
    expect(find.text('Truyện đang chờ bạn duyệt'), findsOneWidget);
  });
}
