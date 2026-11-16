import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../data/notification_repository.dart';

/// Mở màn Thông báo; quay lại thì tải lại số chưa đọc.
Future<void> openNotifications(BuildContext context, WidgetRef ref) async {
  await context.push('/notifications');
  ref.invalidate(unreadNotificationCountProvider);
}

/// Số chưa đọc (lỗi/đang tải coi như 0 để không hiện badge sai).
int watchUnreadCount(WidgetRef ref) =>
    ref.watch(unreadNotificationCountProvider).value ?? 0;

/// Viên vàng chứa số chưa đọc.
class UnreadBadge extends StatelessWidget {
  const UnreadBadge({super.key, required this.count, this.child});

  final int count;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Badge(
      isLabelVisible: count > 0,
      backgroundColor: tt.gold,
      textColor: tt.text,
      label: Text(count > 99 ? '99+' : '$count'),
      child: child,
    );
  }
}

/// Nút chuông ở Trang chủ, kèm số chưa đọc.
class NotificationBellButton extends ConsumerWidget {
  const NotificationBellButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = watchUnreadCount(ref);
    return UnreadBadge(
      count: count,
      child: TtIconButton(
        icon: Icons.notifications_rounded,
        tooltip: count > 0 ? 'Thông báo, $count chưa đọc' : 'Thông báo',
        onPressed: () => openNotifications(context, ref),
      ),
    );
  }
}
