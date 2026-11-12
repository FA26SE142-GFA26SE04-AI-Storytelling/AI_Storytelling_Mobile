import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/token_storage.dart';
import 'auth_models.dart';

// ─── Abstract contract ───────────────────────────────────────────────────────

abstract class AuthRepository {
  /// Kiểm tra xem có phiên đăng nhập đã lưu không.
  Future<bool> hasStoredSession();

  /// Đăng nhập, lưu token, trả về thông tin người dùng.
  Future<UserProfile> login({
    required String identifier,
    required String password,
  });

  /// Lấy thông tin người dùng hiện tại từ server.
  Future<UserProfile> fetchMe();

  /// Đăng xuất: gọi API rồi xóa toàn bộ dữ liệu cục bộ.
  Future<void> logout();

  /// Đăng ký tài khoản mới.
  Future<void> register({
    required String username,
    required String email,
    required String fullName,
    required String password,
    required String confirmPassword,
  });

  /// Xác minh email bằng OTP.
  Future<void> verifyEmail({required String email, required String otp});

  /// Gửi lại email xác minh.
  Future<void> resendVerificationEmail({required String email});

  /// Gửi yêu cầu quên mật khẩu.
  Future<void> forgotPassword({required String email});

  /// Đặt lại mật khẩu bằng mã OTP.
  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  });
}

// ─── Implementation ──────────────────────────────────────────────────────────

class ApiAuthRepository implements AuthRepository {
  final Dio dio;
  final TokenStorage storage;

  ApiAuthRepository({required this.dio, required this.storage});

  Options get _anonOptions => Options(extra: {'anonymous': true});

  /// Giải nén data từ response theo cấu trúc {"success", "message", "data"}.
  /// Ném [ApiException] nếu success != true hoặc body bị null.
  dynamic _unwrap(Response<dynamic> response) {
    final body = response.data as Map<String, dynamic>?;
    if (body == null || body['success'] != true) {
      final msg = (body?['message'] as String?)?.trim();
      throw ApiException(
        statusCode: response.statusCode,
        message: (msg != null && msg.isNotEmpty)
            ? msg
            : 'Có lỗi xảy ra. Vui lòng thử lại.',
      );
    }
    return body['data'];
  }

  @override
  Future<bool> hasStoredSession() async {
    final access = await storage.readAccessToken();
    if (access != null && access.isNotEmpty) return true;
    // Fallback: kiểm tra refresh token
    final refresh = await storage.readRefreshToken();
    return refresh != null && refresh.isNotEmpty;
  }

  @override
  Future<UserProfile> login({
    required String identifier,
    required String password,
  }) =>
      runApi(() async {
        final response = await dio.post<dynamic>(
          '/Auth/login',
          data: {'identifier': identifier, 'password': password},
          options: _anonOptions,
        );
        final data = _unwrap(response);
        final session = AuthSession.fromJson(data as Map<String, dynamic>);

        // Lưu token (không log giá trị token)
        await storage.saveTokens(
          accessToken: session.accessToken,
          refreshToken: session.refreshToken,
        );
        return session.user;
      });

  @override
  Future<UserProfile> fetchMe() => runApi(() async {
        final response = await dio.get<dynamic>('/Auth/me');
        final data = _unwrap(response);
        return UserProfile.fromJson(data as Map<String, dynamic>);
      });

  @override
  Future<void> logout() async {
    // Lấy refresh token trước, không throw nếu không có
    String? refreshToken;
    try {
      refreshToken = await storage.readRefreshToken();
    } catch (_) {}

    try {
      if (refreshToken != null && refreshToken.isNotEmpty) {
        // Gọi API logout, bỏ qua lỗi trả về
        try {
          await dio.post<dynamic>(
            '/Auth/logout',
            data: {'refreshToken': refreshToken},
          );
        } catch (_) {
          // Bỏ qua mọi lỗi từ server khi logout
        }
      }
    } finally {
      // Luôn xóa toàn bộ dữ liệu cục bộ dù API có lỗi hay không
      await storage.clearAll();
    }
  }

  @override
  Future<void> register({
    required String username,
    required String email,
    required String fullName,
    required String password,
    required String confirmPassword,
  }) =>
      runApi(() async {
        final response = await dio.post<dynamic>(
          '/Auth/register',
          data: {
            'username': username,
            'email': email,
            'fullName': fullName,
            'password': password,
            'confirmPassword': confirmPassword,
          },
          options: _anonOptions,
        );
        _unwrap(response);
      });

  @override
  Future<void> verifyEmail({required String email, required String otp}) =>
      runApi(() async {
        final response = await dio.post<dynamic>(
          '/Auth/verify-email',
          data: {'email': email, 'otp': otp},
          options: _anonOptions,
        );
        _unwrap(response);
      });

  @override
  Future<void> resendVerificationEmail({required String email}) =>
      runApi(() async {
        final response = await dio.post<dynamic>(
          '/Auth/resend-verification-email',
          data: {'email': email},
          options: _anonOptions,
        );
        _unwrap(response);
      });

  @override
  Future<void> forgotPassword({required String email}) => runApi(() async {
        final response = await dio.post<dynamic>(
          '/Auth/forgot-password',
          data: {'email': email},
          options: _anonOptions,
        );
        _unwrap(response);
      });

  @override
  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) =>
      runApi(() async {
        final response = await dio.post<dynamic>(
          '/Auth/reset-password',
          data: {
            'email': email,
            'resetToken': code,
            'newPassword': newPassword,
            'confirmPassword': confirmPassword,
          },
          options: _anonOptions,
        );
        _unwrap(response);
      });
}

// ─── Riverpod provider ───────────────────────────────────────────────────────

/// Provider toàn cục cho [AuthRepository].
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => ApiAuthRepository(
    dio: ref.watch(dioProvider),
    storage: ref.watch(tokenStorageProvider),
  ),
);
