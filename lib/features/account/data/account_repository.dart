import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/token_storage.dart';
import '../../../models/audit_log_entry_dto.dart';
import '../../../models/login_session_dto.dart';

// ─── Abstract contract ───────────────────────────────────────────────────────

abstract class AccountRepository {
  Future<void> updateProfile({
    required String fullName,
    String? avatarUrl,
  });

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<void> requestEmailChange({
    required String currentPassword,
    required String newEmail,
  });

  Future<void> confirmEmailChange(String otp);

  Future<List<LoginSessionDto>> listSessions();

  Future<void> revokeSession(int id);

  Future<void> logoutAllDevices();

  Future<({List<AuditLogEntryDto> items, int totalPages})> accountAudit({
    int pageIndex = 0,
  });
}

// ─── Implementation ──────────────────────────────────────────────────────────

class ApiAccountRepository implements AccountRepository {
  final Dio dio;
  final TokenStorage tokenStorage;

  ApiAccountRepository({
    required this.dio,
    required this.tokenStorage,
  });

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
  Future<void> updateProfile({
    required String fullName,
    String? avatarUrl,
  }) =>
      runApi(() async {
        final response = await dio.put<dynamic>(
          '/Auth/me',
          data: {
            'fullName': fullName,
            'avatarUrl': avatarUrl,
          },
        );
        _unwrap(response);
      });

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) =>
      runApi(() async {
        final currentRefreshToken = await tokenStorage.readRefreshToken();
        final response = await dio.post<dynamic>(
          '/Auth/change-password',
          data: {
            'currentPassword': currentPassword,
            'newPassword': newPassword,
            'confirmPassword': confirmPassword,
            'currentRefreshToken': currentRefreshToken,
          },
        );
        _unwrap(response);
      });

  @override
  Future<void> requestEmailChange({
    required String currentPassword,
    required String newEmail,
  }) =>
      runApi(() async {
        final response = await dio.post<dynamic>(
          '/Auth/change-email',
          data: {
            'currentPassword': currentPassword,
            'newEmail': newEmail,
          },
        );
        _unwrap(response);
      });

  @override
  Future<void> confirmEmailChange(String otp) => runApi(() async {
        final response = await dio.post<dynamic>(
          '/Auth/change-email/confirm',
          data: {
            'otp': otp,
          },
        );
        _unwrap(response);
      });

  @override
  Future<List<LoginSessionDto>> listSessions() => runApi(() async {
        final response = await dio.get<dynamic>('/Auth/sessions');
        final data = _unwrap(response);
        if (data == null) return <LoginSessionDto>[];
        final list = data as List<dynamic>;
        return list
            .map((e) => LoginSessionDto.fromJson(e as Map<String, dynamic>))
            .toList();
      });

  @override
  Future<void> revokeSession(int id) => runApi(() async {
        final response = await dio.delete<dynamic>('/Auth/sessions/$id');
        _unwrap(response);
      });

  @override
  Future<void> logoutAllDevices() => runApi(() async {
        final response = await dio.post<dynamic>('/Auth/logout-all-devices');
        _unwrap(response);
      });

  @override
  Future<({List<AuditLogEntryDto> items, int totalPages})> accountAudit({
    int pageIndex = 0,
  }) =>
      runApi(() async {
        final response = await dio.get<dynamic>(
          '/Auth/me/audit-log',
          queryParameters: {
            'pageIndex': pageIndex,
            'pageSize': 20,
            'isDescending': true,
          },
        );
        final data = _unwrap(response);
        if (data == null) {
          return (items: <AuditLogEntryDto>[], totalPages: 1);
        }
        final map = data as Map<String, dynamic>;
        final rawItems = map['items'] as List<dynamic>? ?? const <dynamic>[];
        final items = rawItems
            .map((e) => AuditLogEntryDto.fromJson(e as Map<String, dynamic>))
            .toList();
        final totalPages = (map['totalPages'] as num?)?.toInt() ?? 1;
        return (items: items, totalPages: totalPages);
      });
}

// ─── Provider ────────────────────────────────────────────────────────────────

final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => ApiAccountRepository(
    dio: ref.watch(dioProvider),
    tokenStorage: ref.watch(tokenStorageProvider),
  ),
);
