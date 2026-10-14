import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api/api_client.dart';
import '../core/env.dart';
import '../core/storage/session_storage.dart';
import '../data/auth/auth_repository.dart';
import '../data/auth/mock_auth_repository.dart';

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
