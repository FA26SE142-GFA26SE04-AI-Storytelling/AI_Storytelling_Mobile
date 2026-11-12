import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/auth/presentation/splash_screen.dart';
import 'package:ai_storytelling_mobile/features/auth/presentation/login_screen.dart';
import 'package:ai_storytelling_mobile/features/auth/presentation/register_screen.dart';
import 'package:ai_storytelling_mobile/features/auth/presentation/verify_email_screen.dart';
import 'package:ai_storytelling_mobile/features/auth/presentation/forgot_password_screen.dart';
import 'package:ai_storytelling_mobile/features/auth/presentation/reset_password_screen.dart';
import 'package:ai_storytelling_mobile/features/auth/presentation/blocked_screen.dart';
import 'package:ai_storytelling_mobile/features/shell/empty_tab_screen.dart';
import 'package:ai_storytelling_mobile/features/account/account_screen.dart';
import 'package:ai_storytelling_mobile/core/router/app_shell.dart';

// ---------------------------------------------------------------------------
// Hằng số đường dẫn tập trung — dùng chung toàn app
// ---------------------------------------------------------------------------
abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyEmail = '/verify-email';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String blocked = '/blocked';
  static const String home = '/home';
  static const String library = '/library';
  static const String create = '/create';
  static const String kids = '/kids';
  static const String account = '/account';
  static const String kidMode = '/kid';
}

// ---------------------------------------------------------------------------
// Các nhóm route dùng trong authRedirect
// ---------------------------------------------------------------------------
const _authRoutes = {
  AppRoutes.login,
  AppRoutes.register,
  AppRoutes.verifyEmail,
  AppRoutes.forgotPassword,
  AppRoutes.resetPassword,
};

// ---------------------------------------------------------------------------
// authRedirect — hàm thuần tuý, không phụ thuộc Riverpod → dễ unit test
// ---------------------------------------------------------------------------
String? authRedirect(AuthState state, String location) {
  return switch (state) {
    // Đang kiểm tra phiên: giữ splash, mọi nơi khác về splash
    AuthChecking() =>
      location == AppRoutes.splash ? null : AppRoutes.splash,

    // Chưa đăng nhập: cho ở lại nhóm auth, còn lại về login
    AuthSignedOut() =>
      _authRoutes.contains(location) ? null : AppRoutes.login,

    // Bị khoá: chỉ ở lại blocked
    AuthBlocked() =>
      location == AppRoutes.blocked ? null : AppRoutes.blocked,

    // Đã đăng nhập: đẩy khỏi splash / blocked / nhóm auth về home
    AuthSignedIn() =>
      (location == AppRoutes.splash ||
              location == AppRoutes.blocked ||
              _authRoutes.contains(location))
          ? AppRoutes.home
          : null,
  };
}

// ---------------------------------------------------------------------------
// _AuthRefresh — cầu nối giữa Riverpod và GoRouter.refreshListenable
// ---------------------------------------------------------------------------
class _AuthRefresh extends ChangeNotifier {
  _AuthRefresh(Ref ref) {
    ref.listen(authControllerProvider, (_, _) => notifyListeners());
  }
}

// ---------------------------------------------------------------------------
// appRouterProvider
// ---------------------------------------------------------------------------
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: _AuthRefresh(ref),
    redirect: (context, state) =>
        authRedirect(ref.read(authControllerProvider), state.matchedLocation),
    routes: [
      // --- Các route độc lập (không thuộc shell) ---
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.verifyEmail,
        builder: (context, state) =>
            VerifyEmailScreen(initialEmail: (state.extra as String?) ?? ''),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) =>
            ResetPasswordScreen(initialEmail: (state.extra as String?) ?? ''),
      ),
      GoRoute(
        path: AppRoutes.blocked,
        builder: (context, state) => BlockedScreen(),
      ),

      // --- Chế độ bé (toàn màn hình, không thuộc bottom nav) ---
      GoRoute(
        path: AppRoutes.kidMode,
        builder: (context, state) => EmptyTabScreen(
          title: 'Chế độ của bé',
          icon: Icons.face_rounded,
          message: 'Trang của bé sẽ có ở giai đoạn 2.',
        ),
      ),

      // --- Shell chứa bottom navigation / navigation rail ---
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          // Tab 0: Trang chủ
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => EmptyTabScreen(
                  title: 'Trang chủ',
                  icon: Icons.home_rounded,
                  message:
                      'Lời chào, thẻ Cho bé đọc và việc cần làm sẽ có ở giai đoạn 3.',
                ),
              ),
            ],
          ),

          // Tab 1: Thư viện
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.library,
                builder: (context, state) => EmptyTabScreen(
                  title: 'Thư viện',
                  icon: Icons.auto_stories_rounded,
                  message:
                      'Truyện của tôi và thư viện cộng đồng sẽ có ở giai đoạn 4.',
                ),
              ),
            ],
          ),

          // Tab 2: Tạo truyện
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.create,
                builder: (context, state) => EmptyTabScreen(
                  title: 'Tạo truyện',
                  icon: Icons.add_circle_rounded,
                  message: 'Studio tạo truyện bằng AI sẽ có ở giai đoạn 4.',
                ),
              ),
            ],
          ),

          // Tab 3: Bé
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.kids,
                builder: (context, state) => EmptyTabScreen(
                  title: 'Bé',
                  icon: Icons.child_care_rounded,
                  message:
                      'Hồ sơ bé và các mục quản lý bé sẽ có ở giai đoạn 3.',
                ),
              ),
            ],
          ),

          // Tab 4: Tài khoản
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.account,
                builder: (context, state) => AccountScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
