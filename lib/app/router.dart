import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../data/auth/auth_models.dart';
import '../features/account/account_screen.dart';
import '../features/auth/auth_controller.dart';
import '../features/auth/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/library/library_screen.dart';
import '../features/review/review_screen.dart';
import '../features/shell/app_shell.dart';
import '../features/shell/splash_screen.dart';
import '../features/story/story_detail_screen.dart';
import '../features/studio/studio_screen.dart';

final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Chi tiết truyện, lồng trong từng tab (/home/story/3, /library/story/3…) để giữ thanh điều hướng và nút quay lại.
final _storyRoute = GoRoute(
  path: 'story/:id',
  builder: (context, state) => StoryDetailScreen(storyId: int.parse(state.pathParameters['id']!)),
);

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ValueNotifier<AsyncValue<UserProfile?>>(const AsyncLoading());
  ref.listen(authControllerProvider, (_, next) => auth.value = next, fireImmediately: true);

  final router = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/splash',
    refreshListenable: auth,
    redirect: (context, state) => authRedirect(auth.value, state.uri),
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          final q = state.uri.queryParameters;
          return LoginScreen(key: ValueKey(state.uri.toString()), initialMode: LoginMode.parse(q['mode']), email: q['email'], token: q['token']);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/home', builder: (context, state) => const HomeScreen(), routes: [_storyRoute]),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/library', builder: (context, state) => const LibraryScreen(), routes: [_storyRoute]),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/review', builder: (context, state) => const ReviewScreen(), routes: [_storyRoute]),
            ],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/child', builder: (context, state) => const AccountScreen())],
          ),
        ],
      ),
      GoRoute(
        path: '/studio',
        parentNavigatorKey: _rootKey,
        pageBuilder: (context, state) => const MaterialPage(fullscreenDialog: true, child: StudioScreen()),
      ),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    auth.dispose();
  });
  return router;
});

/// Quyết định chuyển hướng theo trạng thái đăng nhập. Tách riêng để test.
///
/// - Đang khôi phục phiên → /splash (nhớ đích đến trong `from`).
/// - Chưa đăng nhập → /login (giữ nguyên tham số nếu đang ở /login, ví dụ link đặt lại mật khẩu).
/// - Đã đăng nhập mà đang ở /login, /splash hoặc / → /home.
String? authRedirect(AsyncValue<UserProfile?> auth, Uri uri) {
  final target = emailLinkToLogin(uri);
  final loading = auth.isLoading && !auth.hasValue;
  if (loading) {
    if (uri.path == '/splash') return null;
    return Uri(path: '/splash', queryParameters: {'from': target.toString()}).toString();
  }

  final from = uri.path == '/splash' ? Uri.tryParse(uri.queryParameters['from'] ?? '') : null;
  final dest = (from != null && from.path.isNotEmpty) ? from : target;
  final signedIn = switch (auth) {
    AsyncData(:final value) => value != null,
    _ => false,
  };

  String? goTo(Uri next) => next.toString() == uri.toString() ? null : next.toString();

  if (!signedIn) return dest.path == '/login' ? goTo(dest) : '/login';
  if (const {'/login', '/splash', '/', ''}.contains(dest.path)) return '/home';
  return goTo(dest);
}

/// Link trong email của backend trỏ về "/" kèm tham số (giống web):
/// `?auth=reset&token=…&email=…` → đặt lại mật khẩu; `?auth=forgot|signup|signin` → mở đúng biểu mẫu.
Uri emailLinkToLogin(Uri uri) {
  if (uri.path != '/' && uri.path.isNotEmpty) return uri;
  final q = uri.queryParameters;
  final token = q['token'] ?? q['resetToken'];
  final mode = (token != null || q['auth'] == 'reset')
      ? LoginMode.reset
      : switch (q['auth']) {
          'forgot' => LoginMode.forgot,
          'signup' => LoginMode.register,
          'signin' => LoginMode.login,
          _ => null,
        };
  if (mode == null) return uri;
  return Uri(path: '/login', queryParameters: {'mode': mode.name, 'email': ?q['email'], 'token': ?token});
}
