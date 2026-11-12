import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../auth/application/auth_controller.dart';
import '../data/kid_session_controller.dart';
import '../data/kid_session_watcher.dart';
import '../gate/parental_gate_dialog.dart';
import 'kid_home_providers.dart';
import 'kid_roadmap_strip.dart';
import 'kid_tile_grid.dart';
import 'kid_today_card.dart';

/// Trang chính Chế độ của bé (route /kid).
class KidHomeScreen extends ConsumerWidget {
  const KidHomeScreen({super.key});

  Future<void> _exit(BuildContext context, WidgetRef ref) async {
    final state = ref.read(kidSessionProvider);
    if (state is! KidActive) {
      ref.read(kidSessionProvider.notifier).end();
      return;
    }

    if (!state.session.parentalGateEnabled) {
      ref.read(kidSessionProvider.notifier).end();
      return;
    }

    final authState = ref.read(authControllerProvider);
    final email = authState is AuthSignedIn ? authState.user.email : '';
    final ok = await showParentalGateDialog(context, initialEmail: email);
    if (!context.mounted) return;
    if (ok) {
      ref.read(kidSessionProvider.notifier).end();
    }
  }

  Widget _animateBlock(
    BuildContext context,
    Widget child, {
    int delayMs = 0,
  }) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return child;
    }
    return child
        .animate(delay: delayMs.ms)
        .fadeIn(duration: 350.ms)
        .slideY(begin: 0.08, end: 0);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(kidSessionWatcherProvider);
    final sessionState = ref.watch(kidSessionProvider);
    final tt = context.tt;

    return switch (sessionState) {
      KidChecking() => Scaffold(
          backgroundColor: tt.bg,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TtFrog(
                  mood: TtFrogMood.think,
                  size: 120,
                ),
                const SizedBox(height: 16),
                Text(
                  'Đang mở cửa vào đầm sen…',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Baloo2',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: tt.text,
                  ),
                ),
              ],
            ),
          ),
        ),
      KidNone() || KidEnded() => Scaffold(
          backgroundColor: tt.bg,
          body: _EndedView(
            onGoHome: () => ref.read(kidSessionProvider.notifier).end(),
          ),
        ),
      KidActive() => PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              _exit(context, ref);
            }
          },
          child: Scaffold(
            backgroundColor: tt.bg,
            body: SafeArea(
              child: Column(
                children: [
                  _buildHeader(context, ref),
                  Expanded(
                    child: _buildContent(context, ref),
                  ),
                ],
              ),
            ),
          ),
        ),
    };
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    final tt = context.tt;
    final homeDataAsync = ref.watch(kidHomeDataProvider);
    final nickname = homeDataAsync.value?.nickname;
    final displayName =
        (nickname != null && nickname.trim().isNotEmpty) ? nickname : 'Chào em!';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          TtButton(
            label: 'Thoát',
            icon: Icons.logout_rounded,
            variant: TtButtonVariant.secondary,
            onPressed: () => _exit(context, ref),
          ),
          const SizedBox(width: 8),
          // Expanded (không dùng Spacer + Flexible) để tên dùng hết khoảng giữa hai nút.
          Expanded(
            child: Text(
              displayName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Baloo2',
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: tt.text,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          TtIconButton(
            icon: Icons.refresh_rounded,
            tooltip: 'Tải lại',
            onPressed: () => ref.invalidate(kidHomeDataProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    final homeDataAsync = ref.watch(kidHomeDataProvider);

    return homeDataAsync.when(
      loading: () => SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            TtSkeleton(
              height: 220,
              radius: BorderRadius.circular(TtRadius.xl),
            ),
            const SizedBox(height: 24),
            TtSkeleton(
              height: 140,
              radius: BorderRadius.circular(TtRadius.lg),
            ),
          ],
        ),
      ),
      error: (error, _) {
        final message = error is ApiException
            ? error.message
            : 'Có lỗi xảy ra. Vui lòng thử lại.';
        return Center(
          child: TtErrorState(
            title: 'Chưa mở được trang của em',
            message: message,
            onRetry: () => ref.invalidate(kidHomeDataProvider),
          ),
        );
      },
      data: (data) => RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(kidHomeDataProvider);
          try {
            await ref.read(kidHomeDataProvider.future);
          } catch (_) {}
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isTablet = constraints.maxWidth >= 600;

              final todayCard = _animateBlock(
                context,
                KidTodayCard(
                  roadmap: data.roadmap,
                  onRead: (storyId) => context.push('/kid/read/$storyId'),
                  onChooseStory: () => context.push('/kid/soon', extra: 'Truyện'),
                ),
                delayMs: 0,
              );

              final roadmapStrip = _animateBlock(
                context,
                KidRoadmapStrip(
                  roadmap: data.roadmap,
                  onRead: (storyId) => context.push('/kid/read/$storyId'),
                ),
                delayMs: 100,
              );

              final tileGrid = _animateBlock(
                context,
                KidTileGrid(
                  onOpen: (title) => context.push('/kid/soon', extra: title),
                ),
                delayMs: 200,
              );

              if (isTablet) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          todayCard,
                          const SizedBox(height: 24),
                          roadmapStrip,
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: tileGrid,
                    ),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  todayCard,
                  const SizedBox(height: 24),
                  roadmapStrip,
                  const SizedBox(height: 24),
                  tileGrid,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _EndedView extends StatelessWidget {
  const _EndedView({required this.onGoHome});

  final VoidCallback onGoHome;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TtFrog(
              mood: TtFrogMood.idle,
              size: 150,
            ),
            const SizedBox(height: 24),
            Text(
              'Phiên đọc đã kết thúc',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Baloo2',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: tt.text,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Em nhờ bố mẹ mở lại nhé.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Baloo2',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: tt.muted,
              ),
            ),
            const SizedBox(height: 32),
            TtButton(
              label: 'Về với bố mẹ',
              icon: Icons.home_rounded,
              expanded: true,
              onPressed: onGoHome,
            ),
          ],
        ),
      ),
    );
  }
}
