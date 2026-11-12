import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_button.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_session_controller.dart';
import 'package:ai_storytelling_mobile/features/kid/data/stored_kid_session.dart';
import 'package:ai_storytelling_mobile/features/kid/home/kid_home_screen.dart';
import 'package:ai_storytelling_mobile/models/child_session_dto.dart';
import 'package:ai_storytelling_mobile/models/my_roadmap_dto.dart';
import 'package:ai_storytelling_mobile/models/safety_policy_dto.dart';

class FakeKidRepository implements KidRepository {
  final MyRoadmapDto roadmap;

  FakeKidRepository(this.roadmap);

  @override
  Future<ChildSessionProfileDto> getSessionProfile(String childToken) async {
    return const ChildSessionProfileDto(
      childProfileId: 1,
      nickname: 'Bé Na',
      ageBand: 'Age_6_8',
    );
  }

  @override
  Future<MyRoadmapDto> getMyRoadmap(String childToken) async {
    return roadmap;
  }

  @override
  Future<ChildSessionDto> loginWithEasyLogin(String secret) =>
      throw UnimplementedError();

  @override
  Future<ChildSessionDto> startHandover({
    required int childId,
    required String supervisorRefreshToken,
  }) =>
      throw UnimplementedError();

  @override
  Future<SafetyPolicyDto> getSafetyPolicy(int childId) =>
      throw UnimplementedError();

  @override
  Future<void> verifyParentalGate({
    required String email,
    required String password,
  }) =>
      throw UnimplementedError();
}

class FakeKidSessionController extends KidSessionController {
  @override
  KidSessionState build() {
    return const KidActive(
      StoredKidSession(
        childProfileId: 1,
        accessToken: 'test-token',
        expiresAtMs: 4102444800000,
        via: KidSessionVia.easyLogin,
        parentalGateEnabled: true,
      ),
    );
  }
}

Future<void> pumpHome(WidgetTester tester, MyRoadmapDto roadmap) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        kidRepositoryProvider.overrideWithValue(FakeKidRepository(roadmap)),
        kidSessionProvider.overrideWith(FakeKidSessionController.new),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const KidHomeScreen(),
      ),
    ),
  );
}

void main() {
  group('KidHomeScreen', () {
    testWidgets('Có truyện hôm nay', (tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final roadmap = MyRoadmapDto(
        open: const MyRoadmapOpenStoryDto(
          storyId: 10,
          title: 'Chú ếch và hoa sen',
          note: 'Đọc cho ngoan nhé',
          isLocked: false,
        ),
        done: const [
          MyRoadmapDoneDto(storyId: 9, title: 'Truyện đã xong'),
        ],
        upcoming: const [
          MyRoadmapUpcomingDto(
            order: 2,
            storyId: 11,
            title: 'Truyện sắp đọc',
            isLocked: false,
          ),
        ],
        completedCount: 1,
        totalCount: 3,
      );

      await pumpHome(tester, roadmap);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Hôm nay em đọc'), findsOneWidget);
      expect(find.text('Chú ếch và hoa sen'), findsWidgets);
      expect(find.text('Đọc ngay'), findsOneWidget);

      final button =
          tester.widget<TtButton>(find.widgetWithText(TtButton, 'Đọc ngay'));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('Bị khoá', (tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      const roadmap = MyRoadmapDto(
        open: MyRoadmapOpenStoryDto(
          storyId: 10,
          title: 'Chú ếch và hoa sen',
          isLocked: true,
        ),
      );

      await pumpHome(tester, roadmap);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(
        find.text('Truyện này chưa mở, em chờ bố mẹ nhé.'),
        findsOneWidget,
      );

      final button =
          tester.widget<TtButton>(find.widgetWithText(TtButton, 'Đọc ngay'));
      expect(button.onPressed, isNull);
    });

    testWidgets('Rỗng', (tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      const roadmap = MyRoadmapDto(
        open: null,
        upcoming: [],
        done: [],
        totalCount: 0,
        isFinished: false,
      );

      await pumpHome(tester, roadmap);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Hôm nay em muốn đọc truyện gì?'), findsOneWidget);
      expect(find.text('Chọn truyện'), findsOneWidget);
    });
  });
}
