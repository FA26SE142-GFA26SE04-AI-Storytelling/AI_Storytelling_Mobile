import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/child_roadmap_dto.dart';
import '../../../models/parent_reading_feedback_dto.dart';

/// Bé đã đọc gì và lộ trình của bé (dùng ở tab Học tập).
abstract class HomeRepository {
  /// GET /ParentReadingFeedback/{childId}: truyện đã đọc xong, mới nhất trước.
  Future<ParentReadingFeedbackPageDto> fetchReadingFeedback(
    int childId, {
    int pageIndex = 1,
    int pageSize = 20,
  });

  /// GET /ChildRoadmap/{childId}; null khi bé chưa có lộ trình (404).
  Future<ChildRoadmapDto?> fetchRoadmap(int childId);
}

class ApiHomeRepository implements HomeRepository {
  ApiHomeRepository({required this.dio});

  final Dio dio;

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
  Future<ParentReadingFeedbackPageDto> fetchReadingFeedback(
    int childId, {
    int pageIndex = 1,
    int pageSize = 20,
  }) => runApi(() async {
    final response = await dio.get<dynamic>(
      '/ParentReadingFeedback/$childId',
      queryParameters: {'pageIndex': pageIndex, 'pageSize': pageSize},
    );
    final data = _unwrap(response);
    if (data == null) return const ParentReadingFeedbackPageDto();
    return ParentReadingFeedbackPageDto.fromJson(data as Map<String, dynamic>);
  });

  @override
  Future<ChildRoadmapDto?> fetchRoadmap(int childId) async {
    try {
      return await runApi(() async {
        final response = await dio.get<dynamic>('/ChildRoadmap/$childId');
        final data = _unwrap(response);
        if (data == null) return null;
        return ChildRoadmapDto.fromJson(data as Map<String, dynamic>);
      });
    } on ApiException catch (e) {
      if (e.statusCode == 404) return null;
      rethrow;
    }
  }
}

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => ApiHomeRepository(dio: ref.watch(dioProvider)),
);
