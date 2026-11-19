import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/kid/home/kid_frog_cue.dart';
import 'package:ai_storytelling_mobile/features/kid/home/kid_lobby_frog.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_rewards_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_session_controller.dart';
import 'package:ai_storytelling_mobile/features/kid/data/stored_kid_session.dart';
import 'package:ai_storytelling_mobile/features/kid/home/kid_home_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/home/kid_journey_screen.dart';
import 'package:ai_storytelling_mobile/models/child_rewards_dto.dart';
import 'package:ai_storytelling_mobile/models/child_session_dto.dart';
import 'package:ai_storytelling_mobile/models/my_roadmap_dto.dart';

class FakeKidRepository implements KidRepository {
  FakeKidRepository(this.roadmap, {this.fail = false});

  final MyRoadmapDto roadmap;
  final bool fail;

  @override
  Future<ChildSessionProfileDto> getSessionProfile(String childToken) async {
    if (fail) throw const ApiException(statusCode: 500, message: 'Máy chủ bận');
    return const ChildSessionProfileDto(
      childProfileId: 1,
      nickname: 'Bé Na',
      ageBand: 'Age_6_8',
    );
  }

  @override
  Future<MyRoadmapDto> getMyRoadmap(String childToken) async => roadmap;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeRewards implements KidRewardsRepository {
  FakeRewards({this.fail = false});

  final bool fail;

  @override
  Future<ChildRewards> rewards() async {
    if (fail) throw const ApiException(statusCode: 500, message: 'Lỗi');
    return const ChildRewards(
      knowledgeTree: KnowledgeTree(
        stage: 'SPROUT',
        stageName: 'Mầm non',
        expToWater: 5,
      ),
      badges: [
        RewardBadge(code: 'A', name: 'A', earned: true),
        RewardBadge(code: 'B', name: 'B', earned: true),
        RewardBadge(code: 'C', name: 'C'),
      ],
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ActiveSession extends KidSessionController {
  @override
  KidSessionState build() => const KidActive(
    StoredKidSession(
      childProfileId: 1,
      accessToken: 'test-token',
      expiresAtMs: 4102444800000,
      via: KidSessionVia.easyLogin,
      parentalGateEnabled: true,
    ),
  );
}

class EndedSession extends KidSessionController {
  @override
  KidSessionState build() => const KidEnded();
}

const openRoadmap = MyRoadmapDto(
  open: MyRoadmapOpenStoryDto(
    storyId: 10,
    title: 'Chú ếch và hoa sen',
    note: 'Đọc cho ngoan nhé',
    isLocked: false,
  ),
  done: [MyRoadmapDoneDto(storyId: 9, title: 'Truyện đã xong')],
  upcoming: [
    MyRoadmapUpcomingDto(
      order: 2,
      storyId: 11,
      title: 'Sắp đọc',
      isLocked: false,
    ),
  ],
  completedCount: 1,
  totalCount: 3,
);

Future<void> pumpHome(
  WidgetTester tester,
  MyRoadmapDto roadmap, {
  Size size = const Size(390, 844),
  bool rewardsFail = false,
  bool homeFail = false,
  bool reduceMotion = false,
  KidSessionController Function() session = ActiveSession.new,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final router = GoRouter(
    initialLocation: '/kid',
    routes: [
      GoRoute(path: '/kid', builder: (_, _) => const KidHomeScreen()),
      GoRoute(
        path: '/kid/:rest(.*)',
        builder: (_, state) => Scaffold(body: Text('route:${state.uri.path}')),
      ),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        kidRepositoryProvider.overrideWithValue(
          FakeKidRepository(roadmap, fail: homeFail),
        ),
        kidRewardsRepositoryProvider.overrideWithValue(
          FakeRewards(fail: rewardsFail),
        ),
        kidSessionProvider.overrideWith(session),
      ],
      child: MaterialApp.router(
        theme: AppTheme.light(),
        routerConfig: router,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(disableAnimations: reduceMotion),
          child: child!,
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
  // Badge hiện sau khi phần thưởng tải xong: thêm một khung để hiệu ứng nảy của badge khởi chạy.
  await tester.pump(const Duration(milliseconds: 500));
}

Future<void> tapAndSettleRoute(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
}

void main() {
  testWidgets('Sảnh hiện thẻ Hôm nay, đủ nút và badge từ API', (tester) async {
    await pumpHome(tester, openRoadmap);

    expect(find.text('Bé Na'), findsOneWidget);
    expect(find.text('Hôm nay'), findsOneWidget);
    expect(find.text('Chú ếch và hoa sen'), findsOneWidget);
    for (final label in [
      'Hành trình',
      'Sổ tay',
      'Điều ước',
      'Huy hiệu',
      'Kho truyện',
      'Cây',
      'ĐỌC NGAY',
    ]) {
      expect(find.text(label), findsOneWidget, reason: label);
    }
    expect(find.text('2'), findsOneWidget); // huy hiệu đã đạt
    expect(find.text('5'), findsOneWidget); // giọt nước chờ tưới
  });

  testWidgets('Lỗi tải phần thưởng thì ẩn badge, sảnh vẫn hiện', (
    tester,
  ) async {
    await pumpHome(tester, openRoadmap, rewardsFail: true);

    expect(find.text('Huy hiệu'), findsOneWidget);
    expect(find.text('2'), findsNothing);
    expect(find.text('5'), findsNothing);
  });

  group('Điều hướng', () {
    const cases = {
      'ĐỌC NGAY': '/kid/read/10',
      'Chú ếch và hoa sen': '/kid/read/10',
      'Hành trình': '/kid/journey',
      'Sổ tay': '/kid/notebook',
      'Điều ước': '/kid/wish',
      'Huy hiệu': '/kid/rewards',
      'Kho truyện': '/kid/library',
      'Cây': '/kid/rewards',
    };
    cases.forEach((label, route) {
      testWidgets('$label → $route', (tester) async {
        await pumpHome(tester, openRoadmap);
        await tapAndSettleRoute(tester, find.text(label));
        expect(find.text('route:$route'), findsOneWidget);
      });
    });
  });

  testWidgets('Truyện bị khoá: bấm Đọc chỉ hiện toast', (tester) async {
    const locked = MyRoadmapDto(
      open: MyRoadmapOpenStoryDto(
        storyId: 10,
        title: 'Truyện khoá',
        isLocked: true,
      ),
    );
    await pumpHome(tester, locked);
    await tapAndSettleRoute(tester, find.text('ĐỌC NGAY'));

    expect(find.text('Truyện này chưa mở, em chờ bố mẹ nhé.'), findsOneWidget);
    expect(find.textContaining('route:'), findsNothing);
  });

  testWidgets('Chưa có truyện: mời chọn truyện, nút chính mở Kho truyện', (
    tester,
  ) async {
    await pumpHome(tester, const MyRoadmapDto());

    expect(find.text('Hôm nay em muốn đọc truyện gì?'), findsOneWidget);
    await tapAndSettleRoute(tester, find.text('CHỌN TRUYỆN'));
    expect(find.text('route:/kid/library'), findsOneWidget);
  });

  KidFrogCue cueOf(WidgetTester tester) =>
      tester.widget<KidLobbyFrog>(find.byType(KidLobbyFrog)).cue;

  testWidgets('Chạm ếch: lần lượt đổi động tác như web', (tester) async {
    await pumpHome(tester, openRoadmap);
    final seen = <KidFrogAction?>[];
    for (var i = 0; i < 3; i++) {
      await tester.tap(find.byType(KidLobbyFrog));
      await tester.pump(const Duration(milliseconds: 1500));
      seen.add(cueOf(tester).action);
    }
    expect(seen, [
      KidFrogAction.wave,
      KidFrogAction.spin,
      KidFrogAction.tongue,
    ]);
    expect(tester.takeException(), isNull);
  });

  group('Chạm xuống nút thì ếch làm động tác của nút', () {
    const actions = {
      'Kho truyện': KidFrogAction.wink,
      'ĐỌC NGAY': KidFrogAction.wave,
      'Cây': KidFrogAction.tongue,
      'Hành trình': KidFrogAction.wave,
      'Sổ tay': KidFrogAction.wink,
      'Điều ước': KidFrogAction.wave,
      'Huy hiệu': KidFrogAction.tongue,
    };
    actions.forEach((label, action) {
      testWidgets('$label → ${action.name}', (tester) async {
        await pumpHome(tester, openRoadmap);
        final cue = cueOf(tester);
        final before = cue.count;
        final g = await tester.startGesture(tester.getCenter(find.text(label)));
        await tester.pump(const Duration(milliseconds: 300));
        // Động tác bắt đầu ngay khi chạm xuống, chưa cần nhấc tay.
        expect(cue.count, before + 1);
        expect(cue.action, action);
        expect(cue.pointer.value, isNotNull);
        await g.cancel();
        await tester.pump(const Duration(milliseconds: 500));
        expect(cue.pointer.value, isNull);
      });
    });
  });

  testWidgets(
    'Giảm chuyển động: không chạy hoạt cảnh lặp, chạm vẫn hoạt động',
    (tester) async {
      await pumpHome(tester, openRoadmap, reduceMotion: true);
      await tester.pump(const Duration(seconds: 2));
      expect(tester.binding.hasScheduledFrame, isFalse);

      await tester.tap(find.byType(KidLobbyFrog));
      await tester.pump();
      expect(cueOf(tester).action, KidFrogAction.wave);
      await tapAndSettleRoute(tester, find.text('Sổ tay'));
      expect(find.text('route:/kid/notebook'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  const labels = [
    'Hành trình',
    'Sổ tay',
    'Điều ước',
    'Huy hiệu',
    'Kho truyện',
    'ĐỌC NGAY',
    'Cây',
  ];
  for (final size in const [
    Size(360, 740),
    Size(390, 844),
    Size(844, 390),
    Size(740, 360),
    Size(1024, 768),
    Size(1180, 820),
    Size(1366, 1024),
  ]) {
    testWidgets(
      'Vừa một màn, đủ 7 nút và ếch ở ${size.width.toInt()}×${size.height.toInt()}',
      (tester) async {
        await pumpHome(tester, openRoadmap, size: size);

        expect(tester.takeException(), isNull);
        expect(find.byType(KidLobbyFrog), findsOneWidget);
        final screen = Offset.zero & size;
        for (final label in labels) {
          // Mọi nút nằm trọn trong màn hình: không phải cuộn.
          final r = tester.getRect(find.text(label));
          expect(
            screen.contains(r.topLeft) && screen.contains(r.bottomRight),
            isTrue,
            reason: '$label $r',
          );
        }
        if (size.width > size.height) {
          // Màn ngang: hai cột nút sát hai bên ếch, không dạt ra mép màn.
          final frog = tester.getRect(find.byType(KidLobbyFrog));
          final left = tester.getRect(find.text('Hành trình'));
          final right = tester.getRect(find.text('Điều ước'));
          expect(frog.left - left.right, lessThan(120));
          expect(right.left - frog.right, lessThan(120));
        }
      },
    );
  }

  testWidgets('Màn thấp thì cuộn được, không tràn', (tester) async {
    await pumpHome(tester, openRoadmap, size: const Size(320, 520));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Lỗi tải sảnh: hiện thông báo và nút thử lại', (tester) async {
    await pumpHome(tester, openRoadmap, homeFail: true);

    expect(find.text('Chưa mở được trang của em'), findsOneWidget);
    expect(find.text('Máy chủ bận'), findsOneWidget);
  });

  testWidgets('Phiên kết thúc: hiện màn kết thúc', (tester) async {
    await pumpHome(tester, openRoadmap, session: EndedSession.new);

    expect(find.text('Phiên đọc đã kết thúc'), findsOneWidget);
  });

  testWidgets('Màn Hành trình hiện dải lộ trình', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          kidRepositoryProvider.overrideWithValue(
            FakeKidRepository(openRoadmap),
          ),
          kidSessionProvider.overrideWith(ActiveSession.new),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const KidJourneyScreen(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Hành trình của em'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
