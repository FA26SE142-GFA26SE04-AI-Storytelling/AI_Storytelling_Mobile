import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_models.dart';
import 'package:ai_storytelling_mobile/features/children/data/child_profile_repository.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/children_providers.dart';
import 'package:ai_storytelling_mobile/features/home/data/home_repository.dart';
import 'package:ai_storytelling_mobile/features/home/presentation/home_screen.dart';
import 'package:ai_storytelling_mobile/models/child_profile_dto.dart';
import 'package:ai_storytelling_mobile/models/child_roadmap_dto.dart';
import 'package:ai_storytelling_mobile/models/parent_reading_feedback_dto.dart';

class _FakeChildren implements ChildProfileRepository {
  _FakeChildren(this.children);
  final List<ChildProfileDto> children;

  @override
  Future<List<ChildProfileDto>> fetchMine() async => children;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHome implements HomeRepository {
  /// Bé nào nằm trong đây thì tải lỗi.
  final Set<int> failing = {2};

  @override
  Future<ParentReadingFeedbackPageDto> fetchReadingFeedback(
    int childId, {
    int pageIndex = 1,
    int pageSize = 20,
  }) async {
    if (failing.contains(childId)) {
      throw const ApiException(message: 'Không tải được dữ liệu của bé.');
    }
    final now = DateTime.now();
    ParentReadingFeedbackItemDto item(int id, DateTime at, {String? feeling, double? quiz}) =>
        ParentReadingFeedbackItemDto(
          sessionId: id,
          storyId: id,
          title: 'Truyện $id',
          completedAt: at.toUtc(),
          feelingLabel: feeling,
          quizBestPercent: quiz,
        );
    return ParentReadingFeedbackPageDto(
      items: childId == 1
          ? [
              item(13, now, feeling: 'Rất thích', quiz: 80),
              item(12, now),
              item(11, now.subtract(const Duration(days: 1))),
            ]
          : [item(21, now.subtract(const Duration(days: 2)))],
    );
  }

  @override
  Future<ChildRoadmapDto?> fetchRoadmap(int childId) async => ChildRoadmapDto(
        childProfileId: childId,
        open: ChildRoadmapItemDto(
          id: 1,
          storyId: 99,
          title: 'Truyện tiếp $childId',
          status: 'Open',
        ),
      );
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

const _an = ChildProfileDto(
  id: 1,
  nickname: 'Bé An',
  avatarId: '1',
  ageBand: 'Age_6_8',
  status: 'Active',
);
const _binh = ChildProfileDto(
  id: 2,
  nickname: 'Bé Bình',
  avatarId: '2',
  ageBand: 'Age_9_10',
  status: 'Active',
);
const _draft = ChildProfileDto(
  id: 3,
  nickname: 'Bé Nháp',
  avatarId: '3',
  ageBand: 'Age_6_8',
  status: 'Draft',
);

Future<(ProviderContainer, _FakeHome)> _pump(
  WidgetTester tester, {
  List<ChildProfileDto> children = const [_an, _binh, _draft],
  Size? size,
}) async {
  if (size != null) {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }
  final home = _FakeHome();
  final container = ProviderContainer(
    // Tắt tự thử lại của Riverpod để lỗi hiện ngay, không để timer treo.
    retry: (_, _) => null,
    overrides: [
      childProfileRepositoryProvider.overrideWithValue(_FakeChildren(children)),
      homeRepositoryProvider.overrideWithValue(home),
      authControllerProvider.overrideWith(_SignedIn.new),
    ],
  );
  addTearDown(container.dispose);

  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
      GoRoute(
        path: '/kids',
        builder: (_, _) => const Scaffold(body: Text('KIDS_TAB')),
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
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
  return (container, home);
}

void main() {
  testWidgets('2 bé Active: đúng "N hôm nay", gần nhất, tiếp theo; bé Nháp không hiện',
      (tester) async {
    await _pump(tester);

    expect(find.textContaining('Nguyễn Văn A'), findsOneWidget);
    expect(find.text('Bé An'), findsOneWidget);
    expect(find.text('Bé Bình'), findsOneWidget);
    expect(find.text('Bé Nháp'), findsNothing);

    expect(find.text('📖 2 hôm nay'), findsOneWidget);
    expect(find.textContaining('Truyện 13'), findsOneWidget);
    expect(find.text('Rất thích'), findsOneWidget);
    expect(find.text('Quiz 80%'), findsOneWidget);
    expect(find.textContaining('Truyện tiếp 1'), findsOneWidget);
    expect(find.text('Cho bé đọc'), findsNWidgets(2));
  });

  testWidgets('lỗi của một bé chỉ hiện trong thẻ đó, thử lại thì tải được',
      (tester) async {
    final (_, home) = await _pump(tester);

    // Bé An vẫn đủ dữ liệu, Bé Bình hiện lỗi trong thẻ.
    expect(find.text('📖 2 hôm nay'), findsOneWidget);
    expect(find.text('Không tải được dữ liệu của bé.'), findsOneWidget);
    expect(find.text('Cho bé đọc'), findsNWidgets(2));

    home.failing.clear();
    await tester.tap(find.byTooltip('Thử lại'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Không tải được dữ liệu của bé.'), findsNothing);
    expect(find.text('📖 0 hôm nay'), findsOneWidget);
    expect(find.textContaining('Truyện tiếp 2'), findsOneWidget);
  });

  testWidgets('chạm thẻ: chọn bé đó và chuyển sang tab Bé', (tester) async {
    final (container, _) = await _pump(tester);

    await tester.tap(find.text('Bé Bình'));
    await tester.pumpAndSettle();

    expect(container.read(selectedChildIdProvider), 2);
    expect(find.text('KIDS_TAB'), findsOneWidget);
  });

  testWidgets('không có bé Active: trạng thái rỗng và nút Mở tab Bé',
      (tester) async {
    await _pump(tester, children: const [_draft]);

    expect(find.text('Chưa có bé nào sẵn sàng đọc'), findsOneWidget);
    await tester.tap(find.text('Mở tab Bé'));
    await tester.pumpAndSettle();
    expect(find.text('KIDS_TAB'), findsOneWidget);
  });

  test('greeting theo giờ', () {
    expect(HomeScreen.greeting(DateTime(2026, 1, 1, 8)), 'Chào buổi sáng');
    expect(HomeScreen.greeting(DateTime(2026, 1, 1, 14)), 'Chào buổi chiều');
    expect(HomeScreen.greeting(DateTime(2026, 1, 1, 20)), 'Chào buổi tối');
  });

  group('không tràn', () {
    for (final size in const [Size(320, 640), Size(390, 844), Size(1024, 768)]) {
      testWidgets('${size.width.toInt()}×${size.height.toInt()}', (tester) async {
        await _pump(tester, size: size);
        expect(tester.takeException(), isNull);
      });
    }
  });
}
