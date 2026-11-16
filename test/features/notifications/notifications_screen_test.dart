import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_button.dart';
import 'package:ai_storytelling_mobile/features/children/data/child_profile_repository.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/children_providers.dart';
import 'package:ai_storytelling_mobile/features/notifications/data/notification_repository.dart';
import 'package:ai_storytelling_mobile/features/notifications/presentation/notifications_screen.dart';
import 'package:ai_storytelling_mobile/models/child_profile_dto.dart';
import 'package:ai_storytelling_mobile/models/notification_dto.dart';

class _FakeChildren implements ChildProfileRepository {
  @override
  Future<List<ChildProfileDto>> fetchMine() async => const [
        ChildProfileDto(
          id: 1,
          nickname: 'Bé An',
          avatarId: 'avatar-cat',
          ageBand: 'Age_6_8',
          status: 'Active',
        ),
      ];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeRepo implements NotificationRepository {
  _FakeRepo(this.items);

  List<NotificationDto> items;
  bool failList = false;
  final read = <int>[];
  final deleted = <int>[];
  int readAll = 0;

  @override
  Future<List<NotificationDto>> list() async {
    if (failList) {
      throw const ApiException(message: 'Mất kết nối, bạn thử lại nhé.');
    }
    return items;
  }

  @override
  Future<int> unreadCount() async => items.where((n) => n.isUnread).length;

  @override
  Future<void> markRead(int id) async {
    read.add(id);
    items = [
      for (final n in items)
        n.id == id ? n.copyWith(status: 'Read', readAt: DateTime.now()) : n,
    ];
  }

  @override
  Future<void> markAllRead() async {
    readAll++;
    items = [for (final n in items) n.copyWith(status: 'Read')];
  }

  @override
  Future<void> delete(int id) async {
    deleted.add(id);
    items = items.where((n) => n.id != id).toList();
  }
}

final _now = DateTime.now();

List<NotificationDto> _sample() => [
      NotificationDto(
        id: 1,
        childProfileId: 1,
        type: 'StoryWishSubmitted',
        group: 'children',
        payload: '{"childProfileId":1,"wishId":5}',
        status: 'Unread',
        createdAt: _now.subtract(const Duration(minutes: 5)),
      ),
      NotificationDto(
        id: 2,
        type: 'PaymentConfirmed',
        group: 'account',
        payload: '{"orderCode":123}',
        status: 'Unread',
        createdAt: _now.subtract(const Duration(hours: 2)),
      ),
      NotificationDto(
        id: 3,
        type: 'SomethingBrandNew',
        payload: '{"secret":"x"}',
        status: 'Read',
        readAt: _now,
        createdAt: _now.subtract(const Duration(days: 3)),
      ),
    ];

Future<(ProviderContainer, _FakeRepo)> _pump(
  WidgetTester tester, {
  List<NotificationDto>? items,
  bool failList = false,
  Size size = const Size(412, 915),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final repo = _FakeRepo(items ?? _sample())..failList = failList;
  final container = ProviderContainer(
    retry: (_, _) => null,
    overrides: [
      notificationRepositoryProvider.overrideWithValue(repo),
      childProfileRepositoryProvider.overrideWithValue(_FakeChildren()),
    ],
  );
  addTearDown(container.dispose);

  final router = GoRouter(
    initialLocation: '/notifications',
    routes: [
      GoRoute(
        path: '/notifications',
        builder: (_, _) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/learning',
        builder: (_, _) => const Scaffold(body: Text('LEARNING_TAB')),
      ),
    ],
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(theme: AppTheme.light(), routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  return (container, repo);
}

void main() {
  testWidgets('hiện danh sách: câu dễ hiểu, tên bé, không lộ JSON',
      (tester) async {
    await _pump(tester);

    expect(find.text('Thông báo'), findsOneWidget);
    expect(find.text('Bé vừa gửi một điều ước'), findsOneWidget);
    expect(find.text('Bé An · 5 phút trước'), findsOneWidget);
    expect(find.text('Thanh toán thành công, gói đã được áp'), findsOneWidget);
    expect(find.text('2 giờ trước'), findsOneWidget);
    expect(find.text('Bạn có thông báo mới'), findsOneWidget);
    expect(find.textContaining('{'), findsNothing);
    expect(find.byKey(const ValueKey('unread-dot')), findsNWidgets(2));
  });

  testWidgets('chạm thông báo điều ước: đánh dấu đọc, chọn bé, mở Học tập',
      (tester) async {
    final (container, repo) = await _pump(tester);

    await tester.tap(find.text('Bé vừa gửi một điều ước'));
    await tester.pumpAndSettle();

    expect(repo.read, [1]);
    expect(container.read(selectedChildIdProvider), 1);
    expect(find.text('LEARNING_TAB'), findsOneWidget);
  });

  testWidgets('chạm thông báo không có đích: chỉ đánh dấu đọc, ở lại',
      (tester) async {
    final (_, repo) = await _pump(tester);

    await tester.tap(find.text('Thanh toán thành công, gói đã được áp'));
    await tester.pumpAndSettle();

    expect(repo.read, [2]);
    expect(find.text('LEARNING_TAB'), findsNothing);
    expect(find.byKey(const ValueKey('unread-dot')), findsOneWidget);
  });

  testWidgets('chạm mục đã đọc thì không gọi lại API đọc', (tester) async {
    final (_, repo) = await _pump(tester);
    await tester.tap(find.text('Bạn có thông báo mới'));
    await tester.pumpAndSettle();
    expect(repo.read, isEmpty);
  });

  testWidgets('Đánh dấu tất cả đã đọc', (tester) async {
    final (_, repo) = await _pump(tester);

    await tester.tap(find.byTooltip('Đánh dấu tất cả đã đọc'));
    await tester.pumpAndSettle();

    expect(repo.readAll, 1);
    expect(find.text('Đã đánh dấu tất cả là đã đọc.'), findsOneWidget);
    expect(find.byKey(const ValueKey('unread-dot')), findsNothing);
  });

  testWidgets('Xoá: có popup; Huỷ thì không xoá, Xoá thì gọi delete',
      (tester) async {
    final (_, repo) = await _pump(tester);

    await tester.tap(find.byTooltip('Xoá thông báo').first);
    await tester.pumpAndSettle();
    expect(find.text('Xoá thông báo này?'), findsOneWidget);
    await tester.tap(find.text('Huỷ'));
    await tester.pumpAndSettle();
    expect(repo.deleted, isEmpty);

    await tester.tap(find.byTooltip('Xoá thông báo').first);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TtButton, 'Xoá'));
    await tester.pumpAndSettle();

    expect(repo.deleted, [1]);
    expect(find.text('Bé vừa gửi một điều ước'), findsNothing);
    expect(find.text('Đã xoá thông báo.'), findsOneWidget);
  });

  testWidgets('rỗng: ếch và câu Chưa có thông báo nào', (tester) async {
    await _pump(tester, items: const []);
    expect(find.text('Chưa có thông báo nào'), findsOneWidget);
  });

  testWidgets('lỗi + thử lại', (tester) async {
    final (_, repo) = await _pump(tester, failList: true);

    expect(find.text('Chưa tải được thông báo'), findsOneWidget);
    expect(find.text('Mất kết nối, bạn thử lại nhé.'), findsOneWidget);

    repo.failList = false;
    await tester.tap(find.text('Thử lại'));
    await tester.pumpAndSettle();

    expect(find.text('Bé vừa gửi một điều ước'), findsOneWidget);
  });

  group('không tràn', () {
    for (final size in const [Size(360, 740), Size(800, 1280)]) {
      testWidgets('${size.width.toInt()}×${size.height.toInt()}',
          (tester) async {
        await _pump(tester, size: size);
        expect(tester.takeException(), isNull);
      });
    }
  });
}
