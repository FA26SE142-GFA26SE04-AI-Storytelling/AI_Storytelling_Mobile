import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'kid_repository.dart';
import 'kid_session_controller.dart';

/// Provider định kỳ kiểm tra tính hợp lệ của phiên bé mỗi 15 giây.
final kidSessionWatcherProvider = Provider.autoDispose<void>((ref) {
  final state = ref.watch(kidSessionProvider);
  if (state is! KidActive) return;
  final token = state.session.accessToken;
  final timer = Timer.periodic(const Duration(seconds: 15), (_) async {
    try {
      await ref.read(kidRepositoryProvider).getSessionProfile(token);
    } catch (_) {
      // 401/403 đã được kidRepository báo kết thúc phiên; lỗi mạng thì thử lại lần sau.
    }
  });
  ref.onDispose(timer.cancel);
});
