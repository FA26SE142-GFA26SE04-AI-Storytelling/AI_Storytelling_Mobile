import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_models.dart';
import '../data/auth_repository.dart';
import '../../../core/network/api_exception.dart';

// ─── Trạng thái xác thực ───────────────────────────────────────────────────

sealed class AuthState {
  const AuthState();
}

/// Đang kiểm tra phiên đã lưu
class AuthChecking extends AuthState {
  const AuthChecking();
}

/// Chưa đăng nhập.
/// [sessionExpired] = true khi phiên hết hạn giữa chừng.
class AuthSignedOut extends AuthState {
  final bool sessionExpired;
  const AuthSignedOut({this.sessionExpired = false});
}

/// Phụ huynh đã đăng nhập (role == 'User')
class AuthSignedIn extends AuthState {
  final UserProfile user;
  const AuthSignedIn(this.user);
}

/// Tài khoản không được phép dùng app mobile (Moderator, Admin, v.v.)
class AuthBlocked extends AuthState {
  final UserProfile user;
  const AuthBlocked(this.user);
}

// ─── Controller ────────────────────────────────────────────────────────────

class AuthController extends Notifier<AuthState> {
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  AuthState build() {
    // Kiểm tra phiên ngay sau khi build, không block build()
    Future.microtask(restore);
    return const AuthChecking();
  }

  /// Khôi phục phiên đã lưu khi khởi động app
  Future<void> restore() async {
    try {
      if (!await _repo.hasStoredSession()) {
        state = const AuthSignedOut();
        return;
      }
      final user = await _repo.fetchMe();
      _applyUser(user);
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        // Phiên hết hạn hoặc không hợp lệ → xoá token, về màn đăng nhập
        await _repo.logout();
        state = const AuthSignedOut();
      } else {
        // Lỗi mạng hoặc server (5xx) → không xoá token, chờ người dùng thử lại
        state = const AuthSignedOut();
      }
    } catch (_) {
      // Lỗi không xác định → coi như lỗi mạng, không xoá token
      state = const AuthSignedOut();
    }
  }

  /// Đăng nhập; ném ApiException lên để UI tự hiện thông báo lỗi
  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    final user = await _repo.login(identifier: identifier, password: password);
    _applyUser(user);
  }

  /// Đăng xuất chủ động
  Future<void> logout() async {
    await _repo.logout();
    state = const AuthSignedOut();
  }

  /// Phiên hết hạn giữa chừng (gọi từ interceptor HTTP)
  void sessionExpired() {
    state = const AuthSignedOut(sessionExpired: true);
  }

  /// Xác nhận đã hiện toast "phiên hết hạn", tránh hiện lặp lại
  void acknowledgeSessionExpired() {
    if (state is AuthSignedOut) {
      state = const AuthSignedOut();
    }
  }

  /// Áp dụng thông tin người dùng vào state theo role
  void _applyUser(UserProfile user) {
    state = user.role == 'User' ? AuthSignedIn(user) : AuthBlocked(user);
  }
}

// ─── Provider ──────────────────────────────────────────────────────────────

final authControllerProvider =
    NotifierProvider<AuthController, AuthState>(AuthController.new);
