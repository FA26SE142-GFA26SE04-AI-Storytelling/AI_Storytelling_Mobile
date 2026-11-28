import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/child_roadmap_dto.dart';
import '../../../models/parent_reading_feedback_dto.dart';
import '../../../models/story_handover_dto.dart';

/// Bé đã đọc gì và lộ trình của bé (dùng ở tab Học tập).
abstract class HomeRepository {
  /// GET /ParentReadingFeedback/{childId}: truyện đã đọc xong, mới nhất trước.
  /// [storyId] khác null thì chỉ lấy các lần đọc của truyện đó.
  Future<ParentReadingFeedbackPageDto> fetchReadingFeedback(
    int childId, {
    int pageIndex = 1,
    int pageSize = 20,
    int? storyId,
  });

  /// GET /ChildRoadmap/{childId}; null khi bé chưa có lộ trình (404).
  Future<ChildRoadmapDto?> fetchRoadmap(int childId);

  /// POST /ChildRoadmap/stories: thêm truyện vào cuối lộ trình (chặng mới) của từng bé.
  Future<List<RoadmapAddResult>> addRoadmapStory({
    required int storyId,
    required List<int> childIds,
  });
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
    int? storyId,
  }) => runApi(() async {
    final response = await dio.get<dynamic>(
      '/ParentReadingFeedback/$childId',
      queryParameters: {
        'pageIndex': pageIndex,
        'pageSize': pageSize,
        'storyId': ?storyId,
      },
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

  @override
  Future<List<RoadmapAddResult>> addRoadmapStory({
    required int storyId,
    required List<int> childIds,
  }) => runApi(() async {
    final data =
        _unwrap(
              await dio.post<dynamic>(
                '/ChildRoadmap/stories',
                data: {
                  'storyId': storyId,
                  'childProfileIds': childIds,
                  'position': 'End',
                  'expectedDays': null,
                  'note': null,
                },
              ),
            )
            as Map<String, dynamic>?;
    return [
      for (final r in data?['results'] as List<dynamic>? ?? const [])
        (
          childProfileId: (r as Map<String, dynamic>)['childProfileId'] as int,
          outcome: r['outcome'] as String? ?? '',
          message: r['message'] as String?,
        ),
    ];
  });
}

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => ApiHomeRepository(dio: ref.watch(dioProvider)),
);
