import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/children/data/child_profile_repository.dart';
import 'package:ai_storytelling_mobile/features/home/data/home_repository.dart';
import 'package:ai_storytelling_mobile/features/learning/data/learning_repository.dart';
import 'package:ai_storytelling_mobile/features/learning/presentation/learning_screen.dart';
import 'package:ai_storytelling_mobile/models/child_profile_dto.dart';
import 'package:ai_storytelling_mobile/models/child_roadmap_dto.dart';
import 'package:ai_storytelling_mobile/models/parent_reading_feedback_dto.dart';
import 'package:ai_storytelling_mobile/models/parent_story_summary_dto.dart';
import 'package:ai_storytelling_mobile/models/story_wish_dto.dart';

class _FakeChildren implements ChildProfileRepository {
  _FakeChildren(this.children);
  final List<ChildProfileDto> children;

  @override
  Future<List<ChildProfileDto>> fetchMine() async => children;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Bé 1 có đủ dữ liệu; bé 2 có dữ liệu khác; bé 4 trống hết.
class _FakeHome implements HomeRepository {
  final calls = <String>[];
  bool failFeedback = false;
  int feedbackTotal = 7;

  @override
  Future<ParentReadingFeedbackPageDto> fetchReadingFeedback(
    int childId, {
    int pageIndex = 1,
    int pageSize = 20,
  }) async {
    calls.add('feedback:$childId:$pageIndex');
    if (failFeedback) {
      throw const ApiException(message: 'Không tải được truyện bé đã đọc.');
    }
    if (childId == 4) return const ParentReadingFeedbackPageDto();
    final start = (pageIndex - 1) * pageSize;
    final count = (feedbackTotal - start).clamp(0, pageSize);
    return ParentReadingFeedbackPageDto(
      items: [
        for (var i = 0; i < count; i++)
          ParentReadingFeedbackItemDto(
            sessionId: start + i + 1,
            storyId: start + i + 1,
            title: 'Đọc xong ${start + i + 1}',
            completedAt: DateTime.utc(2026, 11, 14),
            feeling: 'VeryLike',
            feelingLabel: 'Rất thích',
            quizTotalQuestions: 5,
            quizBestPercent: 80,
          ),
      ],
      totalCount: feedbackTotal,
      pageIndex: pageIndex,
      hasNextPage: start + count < feedbackTotal,
    );
  }

  @override
  Future<ChildRoadmapDto?> fetchRoadmap(int childId) async {
    calls.add('roadmap:$childId');
    if (childId == 4) return null;
    return ChildRoadmapDto(
      childProfileId: childId,
      open: ChildRoadmapItemDto(
        id: 10,
        storyId: 100,
        title: 'Đang đọc của bé $childId',
        status: 'Open',
      ),
      waiting: const [
        ChildRoadmapItemDto(id: 12, storyId: 102, title: 'Chờ B', position: 2, status: 'Waiting'),
        ChildRoadmapItemDto(id: 11, storyId: 101, title: 'Chờ A', position: 1, status: 'Waiting'),
      ],
      history: const [
        ChildRoadmapItemDto(id: 9, storyId: 99, title: 'Đã đọc 1', status: 'Completed'),
        ChildRoadmapItemDto(id: 8, storyId: 98, title: 'Bị bỏ qua', status: 'Skipped', skipReason: 'WrongAge'),
      ],
      completedCount: 2,
      totalCount: 5,
    );
  }
}

class _FakeLearning implements LearningRepository {
  final calls = <String>[];
  final deleted = <int>[];
  final summaries = <ParentStorySummaryItemDto>[
    const ParentStorySummaryItemDto(
      summaryId: 31,
      title: 'Kể lại Sóc Bông',
      recordingUrl: 'https://cdn.example/rec.webm',
      flags: [
        ParentStorySummaryFlagDto(sceneId: 1, sceneIndex: 0, sceneText: 'Sóc leo cây cao'),
      ],
    ),
    const ParentStorySummaryItemDto(summaryId: 32, title: 'Kể lại Rùa'),
    const ParentStorySummaryItemDto(summaryId: 33, title: 'Kể lại Thỏ'),
  ];

