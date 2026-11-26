import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_storytelling_mobile/core/theme/kid_metrics.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../auth/application/auth_controller.dart';
import '../data/kid_session_controller.dart';
import '../data/stored_kid_session.dart';
import '../gate/parental_gate_dialog.dart';
import '../time/kid_habit_widgets.dart';
import '../time/kid_status_provider.dart';
import '../time/kid_time_layer.dart';
import 'kid_home_providers.dart';
import 'kid_lobby.dart';

/// Trang chính Chế độ của bé (route /kid).
class KidHomeScreen extends ConsumerWidget {
  const KidHomeScreen({super.key});

  Future<void> _exit(BuildContext context, WidgetRef ref) async {
    final state = ref.read(kidSessionProvider);
    if (state is! KidActive) {
      ref.read(kidSessionProvider.notifier).end();
      return;
    }

    // Bé vào bằng mã QR tự thoát, không cần cổng phụ huynh (Luồng 3 Bước 3.0b, như web).
    if (!state.session.parentalGateEnabled ||
        state.session.via == KidSessionVia.easyLogin) {
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

  void _refresh(WidgetRef ref) {
    ref.invalidate(kidHomeDataProvider);
    ref.invalidate(kidLobbyRewardsProvider);
  }

  /// Mở màn con; quay về thì tải lại badge (bé có thể vừa tưới cây, nhận huy hiệu).
  Future<void> _open(BuildContext context, WidgetRef ref, String route) async {
    await context.push(route);
    if (context.mounted) ref.invalidate(kidLobbyRewardsProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(kidSessionProvider);
    final kidStatus = ref.watch(kidStatusProvider);
    final tt = context.tt;

    return switch (sessionState) {
      KidChecking() => Scaffold(
        backgroundColor: tt.bg,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TtFrog(mood: TtFrogMood.think, size: 120),
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
          body: KidTimeGate(
            status: kidStatus.readingTime,
            onDone: () => ref.read(kidStatusProvider.notifier).refresh(),
            onExit: () => _exit(context, ref),
            child: SafeArea(
              child: Column(
                children: [
                  _buildHeader(context, ref),
                  KidTimeBanner(status: kidStatus.readingTime),
                  if (kidStatus.habit != null)
                    KidReminderHost(
                      habit: kidStatus.habit,
                      child: KidHabitStrip(habit: kidStatus.habit!),
                    ),
                  Expanded(child: _buildContent(context, ref)),
                ],
              ),
            ),
          ),
        ),
      ),
    };
  }

  /// Bảng tên lắc lư -2° ↔ 2° quanh mép trên, chu kỳ 4.5s (kls-swing web).
  Widget _swing(BuildContext context, Widget child) {
    if (MediaQuery.disableAnimationsOf(context)) return child;
    return child
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .rotate(
          begin: -2 / 360,
          end: 2 / 360,
          alignment: Alignment.topCenter,
          duration: 2250.ms,
          curve: Curves.easeInOut,
        );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    final tt = context.tt;
    final homeDataAsync = ref.watch(kidHomeDataProvider);
    final nickname = homeDataAsync.value?.nickname;
    final displayName = (nickname != null && nickname.trim().isNotEmpty)
        ? nickname
        : 'Chào em!';

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
            child: _swing(
              context,
              Text(
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
          ),
          const SizedBox(width: 8),
          TtIconButton(
            size: kKidMinTap,
            icon: Icons.refresh_rounded,
            tooltip: 'Tải lại',
            onPressed: () => _refresh(ref),
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
            TtSkeleton(height: 220, radius: BorderRadius.circular(TtRadius.xl)),
            const SizedBox(height: 24),
            TtSkeleton(height: 140, radius: BorderRadius.circular(TtRadius.lg)),
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
            onRetry: () => _refresh(ref),
          ),
        );
      },
      data: (data) => RefreshIndicator(
        onRefresh: () async {
          _refresh(ref);
          try {
            await ref.read(kidHomeDataProvider.future);
          } catch (_) {}
        },
        child: KidLobby(
          roadmap: data.roadmap,
          // Lỗi tải phần thưởng chỉ ẩn badge, không chặn sảnh.
          rewards: ref.watch(kidLobbyRewardsProvider).value,
          onRead: (id) => _open(context, ref, '/kid/read/$id'),
          onLibrary: () => _open(context, ref, '/kid/library'),
          onJourney: () => _open(context, ref, '/kid/journey'),
          onNotebook: () => _open(context, ref, '/kid/notebook'),
          onWish: () => _open(context, ref, '/kid/wish'),
          onRewards: () => _open(context, ref, '/kid/rewards'),
          disabledFeatures: ref.watch(kidStatusProvider).disabledFeatures,
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
            const TtFrog(mood: TtFrogMood.idle, size: 150),
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
