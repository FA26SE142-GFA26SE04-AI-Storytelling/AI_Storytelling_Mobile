import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/widgets/tt_confirm_dialog.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_profile_dto.dart';
import '../../../models/safety_policy_dto.dart';
import '../data/archived_children_store.dart';
import '../data/child_profile_repository.dart';
import 'children_providers.dart';

/// Các thao tác vòng đời của một hồ sơ bé.
enum ChildLifecycleAction {
  activate,
  suspend,
  resume,
  archive,
  restore,
}

/// Thực hiện thao tác vòng đời trên hồ sơ bé với xác nhận người dùng và cập nhật trạng thái.
Future<bool> runChildLifecycleAction({
  required BuildContext context,
  required WidgetRef ref,
  required ChildProfileDto child,
  required ChildLifecycleAction action,
}) async {
  final String title;
  final String message;
  final bool destructive;
  final String successToast;

  switch (action) {
    case ChildLifecycleAction.activate:
      title = 'Kích hoạt hồ sơ của ${child.nickname}?';
      message = 'Bé sẽ bắt đầu đọc truyện được.';
      destructive = false;
      successToast = 'Hồ sơ đã được kích hoạt.';
    case ChildLifecycleAction.suspend:
      title = 'Tạm dừng hồ sơ của ${child.nickname}?';
      message =
          'Bé sẽ thoát khỏi phiên đang đọc và mã QR đăng nhập bị thu hồi.';
      destructive = false;
      successToast = 'Đã tạm dừng hồ sơ.';
    case ChildLifecycleAction.resume:
      title = 'Tiếp tục hồ sơ của ${child.nickname}?';
      message = '';
      destructive = false;
      successToast =
          'Hồ sơ đã hoạt động trở lại. Tạo mã QR mới nếu bé cần đăng nhập.';
    case ChildLifecycleAction.archive:
      title = 'Lưu trữ hồ sơ của ${child.nickname}?';
      message =
          'Hồ sơ bị ẩn khỏi danh sách, mọi phiên và mã QR của bé bị thu hồi.';
      destructive = true;
      successToast = 'Đã lưu trữ hồ sơ.';
    case ChildLifecycleAction.restore:
      title = 'Khôi phục hồ sơ của ${child.nickname}?';
      message = 'Mã QR cũ không dùng lại được, cần tạo mã mới.';
      destructive = false;
      successToast = 'Đã khôi phục hồ sơ.';
  }

  // 1) Popup xác nhận trước mọi action
  final confirmed = await showConfirmDialog(
    context,
    title: title,
    message: message,
    confirmLabel: 'Đồng ý',
    cancelLabel: 'Huỷ',
    destructive: destructive,
  );

  if (!confirmed) {
    return false;
  }

  if (!context.mounted) {
    return false;
  }

  final repo = ref.read(childProfileRepositoryProvider);

  try {
    // 2) Gọi repo xử lý theo từng action
    switch (action) {
      case ChildLifecycleAction.activate:
        await repo.activate(child.id);

      case ChildLifecycleAction.suspend:
        await repo.suspend(child.id);

      case ChildLifecycleAction.resume:
        SafetyPolicyDto? safety;
        try {
          safety = await repo.fetchSafety(child.id);
        } on ApiException catch (e) {
          if (e.statusCode == 404) {
            safety = null;
          } else {
            rethrow;
          }
        }

        bool acceptCurrentConsent = false;
        if (safety?.consentOutdated == true) {
          if (!context.mounted) {
            return false;
          }

          final consentConfirmed = await showConfirmDialog(
            context,
            title: 'Điều khoản sử dụng đã thay đổi',
            message:
                'Bạn đồng ý với điều khoản hiện tại để tiếp tục hồ sơ?',
            confirmLabel: 'Đồng ý',
            cancelLabel: 'Huỷ',
          );

          if (!consentConfirmed) {
            return false;
          }
          acceptCurrentConsent = true;
        }

        await repo.resume(child.id, acceptCurrentConsent: acceptCurrentConsent);

      case ChildLifecycleAction.archive:
        await repo.archive(child.id);
        await ref.read(archivedChildrenStoreProvider).add(
              ArchivedChild(
                id: child.id,
                nickname: child.nickname,
                avatarId: int.tryParse(child.avatarId),
              ),
            );
        ref.invalidate(archivedChildrenProvider);

      case ChildLifecycleAction.restore:
        await repo.restore(child.id);
        await ref.read(archivedChildrenStoreProvider).remove(child.id);
        ref.invalidate(archivedChildrenProvider);
    }

    // 3) Thành công: invalidate các providers
    ref.invalidate(childrenListProvider);
    ref.invalidate(childOverviewProvider(child.id));
    ref.invalidate(childDetailProvider(child.id));

    if (context.mounted) {
      showTtToast(context, successToast, type: TtToastType.success);
    }

    return true;
  } on ApiException catch (e) {
    // 4) Lỗi: hiển thị toast lỗi
    if (context.mounted) {
      showTtToast(
        context,
        e.message.isNotEmpty ? e.message : 'Không thực hiện được.',
        type: TtToastType.error,
      );
    }
    return false;
  } catch (_) {
    if (context.mounted) {
      showTtToast(
        context,
        'Không thực hiện được.',
        type: TtToastType.error,
      );
    }
    return false;
  }
}
