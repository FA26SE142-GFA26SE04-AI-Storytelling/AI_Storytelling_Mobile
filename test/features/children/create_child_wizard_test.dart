import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/children/data/child_profile_repository.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/children_providers.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/create_child_wizard_screen.dart';
import 'package:ai_storytelling_mobile/models/child_profile_dto.dart';
import 'package:ai_storytelling_mobile/models/content_category_dto.dart';
import 'package:ai_storytelling_mobile/models/learning_profile_dto.dart';

class _FakeRepo extends Fake implements ChildProfileRepository {
  final calls = <String>[];
  Map<String, dynamic>? safetyBody;
  int learningFailures = 0;

  @override
  Future<List<ContentCategoryDto>> fetchContentCategories() async => const [
    ContentCategoryDto(
      id: 1,
      code: 'violence',
      displayName: 'Bạo lực',
      isActive: true,
    ),
    ContentCategoryDto(
      id: 2,
      code: 'animals',
      displayName: 'Động vật',
      isActive: true,
    ),
  ];

  @override
  Future<List<ChildProfileDto>> fetchMine() async => const [];

  @override
  Future<ChildProfileDto> create({
    required String nickname,
    required String ageBand,
    String language = 'vi',
  }) async {
    calls.add('create');
    return ChildProfileDto(
      id: 42,
      nickname: nickname,
      avatarId: 'avatar-default',
      ageBand: ageBand,
      status: 'Draft',
    );
  }

  @override
  Future<LearningProfileDto> setLearning(
    int id, {
    required int readingLevel,
    String? readingMode,
    String? comprehensionGoal,
    required List<LearningTopicDto> topics,
  }) async {
    calls.add('setLearning');
    if (learningFailures > 0) {
      learningFailures--;
      throw const ApiException(statusCode: 500, message: 'Hệ thống đang bận.');
    }
    return LearningProfileDto(
      id: 1,
      childProfileId: id,
      readingLevel: readingLevel,
    );
  }

  @override
  Future<void> setSafety(int id, Map<String, dynamic> body) async {
    calls.add('setSafety');
    safetyBody = body;
  }

  @override
  Future<void> activate(int id) async => calls.add('activate');
}

late ProviderContainer _container;

Future<void> _pump(WidgetTester tester, _FakeRepo repo) async {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, _) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () => context.push('/kids/new'),
              child: const Text('Mở wizard'),
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/kids/new',
        builder: (_, _) => const CreateChildWizardScreen(),
      ),
    ],
  );
  _container = ProviderContainer(
    overrides: [childProfileRepositoryProvider.overrideWithValue(repo)],
  );
  addTearDown(_container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: _container,
      child: MaterialApp.router(theme: AppTheme.light(), routerConfig: router),
    ),
  );
  await tester.tap(find.text('Mở wizard'));
  await tester.pumpAndSettle();
}

Future<void> _tapButton(WidgetTester tester, String label) async {
  final f = find.text(label).hitTestable();
  await tester.tap(f);
  await tester.pumpAndSettle();
}

/// Đi từ bước 1 tới bước Xác nhận; [consent] = tick ô đồng ý ở bước An toàn.
Future<void> _goToSummary(WidgetTester tester, {required bool consent}) async {
  await tester.enterText(find.byType(TextFormField), 'Bé Na');
  await _tapButton(tester, 'Tiếp');
  await _tapButton(tester, 'Tiếp');
  if (consent) {
    final box = find.byType(CheckboxListTile);
    await tester.ensureVisible(box);
    await tester.pumpAndSettle();
    await tester.tap(box);
    await tester.pumpAndSettle();
  }
  await _tapButton(tester, 'Tiếp');
  expect(find.text('Xác nhận'), findsOneWidget);
}

void main() {
  testWidgets(
    'Đủ 4 bước có đồng ý: create → setLearning → setSafety → activate',
    (tester) async {
      final repo = _FakeRepo();
      await _pump(tester, repo);
      await _goToSummary(tester, consent: true);
      await _tapButton(tester, 'Tạo hồ sơ');

      expect(repo.calls, ['create', 'setLearning', 'setSafety', 'activate']);
      final body = repo.safetyBody!;
      expect(body['maxStoryLength'], 900);
      expect(body['requiredApprovalMode'], 'AlwaysManual');
      expect(body['parentalGateEnabled'], true);
      expect(body['consentRecorded'], true);
      expect(body['storyWishesEnabled'], true);
      expect(body['allowInteractiveStories'], true);
      expect(body['applyAgePreset'], false);
      expect(body['categories'], [
        {'contentCategoryId': 1, 'rule': 'Blocked'},
      ]);
      expect(_container.read(selectedChildIdProvider), 42);
      expect(find.text('Mở wizard'), findsOneWidget);
    },
  );

  testWidgets('Không tick đồng ý thì không gọi setSafety/activate', (
    tester,
  ) async {
    final repo = _FakeRepo();
    await _pump(tester, repo);
    await _goToSummary(tester, consent: false);
    await _tapButton(tester, 'Tạo hồ sơ');

    expect(repo.calls, ['create', 'setLearning']);
    expect(find.text('Mở wizard'), findsOneWidget);
  });

  testWidgets('Lỗi setLearning rồi bấm lại không tạo trùng hồ sơ', (
    tester,
  ) async {
    final repo = _FakeRepo()..learningFailures = 1;
    await _pump(tester, repo);
    await _goToSummary(tester, consent: false);
    await _tapButton(tester, 'Tạo hồ sơ');
    expect(repo.calls, ['create', 'setLearning']);
    expect(find.text('Xác nhận'), findsOneWidget);

    // Đợi toast lỗi tự ẩn (nó nằm đè lên thanh nút đáy).
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    await _tapButton(tester, 'Tạo hồ sơ');
    expect(repo.calls, ['create', 'setLearning', 'setLearning']);
    expect(find.text('Mở wizard'), findsOneWidget);
  });

  testWidgets('Chưa nhập biệt danh thì không qua bước 1', (tester) async {
    final repo = _FakeRepo();
    await _pump(tester, repo);
    await _tapButton(tester, 'Tiếp');
    expect(find.text('Hãy nhập biệt danh của bé.'), findsOneWidget);
    expect(find.text('Thông tin bé'), findsOneWidget);
  });

  testWidgets('Đóng khi đã nhập thì hỏi xác nhận', (tester) async {
    final repo = _FakeRepo();
    await _pump(tester, repo);
    await tester.enterText(find.byType(TextFormField), 'Bé Na');
    await tester.tap(find.byTooltip('Đóng'));
    await tester.pumpAndSettle();
    expect(find.text('Bỏ hồ sơ đang tạo?'), findsOneWidget);
    await _tapButton(tester, 'Bỏ');
    expect(find.text('Mở wizard'), findsOneWidget);
    expect(repo.calls, isEmpty);
  });

  for (final size in const [Size(320, 640), Size(1024, 768)]) {
    testWidgets('Không tràn ở ${size.width.toInt()}×${size.height.toInt()}', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final repo = _FakeRepo();
      await _pump(tester, repo);
      await _goToSummary(tester, consent: true);
      expect(tester.takeException(), isNull);
    });
  }
}