  @override
  Future<ParentStorySummaryPageDto> fetchSummaries(
    int childId, {
    int pageIndex = 1,
    int pageSize = 20,
  }) async {
    calls.add('summaries:$childId');
    final items = childId == 1 ? summaries : const <ParentStorySummaryItemDto>[];
    return ParentStorySummaryPageDto(items: items, totalCount: items.length);
  }

  @override
  Future<void> deleteSummary(int childId, int summaryId) async {
    deleted.add(summaryId);
    summaries.removeWhere((s) => s.summaryId == summaryId);
  }

  @override
  Future<List<ParentWish>> fetchWishes(int childId) async {
    calls.add('wishes:$childId');
    if (childId != 1) return const [];
    return [
      ParentWish(
        wishId: 1,
        status: 'Pending',
        cards: const [
          ChildWishCard(id: 1, group: 'Character', label: 'Thỏ con', imageUrl: ''),
        ],
        submittedAt: DateTime.utc(2026, 11, 14),
        expiresAt: DateTime.utc(2030, 1, 1),
      ),
      const ParentWish(
        wishId: 2,
        status: 'Fulfilled',
        cards: [
          ChildWishCard(id: 2, group: 'Place', label: 'Khu rừng', imageUrl: ''),
        ],
      ),
    ];
  }

