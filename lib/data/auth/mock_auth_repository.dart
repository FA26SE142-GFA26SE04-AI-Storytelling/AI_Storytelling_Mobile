import '../../core/api/api_result.dart';
import '../../core/storage/session_storage.dart';
import 'auth_models.dart';
import 'auth_repository.dart';

const mockUser = UserProfile(id: 1, username: 'thuha', email: 'thuha@taletale.site', fullName: 'Nguyễn Thu Hà', role: 'Parent', status: 'Active');

/// Dữ liệu mẫu (USE_MOCK=true): đăng nhập bằng bất kỳ tài khoản nào, không gọi máy chủ.
/// Phiên vẫn được lưu như thật để đóng mở app không bị đăng xuất.
class MockAuthRepository implements AuthRepository {
  MockAuthRepository(this._session, {this.latency = const Duration(milliseconds: 220)});

  final SessionStorage _session;
  final Duration latency;

  @override
  Future<UserProfile?> restore() async {
    await _session.load();
    return _session.hasSession ? (_session.user ?? mockUser) : null;
  }

  @override
  Future<ApiResult<AuthSession>> login({required String identifier, required String password}) async {
    await Future<void>.delayed(latency);
    const session = AuthSession(accessToken: 'mock-access-token', refreshToken: 'mock-refresh-token', expiresInSeconds: 3600, user: mockUser);
    await _session.save(session);
    return const ApiResult.ok(session);
  }

  @override
  Future<ApiResult<void>> register({
    required String username,
    required String email,
    required String fullName,
    required String password,
    required String confirmPassword,
  }) async {
    await Future<void>.delayed(latency);
    return const ApiResult.ok(null, message: 'Đăng ký thành công (dữ liệu mẫu).');
  }

  @override
  Future<ApiResult<void>> forgotPassword({required String email}) async {
    await Future<void>.delayed(latency);
    return const ApiResult.ok(null, message: 'Đã gửi (dữ liệu mẫu).');
  }

  @override
  Future<ApiResult<void>> resetPassword({
    required String email,
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await Future<void>.delayed(latency);
    return const ApiResult.ok(null, message: 'Đã đổi mật khẩu (dữ liệu mẫu).');
  }

  @override
  Future<void> logout() => _session.clear();
}
