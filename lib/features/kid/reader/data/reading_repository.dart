import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../models/reading_content_dto.dart';
import '../../../../models/reading_start_dto.dart';
import '../../data/kid_session_controller.dart';

// ─── Abstract contract ───────────────────────────────────────────────────────

abstract class ReadingRepository {
  Future<ReadingStartedDto> start({
    required String token,
    required int storyId,
  });
  Future<ReadingContentDto> content({
    required String token,
    required int sessionId,
  });
  Future<ReadingProgressDto> saveProgress({
    required String token,
    required int sessionId,
    required int page,
    required String readingMode,
    required int addedSeconds,
  });
  Future<ReadingCompletedDto> complete({
    required String token,
    required int sessionId,
  });
  Future<ReadingFlagsDto> setBookmark({
    required String token,
    required int sessionId,
    required bool value,
  });
  Future<ReadingFlagsDto> setFavorite({
    required String token,
    required int sessionId,
    required bool value,
  });
  Future<void> sendEvent({
    required String token,
    required int sessionId,
    required String eventType,
    String? payload,
  });
  Future<ReadingSignalDto> signal({
    required String token,
    required int sessionId,
  });
  Future<VocabularyDefinitionDto> definition({
    required String token,
    required int sessionId,
    required int vocabularyId,
  });
}

// ─── Implementation ──────────────────────────────────────────────────────────

class ApiReadingRepository implements ReadingRepository {
  final Dio dio;
  final void Function() onChildSessionEnded;

  ApiReadingRepository({
    required this.dio,
    required this.onChildSessionEnded,
  });

  Options _childOptions(String childToken) => Options(
        headers: {'Authorization': 'Bearer $childToken'},
        extra: {'child': true},
      );

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

  Future<T> _childCall<T>(Future<T> Function() request) => runApi(() async {
        try {
          return await request();
        } on DioException catch (e) {
          final statusCode = e.response?.statusCode;
          if (statusCode == 401 || statusCode == 403) {
            onChildSessionEnded();
          }
          rethrow;
        }
      });

  @override
  Future<ReadingStartedDto> start({
    required String token,
    required int storyId,
  }) =>
      _childCall(() async {
        final response = await dio.post<dynamic>(
          '/child/reading/sessions',
          data: {'storyId': storyId},
          options: _childOptions(token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ReadingStartedDto.fromJson(data);
      });

  @override
  Future<ReadingContentDto> content({
    required String token,
    required int sessionId,
  }) =>
      _childCall(() async {
        final response = await dio.get<dynamic>(
          '/child/reading/sessions/$sessionId/content',
          options: _childOptions(token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ReadingContentDto.fromJson(data);
      });

  @override
  Future<ReadingProgressDto> saveProgress({
    required String token,
    required int sessionId,
    required int page,
    required String readingMode,
    required int addedSeconds,
  }) =>
      _childCall(() async {
        final response = await dio.put<dynamic>(
          '/child/reading/sessions/$sessionId/progress',
          data: {
            'page': page,
            'readingMode': readingMode,
            'addedSeconds': addedSeconds,
          },
          options: _childOptions(token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ReadingProgressDto.fromJson(data);
      });

  @override
  Future<ReadingCompletedDto> complete({
    required String token,
    required int sessionId,
  }) =>
      _childCall(() async {
        final response = await dio.post<dynamic>(
          '/child/reading/sessions/$sessionId/complete',
          options: _childOptions(token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ReadingCompletedDto.fromJson(data);
      });

  @override
  Future<ReadingFlagsDto> setBookmark({
    required String token,
    required int sessionId,
    required bool value,
  }) =>
      _childCall(() async {
        final response = await dio.put<dynamic>(
          '/child/reading/sessions/$sessionId/bookmark',
          data: {'value': value},
          options: _childOptions(token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ReadingFlagsDto.fromJson(data);
      });

  @override
  Future<ReadingFlagsDto> setFavorite({
    required String token,
    required int sessionId,
    required bool value,
  }) =>
      _childCall(() async {
        final response = await dio.put<dynamic>(
          '/child/reading/sessions/$sessionId/favorite',
          data: {'value': value},
          options: _childOptions(token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ReadingFlagsDto.fromJson(data);
      });

  @override
  Future<void> sendEvent({
    required String token,
    required int sessionId,
    required String eventType,
    String? payload,
  }) =>
      _childCall(() async {
        final response = await dio.post<dynamic>(
          '/child/reading/sessions/$sessionId/events',
          data: {
            'eventType': eventType,
            'payload': payload,
          },
          options: _childOptions(token),
        );
        _unwrap(response);
      });

  @override
  Future<ReadingSignalDto> signal({
    required String token,
    required int sessionId,
  }) =>
      _childCall(() async {
        final response = await dio.get<dynamic>(
          '/child/reading/sessions/$sessionId/signal',
          options: _childOptions(token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ReadingSignalDto.fromJson(data);
      });

  @override
  Future<VocabularyDefinitionDto> definition({
    required String token,
    required int sessionId,
    required int vocabularyId,
  }) =>
      _childCall(() async {
        final response = await dio.get<dynamic>(
          '/child/reading/sessions/$sessionId/vocabulary/$vocabularyId',
          options: _childOptions(token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return VocabularyDefinitionDto.fromJson(data);
      });
}

// ─── Provider ────────────────────────────────────────────────────────────────

final readingRepositoryProvider = Provider<ReadingRepository>(
  (ref) => ApiReadingRepository(
    dio: ref.watch(dioProvider),
    onChildSessionEnded: () =>
        ref.read(kidSessionProvider.notifier).markEnded(),
  ),
);
