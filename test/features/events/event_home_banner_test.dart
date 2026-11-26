import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/events/data/event_repository.dart';
import 'package:ai_storytelling_mobile/features/events/presentation/event_home_banner.dart';
import 'package:ai_storytelling_mobile/models/event_dto.dart';

import '../../support/fake_event_repository.dart';

Future<void> _pump(WidgetTester tester, List<EventSummaryDto> events) async {
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (_, _) => const Scaffold(body: EventHomeBanner()),
      ),
      GoRoute(
        path: '/events/:id',
        builder: (_, s) => Text('DETAIL_${s.pathParameters['id']}'),
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        eventRepositoryProvider.overrideWithValue(
          FakeEventRepository()..events = events,
        ),
      ],
      child: MaterialApp.router(theme: AppTheme.light(), routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('không có sự kiện Published thì ẩn', (tester) async {
    await _pump(tester, const [
      EventSummaryDto(id: 1, title: 'Đã xong', status: 'Closed'),
    ]);
    expect(find.text('Đã xong'), findsNothing);
    expect(find.text('Tham gia cùng bé'), findsNothing);
  });

  testWidgets('hiện sự kiện đầu tiên + "+1 sự kiện khác", bấm mở chi tiết', (
    tester,
  ) async {
    await _pump(tester, const [
      EventSummaryDto(id: 1, title: 'Đã xong', status: 'Closed'),
      EventSummaryDto(id: 5, title: 'Mùa hè đọc sách', status: 'Published'),
      EventSummaryDto(id: 6, title: 'Trăng rằm', status: 'Published'),
    ]);
    expect(find.text('Mùa hè đọc sách'), findsOneWidget);
    expect(find.text('Sự kiện đang mở'), findsOneWidget);
    expect(find.text('+1 sự kiện khác'), findsOneWidget);

    await tester.tap(find.text('Tham gia cùng bé'));
    await tester.pumpAndSettle();
    expect(find.text('DETAIL_5'), findsOneWidget);
  });
}
