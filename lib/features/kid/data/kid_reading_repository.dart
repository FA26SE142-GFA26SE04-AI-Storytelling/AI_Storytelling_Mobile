import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/child_reading_dto.dart';
import 'kid_session_controller.dart';

// ─── Abstract contract ───────────────────────────────────────────────────────

abstract class KidReadingRepository {
  Future<List<ChildStory>> stories({
    String? search,
    int pageIndex = 1,
    int pageSize = 20,
  });

  Future<ChildStoryPage> storyPage({
    String? search,
    int pageIndex = 1,
    int pageSize = 20,
  });

  Future<ReadingStarted> start({
    String? storyId,
    String? communitySubmissionId,
  });

  Future<ReadingContent> content(String sessionId);

  Future<ReadingProgress> progress(
    String sessionId, {
    required int page,
    required String readingMode,
    required int addedSeconds,
  });

  Future<ReadingCompleted> complete(String sessionId);

  /// Đánh dấu trang (bookmark) của phiên đọc truyện.
  Future<ReadingFlags> bookmark(
    String sessionId, {
    required bool value,
  });

  /// Đánh dấu truyện yêu thích (favorite) của bé.
  Future<ReadingFlags> favorite(
    String sessionId, {
    required bool value,
  });

  Future<ReadingSignal> signal(String sessionId);

  Future<void> event(
    String sessionId, {
    required String eventType,
    String? payload,
  });

  Future<VocabularyDefinition> definition(
    String sessionId, {
    required int vocabularyId,
  });

  Future<NotebookEntry> collectWord(
    String sessionId, {
    required int vocabularyId,
  });
}

// ─── Implementation ──────────────────────────────────────────────────────────

class ApiKidReadingRepository implements KidReadingRepository {
  final Dio dio;
  final String? Function() getChildToken;
  final void Function() onChildSessionEnded;

  ApiKidReadingRepository({
    required this.dio,
    required this.getChildToken,
    required this.onChildSessionEnded,
  });

  String get _token {
    final token = getChildToken();
    if (token == null || token.isEmpty) {
      throw ApiException(
        statusCode: 401,
        message: 'Phiên đọc của bé chưa sẵn sàng hoặc đã hết hạn.',
      );
    }
    return token;
  }

  Options _childOptions(String childToken) => Options(
        headers: {'Authorization': 'Bearer $childToken'},
        extra: {'child': true},
      );

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