  @override
  Future<String?> fetchStoryCover(int storyId) async => null;
}

const _an = ChildProfileDto(id: 1, nickname: 'Bé An', avatarId: '1', ageBand: 'Age_6_8', status: 'Active');
const _binh = ChildProfileDto(id: 2, nickname: 'Bé Bình', avatarId: '2', ageBand: 'Age_9_10', status: 'Active');
const _draft = ChildProfileDto(id: 3, nickname: 'Bé Nháp', avatarId: '3', ageBand: 'Age_6_8', status: 'Draft');
const _trong = ChildProfileDto(id: 4, nickname: 'Bé Trống', avatarId: '4', ageBand: 'Age_6_8', status: 'Active');

Future<(_FakeHome, _FakeLearning)> _pump(
  WidgetTester tester, {
  List<ChildProfileDto> children = const [_an, _binh, _draft],
  Size size = const Size(412, 915),
  _FakeHome? home,
  List<int>? handed,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final h = home ?? _FakeHome();
  final learning = _FakeLearning();
  final container = ProviderContainer(
    retry: (_, _) => null,
    overrides: [
      childProfileRepositoryProvider.overrideWithValue(_FakeChildren(children)),
      homeRepositoryProvider.overrideWithValue(h),
      learningRepositoryProvider.overrideWithValue(learning),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
        theme: AppTheme.light(),
        routerConfig: GoRouter(
          initialLocation: '/learning',
          routes: [
            GoRoute(
              path: '/learning',
              builder: (_, _) => LearningScreen(
                handover: (_, _, child) async => handed?.add(child.id),
              ),
            ),
            GoRoute(
              path: '/kids',
              builder: (_, _) => Scaffold(
                appBar: AppBar(leading: const BackButton()),
                body: const Text('MANAGE'),
              ),
              routes: [
                GoRoute(
                  path: 'new',
                  builder: (_, _) => const Scaffold(body: Text('NEW_CHILD')),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return (h, learning);
}

Future<void> _openTab(WidgetTester tester, String label) async {
  // Thanh tab cuộn ngang: kéo tab vào màn hình trước khi bấm.
  final tab = find.descendant(of: find.byType(TabBar), matching: find.text(label));
  await tester.ensureVisible(tab);
  await tester.pumpAndSettle();
  await tester.tap(tab);
  await tester.pumpAndSettle();
}

void main() {
  navigationTests();
  testWidgets('4 tab hiện; Tổng quan đúng số liệu; bé Nháp không hiện', (tester) async {
    await _pump(tester);

    for (final t in ['Tổng quan', 'Lộ trình', 'Kết quả đọc', 'Điều ước']) {
      expect(find.descendant(of: find.byType(TabBar), matching: find.text(t)), findsOneWidget);
    }
    expect(find.text('Bé Nháp'), findsNothing);

    expect(find.text('2/5'), findsWidgets); // ô Lộ trình + thanh tiến độ
    expect(find.text('7'), findsOneWidget); // Đã đọc xong
    expect(find.text('3'), findsOneWidget); // Bé kể lại
    expect(find.text('Điều ước chờ'), findsOneWidget);
    expect(find.text('Đang đọc của bé 1'), findsOneWidget);
    // Truyện tiếp theo theo position.
    final a = tester.getTopLeft(find.text('Chờ A')).dy;
    final b = tester.getTopLeft(find.text('Chờ B')).dy;
    expect(a, lessThan(b));
    expect(find.text('Đọc xong 1'), findsOneWidget);
    expect(find.text('⭐ Câu đố 80%'), findsWidgets);
  });

  testWidgets('Lộ trình chỉ xem: các nhóm và bỏ qua thu gọn', (tester) async {
    await _pump(tester);
    await _openTab(tester, 'Lộ trình');

    expect(find.text('Tiếp theo'), findsOneWidget);
    expect(find.text('Đã đọc 1'), findsOneWidget);
    expect(find.text('Đã gỡ hoặc bỏ qua'), findsOneWidget);
    expect(find.text('Bị bỏ qua'), findsNothing);
    await tester.tap(find.text('Xem danh sách'));
    await tester.pumpAndSettle();
    expect(find.text('Bị bỏ qua'), findsOneWidget);
    expect(find.text('Không hợp tuổi'), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline_rounded), findsNothing);
  });

  testWidgets('Bấm ô "Bé kể lại" mở Kết quả đọc; xoá có popup và gọi DELETE', (tester) async {
    final (_, learning) = await _pump(tester);

    await tester.tap(find.text('Bé kể lại').first);
    await tester.pumpAndSettle();
    expect(find.text('Kể lại Sóc Bông'), findsOneWidget);
    expect(find.text('Sóc leo cây cao'), findsOneWidget);
    expect(find.byTooltip('Nghe bé kể lại'), findsOneWidget);

    await tester.tap(find.byTooltip('Xoá phần kể lại').first);
    await tester.pumpAndSettle();
    expect(find.text('Xoá phần kể lại?'), findsOneWidget);

    // Huỷ thì không xoá.
    await tester.tap(find.text('Huỷ'));
    await tester.pumpAndSettle();
    expect(learning.deleted, isEmpty);

    await tester.tap(find.byTooltip('Xoá phần kể lại').first);
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byType(Dialog), matching: find.text('Xoá')));
    await tester.pumpAndSettle();

    expect(learning.deleted, [31]);
    expect(find.text('Đã xoá phần kể lại.'), findsOneWidget);
    expect(find.text('Kể lại Sóc Bông'), findsNothing);
    expect(learning.calls.where((c) => c == 'summaries:1'), hasLength(2));
  });

  testWidgets('Kết quả đọc mở câu bé trả lời; tải thêm khi cuộn', (tester) async {
    final home = _FakeHome()..feedbackTotal = 25;
    await _pump(tester, home: home);
    await _openTab(tester, 'Kết quả đọc');

    expect(find.text('Đọc xong 1'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Đọc xong 25'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();
    expect(home.calls, contains('feedback:1:2'));
    expect(find.text('Đọc xong 25'), findsOneWidget);
  });

  testWidgets('Điều ước hiện danh sách, chỉ điều ước chờ có nút mở web', (tester) async {
    await _pump(tester);
    await _openTab(tester, 'Điều ước');

    expect(find.text('Nhân vật: Thỏ con'), findsOneWidget);
    expect(find.text('Nơi chốn: Khu rừng'), findsOneWidget);
    expect(find.text('Đang chờ'), findsOneWidget);
    expect(find.text('Đã có truyện'), findsOneWidget);
    expect(find.byTooltip('Xử lý trên web'), findsOneWidget);
  });

  testWidgets('Bé không có dữ liệu: các tab hiện trạng thái rỗng', (tester) async {
    await _pump(tester, children: const [_trong]);

    expect(find.text('Lộ trình đang trống'), findsOneWidget);
    expect(find.text('Bé Trống chưa đọc xong truyện nào'), findsOneWidget);
    await _openTab(tester, 'Lộ trình');
    expect(find.text('Lộ trình đang trống'), findsOneWidget);
    await _openTab(tester, 'Kết quả đọc');
    expect(find.text('Bé Trống chưa đọc xong truyện nào'), findsOneWidget);
    await tester.tap(find.text('Bé kể lại'));
    await tester.pumpAndSettle();
    expect(find.text('Chưa có phần kể lại nào'), findsOneWidget);
    await _openTab(tester, 'Điều ước');
    expect(find.text('Bé Trống chưa gửi điều ước nào'), findsOneWidget);
  });

  testWidgets('Không có bé đang hoạt động', (tester) async {
    await _pump(tester, children: const [_draft]);
    expect(find.text('Chưa có bé nào đang hoạt động'), findsOneWidget);
    expect(find.byType(TabBar), findsNothing);
  });

  testWidgets('Lỗi tải → trạng thái lỗi, Thử lại thì tải lại được', (tester) async {
    final home = _FakeHome()..failFeedback = true;
    await _pump(tester, home: home);
    await _openTab(tester, 'Kết quả đọc');

    expect(find.text('Chưa tải được truyện bé đã đọc'), findsOneWidget);
    expect(find.text('Không tải được truyện bé đã đọc.'), findsOneWidget);

    home.failFeedback = false;
    await tester.tap(find.text('Thử lại'));
    await tester.pumpAndSettle();
    expect(find.text('Đọc xong 1'), findsOneWidget);
  });

  testWidgets('Đổi bé thì dữ liệu đổi; chuyển tab đi/về không gọi lại API', (tester) async {
    final (home, learning) = await _pump(tester);
    final before = [...home.calls, ...learning.calls];
    expect(before.where((c) => c.endsWith(':1') || c.contains(':1:')), isNotEmpty);

    for (final t in ['Lộ trình', 'Kết quả đọc', 'Điều ước', 'Tổng quan']) {
      await _openTab(tester, t);
    }
    expect([...home.calls, ...learning.calls], before);

    await tester.tap(find.text('Bé Bình'));
    await tester.pumpAndSettle();
    expect(find.text('Đang đọc của bé 2'), findsOneWidget);
    expect(find.text('Đang đọc của bé 1'), findsNothing);
    expect(home.calls, containsAll(['roadmap:2', 'feedback:2:1']));
    expect(learning.calls, containsAll(['summaries:2', 'wishes:2']));
  });

  for (final size in const [Size(320, 640), Size(360, 740), Size(390, 844), Size(1024, 768)]) {
    testWidgets('Không tràn ở ${size.width.toInt()}x${size.height.toInt()}', (tester) async {
      await _pump(tester, size: size);
      expect(tester.takeException(), isNull);
      for (final t in ['Lộ trình', 'Kết quả đọc', 'Điều ước', 'Tổng quan']) {
        await _openTab(tester, t);
        expect(tester.takeException(), isNull, reason: 'tab $t');
      }
      await _openTab(tester, 'Kết quả đọc');
      await tester.tap(find.text('Bé kể lại'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}

void navigationTests() {
  testWidgets('Vào học: giao máy cho đúng bé đang chọn', (tester) async {
    final handed = <int>[];
    await _pump(tester, handed: handed);

    await tester.tap(find.bySemanticsLabel('Cho Bé An vào học'));
    await tester.pumpAndSettle();
    expect(handed, [1]);

    await tester.tap(find.text('Bé Bình'));
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('Cho Bé Bình vào học'));
    await tester.pumpAndSettle();
    expect(handed, [1, 2]);
  });

  testWidgets('⚙ mở Quản lý bé, Back quay về Học tập', (tester) async {
    await _pump(tester);
    await tester.tap(find.bySemanticsLabel('Quản lý bé'));
    await tester.pumpAndSettle();
    expect(find.text('MANAGE'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(TabBar), findsOneWidget);
  });

  testWidgets('Không có bé đang hoạt động: nút Quản lý bé / Thêm bé', (
    tester,
  ) async {
    await _pump(tester, children: const [_draft]);
    await tester.tap(find.text('Thêm bé'));
    await tester.pumpAndSettle();
    expect(find.text('NEW_CHILD'), findsOneWidget);
  });
}
