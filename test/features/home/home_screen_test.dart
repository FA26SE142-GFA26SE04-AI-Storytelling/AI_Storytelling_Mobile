import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/app.dart';
import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_models.dart';
import 'package:ai_storytelling_mobile/features/events/data/event_repository.dart';
import 'package:ai_storytelling_mobile/features/home/presentation/home_screen.dart';
import 'package:ai_storytelling_mobile/features/library/data/library_repository.dart';
import 'package:ai_storytelling_mobile/features/library/presentation/library_story_card.dart';
import 'package:ai_storytelling_mobile/features/library/presentation/library_banner.dart';
import 'package:ai_storytelling_mobile/features/library/presentation/search_screen.dart';
import 'package:ai_storytelling_mobile/features/notifications/data/notification_repository.dart';
import 'package:ai_storytelling_mobile/models/library_story_dto.dart';

import '../../support/ipad_sizes.dart';

LibraryStoryDto _story(
  int id, {
  int? views,
  String genre = 'Tình bạn',
  bool cover = false,
  DateTime? at,
}) => LibraryStoryDto(
  id: id,
  title: 'Truyện số $id',
  genre: genre,
  source: 'AiGenerated',
  status: 'Ready',
  isPublished: true,
  createdAt: at ?? DateTime(2026, 1, id),
  coverImageUrl: cover ? 'http://test/$id.png' : null,
  viewCount: views,
  favoriteCount: views == null ? null : 0,
  content: 'Đoạn một của $id.\n\nĐoạn hai của $id.',
);

class _FakeLibrary implements LibraryRepository {
  bool fail = false;
  bool covers = true;
  int storyCalls = 0;

  @override
  Future<LibraryStoryPageDto> stories({
    required int pageIndex,
    int pageSize = 100,
  }) async {
    storyCalls++;
    if (fail) throw const ApiException(message: 'Không tải được thư viện.');
    return LibraryStoryPageDto(
      items: [
        for (var i = 1; i <= 12; i++)
          _story(
            i,
            genre: i.isEven ? 'Tình bạn' : 'Phiêu lưu',
            // Truyện 3, 6, 9, 12 có ảnh bìa → banner 4 trang.
            cover: covers && i % 3 == 0,
          ),
      ],
      totalCount: 12,
    );
  }

  @override
  Future<LibraryStoryPageDto> community({
    int pageIndex = 1,
    int pageSize = 100,
    String? orderBy,
  }) async => LibraryStoryPageDto(
    items: orderBy == 'favorites'
        ? const []
        : [
            _story(
              20,
              views: 5,
              at: DateTime.now().subtract(const Duration(days: 1)),
            ),
          ],
    totalCount: 1,
  );

  @override
  Future<LibraryStoryDto> story(int id) async => _story(id);

  @override
  Future<StoryMediaPackageDto?> media(int id, {required bool creator}) async =>
      throw const ApiException(message: 'Lỗi media');
}

class _SignedIn extends AuthController {
  @override
  AuthState build() => const AuthSignedIn(
    UserProfile(
      id: 1,
      username: 'me',
      email: 'me@example.com',
      fullName: 'Nguyễn Văn A',
      role: 'User',
      status: 'Active',
    ),
  );
}

Future<_FakeLibrary> _pump(
  WidgetTester tester, {
  Size size = const Size(1024, 3000),
  int unread = 0,
  bool fail = false,
  bool covers = true,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final library = _FakeLibrary()
    ..fail = fail
    ..covers = covers;
  final container = ProviderContainer(
    retry: (_, _) => null,
    overrides: [
      libraryRepositoryProvider.overrideWithValue(library),
      authControllerProvider.overrideWith(_SignedIn.new),
      unreadNotificationCountProvider.overrideWith((_) async => unread),
      eventListProvider.overrideWith((_) async => const []),
    ],
  );
  addTearDown(container.dispose);
  // Giống app: các tab nằm trong StatefulShellRoute nên chuyển tab giữ trạng thái.
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      // Như app: Tìm kiếm mở chồng lên ngoài shell.
      GoRoute(path: '/search', builder: (_, _) => const SearchScreen()),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => shell,
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/account',
                builder: (_, _) => const Scaffold(body: Text('ACCOUNT_TAB')),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
        theme: AppTheme.light(),
        scrollBehavior: appScrollBehavior,
        routerConfig: router,
      ),
    ),
  );
  await tester.pump();
  await tester.pumpAndSettle();
  return library;
}

