import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ai_storytelling_mobile/core/widgets/tt_button.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_card.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_confirm_dialog.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_frog.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_state_views.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';

/// Màn hình thông báo tài khoản không được phép đăng nhập trên thiết bị di động.
class BlockedScreen extends ConsumerWidget {
  const BlockedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: TtCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TtFrog(
                    mood: TtFrogMood.think,
                    size: 96,
                  ),
                  const SizedBox(height: 8),
                  const TtEmptyState(
                    icon: Icons.computer_rounded,
                    title: 'Tài khoản này dùng trên web',
                    message:
                        'Tài khoản này dùng trên web taletale.site. Ứng dụng hiện chỉ dành cho phụ huynh.',
                  ),
                  const SizedBox(height: 16),
                  TtButton(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
