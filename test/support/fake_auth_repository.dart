// Giả lập AuthRepository để dùng trong test
import 'package:ai_storytelling_mobile/features/auth/data/auth_repository.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_models.dart';
import 'package:ai_storytelling_mobile/core/network/api_exception.dart';

class FakeAuthRepository implements AuthRepository {
  // Cờ kiểm soát trạng thái phiên
  bool hasSession = false;

  // Dữ liệu trả về cho các method
  UserProfile? meUser;
  UserProfile? loginUser;

  // Lỗi giả lập
  ApiException? loginError;
  ApiException? meError;

  // Đếm số lần logout được gọi
  int logoutCalls = 0;

  @override
  Future<bool> hasStoredSession() async => hasSession;

  @override
  Future<UserProfile> login({
    required String identifier,
    required String password,
  }) async {
    if (loginError != null) throw loginError!;
    return loginUser!;
  }

  @override
  Future<UserProfile> fetchMe() async {
    if (meError != null) throw meError!;
    return meUser!;
  }

  @override
  Future<void> logout() async {
    logoutCalls++;
  }

  @override
  Future<void> register({
    required String username,
    required String email,
    required String fullName,
    required String password,
    required String confirmPassword,
  }) async {
    // no-op
  }

  @override
  Future<void> verifyEmail({
    required String email,
    required String otp,
  }) async {
    // no-op
  }

  @override
  Future<void> resendVerificationEmail({required String email}) async {
    // no-op
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    // no-op
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    // no-op
  }
}

/// Tạo UserProfile mẫu để dùng trong test
UserProfile fakeUser({String role = 'User'}) => UserProfile(
      id: 1,
      username: 'phuhuynh',
      email: 'ph@example.com',
      fullName: 'Phụ huynh',
      role: role,
      status: 'Active',
    );
