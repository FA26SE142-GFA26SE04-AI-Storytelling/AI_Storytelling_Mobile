import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/application/auth_controller.dart';
import '../data/kid_session_controller.dart';
import '../data/stored_kid_session.dart';
import 'parental_gate_dialog.dart';

/// Rời chế độ bé về với bố mẹ (qua cổng phụ huynh khi bật). Dùng ở sảnh và màn nghỉ trong truyện.
Future<void> exitKidMode(BuildContext context, WidgetRef ref) async {
  final state = ref.read(kidSessionProvider);
  if (state is! KidActive) {
    ref.read(kidSessionProvider.notifier).end();
    return;
  }

  // Bé vào bằng mã QR tự thoát, không cần cổng phụ huynh (Luồng 3 Bước 3.0b, như web).
  if (!state.session.parentalGateEnabled ||
      state.session.via == KidSessionVia.easyLogin) {
    ref.read(kidSessionProvider.notifier).end();
    return;
  }

  final authState = ref.read(authControllerProvider);
  final email = authState is AuthSignedIn ? authState.user.email : '';
  final ok = await showParentalGateDialog(context, initialEmail: email);
  if (!context.mounted) return;
  if (ok) {
    ref.read(kidSessionProvider.notifier).end();
  }
}
