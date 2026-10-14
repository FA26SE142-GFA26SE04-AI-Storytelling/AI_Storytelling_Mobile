import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/auth/auth_models.dart';

/// Kho khoá–giá trị bảo mật. Tách ra để test dùng bản trong bộ nhớ.
abstract interface class SecureStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

/// Keychain (iOS) / EncryptedSharedPreferences (Android).
class FlutterSecureStore implements SecureStore {
  const FlutterSecureStore([this._storage = const FlutterSecureStorage()]);
  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);
  @override
  Future<void> write(String key, String value) => _storage.write(key: key, value: value);
  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}

/// Phiên đăng nhập: token và hồ sơ người dùng, giữ trong bộ nhớ và lưu vào kho bảo mật.
/// Dùng cùng tên khoá với web (`taletale_*`).
class SessionStorage {
  SessionStorage(this._store);

  static const accessKey = 'taletale_access_token';
  static const refreshKey = 'taletale_refresh_token';
  static const userKey = 'taletale_user_profile';

  final SecureStore _store;
  final _expired = StreamController<void>.broadcast();

  String? accessToken;
  String? refreshToken;
  UserProfile? user;

  bool get hasSession => accessToken != null || refreshToken != null;

  /// Phát ra khi phiên hết hạn và không làm mới được (refresh token bị thu hồi...).
  Stream<void> get onExpired => _expired.stream;

  Future<void> load() async {
    accessToken = await _store.read(accessKey);
    refreshToken = await _store.read(refreshKey);
    final raw = await _store.read(userKey);
    try {
      user = raw == null ? null : UserProfile.fromJson(jsonDecode(raw) as Json);
    } catch (_) {
      user = null;
    }
  }

  Future<void> save(AuthSession session) async {
    accessToken = session.accessToken;
    refreshToken = session.refreshToken;
    user = session.user;
    await _store.write(accessKey, session.accessToken);
    await _store.write(refreshKey, session.refreshToken);
    await _store.write(userKey, jsonEncode(session.user.toJson()));
  }

  Future<void> saveUser(UserProfile profile) async {
    user = profile;
    await _store.write(userKey, jsonEncode(profile.toJson()));
  }

  Future<void> clear({bool expired = false}) async {
    accessToken = null;
    refreshToken = null;
    user = null;
    await _store.delete(accessKey);
    await _store.delete(refreshKey);
    await _store.delete(userKey);
    if (expired) _expired.add(null);
  }

  void dispose() => _expired.close();
}
