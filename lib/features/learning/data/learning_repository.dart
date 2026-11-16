import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/parent_story_summary_dto.dart';
import '../../../models/story_wish_dto.dart';

/// Dữ liệu tab Học tập của phụ huynh. Truyện đã đọc xong và lộ trình dùng
/// [HomeRepository] (cùng API với Trang chủ).
abstract class LearningRepository {
  /// GET /ParentStorySummary/{childId}: phần bé kể lại, mới nhất trước.
  Future<ParentStorySummaryPageDto> fetchSummaries(
    int childId, {
    int pageIndex = 1,
    int pageSize = 20,
  });

  /// DELETE /ParentStorySummary/{childId}/{summaryId}: xoá bản ghi âm và phần kể lại.
  Future<void> deleteSummary(int childId, int summaryId);

  /// GET /parent/wishes?childProfileId=: mọi điều ước bé đã gửi.
  Future<List<ParentWish>> fetchWishes(int childId);

  /// GET /Story/{id}: chỉ lấy ảnh bìa cho các bước lộ trình.
  Future<String?> fetchStoryCover(int storyId);
}

class ApiLearningRepository implements LearningRepository {
  ApiLearningRepository({required this.dio});

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
  Future<ParentStorySummaryPageDto> fetchSummaries(
    int childId, {
    int pageIndex = 1,
    int pageSize = 20,
  }) =>
      runApi(() async {
        final response = await dio.get<dynamic>(
          '/ParentStorySummary/$childId',
          queryParameters: {'pageIndex': pageIndex, 'pageSize': pageSize},
        );
        final data = _unwrap(response);
        if (data == null) return const ParentStorySummaryPageDto();
        return ParentStorySummaryPageDto.fromJson(data as Map<String, dynamic>);
      });

  @override
  Future<void> deleteSummary(int childId, int summaryId) => runApi(() async {
        _unwrap(
          await dio.delete<dynamic>('/ParentStorySummary/$childId/$summaryId'),
        );
      });

  @override
  Future<List<ParentWish>> fetchWishes(int childId) => runApi(() async {
        final response = await dio.get<dynamic>(
          '/parent/wishes',
          queryParameters: {'childProfileId': childId},
        );
        final data = _unwrap(response) as List<dynamic>? ?? const [];
        return data
            .map((e) => ParentWish.fromJson(e as Map<String, dynamic>))
            .toList();
      });

  @override
  Future<String?> fetchStoryCover(int storyId) => runApi(() async {
        final data = _unwrap(await dio.get<dynamic>('/Story/$storyId'));
        return (data as Map<String, dynamic>?)?['coverImageUrl'] as String?;
      });
}

final learningRepositoryProvider = Provider<LearningRepository>(
  (ref) => ApiLearningRepository(dio: ref.watch(dioProvider)),
);
