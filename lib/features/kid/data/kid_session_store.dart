import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/token_storage.dart';
import 'stored_kid_session.dart';

class KidSessionStore {
  KidSessionStore(this._tokens);

  final TokenStorage _tokens;

  Future<void> save(StoredKidSession session) async {
    final jsonString = jsonEncode(session.toJson());
    await _tokens.saveChildSession(jsonString);
  }

  Future<StoredKidSession?> read({DateTime? now}) async {
    final raw = await _tokens.readChildSession();
    if (raw == null || raw.isEmpty) {
      return null;
    }

    final StoredKidSession session;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        await clear();
        return null;
      }
      session = StoredKidSession.fromJson(decoded);
    } catch (_) {
      await clear();
      return null;
    }

    final checkTime = now ?? DateTime.now();
    if (!session.isActiveAt(checkTime)) {
      await clear();
      return null;
    }

    return session;
  }

  Future<void> clear() async {
    await _tokens.clearChildSession();
  }
}

final kidSessionStoreProvider = Provider<KidSessionStore>((ref) {
  return KidSessionStore(ref.watch(tokenStorageProvider));
});
