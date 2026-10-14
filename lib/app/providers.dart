import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api/api_client.dart';
import '../core/env.dart';
import '../core/storage/session_storage.dart';
import '../data/auth/auth_repository.dart';
import '../data/auth/mock_auth_repository.dart';
import '../data/mock/mock_db.dart';
import '../data/mock/mock_repositories.dart';
import '../data/repositories/ai_story_repository.dart';
import '../data/repositories/child_repository.dart';
import '../data/repositories/story_repository.dart';

/// Được gán trong main() sau khi SharedPreferences sẵn sàng.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError('sharedPreferencesProvider phải được override trong main()'));

final secureStoreProvider = Provider<SecureStore>((ref) => const FlutterSecureStore());

final sessionStorageProvider = Provider<SessionStorage>((ref) {
  final session = SessionStorage(ref.watch(secureStoreProvider));
  ref.onDispose(session.dispose);
  return session;
});

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient(baseUrl: Env.apiBaseUrl, session: ref.watch(sessionStorageProvider)));

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final session = ref.watch(sessionStorageProvider);
  return Env.useMock ? MockAuthRepository(session) : ApiAuthRepository(ref.watch(apiClientProvider), session);
});

/// Kho dữ liệu mẫu (chỉ dùng khi USE_MOCK=true).
final mockDbProvider = Provider<MockDb>((ref) => MockDb(ref.watch(sharedPreferencesProvider)));

final childRepositoryProvider = Provider<ChildRepository>(
  (ref) => Env.useMock ? MockChildRepository(ref.watch(mockDbProvider)) : ApiChildRepository(ref.watch(apiClientProvider)),
);

final storyRepositoryProvider = Provider<StoryRepository>(
  (ref) => Env.useMock ? MockStoryRepository(ref.watch(mockDbProvider)) : ApiStoryRepository(ref.watch(apiClientProvider)),
);

final aiStoryRepositoryProvider = Provider<AiStoryRepository>(
  (ref) => Env.useMock ? MockAiStoryRepository(ref.watch(mockDbProvider)) : ApiAiStoryRepository(ref.watch(apiClientProvider)),
);
