import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/story_wish_dto.dart';
import 'kid_session_controller.dart';

// ─── Abstract contract ──────────────────────────────────────────

abstract class KidWishRepository {
  Future<List<StoryWish>> wishes();

  Future<WishDraft> startDraft();

  Future<List<ChildWishCard>> wishCards(String group);

  Future<WishDraft> saveDraftCard({
    required String group,
    int? cardId,
    required bool leaveToParent,
  });

  Future<StoryWish> submitDraft();
}

// ─── Implementation ─────────────────────────────────────────────

class ApiKidWishRepository implements KidWishRepository {
  final Dio dio;
  final String? Function() getChildToken;
  final void Function() onChildSessionEnded;

  ApiKidWishRepository({
    required this.dio,
    required this.getChildToken,
    required this.onChildSessionEnded,
  });

  String get _token {
    final token = getChildToken();
    if (token == null || token.isEmpty) {
      throw const ApiException(
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
  Future<List<StoryWish>> wishes() => _childCall(() async {
    final response = await dio.get<dynamic>(
      '/child/wishes',
      options: _childOptions(_token),
    );
    final data = _unwrap(response);
    if (data is List) {
      return data
          .map((e) => StoryWish.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return const <StoryWish>[];
  });

  @override
  Future<WishDraft> startDraft() => _childCall(() async {
    final response = await dio.post<dynamic>(
      '/child/wishes/draft',
      options: _childOptions(_token),
    );
    final data = _unwrap(response) as Map<String, dynamic>;
    return WishDraft.fromJson(data);
  });

  @override
  Future<List<ChildWishCard>> wishCards(String group) => _childCall(() async {
    final response = await dio.get<dynamic>(
      '/child/wish-cards',
      queryParameters: {'group': group},
      options: _childOptions(_token),
    );
    final data = _unwrap(response);
    if (data is List) {
      return data
          .map((e) => ChildWishCard.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return const <ChildWishCard>[];
  });

  @override
  Future<WishDraft> saveDraftCard({
    required String group,
    int? cardId,
    required bool leaveToParent,
  }) => _childCall(() async {
    final request = SelectWishCardRequest(
      group: group,
      cardId: cardId,
      leaveToParent: leaveToParent,
    );
    final response = await dio.put<dynamic>(
      '/child/wishes/draft/cards',
      data: request.toJson(),
      options: _childOptions(_token),
    );
    final data = _unwrap(response) as Map<String, dynamic>;
    return WishDraft.fromJson(data);
  });

  @override
  Future<StoryWish> submitDraft() => _childCall(() async {
    final response = await dio.post<dynamic>(
      '/child/wishes/draft/submit',
      options: _childOptions(_token),
    );
    final data = _unwrap(response) as Map<String, dynamic>;
    return StoryWish.fromJson(data);
  });
}

// ─── Provider ───────────────────────────────────────────────────

final kidWishRepositoryProvider = Provider<KidWishRepository>(
  (ref) => ApiKidWishRepository(
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