void main() {
  testWidgets('thanh trên, chip chủ đề, các kệ; kệ rỗng thì ẩn; nhãn MỚI', (
    tester,
  ) async {
    await _pump(tester);

    expect(find.text('TaleTale'), findsOneWidget);
    expect(find.byTooltip('Tìm truyện'), findsOneWidget);
    expect(find.bySemanticsLabel('Tài khoản'), findsOneWidget);
    expect(find.text('N'), findsOneWidget); // chữ cái đầu khi không có ảnh
    expect(find.widgetWithText(ActionChip, 'Tình bạn'), findsOneWidget);
    expect(find.widgetWithText(ActionChip, 'Phiêu lưu'), findsOneWidget);
    expect(find.text('Đọc nhiều nhất'), findsOneWidget);
    expect(find.text('Được yêu thích'), findsNothing);
    expect(find.text('Đang chuẩn bị'), findsNothing);
    expect(find.text('Theo chủ đề'), findsNothing);
    expect(find.text('Mới nhất'), findsOneWidget);
    expect(find.text('Tất cả truyện'), findsOneWidget);
    // Chỉ truyện 20 tạo trong 7 ngày; hiện ở cả 3 kệ (Đọc nhiều nhất, Mới nhất, Tất cả).
    expect(find.text('MỚI'), findsNWidgets(3));
  });

  testWidgets('avatar: bấm chuyển sang tab Tài khoản', (tester) async {
    await _pump(tester);
    await tester.tap(find.bySemanticsLabel('Tài khoản'));
    await tester.pumpAndSettle();
    expect(find.text('ACCOUNT_TAB'), findsOneWidget);
  });

  testWidgets('banner: số trang = số truyện có ảnh bìa; không có ảnh thì ẩn', (
    tester,
  ) async {
    await _pump(tester);
    expect(find.byType(LibraryBanner), findsOneWidget);
    for (var i = 0; i < 4; i++) {
      expect(find.byKey(ValueKey('banner-dot-$i')), findsOneWidget);
    }
    expect(find.byKey(const ValueKey('banner-dot-4')), findsNothing);

    // Tự chuyển sau 5 giây.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    final dot = tester.getSize(find.byKey(const ValueKey('banner-dot-1')));
    expect(dot.width, 20); // chấm đang chọn dài 16 + lề 4
  });

  testWidgets('banner ẩn khi không truyện nào có ảnh bìa', (tester) async {
    await _pump(tester, covers: false);
    expect(find.byType(LibraryBanner), findsNothing);
    expect(find.text('Mới nhất'), findsOneWidget);
  });

  testWidgets('🔍 mở màn Tìm kiếm và focus sẵn ô tìm (cả lần sau)', (
    tester,
  ) async {
    await _pump(tester);
    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.byTooltip('Tìm truyện'));
    await tester.pumpAndSettle();
    expect(find.byType(SearchScreen), findsOneWidget);
    FocusNode focus() =>
        tester.widget<TextField>(find.byType(TextField)).focusNode!;
    expect(focus().hasFocus, isTrue);

    // Quay lại Trang chủ rồi bấm 🔍 lần nữa: mở màn mới, vẫn focus sẵn.
    focus().unfocus();
    await tester.tap(find.byTooltip('Quay lại'));
    await tester.pumpAndSettle();
    expect(find.byType(SearchScreen), findsNothing);
    await tester.tap(find.byTooltip('Tìm truyện'));
    await tester.pumpAndSettle();
    expect(focus().hasFocus, isTrue);
  });

  testWidgets(
    'Tìm kiếm: trống thì Tất cả truyện; tìm theo tên; rỗng; chip chủ đề lọc / bấm lại bỏ lọc',
    (tester) async {
      await _pump(tester);
      await tester.tap(find.byTooltip('Tìm truyện'));
      await tester.pumpAndSettle();
      expect(find.text('Tất cả truyện'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'SỐ 20');
      await tester.pumpAndSettle();
      expect(find.text('Kết quả tìm kiếm'), findsOneWidget);
      expect(find.text('Truyện số 20'), findsOneWidget);
      expect(find.text('Truyện số 1'), findsNothing);

      await tester.enterText(find.byType(TextField), 'không có');
      await tester.pumpAndSettle();
      expect(find.text('Không tìm thấy truyện phù hợp'), findsOneWidget);
      await tester.tap(find.text('Xoá tìm kiếm'));
      await tester.pumpAndSettle();
      expect(find.text('Tất cả truyện'), findsOneWidget);

      await tester.tap(find.widgetWithText(ChoiceChip, 'Phiêu lưu'));
      await tester.pumpAndSettle();
      expect(find.text('Chủ đề: Phiêu lưu'), findsOneWidget);
      expect(find.text('Truyện số 1'), findsOneWidget);
      expect(find.text('Truyện số 2'), findsNothing);

      await tester.tap(find.widgetWithText(ChoiceChip, 'Phiêu lưu'));
      await tester.pumpAndSettle();
      expect(find.text('Tất cả truyện'), findsOneWidget);
    },
  );

  testWidgets('Xem thêm mở lưới đầy đủ, Quay lại về các kệ', (tester) async {
    await _pump(tester);

    await tester.tap(find.bySemanticsLabel('Xem thêm Mới nhất'));
    await tester.pumpAndSettle();
    expect(find.text('Đọc nhiều nhất'), findsNothing);
    expect(find.text('Truyện số 1'), findsOneWidget);

    await tester.tap(find.byTooltip('Quay lại thư viện'));
    await tester.pumpAndSettle();
    expect(find.text('Đọc nhiều nhất'), findsOneWidget);
  });

  testWidgets('chip chủ đề mở lưới "Chủ đề: X", quay lại được', (tester) async {
    await _pump(tester);

    await tester.tap(find.widgetWithText(ActionChip, 'Phiêu lưu'));
    await tester.pumpAndSettle();
    expect(find.text('Chủ đề: Phiêu lưu'), findsOneWidget);
    expect(find.text('Truyện số 1'), findsOneWidget);
    expect(find.text('Truyện số 2'), findsNothing);

    await tester.tap(find.byTooltip('Quay lại thư viện'));
    await tester.pumpAndSettle();
    expect(find.text('Đọc nhiều nhất'), findsOneWidget);
  });

  testWidgets('lỗi tải: trạng thái lỗi, thử lại thì tải được', (tester) async {
    final library = await _pump(tester, fail: true);
    expect(find.text('Chưa tải được thư viện truyện'), findsOneWidget);

    library.fail = false;
    await tester.tap(find.text('Thử lại'));
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text('Mới nhất'), findsOneWidget);
  });

  testWidgets('bấm truyện: xem trước có chữ dù lỗi media, lật trang được', (
    tester,
  ) async {
    await _pump(tester);

    await tester.tap(find.bySemanticsLabel('Truyện số 20').first);
    await tester.pumpAndSettle();
    expect(find.text('Đoạn một của 20.'), findsOneWidget);
    expect(find.text('Trang 1 / 2'), findsOneWidget);

    await tester.tap(find.byTooltip('Trang sau'));
    await tester.pumpAndSettle();
    expect(find.text('Đoạn hai của 20.'), findsOneWidget);

    await tester.tap(find.byTooltip('Đóng xem trước'));
    await tester.pumpAndSettle();
    expect(find.text('Mới nhất'), findsOneWidget);
  });

  testWidgets('kéo làm mới không nhân đôi truyện', (tester) async {
    final library = await _pump(tester);
    final before = find.text('Truyện số 5').evaluate().length;

    await tester.fling(find.text('TaleTale'), const Offset(0, 1200), 1000);
    await tester.pumpAndSettle();
    expect(library.storyCalls, 2);
    expect(find.text('Truyện số 5').evaluate().length, before);
  });

  testWidgets('kệ ngang kéo bằng chuột được (web/desktop)', (tester) async {
    await _pump(tester, size: const Size(390, 3000));
    // Kệ ngang đầu tiên có truyện tràn ra ngoài (kệ ít truyện thì không cuộn).
    final state = find
        .byType(LibraryStoryCard)
        .evaluate()
        .map((e) => e.findAncestorStateOfType<ScrollableState>()!)
        .firstWhere(
          (s) =>
              s.position.axis == Axis.horizontal &&
              s.position.maxScrollExtent > 0,
        );
    final row = find.byElementPredicate((x) => x == state.context);
    final position = tester.state<ScrollableState>(row).position;
    expect(position.axis, Axis.horizontal);
    expect(position.pixels, 0);

    await tester.drag(
      row,
      const Offset(-200, 0),
      kind: PointerDeviceKind.mouse,
    );
    await tester.pumpAndSettle();
    expect(position.pixels, greaterThan(0));
  });

  testWidgets('chuông thông báo hiện số chưa đọc', (tester) async {
    await _pump(tester, unread: 3);
    expect(find.byTooltip('Thông báo, 3 chưa đọc'), findsOneWidget);
  });

  group('không tràn', () {
    for (final size in const [
      Size(320, 640),
      Size(360, 740),
      Size(390, 844),
      Size(1024, 768),
    ]) {
      testWidgets('${size.width.toInt()}×${size.height.toInt()}', (
        tester,
      ) async {
        await _pump(tester, size: size);
        expect(tester.takeException(), isNull);
        await tester.tap(find.byTooltip('Tìm truyện'));
        await tester.pumpAndSettle();
        // Màn Tìm kiếm: đang gõ (có nút xoá) và đang lọc chủ đề.
        await tester.enterText(find.byType(TextField), 'truyện');
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(ChoiceChip, 'Tình bạn'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });
    }
  });

  testWidgets('bố cục iPad không lỗi tràn', (tester) async {
    for (final size in kIpadSizes.values) {
      await _pump(tester, size: size);
      expect(tester.takeException(), isNull);
      expect(find.text('TaleTale'), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 10));
    }
  });
}
