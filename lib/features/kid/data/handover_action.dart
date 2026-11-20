import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/storage/token_storage.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_toast.dart';
import 'package:ai_storytelling_mobile/models/child_profile_dto.dart';
import 'package:ai_storytelling_mobile/models/child_session_dto.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_session_controller.dart';
import 'package:ai_storytelling_mobile/features/kid/data/stored_kid_session.dart';

Future<void> handoverChildToKid(
  BuildContext context,
  WidgetRef ref,
  ChildProfileDto child,
) => _handover(
  context,
  ref,
  child.id,
  (repo, refresh) =>
      repo.startHandover(childId: child.id, supervisorRefreshToken: refresh),
);

/// Giao máy cho bé và mở thẳng truyện [storyId] trong Chế độ của bé.
Future<void> handoverStoryToKid(
  BuildContext context,
  WidgetRef ref,
  int childId,
  int storyId,
) => _handover(
  context,
  ref,
  childId,
  (repo, refresh) => repo.startStoryHandover(
    childId: childId,
    storyId: storyId,
    supervisorRefreshToken: refresh,
  ),
  storyId: storyId,
);

Future<void> _handover(
  BuildContext context,
  WidgetRef ref,
  int childId,
  Future<ChildSessionDto> Function(KidRepository repo, String refresh) login, {
  int? storyId,
}) async {
  // Lấy router trước: bật phiên bé sẽ đổi trang và có thể gỡ màn đang mở.
  final router = GoRouter.of(context);
  try {
    final refresh = await ref.read(tokenStorageProvider).readRefreshToken();
    if (refresh == null || refresh.trim().isEmpty) {
      if (context.mounted) {
        showTtToast(
          context,
          'Phiên đăng nhập đã hết hạn. Hãy đăng nhập lại.',
          type: TtToastType.error,
        );
      }
      return;
    }

    final repo = ref.read(kidRepositoryProvider);
    final session = await login(repo, refresh.trim());

    var gate = true;
    try {
      final policy = await repo.getSafetyPolicy(childId);
      gate = policy.parentalGateEnabled;
    } catch (_) {
      gate = true;
    }

    await ref.read(kidSessionProvider.notifier).start(
          StoredKidSession.fromChildSession(
            session,
            via: KidSessionVia.handover,
            parentalGateEnabled: gate,
          ),
        );

    router.go('/kid');
    if (storyId != null) router.push('/kid/read/$storyId');
  } on ApiException catch (e) {
    if (context.mounted) {
      showTtToast(context, e.message, type: TtToastType.error);
    }
  } catch (_) {
    if (context.mounted) {
      showTtToast(
        context,
        'Có lỗi xảy ra. Vui lòng thử lại.',
        type: TtToastType.error,
      );
    }
  }
}
