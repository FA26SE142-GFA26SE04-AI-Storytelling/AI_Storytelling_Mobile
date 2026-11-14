import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/child_reading_dto.dart';
import '../../../models/child_rewards_dto.dart';
import 'kid_session_controller.dart';

// ─── Abstract contract ───────────────────────────────────────────────────────

abstract class KidRewardsRepository {
  /// Thông tin phần thưởng, streak, EXP và trạng thái Cây tri thức của bé.
  Future<ChildRewards> rewards();

  /// Tưới nước cho Cây tri thức bằng toàn bộ EXP chưa tưới.
  Future<KnowledgeTreeWaterResult> waterTree();

  /// Danh sách các từ vựng bé đã lưu trong Sổ tay.
  Future<List<NotebookEntry>> notebook();

  /// Xóa một từ khỏi Sổ tay theo mã mục sổ tay [entryId].
  Future<void> removeNotebookEntry(int entryId);
}

// ─── Implementation ──────────────────────────────────────────────────────────

class ApiKidRewardsRepository implements KidRewardsRepository {
  final Dio dio;
  final String? Function() getChildToken;
  final void Function() onChildSessionEnded;

  ApiKidRewardsRepository({
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
  Future<ChildRewards> rewards() => _childCall(() async {
    final response = await dio.get<dynamic>(
      '/child/rewards',
      options: _childOptions(_token),
    );
    final data = _unwrap(response) as Map<String, dynamic>;
    return ChildRewards.fromJson(data);
  });

  @override
  Future<KnowledgeTreeWaterResult> waterTree() => _childCall(() async {
    final response = await dio.post<dynamic>(
      '/child/rewards/knowledge-tree/water',
      options: _childOptions(_token),
    );
    final data = _unwrap(response) as Map<String, dynamic>;
    return KnowledgeTreeWaterResult.fromJson(data);
  });

  @override
  Future<List<NotebookEntry>> notebook() => _childCall(() async {
    final response = await dio.get<dynamic>(
      '/child/notebook',
      options: _childOptions(_token),
    );
    final data = _unwrap(response);
    final list = (data is List)
        ? data
        : (data is Map<String, dynamic> && data['items'] is List)
        ? data['items'] as List
        : const [];
    return list
        .whereType<Map<String, dynamic>>()
        .map((e) => NotebookEntry.fromJson(e))
        .toList();
  });

  @override
  Future<void> removeNotebookEntry(int entryId) => _childCall(() async {
    final response = await dio.delete<dynamic>(
      '/child/notebook/$entryId',
      options: _childOptions(_token),
    );
    _unwrap(response);
  });
}

// ─── Provider ────────────────────────────────────────────────────────────────

final kidRewardsRepositoryProvider = Provider<KidRewardsRepository>(
  (ref) => ApiKidRewardsRepository(
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
