import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Quản lý lưu trữ bảo mật cho access token, refresh token và phiên của bé.
class TokenStorage {
  TokenStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const String _accessTokenKey = 'tt_access_token';
  static const String _refreshTokenKey = 'tt_refresh_token';
  static const String _childSessionKey = 'tt_child_session';

  /// Lưu access token và refresh token.
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  /// Đọc access token.
  Future<String?> readAccessToken() async {
    return _storage.read(key: _accessTokenKey);
  }

  /// Đọc refresh token.
  Future<String?> readRefreshToken() async {
    return _storage.read(key: _refreshTokenKey);
  }

  /// Chỉ xoá access và refresh token, KHÔNG xoá phiên của bé.
  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  /// Lưu thông tin phiên làm việc của bé (dạng chuỗi JSON).
  Future<void> saveChildSession(String json) async {
    await _storage.write(key: _childSessionKey, value: json);
  }

  /// Đọc thông tin phiên làm việc của bé.
  Future<String?> readChildSession() async {
    return _storage.read(key: _childSessionKey);
  }

  /// Xoá phiên làm việc của bé.
  Future<void> clearChildSession() async {
    await _storage.delete(key: _childSessionKey);
  }

  /// Xoá cả token và phiên của bé.
  Future<void> clearAll() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _childSessionKey);
  }
}

/// Provider cung cấp instance [TokenStorage].
final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());
