import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/events/data/event_repository.dart';
import 'package:ai_storytelling_mobile/features/events/presentation/event_detail_screen.dart';
import 'package:ai_storytelling_mobile/features/library/data/library_logic.dart';
import 'package:ai_storytelling_mobile/features/library/presentation/library_providers.dart';
import 'package:ai_storytelling_mobile/models/event_dto.dart';

import '../../support/fake_event_repository.dart';
import '../../support/ipad_sizes.dart';

final _now = DateTime.now();

EventDetailDto _legacy() => EventDetailDto(
  id: 1,
  title: 'Mùa hè đọc sách',
  description: 'Cùng bé đọc truyện mỗi ngày',
  status: 'Published',
  configVersion: 'LegacyRoleBased',
  targetAgeBands: '6-8',
  eventStoriesCount: 2,
  tracks: [
    EventTrackDto(
      id: 11,
      trackType: 'Parent',
      registrationStartAt: _now.subtract(const Duration(days: 1)),
      registrationEndAt: _now.add(const Duration(days: 5)),
      executionStartAt: _now.subtract(const Duration(days: 1)),
      executionEndAt: _now.add(const Duration(days: 9)),
    ),
  ],
  activeRule: const EventRuleVersionDto(
    id: 5,
    rulesText: 'THỂ LỆ: mỗi ngày đọc một truyện.',
    completionMode: 'AllMandatory',
    tasks: [EventTaskDefinitionDto(id: 1, title: 'Đọc 3 truyện')],
  ),
  awards: const [
    EventAwardSlotDto(
      id: 70,
      rankOrTier: 'Giải nhất',
      rewardType: 'PhysicalGift',
      rewardName: 'Bộ sách',
    ),
  ],
);

const _dashboard = EventMissionDashboardDto(
  participation: EventParticipationDto(
    id: 9,
    eventId: 1,
    trackType: 'Parent',
    status: 'Registered',
  ),
  completedTasksCount: 1,
  earnedPoints: 20,
  tasks: [
    EventTaskProgressItemDto(
      taskDefinitionId: 1,
      title: 'Đọc 3 truyện',
      verifierType: 'ReadEventStories',
      targetValue: 3,
      currentValue: 3,
      isCompleted: true,
      isMandatory: true,
      points: 20,
    ),
    EventTaskProgressItemDto(
      taskDefinitionId: 2,
      title: 'Thảo luận cùng con',
      verifierType: 'GuidedDiscussionCheckin',
      targetValue: 1,
      points: 10,
    ),
  ],
  stories: [
    EventStoryLibraryItemDto(
      storyId: 31,
      title: 'Chú ếch xanh',
      genre: 'Phiêu lưu',
      ageBand: 'Age_6_8',
      hasFamilyRead: true,
    ),
  ],
);

