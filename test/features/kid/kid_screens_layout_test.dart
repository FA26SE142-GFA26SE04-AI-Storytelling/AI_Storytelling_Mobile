import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_reading_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_rewards_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_wish_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/quiz/kid_after_reading_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/rewards/kid_notebook_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/rewards/kid_rewards_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/wish/kid_wish_screen.dart';
import 'package:ai_storytelling_mobile/models/child_reading_dto.dart';
import 'package:ai_storytelling_mobile/models/child_rewards_dto.dart';
import 'package:ai_storytelling_mobile/models/story_wish_dto.dart';

// Bố cục các màn mới của bé ở điện thoại nhỏ và máy tính bảng nằm ngang:
// Flutter báo lỗi khi chữ/khung tràn, nên test đạt nghĩa là không tràn.

const _longName = 'Huy hiệu đọc truyện chăm chỉ suốt cả tuần liền';

class _Rewards implements KidRewardsRepository {
  @override
  Future<ChildRewards> rewards() async => ChildRewards(
    expTotal: 168,
    streakDays: 12,
    knowledgeTree: const KnowledgeTree(
      stage: 'SAPLING',
      stageName: 'Cây non',
      currentTreeExp: 60,
      nextStageAt: 100,
      expToWater: 10,
    ),
    badges: [
      for (var i = 0; i < 7; i++)
        RewardBadge(
          code: 'B$i',
          name: i.isEven ? _longName : 'Mọt sách',
          description: 'Mô tả',
          earned: i < 3,
        ),
    ],
  );

  @override
  Future<List<NotebookEntry>> notebook() async => [
    const NotebookEntry(
      entryId: 1,
      vocabularyId: 1,
      term: 'thông minh tuyệt vời ơi là tuyệt vời',
      definition: 'Có khả năng suy nghĩ nhanh và chính xác trong mọi việc',
      storyId: 1,
      storyTitle: 'Chú Thỏ Thông Minh và cuộc phiêu lưu trong rừng sâu',
      collectedAt: '2026-11-14T08:00:00Z',
    ),
  ];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Wishes implements KidWishRepository {
  @override
  Future<List<StoryWish>> wishes() async => [
    const StoryWish(
      wishId: 1,
      kind: 'Cards',
      status: 'Pending',
      message: 'Bố mẹ đang xem điều ước của em, em chờ một chút nhé!',
      lessonLeftToParent: false,
      cards: [
        ChildWishCard(
          id: 1,
          group: 'Character',
          label: 'Cô bé phi hành gia',
          imageUrl: '',
        ),
      ],
    ),
  ];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Reading implements KidReadingRepository {
  @override
  Future<ChildQuiz> quiz(String sessionId) async => const ChildQuiz(
    sessionId: 1,
    totalQuestions: 1,
    questions: [
      ChildQuizItem(
        quizItemId: 1,
        question: 'Sóc Bông có đặc điểm ngoại hình nào được nhắc đến ở đầu câu chuyện?',
        choices: ['Đôi mắt tròn xoe và chiếc đuôi ngắn', 'Đôi tai dài'],
      ),
    ],
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<void> _pump(WidgetTester tester, Size size, Widget screen) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        kidRewardsRepositoryProvider.overrideWithValue(_Rewards()),
        kidWishRepositoryProvider.overrideWithValue(_Wishes()),
        kidReadingRepositoryProvider.overrideWithValue(_Reading()),
      ],
      child: MaterialApp(theme: AppTheme.light(), home: screen),
    ),
  );
  // Chờ dữ liệu giả và animation vào màn (không dùng pumpAndSettle vì có animation lặp).
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
}

void main() {
  const sizes = {
    'điện thoại nhỏ': Size(360, 640),
    'tablet ngang': Size(1024, 768),
  };
  final screens = <String, Widget Function()>{
    'Phần thưởng': () => const KidRewardsScreen(),
    'Sổ tay': () => const KidNotebookScreen(),
    'Điều ước': () => const KidWishScreen(),
    'Sau khi đọc': () => const KidAfterReadingScreen(
      sessionId: 1,
      result: ReadingCompleted(
        sessionId: 1,
        storyId: 1,
        expGained: 12,
        roadmapStepCompleted: true,
        newBadges: ['B0'],
      ),
      scenes: [],
    ),
  };

  for (final size in sizes.entries) {
    for (final screen in screens.entries) {
      testWidgets('${screen.key} không tràn ở ${size.key}', (tester) async {
        await _pump(tester, size.value, screen.value());
        // Lỗi tràn (nếu có) được framework tự báo kèm widget gây lỗi khi test kết thúc.
      });
    }
  }
}
