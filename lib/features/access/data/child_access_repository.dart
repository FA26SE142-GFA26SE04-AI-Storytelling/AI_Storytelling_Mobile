import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/child_access_credential_dto.dart';

// ─── Abstract contract ───────────────────────────────────────────────────────

abstract class ChildAccessRepository {
  Future<ChildAccessCredentialDto> fetchCredential(int id);
  Future<EasyLoginSecretDto> generateEasyLogin(int id);
  Future<void> revokeCredential(int id);
}

// ─── Implementation ──────────────────────────────────────────────────────────

class ApiChildAccessRepository implements ChildAccessRepository {
  final Dio dio;

  ApiChildAccessRepository({required this.dio});

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
  Future<ChildAccessCredentialDto> fetchCredential(int id) => runApi(() async {
        final response = await dio.get<dynamic>('/ChildAccessCredential/$id');
        final data = _unwrap(response);
        return ChildAccessCredentialDto.fromJson(data as Map<String, dynamic>);
      });

  @override
  Future<EasyLoginSecretDto> generateEasyLogin(int id) => runApi(() async {
        final response =
            await dio.post<dynamic>('/ChildAccessCredential/$id/easylogin');
        final data = _unwrap(response);
        return EasyLoginSecretDto.fromJson(data as Map<String, dynamic>);
      });

  @override
  Future<void> revokeCredential(int id) => runApi(() async {
        final response =
            await dio.delete<dynamic>('/ChildAccessCredential/$id');
        _unwrap(response);
      });
}

// ─── Provider ────────────────────────────────────────────────────────────────

final childAccessRepositoryProvider = Provider<ChildAccessRepository>(
  (ref) => ApiChildAccessRepository(dio: ref.watch(dioProvider)),
);