Future<FakeEventRepository> _pump(
  WidgetTester tester,
  FakeEventRepository repo, {
  Size size = const Size(412, 3000),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final router = GoRouter(
    initialLocation: '/events/1',
    routes: [
      GoRoute(
        path: '/events',
        builder: (_, _) => const Text('LIST'),
        routes: [
          GoRoute(
            path: ':id',
            builder: (_, s) =>
                EventDetailScreen(eventId: int.parse(s.pathParameters['id']!)),
          ),
        ],
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        eventRepositoryProvider.overrideWithValue(repo),
        libraryProvider.overrideWith(
          (_) async => LibraryData(
            shelves: LibraryShelves(const []),
            mostViewed: const [],
            mostFavorited: const [],
          ),
        ),
      ],
      child: MaterialApp.router(theme: AppTheme.light(), routerConfig: router),
    ),
  );
  await tester.pump();
  await tester.pumpAndSettle();
  return repo;
}

FakeEventRepository _joined() => FakeEventRepository()
  ..details[1] = _legacy()
  ..participations = [_dashboard.participation!]
  ..dashboard = _dashboard;

void main() {
  testWidgets('chưa tham gia: đăng ký → popup thể lệ → đồng ý gọi register', (
    tester,
  ) async {
    final repo = await _pump(
      tester,
      FakeEventRepository()..details[1] = _legacy(),
    );

    expect(find.text('Mùa hè đọc sách'), findsOneWidget);
    expect(find.text('Tham gia cùng gia đình'), findsOneWidget);
    await tester.tap(find.text('Đăng ký tham gia'));
    await tester.pumpAndSettle();
    expect(find.text('Thể lệ sự kiện'), findsOneWidget);
    // Thể lệ hiện ở cả khung thông tin và popup.
    expect(find.text('THỂ LỆ: mỗi ngày đọc một truyện.'), findsNWidgets(2));

    await tester.tap(find.text('Đồng ý & đăng ký'));
    await tester.pumpAndSettle();
    expect(repo.registers.single['trackType'], 'Parent');
    expect(find.text('Đã đăng ký tham gia cho gia đình.'), findsOneWidget);
    // Làm mới xong thì hiện bảng nhiệm vụ.
    expect(find.text('Tiến độ nhiệm vụ'), findsOneWidget);
  });

  testWidgets('ngoài thời gian đăng ký: nút tắt, có lời nhắc', (tester) async {
    final detail = _legacy().copyWith(
      tracks: [
        EventTrackDto(
          id: 11,
          trackType: 'Parent',
          registrationStartAt: _now.add(const Duration(days: 2)),
          registrationEndAt: _now.add(const Duration(days: 5)),
        ),
      ],
    );
    final repo = await _pump(
      tester,
      FakeEventRepository()..details[1] = detail,
    );
    expect(find.textContaining('Đăng ký gia đình mở lúc'), findsOneWidget);
    await tester.tap(find.text('Đăng ký tham gia'));
    await tester.pumpAndSettle();
    expect(find.text('Thể lệ sự kiện'), findsNothing);
    expect(repo.registers, isEmpty);
  });

  testWidgets('đã tham gia: KPI + nhiệm vụ; Xác nhận nhiệm vụ checkin', (
    tester,
  ) async {
    final repo = await _pump(tester, _joined());

    expect(find.text('1 / 2'), findsOneWidget);
    expect(find.text('20 điểm'), findsOneWidget);
    expect(find.text('Đang thực hiện'), findsOneWidget);
    expect(find.text('Thảo luận cùng con'), findsOneWidget);
    expect(find.text('Chú ếch xanh'), findsOneWidget);
    expect(find.text('Bé đã đọc xong'), findsOneWidget);
    // Chỉ nhiệm vụ tự xác nhận chưa xong mới có nút.
    expect(find.text('Xác nhận'), findsOneWidget);

    await tester.tap(find.text('Xác nhận'));
    await tester.pumpAndSettle();
    expect(find.text('Xác nhận nhiệm vụ'), findsOneWidget);
    await tester.tap(find.text('Chú ếch xanh').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Xác nhận').last);
    await tester.pumpAndSettle();
    expect(repo.completes.single, (2, 31));
    expect(find.text('Đã cập nhật tiến độ nhiệm vụ.'), findsOneWidget);

    // Chuyển sang Thông tin rồi quay lại.
    await tester.tap(find.text('Thông tin'));
    await tester.pumpAndSettle();
    expect(find.text('Cơ cấu giải thưởng'), findsOneWidget);
    expect(find.text('Tiến độ nhiệm vụ'), findsNothing);
  });

  testWidgets('nhận thưởng: thiếu trường báo lỗi, đủ thì gọi claimReward', (
    tester,
  ) async {
    final repo = _joined()
      ..rewards = [
        const EventAwardSlotDto(
          id: 70,
          rankOrTier: 'Giải nhất',
          rewardType: 'PhysicalGift',
          rewardName: 'Bộ sách',
          status: 'AwaitingClaim',
        ),
      ];
    await _pump(tester, repo);

    await tester.tap(find.text('Nhận thưởng'));
    await tester.pumpAndSettle();
    expect(find.text('Nhận thưởng: Bộ sách'), findsOneWidget);
    await tester.tap(find.text('Nhận thưởng').last);
    await tester.pumpAndSettle();
    expect(
      find.text('Cần nhập họ tên, số điện thoại và địa chỉ nhận quà.'),
      findsOneWidget,
    );
    expect(repo.claims, isEmpty);
    expect(find.text('Nhận thưởng: Bộ sách'), findsOneWidget);

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'Nguyễn Văn A');
    await tester.enterText(fields.at(1), '0900000000');
    await tester.enterText(fields.at(2), '1 Lê Lợi');
    await tester.tap(find.text('Nhận thưởng').last);
    await tester.pumpAndSettle();
    expect(repo.claims.single.$1, 70);
    expect(repo.claims.single.$2['phoneNumber'], '0900000000');
    expect(find.text('Đã nhận thưởng thành công.'), findsOneWidget);
    expect(find.text('Nhận thưởng: Bộ sách'), findsNothing);
  });

  testWidgets('ActivityBased: đăng ký hoạt động gửi activityType + id', (
    tester,
  ) async {
    final detail = _legacy().copyWith(
      configVersion: 'ActivityBased',
      tracks: const [],
      activities: [
        EventActivityDto(
          id: 41,
          activityType: 'ReadingMissions',
          allowedAudience: 'Parent',
          startAt: _now,
          endAt: _now.add(const Duration(days: 3)),
        ),
      ],
      myActivityStates: const [
        EventActivityUserStateDto(
          activityId: 41,
          activityType: 'ReadingMissions',
          allowedAudience: 'Parent',
          lifecycleStatus: 'Open',
          isEligible: true,
          canRegister: true,
        ),
      ],
    );
    final repo = await _pump(
      tester,
      FakeEventRepository()..details[1] = detail,
    );

    expect(find.text('Đọc truyện & Làm nhiệm vụ · Parent'), findsOneWidget);
    await tester.tap(find.text('Đăng ký'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Đồng ý & đăng ký'));
    await tester.pumpAndSettle();
    expect(repo.registers.single['activityType'], 'ReadingMissions');
    expect(repo.registers.single['eventActivityId'], 41);
  });

  testWidgets('quay lại về danh sách; 360px chữ 1.3 không tràn', (
    tester,
  ) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    final repo = _joined()
      ..rewards = [
        const EventAwardSlotDto(
          id: 70,
          rankOrTier: 'Giải nhất toàn quốc dành cho gia đình',
          rewardType: 'CashTransfer',
          rewardName: 'Tiền thưởng chuyển khoản rất lớn',
          unitValueVnd: 123456789,
          status: 'AwaitingClaim',
        ),
      ];
    await _pump(tester, repo, size: const Size(360, 3000));
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Thông tin'));
    await tester.pumpAndSettle();
    expect(find.text('Hành trình sự kiện'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byTooltip('Quay lại'));
    await tester.pumpAndSettle();
    expect(find.text('LIST'), findsOneWidget);
  });

  testWidgets('bố cục iPad không lỗi tràn', (tester) async {
    for (final size in kIpadSizes.values) {
      await _pump(tester, _joined(), size: size);
      expect(tester.takeException(), isNull);
      expect(find.text('Mùa hè đọc sách'), findsOneWidget);
    }
  });
}
