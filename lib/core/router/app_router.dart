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
import 'package:ai_storytelling_mobile/features/kid/data/kid_session_controller.dart';
import 'package:ai_storytelling_mobile/features/kid/home/kid_home_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/entry/kid_qr_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/home/kid_coming_soon_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/kid_reader_placeholder_screen.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/children_tab_screen.dart';

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
  static const String kidEntry = '/kid-entry';
  static const String kidRead = '/kid/read/:storyId';
  static const String kidSoon = '/kid/soon';
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
String? authRedirect(
  AuthState state,
  String location, {
  KidSessionState kid = const KidNone(),
}) {
  if (kid is KidChecking) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }

  if (kid is KidActive || kid is KidEnded) {
    if (location == AppRoutes.kidMode ||
        location.startsWith('/kid/') ||
        location == AppRoutes.kidEntry) {
      return null;
    }
    return AppRoutes.kidMode;
  }

  if (kid is KidNone) {
    if (location == AppRoutes.kidEntry) {
      return null;
    }
    if ((location == AppRoutes.kidMode || location.startsWith('/kid/')) &&
        state is AuthSignedIn) {
      return AppRoutes.home;
    }
  }

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
    ref.listen(kidSessionProvider, (_, _) => notifyListeners());
  }
}

// ---------------------------------------------------------------------------
// appRouterProvider
// ---------------------------------------------------------------------------
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: _AuthRefresh(ref),
    redirect: (context, state) => authRedirect(
      ref.read(authControllerProvider),
      state.matchedLocation,
      kid: ref.read(kidSessionProvider),
    ),
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
      GoRoute(
        path: AppRoutes.kidEntry,
        builder: (context, state) => const KidQrScreen(),
      ),

      // --- Chế độ bé (toàn màn hình, không thuộc bottom nav) ---
      GoRoute(
        path: AppRoutes.kidMode,
        builder: (context, state) => const KidHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.kidRead,
        builder: (context, state) => KidReaderPlaceholderScreen(
          storyId: int.parse(state.pathParameters['storyId']!),
        ),
      ),
      GoRoute(
        path: AppRoutes.kidSoon,
        builder: (context, state) => KidComingSoonScreen(
          title: (state.extra as String?) ?? 'Sắp có',
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
                builder: (context, state) => const ChildrenTabScreen(),
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
