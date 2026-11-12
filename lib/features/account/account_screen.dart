import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ai_storytelling_mobile/core/widgets/tt_button.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_confirm_dialog.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/shell/empty_tab_screen.dart';

/// Màn hình quản lý tài khoản người dùng.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EmptyTabScreen(
      title: 'Tài khoản',
      icon: Icons.person_rounded,
      message: 'Hồ sơ, gói và phiên đăng nhập sẽ có ở các giai đoạn sau.',
      footer: TtButton(
        label: 'Đăng xuất',
        icon: Icons.logout_rounded,
        variant: TtButtonVariant.secondary,
        expanded: true,
        onPressed: () async {
          final confirmed = await showConfirmDialog(
            context,
            title: 'Đăng xuất?',
            message: 'Bạn có chắc muốn đăng xuất khỏi thiết bị này?',
            confirmLabel: 'Đăng xuất',
            destructive: true,
          );
          if (confirmed) {
            if (!context.mounted) return;
            await ref.read(authControllerProvider.notifier).logout();
          }
        },
      ),
    );
  }
}
