import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'kid_session_store.dart';
import 'stored_kid_session.dart';

// ─── Trạng thái phiên bé ───────────────────────────────────────────────────

/// Trạng thái phiên đọc của bé
sealed class KidSessionState {
  const KidSessionState();
}

/// Đang đọc phiên đã lưu
class KidChecking extends KidSessionState {
  const KidChecking();
}

/// Không có phiên bé
class KidNone extends KidSessionState {
  const KidNone();
}

/// Đang có phiên bé hoạt động
class KidActive extends KidSessionState {
  final StoredKidSession session;
  const KidActive(this.session);
}

/// Backend đã từ chối phiên bé: màn Phiên đọc đã kết thúc
class KidEnded extends KidSessionState {
  const KidEnded();
}

// ─── Controller ────────────────────────────────────────────────────────────

/// Quản lý trạng thái và vòng đời phiên đọc của bé
class KidSessionController extends Notifier<KidSessionState> {
  KidSessionStore get _store => ref.read(kidSessionStoreProvider);

  @override
  KidSessionState build() {
    Future.microtask(restore);
    return const KidChecking();
  }

  /// Khôi phục phiên đã lưu từ kho lưu trữ
  Future<void> restore() async {
    if (state is! KidChecking) {
      return;
    }
    try {
      final session = await _store
          .read()
          .timeout(const Duration(seconds: 5), onTimeout: () => null);
      if (session == null) {
        state = const KidNone();
      } else {
        state = KidActive(session);
      }
    } catch (_) {
      state = const KidNone();
    }
  }

  /// Bắt đầu phiên đọc mới của bé
  Future<void> start(StoredKidSession session) async {
    await _store.save(session);
    state = KidActive(session);
  }

  /// Đánh dấu phiên đã kết thúc từ phía backend
  void markEnded() {
    if (state is KidActive) {
      state = const KidEnded();
      unawaited(_store.clear());
    }
  }

  /// Kết thúc phiên đọc chủ động
  Future<void> end() async {
    state = const KidNone();
    await _store.clear();
  }
}

/// Provider cung cấp [KidSessionController]
final kidSessionProvider =
    NotifierProvider<KidSessionController, KidSessionState>(
  KidSessionController.new,
);
