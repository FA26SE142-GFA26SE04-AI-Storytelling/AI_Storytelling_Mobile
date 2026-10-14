import 'package:ai_storytelling_mobile/app/app.dart';
import 'package:ai_storytelling_mobile/app/providers.dart';
import 'package:ai_storytelling_mobile/core/storage/session_storage.dart';
import 'package:ai_storytelling_mobile/data/auth/mock_auth_repository.dart';
import 'package:ai_storytelling_mobile/data/mock/mock_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fakes.dart';

/// Dựng cả app với dữ liệu mẫu không độ trễ, tắt chuyển động lặp (ếch chớp mắt, nền ao).
Future<void> pumpTaletale(
  WidgetTester tester, {
  required MemorySecureStore store,
  Size size = const Size(390, 844),
  bool signedIn = false,
  Map<String, Object> prefs = const {},
}) async {
  tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(disableAnimations: true);
  tester.view.physicalSize = size * 3;
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
  addTearDown(tester.view.reset);

  if (signedIn) store.values[SessionStorage.refreshKey] = 'mock-refresh-token';
  SharedPreferences.setMockInitialValues(prefs);
  final sp = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sp),
        secureStoreProvider.overrideWithValue(store),
        authRepositoryProvider.overrideWith((ref) => MockAuthRepository(ref.watch(sessionStorageProvider), latency: Duration.zero)),
        childRepositoryProvider.overrideWith((ref) => MockChildRepository(ref.watch(mockDbProvider), latency: Duration.zero)),
        storyRepositoryProvider.overrideWith((ref) => MockStoryRepository(ref.watch(mockDbProvider), latency: Duration.zero)),
        aiStoryRepositoryProvider.overrideWith((ref) => MockAiStoryRepository(ref.watch(mockDbProvider), latency: Duration.zero)),
      ],
      child: const TaletaleApp(),
    ),
  );
  await tester.pumpAndSettle();
}
