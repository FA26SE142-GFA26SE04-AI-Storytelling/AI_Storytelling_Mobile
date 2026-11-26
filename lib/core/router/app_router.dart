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
import 'package:ai_storytelling_mobile/features/learning/presentation/learning_screen.dart';
import 'package:ai_storytelling_mobile/features/account/account_screen.dart';
import 'package:ai_storytelling_mobile/features/home/presentation/home_screen.dart';
import 'package:ai_storytelling_mobile/features/account/presentation/account_sessions_screen.dart';
import 'package:ai_storytelling_mobile/features/account/presentation/account_activity_screen.dart';
import 'package:ai_storytelling_mobile/core/router/app_shell.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_session_controller.dart';
import 'package:ai_storytelling_mobile/features/kid/home/kid_home_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/entry/kid_qr_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/home/kid_coming_soon_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/home/kid_journey_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/kid_reader_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/library/kid_library_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/rewards/kid_notebook_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/rewards/kid_rewards_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/wish/kid_wish_screen.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/children_tab_screen.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/child_profile_screen.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/child_learning_screen.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/create_child_wizard_screen.dart';
import 'package:ai_storytelling_mobile/features/safety/presentation/child_safety_screen.dart';
import 'package:ai_storytelling_mobile/features/access/presentation/child_access_screen.dart';
import 'package:ai_storytelling_mobile/features/notifications/presentation/notifications_screen.dart';
import 'package:ai_storytelling_mobile/features/library/presentation/search_screen.dart';
import 'package:ai_storytelling_mobile/features/events/presentation/events_screen.dart';
import 'package:ai_storytelling_mobile/features/events/presentation/event_detail_screen.dart';

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
  static const String search = '/search';
  static const String events = '/events';
  static const String eventDetail = '/events/:id';
  static String eventPath(int id) => '/events/$id';
  static const String kids = '/kids';
  static const String kidsNew = '/kids/new';
  static const String learning = '/learning';
  static const String account = '/account';
  static const String notifications = '/notifications';
  static const String kidMode = '/kid';
  static const String kidEntry = '/kid-entry';
  static const String kidRead = '/kid/read/:storyId';
  static const String kidLibrary = '/kid/library';
  static const String kidSoon = '/kid/soon';
  static const String kidRewards = '/kid/rewards';
  static const String kidNotebook = '/kid/notebook';
  static const String kidWish = '/kid/wish';
  static const String kidJourney = '/kid/journey';
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
    AuthChecking() => location == AppRoutes.splash ? null : AppRoutes.splash,

    // Chưa đăng nhập: cho ở lại nhóm auth, còn lại về login
    AuthSignedOut() => _authRoutes.contains(location) ? null : AppRoutes.login,

    // Bị khoá: chỉ ở lại blocked
    AuthBlocked() => location == AppRoutes.blocked ? null : AppRoutes.blocked,

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
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
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
      // Thông báo phụ huynh: toàn màn hình, mở từ Trang chủ hoặc Tài khoản.
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      // Tìm truyện: mở chồng lên (context.push) từ nút 🔍 ở Trang chủ.
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const SearchScreen(),
      ),

      // --- Chế độ bé (toàn màn hình, không thuộc bottom nav) ---
      GoRoute(
        path: AppRoutes.kidMode,
        builder: (context, state) => const KidHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.kidRead,
        builder: (context, state) =>
            KidReaderScreen(storyId: state.pathParameters['storyId']!),
      ),
      GoRoute(
        path: AppRoutes.kidLibrary,
        builder: (context, state) => const KidLibraryScreen(),
      ),
      GoRoute(
        path: AppRoutes.kidRewards,
        builder: (context, state) => const KidRewardsScreen(),
      ),
      GoRoute(
        path: AppRoutes.kidNotebook,
        builder: (context, state) => const KidNotebookScreen(),
      ),
      GoRoute(
        path: AppRoutes.kidWish,
        builder: (context, state) => const KidWishScreen(),
      ),
      GoRoute(
        path: AppRoutes.kidJourney,
        builder: (context, state) => const KidJourneyScreen(),
      ),
      GoRoute(
        path: AppRoutes.kidSoon,
        builder: (context, state) =>
            KidComingSoonScreen(title: (state.extra as String?) ?? 'Sắp có'),
      ),

      // --- Quản lý bé (mở từ tab Học tập): màn đẩy lên trên thanh đáy, có nút quay lại.
      // Luôn mở bằng context.push để Back trở về tab cũ, không thoát app.
      GoRoute(
        path: AppRoutes.kids,
        builder: (context, state) => const ChildrenTabScreen(),
        routes: [
          GoRoute(
            path: 'new',
            builder: (context, state) => const CreateChildWizardScreen(),
          ),
          GoRoute(
            path: ':childId/profile',
            builder: (context, state) => ChildProfileScreen(
              childId: int.parse(state.pathParameters['childId']!),
            ),
          ),
          GoRoute(
            path: ':childId/learning',
            builder: (context, state) => ChildLearningScreen(
              childId: int.parse(state.pathParameters['childId']!),
            ),
          ),
          GoRoute(
            path: ':childId/safety',
            builder: (context, state) => ChildSafetyScreen(
              childId: int.parse(state.pathParameters['childId']!),
            ),
          ),
          GoRoute(
            path: ':childId/access',
            builder: (context, state) => ChildAccessScreen(
              childId: int.parse(state.pathParameters['childId']!),
            ),
          ),
        ],
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
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // Tab 1: Sự kiện (chi tiết là route con để vẫn thấy thanh tab dưới)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.events,
                builder: (context, state) => const EventsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => EventDetailScreen(
                      eventId:
                          int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Tab 2: Học tập
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.learning,
                builder: (context, state) => const LearningScreen(),
              ),
            ],
          ),

          // Tab 3: Tài khoản
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.account,
                builder: (context, state) => AccountScreen(),
                routes: [
                  GoRoute(
                    path: 'sessions',
                    builder: (context, state) => const AccountSessionsScreen(),
                  ),
                  GoRoute(
                    path: 'activity',
                    builder: (context, state) => const AccountActivityScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
