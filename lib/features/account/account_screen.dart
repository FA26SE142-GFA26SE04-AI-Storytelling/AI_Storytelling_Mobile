import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme/theme_mode_controller.dart';
import '../../app/theme/tt_colors.dart';
import '../../app/theme/tt_theme.dart';
import '../../core/env.dart';
import '../../shared/motion/motion.dart';
import '../../shared/widgets/feedback.dart';
import '../../shared/widgets/tt_button.dart';
import '../auth/auth_controller.dart';
import '../shell/tt_page.dart';

/// Tab "Bé": hồ sơ bé, Báo cáo, Cài đặt an toàn (P1–P4) và tài khoản phụ huynh.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Đăng xuất?'),
        content: const Text('Bạn sẽ cần đăng nhập lại để quản lý truyện của bé.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Ở lại')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Đăng xuất')),
        ],
      ),
    );
    if (ok == true) await ref.read(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.tt;
    final text = Theme.of(context).textTheme;
    final user = ref.watch(authControllerProvider).value;
    final mode = ref.watch(themeModeProvider);

    return TtPage(
      title: 'Bé và tài khoản',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: riseIn(context, [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: c.primary.withValues(alpha: 0.16),
                    child: Text(user?.initial ?? '?', style: text.headlineSmall?.copyWith(color: c.primaryStrong)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user?.fullName ?? '', style: text.titleMedium),
                        Text(user?.email ?? '', style: text.bodySmall),
                      ],
                    ),
                  ),
                  if (Env.useMock) const StatusPill(label: 'Dữ liệu mẫu', tone: PillTone.wait),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Giao diện', style: text.titleMedium),
          const SizedBox(height: 4),
          Text('Giao diện tối dịu mắt hơn khi bé đọc trước giờ ngủ.', style: text.bodySmall),
          const SizedBox(height: 10),
          SegmentedButton<ThemeMode>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: ThemeMode.light, icon: Icon(Icons.light_mode_rounded), label: Text('Sáng')),
              ButtonSegment(value: ThemeMode.dark, icon: Icon(Icons.dark_mode_rounded), label: Text('Tối')),
              ButtonSegment(value: ThemeMode.system, icon: Icon(Icons.phone_iphone_rounded), label: Text('Theo máy')),
            ],
            selected: {mode},
            onSelectionChanged: (s) => ref.read(themeModeProvider.notifier).set(s.first),
          ),
          const SizedBox(height: 32),
          Align(
            alignment: Alignment.centerLeft,
            child: TtButton(label: 'Đăng xuất', icon: Icons.logout_rounded, variant: TtButtonVariant.danger, onPressed: () => _confirmLogout(context, ref)),
          ),
          const SizedBox(height: 12),
          Text('Taletale · ${Env.useMock ? 'dữ liệu mẫu' : Env.apiBaseUrl}', style: text.labelSmall?.copyWith(fontFamily: TtFonts.ui)),
        ]),
      ),
    );
  }
}
