import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ai_storytelling_mobile/core/theme/tt_colors.dart';
import 'package:ai_storytelling_mobile/core/theme/tt_radius.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_button.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_card.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_confirm_dialog.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_network_image.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_toast.dart';
import 'package:ai_storytelling_mobile/features/account/presentation/account_email_dialog.dart';
import 'package:ai_storytelling_mobile/features/account/presentation/account_name_dialog.dart';
import 'package:ai_storytelling_mobile/features/account/presentation/account_password_dialog.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_models.dart';
import 'package:ai_storytelling_mobile/features/notifications/presentation/notification_bell.dart';

const _deleteAccountUrl = 'https://www.taletale.site';

/// Màn hình quản lý tài khoản người dùng.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final user = authState is AuthSignedIn ? authState.user : null;
    final unread = watchUnreadCount(ref);

    final sections = <Widget>[
      if (user != null) _ProfileCard(user: user),
      _Group(
        title: 'Bảo mật',
        items: [
          _Item(
            icon: Icons.lock_reset_rounded,
            label: 'Đổi mật khẩu',
            onTap: () => showChangePasswordDialog(context, ref),
          ),
          if (user != null)
            _Item(
              icon: Icons.alternate_email_rounded,
              label: 'Đổi email',
              onTap: () => showChangeEmailDialog(context, ref, user),
            ),
          _Item(
            icon: Icons.devices_rounded,
            label: 'Phiên đăng nhập',
            onTap: () => context.push('/account/sessions'),
          ),
          _Item(
            icon: Icons.history_rounded,
            label: 'Lịch sử hoạt động',
            onTap: () => context.push('/account/activity'),
          ),
        ],
      ),
      _Group(
        title: 'Khác',
        items: [
          _Item(
            icon: Icons.notifications_rounded,
            label: 'Thông báo',
            badge: unread,
            onTap: () => openNotifications(context, ref),
          ),
          _Item(
            icon: Icons.person_remove_rounded,
            label: 'Xoá tài khoản',
            trailing: Icons.open_in_new_rounded,
            onTap: () => _openDeleteAccount(context),
          ),
        ],
      ),
      TtButton(
        label: 'Đăng xuất',
        icon: Icons.logout_rounded,
        variant: TtButtonVariant.danger,
        expanded: true,
        onPressed: () => _confirmLogout(context, ref),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: sections.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (_, i) => sections[i]
                  .animate(delay: (60 * i).ms)
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.05, end: 0, duration: 300.ms),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openDeleteAccount(BuildContext context) async {
    var opened = false;
    try {
      opened = await launchUrl(
        Uri.parse(_deleteAccountUrl),
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      opened = false;
    }
    if (!opened && context.mounted) {
      showTtToast(
        context,
        'Không mở được trình duyệt. Bạn hãy vào taletale.site để xoá tài khoản nhé.',
        type: TtToastType.error,
      );
    }
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Đăng xuất?',
      message: 'Bạn có chắc muốn đăng xuất khỏi thiết bị này?',
      confirmLabel: 'Đăng xuất',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    await ref.read(authControllerProvider.notifier).logout();
  }
}

class _ProfileCard extends ConsumerWidget {
  const _ProfileCard({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;

    return TtCard(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: tt.gold, width: 2.5),
            ),
            child: ClipOval(
              child: TtNetworkImage(
                url: user.avatarUrl,
                width: 56,
                height: 56,
                radius: BorderRadius.circular(28),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName.isEmpty ? user.username : user.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    color: tt.text,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(color: tt.muted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          TtIconButton(
            icon: Icons.edit_rounded,
            tooltip: 'Sửa họ tên',
            onPressed: () => showEditNameDialog(context, ref, user),
          ),
        ],
      ),
    );
  }
}

class _Item {
  const _Item({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing = Icons.chevron_right_rounded,
    this.badge = 0,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final IconData trailing;

  /// Số chưa đọc hiện trong viên vàng trước mũi tên (0 = ẩn).
  final int badge;
}

/// Một nhóm chức năng: nhãn nhóm + TtCard chứa các dòng ngăn cách bằng Divider.
class _Group extends StatelessWidget {
  const _Group({required this.title, required this.items});

  final String title;
  final List<_Item> items;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: textTheme.titleSmall?.copyWith(
              color: tt.text,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TtCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0) Divider(height: 1, color: tt.line),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: tt.gold.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(TtRadius.md),
                    ),
                    child: Icon(items[i].icon, size: 20, color: tt.goldDeep),
                  ),
                  title: Text(
                    items[i].label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyLarge?.copyWith(
                      color: tt.text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (items[i].badge > 0) ...[
                        UnreadBadge(count: items[i].badge),
                        const SizedBox(width: 8),
                      ],
                      Icon(items[i].trailing, color: tt.muted),
                    ],
                  ),
                  onTap: items[i].onTap,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
