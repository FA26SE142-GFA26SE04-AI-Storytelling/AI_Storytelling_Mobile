import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/reading_schedule_dto.dart';

// ─── Abstract contract ───────────────────────────────────────────────────────

abstract class ReadingScheduleRepository {
  Future<ReadingScheduleDto> fetch(int childId);
  Future<ReadingScheduleDto> save(int childId, Map<String, dynamic> body);
}

// ─── Implementation ──────────────────────────────────────────────────────────

class ApiReadingScheduleRepository implements ReadingScheduleRepository {
  final Dio dio;

  ApiReadingScheduleRepository({required this.dio});

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
  Future<ReadingScheduleDto> fetch(int childId) => runApi(() async {
        final response = await dio.get<dynamic>('/ReadingSchedule/$childId');
        final data = _unwrap(response);
        return ReadingScheduleDto.fromJson(data as Map<String, dynamic>);
      });

  @override
  Future<ReadingScheduleDto> save(int childId, Map<String, dynamic> body) =>
      runApi(() async {
        final response = await dio.put<dynamic>(
          '/ReadingSchedule/$childId',
          data: body,
        );
        final data = _unwrap(response);
        return ReadingScheduleDto.fromJson(data as Map<String, dynamic>);
      });
}

// ─── Provider ────────────────────────────────────────────────────────────────

final readingScheduleRepositoryProvider = Provider<ReadingScheduleRepository>(
  (ref) => ApiReadingScheduleRepository(dio: ref.watch(dioProvider)),
);
