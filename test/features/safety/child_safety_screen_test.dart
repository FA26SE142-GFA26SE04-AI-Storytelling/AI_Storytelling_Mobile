import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_models.dart';
import 'package:ai_storytelling_mobile/features/children/data/child_profile_repository.dart';
import 'package:ai_storytelling_mobile/features/safety/presentation/child_safety_screen.dart';
import 'package:ai_storytelling_mobile/models/child_profile_dto.dart';
import 'package:ai_storytelling_mobile/models/content_category_dto.dart';
import 'package:ai_storytelling_mobile/models/safety_policy_dto.dart';

class _FakeChildProfileRepository extends Fake
    implements ChildProfileRepository {
  final Object? safetyError;
  final List<Map<String, dynamic>> recordedBodies = [];

  _FakeChildProfileRepository({this.safetyError});

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
  Future<SafetyPolicyDto> fetchSafety(int id) async {
    if (safetyError != null) {
      throw safetyError!;
    }
    return const SafetyPolicyDto(
      childProfileId: 1,
      maxStoryLength: 1200,
      requiredApprovalMode: 'AlwaysManual',
      parentalGateEnabled: true,
      storyWishesEnabled: false,
      allowInteractiveStories: false,
      voiceAnswersEnabled: false,
      consentRecorded: true,
      categories: [],
    );
  }

  @override
  Future<List<ContentCategoryDto>> fetchContentCategories() async {
    return const [
      ContentCategoryDto(
        id: 3,
        code: 'horror',
        displayName: 'Kinh dị',
        isActive: true,
      ),
    ];
  }

  @override
  Future<void> setSafety(int id, Map<String, dynamic> body) async {
    recordedBodies.add(body);
  }

  @override
  Future<void> reconsent(int id) async {}
}

class _FakeAuthController extends AuthController {
  final UserProfile _user;

  _FakeAuthController(this._user);

  @override
  AuthState build() {
    return AuthSignedIn(_user);
  }
}

Future<void> _pumpChildSafetyScreen(
  WidgetTester tester, {
  required ChildProfileRepository repo,
  int currentUserId = 7,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        childProfileRepositoryProvider.overrideWithValue(repo),
        authControllerProvider.overrideWith(
          () => _FakeAuthController(
            UserProfile(
              id: currentUserId,
              username: 'parent',
              email: 'parent@example.com',
              fullName: 'Parent User',
              role: 'User',
              status: 'Active',
            ),
          ),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const ChildSafetyScreen(childId: 1),
      ),
    ),
  );
}

void main() {
  group('ChildSafetyScreen', () {
    testWidgets('Test A: Bật công tắc giữ giá trị cũ', (tester) async {
      final repo = _FakeChildProfileRepository();

      await _pumpChildSafetyScreen(tester, repo: repo);
      await tester.pumpAndSettle();

      final switchFinder =
          find.widgetWithText(SwitchListTile, 'Bé gửi điều ước');
      expect(switchFinder, findsOneWidget);

      await tester.ensureVisible(switchFinder);
      await tester.tap(switchFinder);
      await tester.pump();
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      expect(repo.recordedBodies.length, 1);
      final body = repo.recordedBodies.first;
      expect(body['storyWishesEnabled'], isTrue);
      expect(body['maxStoryLength'], 1200);
      expect(body['requiredApprovalMode'], 'AlwaysManual');
    });

    testWidgets('Test B: 404 hiện trạng thái chưa có cài đặt an toàn',
        (tester) async {
      final repo = _FakeChildProfileRepository(
        safetyError: const ApiException(
          statusCode: 404,
          message: 'not found',
        ),
      );

      await _pumpChildSafetyScreen(tester, repo: repo);
      await tester.pumpAndSettle();

      expect(find.text('Chưa có cài đặt an toàn'), findsOneWidget);
      expect(find.text('Tạo cài đặt an toàn'), findsOneWidget);
    });

    testWidgets('Test C: Layout 320x640 và 1024x768 không lỗi overflow',
        (tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      for (final size in const [Size(320, 640), Size(1024, 768)]) {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;

        final repo = _FakeChildProfileRepository();
        await _pumpChildSafetyScreen(tester, repo: repo);
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      }
    });
  });
}
