import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/tt_colors.dart';
import '../../auth/application/auth_controller.dart';

/// Ảnh đại diện tài khoản đang đăng nhập (tròn, viền rõ); không có ảnh hoặc ảnh
/// lỗi thì hiện chữ cái đầu tên. Bấm để sang tab Tài khoản.
class AccountAvatarButton extends ConsumerWidget {
  const AccountAvatarButton({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tt = context.tt;
    final auth = ref.watch(authControllerProvider);
    final user = auth is AuthSignedIn ? auth.user : null;
    final name = (user?.fullName.trim().isNotEmpty ?? false)
        ? user!.fullName.trim()
        : (user?.username ?? '');
    final url = (user?.avatarUrl ?? '').trim();

    final initial = Container(
      color: tt.primary,
      alignment: Alignment.center,
      child: Text(
        name.isEmpty ? '?' : name.characters.first.toUpperCase(),
        style: Theme.of(context).textTheme.titleMedium
            ?.copyWith(color: Colors.white, fontSize: size * 0.42, height: 1),
      ),
    );

    void open() => context.go(AppRoutes.account);

    return Semantics(
      button: true,
      label: 'Tài khoản',
      excludeSemantics: true,
      onTap: open,
      child: Tooltip(
        message: 'Tài khoản',
        child: InkWell(
          onTap: open,
          customBorder: const CircleBorder(),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: tt.gold, width: 2),
            ),
            child: ClipOval(
              child: url.isEmpty
                  ? initial
                  : Image.network(
                      url,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) =>
                          progress == null ? child : initial,
                      errorBuilder: (_, _, _) => initial,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
