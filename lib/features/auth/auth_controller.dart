import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/api/api_result.dart';
import '../../data/auth/auth_models.dart';
import '../../data/auth/auth_repository.dart';

/// Người dùng đang đăng nhập. Đang tải = đang khôi phục phiên; `null` = chưa đăng nhập.
final authControllerProvider = AsyncNotifierProvider<AuthController, UserProfile?>(AuthController.new);

class AuthController extends AsyncNotifier<UserProfile?> {
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  Future<UserProfile?> build() async {
    // Phiên hết hạn giữa chừng (làm mới token thất bại) thì quay về màn đăng nhập.
    final sub = ref.watch(sessionStorageProvider).onExpired.listen((_) => state = const AsyncData(null));
    ref.onDispose(sub.cancel);
    return ref.watch(authRepositoryProvider).restore();
  }

  Future<ApiResult<AuthSession>> login({required String identifier, required String password}) async {
    final res = await _repo.login(identifier: identifier, password: password);
    if (res.success && res.data != null) state = AsyncData(res.data!.user);
    return res;
  }

  Future<ApiResult<void>> register({
    required String username,
    required String email,
    required String fullName,
    required String password,
    required String confirmPassword,
  }) => _repo.register(username: username, email: email, fullName: fullName, password: password, confirmPassword: confirmPassword);

  Future<ApiResult<void>> forgotPassword({required String email}) => _repo.forgotPassword(email: email);

  Future<ApiResult<void>> resetPassword({required String email, required String resetToken, required String newPassword, required String confirmPassword}) =>
      _repo.resetPassword(email: email, resetToken: resetToken, newPassword: newPassword, confirmPassword: confirmPassword);

  Future<void> logout() async {
    await _repo.logout();
    state = const AsyncData(null);
  }
}
