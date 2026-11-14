import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'kid_repository.dart';
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

  // Giống web (useKidSession): kiểm tra mỗi 15 giây, hết phiên sau 20 phút không hoạt động.
  static const _checkEvery = Duration(seconds: 15);
  static const _idleAfter = Duration(minutes: 20);
  // Backend ghi hoạt động tối đa 1 lần/phút nên không hỏi dày hơn.
  static const _pingEvery = Duration(minutes: 1);

  /// Đồng hồ; test thay để giả lập thời gian trôi.
  @visibleForTesting
  DateTime Function() now = DateTime.now;

  Timer? _timer;
  DateTime _lastActivity = DateTime.now();
  DateTime _lastPing = DateTime.now();

  @override
  KidSessionState build() {
    ref.onDispose(() => _timer?.cancel());
    Future.microtask(restore);
    return const KidChecking();
  }

  /// Đổi trạng thái; chỉ chạy bộ hẹn giờ kiểm tra phiên khi bé đang có phiên.
  void _set(KidSessionState next) {
    state = next;
    _timer?.cancel();
    _timer = null;
    if (next is KidActive) {
      _lastActivity = _lastPing = now();
      _timer = Timer.periodic(_checkEvery, (_) => _tick());
    }
  }

  /// Bé vừa chạm màn hình hoặc đang nghe đọc: lùi mốc hết phiên vì không hoạt động.
  void touch() => _lastActivity = now();

  /// Màn đọc bật khi giọng đọc đang phát (giống `isNarrating` của web).
  bool narrating = false;

  Future<void> _tick() async {
    final current = state;
    if (current is! KidActive) return;
    final at = now();
    if (narrating) _lastActivity = at;
    if (at.difference(_lastActivity) >= _idleAfter) {
      markEnded();
      return;
    }
    // Chỉ báo backend khi bé vừa hoạt động, để backend cũng tự hết hạn khi bé bỏ dở.
    if (_lastActivity.isAfter(_lastPing) &&
        at.difference(_lastPing) >= _pingEvery) {
      _lastPing = at;
      try {
        await ref
            .read(kidRepositoryProvider)
            .getSessionProfile(current.session.accessToken);
      } catch (_) {
        // 401/403 đã tự gọi markEnded; mất mạng thì giữ phiên, lần sau thử lại.
      }
    }
  }

  /// Khôi phục phiên đã lưu từ kho lưu trữ
  Future<void> restore() async {
    if (state is! KidChecking) {
      return;
    }
    try {
      final session = await _store.read().timeout(
        const Duration(seconds: 5),
        onTimeout: () => null,
      );
      _set(session == null ? const KidNone() : KidActive(session));
    } catch (_) {
      _set(const KidNone());
    }
  }

  /// Bắt đầu phiên đọc mới của bé
  Future<void> start(StoredKidSession session) async {
    await _store.save(session);
    _set(KidActive(session));
  }

  /// Đánh dấu phiên đã kết thúc (backend từ chối hoặc bé không hoạt động quá lâu)
  void markEnded() {
    if (state is KidActive) {
      _set(const KidEnded());
      unawaited(_store.clear());
    }
  }

  /// Kết thúc phiên đọc chủ động
  Future<void> end() async {
    _set(const KidNone());
    await _store.clear();
  }
}

/// Provider cung cấp [KidSessionController]
final kidSessionProvider =
    NotifierProvider<KidSessionController, KidSessionState>(
      KidSessionController.new,
    );
