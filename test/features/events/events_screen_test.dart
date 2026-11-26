import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/events/data/event_repository.dart';
import 'package:ai_storytelling_mobile/features/events/presentation/events_screen.dart';
import 'package:ai_storytelling_mobile/models/event_dto.dart';

import '../../support/fake_event_repository.dart';

final _now = DateTime.now();

EventSummaryDto _event(
  int id,
  String title, {
  String status = 'Published',
  DateTime? opensAt,
  DateTime? closesAt,
  String description = 'Cùng bé đọc truyện mỗi ngày',
  String? category,
  int budget = 0,
}) => EventSummaryDto(
  id: id,
  title: title,
  description: description,
  status: status,
  targetAgeBands: '6-8',
  mainCategoryName: category,
  budgetVnd: budget,
  opensAt: opensAt ?? _now.subtract(const Duration(days: 2)),
  closesAt: closesAt ?? _now.add(const Duration(days: 10)),
  createdAt: _now.subtract(const Duration(days: 30)),
  publishedAt: _now.subtract(const Duration(days: 30)),
);

FakeEventRepository _sample() => FakeEventRepository()
  ..events = [
    _event(1, 'Mùa hè đọc sách', category: 'Tình bạn', budget: 1500000),
    _event(
      2,
      'Lễ hội trăng rằm',
      opensAt: _now.add(const Duration(days: 5)),
      closesAt: _now.add(const Duration(days: 20)),
    ),
    _event(3, 'Tết thiếu nhi', status: 'Closed'),
    _event(4, 'Bản nháp', status: 'Draft'),
  ]
  ..participations = [
    const EventParticipationDto(
      id: 9,
      eventId: 1,
      trackType: 'Parent',
      status: 'Registered',
    ),
  ];

Future<void> _pump(
  WidgetTester tester,
  FakeEventRepository repo, {
  // Rộng để cả 5 chip lọc cùng hiện (màn hẹp thì chip cuộn ngang).
  Size size = const Size(1024, 2400),
  double textScale = 1,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final router = GoRouter(
    initialLocation: '/events',
    routes: [
      GoRoute(
        path: '/events',
        builder: (_, _) => const EventsScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (_, s) => Text('DETAIL_${s.pathParameters['id']}'),
          ),
        ],
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [eventRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp.router(
        theme: AppTheme.light(),
        routerConfig: router,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(textScale)),
          child: child!,
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pumpAndSettle();
}

Finder _chip(String label) => find.widgetWithText(ChoiceChip, label);

void main() {
  testWidgets('thẻ sự kiện + số đếm chip; bỏ sự kiện nháp', (tester) async {
    await _pump(tester, _sample());

    expect(_chip('Tất cả (3)'), findsOneWidget);
    expect(_chip('Đang mở (1)'), findsOneWidget);
    expect(_chip('Sắp diễn ra (1)'), findsOneWidget);
    expect(_chip('Đã kết thúc (1)'), findsOneWidget);
    expect(_chip('Đã tham gia (1)'), findsOneWidget);
    expect(find.text('Mùa hè đọc sách'), findsOneWidget);
    expect(find.text('Bản nháp'), findsNothing);
    expect(find.text('Đã đăng ký'), findsOneWidget);
    expect(find.text('1.500.000 đ'), findsOneWidget);
    expect(find.text('Tình bạn'), findsOneWidget);
    expect(find.text('6-8 tuổi'), findsNWidgets(3));
  });

  testWidgets('lọc Đã tham gia, Sắp diễn ra; bấm thẻ mở chi tiết', (
    tester,
  ) async {
    await _pump(tester, _sample());

    await tester.tap(_chip('Đã tham gia (1)'));
    await tester.pumpAndSettle();
    expect(find.text('Mùa hè đọc sách'), findsOneWidget);
    expect(find.text('Lễ hội trăng rằm'), findsNothing);

    await tester.tap(_chip('Sắp diễn ra (1)'));
    await tester.pumpAndSettle();
    expect(find.text('Lễ hội trăng rằm'), findsOneWidget);
    expect(find.text('Mùa hè đọc sách'), findsNothing);

    await tester.tap(find.text('Lễ hội trăng rằm'));
    await tester.pumpAndSettle();
    expect(find.text('DETAIL_2'), findsOneWidget);
  });

  testWidgets('tìm không dấu theo tên / chủ đề; không thấy thì báo rỗng', (
    tester,
  ) async {
    await _pump(tester, _sample());

    await tester.enterText(find.byType(TextField), 'TRANG RAM');
    await tester.pumpAndSettle();
    expect(find.text('Lễ hội trăng rằm'), findsOneWidget);
    expect(find.text('Mùa hè đọc sách'), findsNothing);

    await tester.enterText(find.byType(TextField), 'tinh ban');
    await tester.pumpAndSettle();
    expect(find.text('Mùa hè đọc sách'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'không có');
    await tester.pumpAndSettle();
    expect(find.text('Không tìm thấy sự kiện phù hợp'), findsOneWidget);

    await tester.tap(find.byTooltip('Xoá tìm kiếm'));
    await tester.pumpAndSettle();
    expect(find.text('Mùa hè đọc sách'), findsOneWidget);
  });

  testWidgets('chưa có sự kiện công bố', (tester) async {
    await _pump(
      tester,
      FakeEventRepository()..events = [_event(4, 'Nháp', status: 'Draft')],
    );
    expect(find.text('Chưa có sự kiện nào được công bố'), findsOneWidget);
  });

  testWidgets('lỗi tải: thử lại thì hiện danh sách', (tester) async {
    final repo = _sample()..failList = true;
    await _pump(tester, repo);
    expect(find.text('Chưa tải được danh sách sự kiện'), findsOneWidget);

    repo.failList = false;
    await tester.tap(find.text('Thử lại'));
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text('Mùa hè đọc sách'), findsOneWidget);
  });

  group('không tràn', () {
    for (final w in const [360.0, 412.0]) {
      testWidgets('${w.toInt()}px, chữ 1.3', (tester) async {
        final repo = _sample()
          ..events = [
            _event(
              1,
              'Sự kiện có tên rất dài để kiểm tra chữ không tràn ra ngoài thẻ',
              description: 'Mô tả rất dài, rất dài, rất dài để kiểm tra hai dòng cắt dấu ba chấm',
              category: 'Chủ đề tên dài lắm luôn',
              budget: 123456789,
            ),
          ];
        await _pump(tester, repo, size: Size(w, 1600), textScale: 1.3);
        expect(tester.takeException(), isNull);
      });
    }
  });
}
