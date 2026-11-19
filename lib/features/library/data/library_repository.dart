import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/library_story_dto.dart';

/// API thư viện truyện của phụ huynh (giống thư viện phụ huynh trên web).
abstract class LibraryRepository {
  /// GET /Story: một trang truyện, mới trước.
  Future<LibraryStoryPageDto> stories({
    required int pageIndex,
    int pageSize = 100,
  });

  /// GET /Story/community: truyện Creator đã công khai; [orderBy] = views | favorites.
  Future<LibraryStoryPageDto> community({
    int pageIndex = 1,
    int pageSize = 100,
    String? orderBy,
  });

  /// GET /Story/{id}: chi tiết (có nội dung) của truyện.
  Future<LibraryStoryDto> story(int id);

  /// Tranh và giọng đọc: truyện Creator qua /Story/community/{id}/media,
  /// còn lại qua /stories/{id}/media/package.
  Future<StoryMediaPackageDto?> media(int id, {required bool creator});
}

class ApiLibraryRepository implements LibraryRepository {
  ApiLibraryRepository({required this.dio});

  final Dio dio;

  dynamic _unwrap(Response<dynamic> response) {
    final body = response.data as Map<String, dynamic>?;
    if (body == null || body['success'] != true) {
      final msg = (body?['message'] as String?)?.trim();
      throw ApiException(
        statusCode: response.statusCode,
        message: (msg != null && msg.isNotEmpty)
            ? msg
            : 'Chưa tải được thư viện truyện. Vui lòng thử lại.',
      );
    }
    return body['data'];
  }

  Future<LibraryStoryPageDto> _page(String path, Map<String, dynamic> query) =>
      runApi(() async {
        final response = await dio.get<dynamic>(path, queryParameters: query);
        final data = _unwrap(response);
        if (data == null) return const LibraryStoryPageDto();
        return LibraryStoryPageDto.fromJson(data as Map<String, dynamic>);
      });

  @override
  Future<LibraryStoryPageDto> stories({
    required int pageIndex,
    int pageSize = 100,
  }) => _page('/Story', {
    'pageIndex': pageIndex,
    'pageSize': pageSize,
    'isDescending': true,
  });

  @override
  Future<LibraryStoryPageDto> community({
    int pageIndex = 1,
    int pageSize = 100,
    String? orderBy,
  }) => _page('/Story/community', {
    'pageIndex': pageIndex,
    'pageSize': pageSize,
    'isDescending': true,
    'orderBy': ?orderBy,
  });

  @override
  Future<LibraryStoryDto> story(int id) => runApi(() async {
    final response = await dio.get<dynamic>('/Story/$id');
    return LibraryStoryDto.fromJson(_unwrap(response) as Map<String, dynamic>);
  });

  @override
  Future<StoryMediaPackageDto?> media(int id, {required bool creator}) =>
      runApi(() async {
        final response = await dio.get<dynamic>(
          creator ? '/Story/community/$id/media' : '/stories/$id/media/package',
        );
        final data = _unwrap(response);
        if (data == null) return null;
        return StoryMediaPackageDto.fromJson(data as Map<String, dynamic>);
      });
}

final libraryRepositoryProvider = Provider<LibraryRepository>(
  (ref) => ApiLibraryRepository(dio: ref.watch(dioProvider)),
);
