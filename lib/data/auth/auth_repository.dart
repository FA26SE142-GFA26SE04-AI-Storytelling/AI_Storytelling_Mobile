import '../../core/api/api_client.dart';
import '../../core/api/api_result.dart';
import '../../core/storage/session_storage.dart';
import 'auth_models.dart';

abstract interface class AuthRepository {
  /// Khôi phục phiên đã lưu khi mở app. Trả về null nếu chưa đăng nhập hoặc phiên đã hết hạn.
  Future<UserProfile?> restore();

  Future<ApiResult<AuthSession>> login({required String identifier, required String password});

  Future<ApiResult<void>> register({
    required String username,
    required String email,
    required String fullName,
    required String password,
    required String confirmPassword,
  });

  Future<ApiResult<void>> forgotPassword({required String email});

  Future<ApiResult<void>> resetPassword({required String email, required String resetToken, required String newPassword, required String confirmPassword});

  Future<void> logout();
}

class ApiAuthRepository implements AuthRepository {
  ApiAuthRepository(this._api, this._session);

  final ApiClient _api;
  final SessionStorage _session;

  @override
  Future<UserProfile?> restore() async {
    await _session.load();
    if (!_session.hasSession) return null;
    // Access token hết hạn thì ApiClient tự làm mới; làm mới thất bại thì phiên bị xoá.
    final res = await _api.request<UserProfile>('/Auth/me', parse: (d) => UserProfile.fromJson(d as Json));
    if (res.success && res.data != null) {
      await _session.saveUser(res.data!);
      return res.data;
    }
    // Mất mạng: vẫn cho vào app bằng hồ sơ đã lưu (bé có thể đọc truyện đã tải khi offline).
    if (res.isNetworkError && _session.hasSession) return _session.user;
    await _session.clear();
    return null;
  }

  @override
  Future<ApiResult<AuthSession>> login({required String identifier, required String password}) async {
    final res = await _api.request<AuthSession>(
      '/Auth/login',
      method: 'POST',
      auth: false,
      body: {'identifier': identifier, 'password': password},
      parse: (d) => AuthSession.fromJson(d as Json),
    );
    if (res.success && res.data != null) {
      await _session.save(res.data!);
      return res;
    }
    await _session.clear();
    return res.message.isEmpty ? const ApiResult.fail('Tài khoản hoặc mật khẩu không chính xác.') : res;
  }

  @override
  Future<ApiResult<void>> register({
    required String username,
    required String email,
    required String fullName,
    required String password,
    required String confirmPassword,
  }) => _api.request<void>(
    '/Auth/register',
    method: 'POST',
    auth: false,
    body: {'username': username, 'email': email, 'fullName': fullName, 'password': password, 'confirmPassword': confirmPassword},
  );

  @override
  Future<ApiResult<void>> forgotPassword({required String email}) =>
      _api.request<void>('/Auth/forgot-password', method: 'POST', auth: false, body: {'email': email});

  @override
  Future<ApiResult<void>> resetPassword({required String email, required String resetToken, required String newPassword, required String confirmPassword}) =>
      _api.request<void>(
        '/Auth/reset-password',
        method: 'POST',
        auth: false,
        body: {'email': email, 'resetToken': resetToken, 'newPassword': newPassword, 'confirmPassword': confirmPassword},
      );

  @override
  Future<void> logout() async {
    final refreshToken = _session.refreshToken;
    if (refreshToken != null && _session.accessToken != null) {
      // Lỗi khi báo đăng xuất cho máy chủ không chặn việc đăng xuất trên máy.
      await _api.request<void>('/Auth/logout', method: 'POST', body: {'refreshToken': refreshToken});
    }
    await _session.clear();
  }
}
