import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/tt_colors.dart';
import 'package:ai_storytelling_mobile/core/theme/tt_radius.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_button.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_card.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_confirm_dialog.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_state_views.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_toast.dart';
import 'package:ai_storytelling_mobile/features/account/data/account_repository.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/models/login_session_dto.dart';

/// Provider lấy danh sách phiên đăng nhập của tài khoản
final accountSessionsProvider =
    FutureProvider.autoDispose<List<LoginSessionDto>>((ref) async {
  return ref.watch(accountRepositoryProvider).listSessions();
});

/// Màn hình quản lý các phiên đăng nhập của tài khoản.
class AccountSessionsScreen extends ConsumerStatefulWidget {
  const AccountSessionsScreen({super.key});

  @override
  ConsumerState<AccountSessionsScreen> createState() =>
      _AccountSessionsScreenState();
}

class _AccountSessionsScreenState
    extends ConsumerState<AccountSessionsScreen> {
  bool _isLoggingOutAll = false;
  int? _revokingSessionId;

  /// Định dạng ngày giờ dạng dd/MM/yyyy HH:mm theo giờ local
  String _formatDateTime(DateTime dt) {
    final local = dt.toLocal();
    final d = local.day.toString().padLeft(2, '0');
    final m = local.month.toString().padLeft(2, '0');
    final y = local.year.toString().padLeft(4, '0');
    final h = local.hour.toString().padLeft(2, '0');
    final min = local.minute.toString().padLeft(2, '0');
    return '$d/$m/$y $h:$min';
  }

  /// Trích xuất thông điệp lỗi chuẩn từ exception
  String _extractErrorMessage(Object error) {
    if (error is ApiException) {
      return error.message;
    }
    return 'Chưa kết nối được máy chủ. Bạn thử lại sau ít phút nhé.';
  }

  /// Huỷ một phiên đăng nhập cụ thể
  Future<void> _revokeSession(int sessionId) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Đăng xuất thiết bị này?',
      message: 'Phiên làm việc trên thiết bị này sẽ bị huỷ bỏ.',
      confirmLabel: 'Đăng xuất',
      destructive: true,
    );

    if (!confirmed || !mounted) return;

    setState(() => _revokingSessionId = sessionId);

    try {
      await ref.read(accountRepositoryProvider).revokeSession(sessionId);
      if (mounted) {
        showTtToast(
          context,
          'Đã đăng xuất thiết bị thành công.',
          type: TtToastType.success,
        );
        ref.invalidate(accountSessionsProvider);
      }
    } on ApiException catch (e) {
      if (mounted) {
        showTtToast(context, e.message, type: TtToastType.error);
      }
    } catch (e) {
      if (mounted) {
        showTtToast(
          context,
          _extractErrorMessage(e),
          type: TtToastType.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _revokingSessionId = null);
      }
    }
  }

  /// Đăng xuất khỏi tất cả thiết bị
  Future<void> _logoutAllDevices() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Đăng xuất mọi thiết bị?',
      message:
          'Tất cả các phiên làm việc khác và thiết bị hiện tại sẽ bị đăng xuất.',
      confirmLabel: 'Đăng xuất tất cả',
      destructive: true,
    );

    if (!confirmed || !mounted) return;

    setState(() => _isLoggingOutAll = true);

    try {
      await ref.read(accountRepositoryProvider).logoutAllDevices();
      // Đăng xuất cục bộ, router sẽ tự động chuyển hướng về màn đăng nhập
      await ref.read(authControllerProvider.notifier).logout();
    } on ApiException catch (e) {
      if (mounted) {
        showTtToast(context, e.message, type: TtToastType.error);
      }
    } catch (e) {
      if (mounted) {
        showTtToast(
          context,
          _extractErrorMessage(e),
          type: TtToastType.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoggingOutAll = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessionsAsync = ref.watch(accountSessionsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Phiên đăng nhập'),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: sessionsAsync.when(
              data: (sessions) => _buildDataView(context, sessions),
              loading: () => _buildLoadingView(),
              error: (error, _) => _buildErrorView(error),
            ),
          ),
        ),
      ),
    );
  }

  /// Giao diện danh sách phiên đăng nhập
  Widget _buildDataView(BuildContext context, List<LoginSessionDto> sessions) {
    if (sessions.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async => ref.invalidate(accountSessionsProvider),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 60),
            const TtEmptyState(
              icon: Icons.devices_rounded,
              title: 'Chưa có phiên đăng nhập nào',
            ),
          ],
        ),
      );
    }

    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(accountSessionsProvider),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          ...sessions.map((session) {
            final isRevokingThis = _revokingSessionId == session.id;
            final isBusy = _isLoggingOutAll || isRevokingThis;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TtCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Đăng nhập lúc: ${_formatDateTime(session.issuedAt)}',
                            style: textTheme.bodyMedium?.copyWith(
                              color: tt.text,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Hết hạn lúc: ${_formatDateTime(session.expiresAt)}',
                            style: textTheme.bodyMedium?.copyWith(
                              color: tt.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (isRevokingThis)
                      const SizedBox(
                        width: 48,
                        height: 48,
                        child: Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      )
                    else
                      TtIconButton(
                        icon: Icons.logout_rounded,
                        tooltip: 'Đăng xuất thiết bị này',
                        onPressed:
                            isBusy ? null : () => _revokeSession(session.id),
                      ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          TtButton(
            label: 'Đăng xuất mọi thiết bị',
            icon: Icons.devices_other_rounded,
            variant: TtButtonVariant.danger,
            expanded: true,
            isLoading: _isLoggingOutAll,
            onPressed: (_isLoggingOutAll || _revokingSessionId != null)
                ? null
                : _logoutAllDevices,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Giao diện khi đang tải dữ liệu
  Widget _buildLoadingView() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, _) => const TtSkeleton(
        height: 80,
        radius: BorderRadius.all(Radius.circular(TtRadius.lg)),
      ),
    );
  }

  /// Giao diện khi xảy ra lỗi tải dữ liệu
  Widget _buildErrorView(Object error) {
    return Center(
      child: TtErrorState(
        message: _extractErrorMessage(error),
        onRetry: () => ref.invalidate(accountSessionsProvider),
      ),
    );
  }
}