  /// Bọc mọi child call: tự động kích hoạt callback kết thúc phiên khi gặp 401 hoặc 403.
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
  Future<List<ChildStory>> stories({
    String? search,
    int pageIndex = 1,
    int pageSize = 20,
  }) =>
      _childCall(() async {
        final queryParams = <String, dynamic>{
          'pageIndex': pageIndex,
          'pageSize': pageSize,
        };
        if (search != null && search.trim().isNotEmpty) {
          queryParams['search'] = search.trim();
        }

        final response = await dio.get<dynamic>(
          '/child/reading/stories',
          queryParameters: queryParams,
          options: _childOptions(_token),
        );
        final data = _unwrap(response);
        if (data is Map<String, dynamic>) {
          final page = ChildStoryPage.fromJson(data);
          return page.items;
        }
        if (data is List) {
          return data
              .map((e) => ChildStory.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return const <ChildStory>[];
      });

  @override
  Future<ChildStoryPage> storyPage({
    String? search,
    int pageIndex = 1,
    int pageSize = 20,
  }) =>
      _childCall(() async {
        final queryParams = <String, dynamic>{
          'pageIndex': pageIndex,
          'pageSize': pageSize,
        };
        if (search != null && search.trim().isNotEmpty) {
          queryParams['search'] = search.trim();
        }

        final response = await dio.get<dynamic>(
          '/child/reading/stories',
          queryParameters: queryParams,
          options: _childOptions(_token),
        );
        final data = _unwrap(response);
        if (data is Map<String, dynamic>) {
          return ChildStoryPage.fromJson(data);
        }
        return const ChildStoryPage();
      });

  @override
  Future<ReadingStarted> start({
    String? storyId,
    String? communitySubmissionId,
  }) =>
      _childCall(() async {
        final body = <String, dynamic>{};
        if (storyId != null && storyId.trim().isNotEmpty) {
          body['storyId'] = int.tryParse(storyId.trim()) ?? storyId.trim();
        }
        if (communitySubmissionId != null &&
            communitySubmissionId.trim().isNotEmpty) {
          body['communitySubmissionId'] =
              int.tryParse(communitySubmissionId.trim()) ??
                  communitySubmissionId.trim();
        }

        final response = await dio.post<dynamic>(
          '/child/reading/sessions',
          data: body,
          options: _childOptions(_token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ReadingStarted.fromJson(data);
      });

  @override
  Future<ReadingContent> content(String sessionId) => _childCall(() async {
        final response = await dio.get<dynamic>(
          '/child/reading/sessions/$sessionId/content',
          options: _childOptions(_token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ReadingContent.fromJson(data);
      });

  @override
  Future<ReadingProgress> progress(
    String sessionId, {
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
          options: _childOptions(_token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ReadingProgress.fromJson(data);
      });

  @override
  Future<ReadingCompleted> complete(String sessionId) => _childCall(() async {
        final response = await dio.post<dynamic>(
          '/child/reading/sessions/$sessionId/complete',
          options: _childOptions(_token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ReadingCompleted.fromJson(data);
      });

  @override
  Future<ReadingFlags> bookmark(
    String sessionId, {
    required bool value,
  }) =>
      _childCall(() async {
        final response = await dio.put<dynamic>(
          '/child/reading/sessions/$sessionId/bookmark',
          data: {'value': value},
          options: _childOptions(_token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ReadingFlags.fromJson(data);
      });

  @override
  Future<ReadingFlags> favorite(
    String sessionId, {
    required bool value,
  }) =>
      _childCall(() async {
        final response = await dio.put<dynamic>(
          '/child/reading/sessions/$sessionId/favorite',
          data: {'value': value},
          options: _childOptions(_token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ReadingFlags.fromJson(data);
      });

  @override
  Future<ReadingSignal> signal(String sessionId) => _childCall(() async {
        final response = await dio.get<dynamic>(
          '/child/reading/sessions/$sessionId/signal',
          options: _childOptions(_token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ReadingSignal.fromJson(data);
      });

  @override
  Future<void> event(
    String sessionId, {
    required String eventType,
    String? payload,
  }) =>
      _childCall(() async {
        final response = await dio.post<dynamic>(
          '/child/reading/sessions/$sessionId/events',
          data: {
            'eventType': eventType,
            'payload': ?payload,
          },
          options: _childOptions(_token),
        );
        _unwrap(response);
      });

  @override
  Future<VocabularyDefinition> definition(
    String sessionId, {
    required int vocabularyId,
  }) =>
      _childCall(() async {
        final response = await dio.get<dynamic>(
          '/child/reading/sessions/$sessionId/vocabulary/$vocabularyId',
          options: _childOptions(_token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return VocabularyDefinition.fromJson(data);
      });

  @override
  Future<NotebookEntry> collectWord(
    String sessionId, {
    required int vocabularyId,
  }) =>
      _childCall(() async {
        final response = await dio.post<dynamic>(
          '/child/notebook/sessions/$sessionId/words',
          data: {'vocabularyId': vocabularyId},
          options: _childOptions(_token),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return NotebookEntry.fromJson(data);
      });
}

// ─── Provider ────────────────────────────────────────────────────────────────

final kidReadingRepositoryProvider = Provider<KidReadingRepository>(
  (ref) => ApiKidReadingRepository(
    dio: ref.watch(dioProvider),
    getChildToken: () {
      final sessionState = ref.read(kidSessionProvider);
      if (sessionState is KidActive) {
        return sessionState.session.accessToken;
      }
      return null;
    },
    onChildSessionEnded: () =>
        ref.read(kidSessionProvider.notifier).markEnded(),
  ),
);
