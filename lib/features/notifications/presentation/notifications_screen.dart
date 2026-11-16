import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_child_avatar.dart';
import '../../../core/widgets/tt_confirm_dialog.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_profile_dto.dart';
import '../../../models/notification_dto.dart';
import '../../children/presentation/children_providers.dart';
import '../data/notification_repository.dart';
import '../notification_text.dart';

String _errorText(Object error) => error is ApiException
    ? error.message
    : 'Chưa kết nối được máy chủ. Bạn thử lại sau ít phút nhé.';

/// Danh sách thông báo của phụ huynh: chạm để đọc và mở màn liên quan.
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  bool _busy = false;

  void _reload() {
    ref.invalidate(notificationsProvider);
    ref.invalidate(unreadNotificationCountProvider);
  }

  /// Chạy một thao tác API; lỗi thì hiện toast. Trả true nếu thành công.
  Future<bool> _run(Future<void> Function() action, {String? success}) async {
    if (_busy) return false;
    setState(() => _busy = true);
    try {
      await action();
      _reload();
      if (success != null && mounted) {
        showTtToast(context, success, type: TtToastType.success);
      }
      return true;
    } catch (e) {
      if (mounted) showTtToast(context, _errorText(e), type: TtToastType.error);
      return false;
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _open(NotificationDto n) async {
    final repo = ref.read(notificationRepositoryProvider);
    if (n.isUnread && !await _run(() => repo.markRead(n.id))) return;
    final target = notificationTarget(n);
    if (target == null || !mounted) return;
    if (n.childProfileId != null) {
      ref.read(selectedChildIdProvider.notifier).select(n.childProfileId!);
    }
    context.go(target);
  }

  Future<void> _delete(NotificationDto n) async {
    final ok = await showConfirmDialog(
      context,
      title: 'Xoá thông báo này?',
      message: 'Thông báo sẽ bị xoá khỏi danh sách và không khôi phục được.',
      confirmLabel: 'Xoá',
      destructive: true,
    );
    if (!ok || !mounted) return;
    await _run(
      () => ref.read(notificationRepositoryProvider).delete(n.id),
      success: 'Đã xoá thông báo.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(notificationsProvider);
    final hasUnread = async.value?.any((n) => n.isUnread) ?? false;
    final children = {
      for (final c in ref.watch(childrenListProvider).value ?? <ChildProfileDto>[])
        c.id: c,
    };

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Thông báo'),
        actions: [
          TtIconButton(
            icon: Icons.done_all_rounded,
            tooltip: 'Đánh dấu tất cả đã đọc',
            onPressed: hasUnread && !_busy
                ? () => _run(
                      ref.read(notificationRepositoryProvider).markAllRead,
                      success: 'Đã đánh dấu tất cả là đã đọc.',
                    )
                : null,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: async.when(
              loading: () => ListView.separated(
                padding: const EdgeInsets.all(16),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (_, _) => const TtSkeleton(
                  height: 84,
                  radius: BorderRadius.all(Radius.circular(TtRadius.lg)),
                ),
              ),
              error: (e, _) => Center(
                child: TtErrorState(
                  title: 'Chưa tải được thông báo',
                  message: _errorText(e),
                  onRetry: _reload,
                ),
              ),
              data: (items) => RefreshIndicator(
                onRefresh: () async {
                  _reload();
                  try {
                    await ref.read(notificationsProvider.future);
                  } catch (_) {}
                },
                child: items.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        children: const [SizedBox(height: 48), _Empty()],
                      )
                    : ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: items.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (_, i) => _NotificationTile(
                          key: ValueKey('notification-${items[i].id}'),
                          item: items[i],
                          child: children[items[i].childProfileId],
                          onTap: _busy ? null : () => _open(items[i]),
                          onDelete: _busy ? null : () => _delete(items[i]),
                        )
                            .animate(delay: (40 * i.clamp(0, 8)).ms)
                            .fadeIn(duration: 260.ms)
                            .slideY(begin: 0.06, end: 0, duration: 260.ms),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TtFrog(mood: TtFrogMood.happy, size: 120),
        const SizedBox(height: 16),
        Text(
          'Chưa có thông báo nào',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    super.key,
    required this.item,
    required this.child,
    required this.onTap,
    required this.onDelete,
  });

  final NotificationDto item;
  final ChildProfileDto? child;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final unread = item.isUnread;
    final time = relativeTime(item.createdAt);
    final meta = child == null ? time : '${child!.nickname} · $time';

    return TtCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Ink(
        color: unread ? tt.gold.withValues(alpha: 0.14) : null,
        padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
        child: Row(
          children: [
            if (child != null)
              TtChildAvatar(avatarId: child!.avatarId, size: 44)
            else
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: tt.gold.withValues(alpha: 0.22),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_rounded,
                  size: 22,
                  color: tt.goldDeep,
                ),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notificationText(item),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall?.copyWith(
                      color: tt.text,
                      fontWeight: unread ? FontWeight.w800 : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    meta,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(color: tt.muted),
                  ),
                ],
              ),
            ),
            if (unread)
              Semantics(
                label: 'Chưa đọc',
                child: Container(
                  key: const ValueKey('unread-dot'),
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: tt.gold,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            TtIconButton(
              icon: Icons.delete_outline_rounded,
              tooltip: 'Xoá thông báo',
              onPressed: onDelete,
              size: 44,
            ),
          ],
        ),
      ),
    );
  }
}
