import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/child_profile_dto.dart';

// ─── Abstract contract ───────────────────────────────────────────────────────

abstract class ChildProfileRepository {
  Future<List<ChildProfileDto>> fetchMine();
}

// ─── Implementation ──────────────────────────────────────────────────────────

class ApiChildProfileRepository implements ChildProfileRepository {
  final Dio dio;

  ApiChildProfileRepository({required this.dio});

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
  Future<List<ChildProfileDto>> fetchMine() => runApi(() async {
        final response = await dio.get<dynamic>('/ChildProfile/mine');
        final data = _unwrap(response);
        if (data == null) return <ChildProfileDto>[];
        final list = data as List<dynamic>;
        return list
            .map((e) => ChildProfileDto.fromJson(e as Map<String, dynamic>))
            .toList();
      });
}

// ─── Provider ────────────────────────────────────────────────────────────────

final childProfileRepositoryProvider = Provider<ChildProfileRepository>(
  (ref) => ApiChildProfileRepository(dio: ref.watch(dioProvider)),
);
