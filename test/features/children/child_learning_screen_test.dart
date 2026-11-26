import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_models.dart';
import 'package:ai_storytelling_mobile/features/children/data/child_profile_repository.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/child_learning_screen.dart';
import 'package:ai_storytelling_mobile/models/child_profile_dto.dart';
import 'package:ai_storytelling_mobile/models/learning_profile_dto.dart';
import '../../support/ipad_sizes.dart';

class FakeChildProfileRepository extends Fake
    implements ChildProfileRepository {
  int? lastSavedReadingLevel;
  String? lastSavedReadingMode;
  String? lastSavedComprehensionGoal;
  List<LearningTopicDto>? lastSavedTopics;
  int setLearningCallCount = 0;

  FakeChildProfileRepository();

  @override
  Future<ChildProfileDto> fetchById(int id) async {
    return const ChildProfileDto(
      id: 1,
      nickname: 'Bé An',
      avatarId: 'avatar-cat',
      ageBand: 'Age_6_8',
      status: 'Active',
      ownerUserId: 7,
    );
  }

  @override
  Future<LearningProfileDto> fetchLearning(int id) async {
    return const LearningProfileDto(
      id: 1,
      childProfileId: 1,
      readingLevel: 2,
      readingMode: 'ListenFirst',
      comprehensionGoal: null,
      topics: [],
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
    setLearningCallCount++;
    lastSavedReadingLevel = readingLevel;
    lastSavedReadingMode = readingMode;
    lastSavedComprehensionGoal = comprehensionGoal;
    lastSavedTopics = topics;

    return LearningProfileDto(
      id: 1,
      childProfileId: id,
      readingLevel: readingLevel,
      readingMode: readingMode,
      comprehensionGoal: comprehensionGoal,
      topics: topics,
    );
  }
}

class _FakeAuthController extends AuthController {
  final int userId;

  _FakeAuthController({this.userId = 7});

  @override
  AuthState build() {
    return AuthSignedIn(
      UserProfile(
        id: userId,
        username: 'parent',
        email: 'parent@example.com',
        fullName: 'Phụ huynh Bé An',
        role: 'User',
        status: 'Active',
      ),
    );
  }
}

Future<void> pumpScreen(
  WidgetTester tester, {
  FakeChildProfileRepository? repo,
  int userId = 7,
  int childId = 1,
}) async {
  final repository = repo ?? FakeChildProfileRepository();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        childProfileRepositoryProvider.overrideWithValue(repository),
        authControllerProvider.overrideWith(
          () => _FakeAuthController(userId: userId),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: ChildLearningScreen(childId: childId),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('ChildLearningScreen', () {
    testWidgets('Test A: Ban đầu không tìm thấy nút Lưu', (tester) async {
      await pumpScreen(tester);
      expect(find.widgetWithText(FilledButton, 'Lưu'), findsNothing);
    });

    testWidgets('Test B: Nhấn ô mức đọc số "4" thì nút Lưu hiện',
        (tester) async {
      await pumpScreen(tester);

      await tester.tap(find.text('4'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(FilledButton, 'Lưu'), findsOneWidget);
    });

    testWidgets('Test C: Nhấn Lưu gọi repo.setLearning và ẩn nút Lưu',
        (tester) async {
      final repo = FakeChildProfileRepository();
      await pumpScreen(tester, repo: repo);

      await tester.tap(find.text('4'));
      await tester.pumpAndSettle();

      final saveButton = find.widgetWithText(FilledButton, 'Lưu');
      expect(saveButton, findsOneWidget);

      await tester.tap(saveButton);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 4));

      expect(repo.lastSavedReadingLevel, 4);
      expect(find.widgetWithText(FilledButton, 'Lưu'), findsNothing);
    });

    testWidgets(
        'Test D: User không phải owner thì không có nút Lưu sau khi nhấn ô mức đọc',
        (tester) async {
      final repo = FakeChildProfileRepository();
      await pumpScreen(tester, repo: repo, userId: 99);

      await tester.tap(find.text('4'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(FilledButton, 'Lưu'), findsNothing);
    });

    testWidgets('Test E: Không bị overflow trên màn hình 320x640 và 1024x768',
        (tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(320, 640);
      await pumpScreen(tester);
      expect(tester.takeException(), isNull);

      tester.view.physicalSize = const Size(1024, 768);
      await pumpScreen(tester);
      expect(tester.takeException(), isNull);
    });
  });

  group('iPad không tràn', () {
    for (final entry in kIpadSizes.entries) {
      testWidgets('${entry.key}: không tràn', (tester) async {
        tester.view.physicalSize = entry.value;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await pumpScreen(tester);
        expect(tester.takeException(), isNull);

        if (entry.key.contains('1366')) {
          expect(
            tester.getTopLeft(find.text('Mức đọc')).dy,
            closeTo(
              tester.getTopLeft(
                find.text('Mục tiêu đọc hiểu (không bắt buộc)'),
              ).dy,
              20,
            ),
          );
        }
      });
    }
  });
}
