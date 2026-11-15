import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/storage/token_storage.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_toast.dart';
import 'package:ai_storytelling_mobile/models/child_profile_dto.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_session_controller.dart';
import 'package:ai_storytelling_mobile/features/kid/data/stored_kid_session.dart';

Future<void> handoverChildToKid(
  BuildContext context,
  WidgetRef ref,
  ChildProfileDto child,
) async {
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
    final login = await repo.startHandover(
      childId: child.id,
      supervisorRefreshToken: refresh.trim(),
    );

    var gate = true;
    try {
      final policy = await repo.getSafetyPolicy(child.id);
      gate = policy.parentalGateEnabled;
    } catch (_) {
      gate = true;
    }

    await ref.read(kidSessionProvider.notifier).start(
          StoredKidSession.fromChildSession(
            login,
            via: KidSessionVia.handover,
            parentalGateEnabled: gate,
          ),
        );

    if (context.mounted) {
      context.go('/kid');
    }
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
