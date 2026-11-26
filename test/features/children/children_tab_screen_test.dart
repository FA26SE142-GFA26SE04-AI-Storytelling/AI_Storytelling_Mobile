import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';

import '../../support/ipad_sizes.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/access/data/child_access_repository.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/children/data/archived_children_store.dart';
import 'package:ai_storytelling_mobile/features/children/data/child_profile_repository.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/child_tab_widgets.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/children_providers.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/children_tab_screen.dart';
import 'package:ai_storytelling_mobile/models/child_access_credential_dto.dart';
import 'package:ai_storytelling_mobile/models/child_profile_dto.dart';
import 'package:ai_storytelling_mobile/models/learning_profile_dto.dart';
import 'package:ai_storytelling_mobile/models/safety_policy_dto.dart';

// ─── Fake Repositories & Controllers ────────────────────────────────────────

class FakeChildProfileRepository implements ChildProfileRepository {
  @override
  Future<List<ChildProfileDto>> fetchMine() async => const [
        ChildProfileDto(
          id: 1,
          nickname: 'Bé An',
          avatarId: '1',
          ageBand: 'Age_6_8',
          status: 'Active',
        ),
        ChildProfileDto(
          id: 2,
          nickname: 'Bé Bình',
          avatarId: '2',
          ageBand: 'Age_9_10',
          status: 'Active',
        ),
      ];

  @override
  Future<LearningProfileDto> fetchLearning(int id) async => LearningProfileDto(
        id: id,
        childProfileId: id,
        readingLevel: 1,
      );

  @override
  Future<SafetyPolicyDto> fetchSafety(int id) async => SafetyPolicyDto(
        childProfileId: id,
        parentalGateEnabled: true,
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeChildAccessRepository implements ChildAccessRepository {
  @override
  Future<ChildAccessCredentialDto> fetchCredential(int id) async =>
      ChildAccessCredentialDto(
        childProfileId: id,
        hasEasyLogin: false,
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeArchivedChildrenStore implements ArchivedChildrenStore {
  @override
  Future<List<ArchivedChild>> load() async => const <ArchivedChild>[];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeAuthController extends AuthController {
  @override
  AuthState build() => const AuthSignedOut();
}

// ─── Helper pump function ───────────────────────────────────────────────────

Future<ProviderContainer> pumpChildrenTab(
  WidgetTester tester, {
  Size? size,
  List<Override> additionalOverrides = const [],
}) async {
  if (size != null) {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  final container = ProviderContainer(
    overrides: [
      childProfileRepositoryProvider.overrideWithValue(
        FakeChildProfileRepository(),
      ),
      childAccessRepositoryProvider.overrideWithValue(
        FakeChildAccessRepository(),
      ),
      archivedChildrenStoreProvider.overrideWithValue(
        FakeArchivedChildrenStore(),
      ),
      archivedChildrenProvider.overrideWith(
        (ref) async => const <ArchivedChild>[],
      ),
      childOverviewProvider.overrideWith(
        (ref, id) async => ChildOverview(
          learning: LearningProfileDto(
            id: id,
            childProfileId: id,
            readingLevel: 1,
          ),
          safety: SafetyPolicyDto(
            childProfileId: id,
            parentalGateEnabled: true,
          ),
          access: ChildAccessCredentialDto(
            childProfileId: id,
            hasEasyLogin: false,
          ),
        ),
      ),
      authControllerProvider.overrideWith(FakeAuthController.new),
      ...additionalOverrides,
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const ChildrenTabScreen(),
      ),
    ),
  );

  // Chờ dữ liệu hoàn tất và hiệu ứng animation flutter_animate chạy xong
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));

  return container;
}

// ─── Tests ───────────────────────────────────────────────────────────────────

void main() {
  testWidgets(
    'Test 1: hiện hàng avatar với 2 tên Bé An và Bé Bình, thẻ chính của bé đang chọn, và 4 thẻ nhóm',
    (tester) async {
      await pumpChildrenTab(tester);

      // 1. Kiểm tra hàng avatar: có cả Bé An và Bé Bình
      expect(find.byKey(const ValueKey('child-1')), findsOneWidget);
      expect(find.byKey(const ValueKey('child-2')), findsOneWidget);
      expect(find.text('Bé Bình'), findsOneWidget);

      // Bé An đang được chọn mặc định nên xuất hiện ở cả avatar strip và thẻ chính
      expect(find.text('Bé An'), findsNWidgets(2));

      // 2. Thẻ chính của bé đang chọn (PrimaryChildCard)
      expect(find.byType(PrimaryChildCard), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(PrimaryChildCard),
          matching: find.text('Bé An'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(PrimaryChildCard),
          matching: find.text('Cho bé đọc'),
        ),
        findsOneWidget,
      );

      // 3. Bốn thẻ nhóm: 'Hồ sơ', 'Học tập', 'An toàn', 'Mã QR'
      expect(find.text('Hồ sơ'), findsOneWidget);
      expect(find.text('Học tập'), findsOneWidget);
      expect(find.text('An toàn'), findsOneWidget);
      expect(find.text('Mã QR'), findsOneWidget);
    },
  );

  testWidgets(
    'Test 2: chạm avatar Bé Bình -> bé được chọn đổi sang Bé Bình',
    (tester) async {
      final container = await pumpChildrenTab(tester);

      // Ban đầu bé được chọn mặc định là Bé An
      expect(
        find.descendant(
          of: find.byType(PrimaryChildCard),
          matching: find.text('Bé An'),
        ),
        findsOneWidget,
      );

      // Chạm vào avatar Bé Bình
      await tester.tap(find.byKey(const ValueKey('child-2')));

      // Pump để kích hoạt notifyListeners và cập nhật giao diện
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Kiểm tra selectedChildIdProvider đổi thành 2 (id của Bé Bình)
      expect(container.read(selectedChildIdProvider), equals(2));

      // Kiểm tra tên trong thẻ chính đổi thành 'Bé Bình'
      expect(
        find.descendant(
          of: find.byType(PrimaryChildCard),
          matching: find.text('Bé Bình'),
        ),
        findsOneWidget,
      );

      // Bé An lúc này chỉ còn trong hàng avatar (1 widget)
      expect(find.text('Bé An'), findsOneWidget);
    },
  );

  group('Test 3: không tràn ở 3 kích thước màn hình', () {
    const sizes = <String, Size>{
      '320×640': Size(320, 640),
      '390×844': Size(390, 844),
      '1024×768': Size(1024, 768),
    };

    for (final entry in sizes.entries) {
      testWidgets('không tràn ở kích thước ${entry.key}', (tester) async {
        await pumpChildrenTab(tester, size: entry.value);

        // Không có exception tràn (overflowed) hoặc bất kỳ lỗi nào từ framework
        expect(tester.takeException(), isNull);
      });
    }
  });

  group('iPad không tràn', () {
    for (final entry in kIpadSizes.entries) {
      testWidgets('${entry.key}: không tràn', (tester) async {
        tester.view.physicalSize = entry.value;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await pumpChildrenTab(tester);

        expect(tester.takeException(), isNull);
      });
    }
  });
}
