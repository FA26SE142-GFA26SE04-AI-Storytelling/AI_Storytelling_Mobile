import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/audit_log_entry_dto.dart';
import '../../../models/child_profile_dto.dart';
import '../../../models/content_category_dto.dart';
import '../../../models/learning_profile_dto.dart';
import '../../../models/safety_policy_dto.dart';

// ─── Abstract contract ───────────────────────────────────────────────────────

abstract class ChildProfileRepository {
  Future<List<ChildProfileDto>> fetchMine();
  Future<ChildProfileDto> fetchById(int id);
  Future<ChildProfileDto> create({
    required String nickname,
    required String ageBand,
    String language = 'vi',
  });
  Future<ChildProfileDto> update(
    int id, {
    required String nickname,
    required String ageBand,
    int? avatarId,
  });
  Future<void> activate(int id);
  Future<void> suspend(int id);
  Future<void> resume(int id, {required bool acceptCurrentConsent});
  Future<void> archive(int id);
  Future<void> restore(int id);
  Future<({List<AuditLogEntryDto> items, int totalPages})> auditLog(
    int id, {
    int pageIndex = 1, // Backend đánh số trang từ 1
  });
  Future<LearningProfileDto> fetchLearning(int id);
  Future<LearningProfileDto> setLearning(
    int id, {
    required int readingLevel,
    String? readingMode,
    String? comprehensionGoal,
    required List<LearningTopicDto> topics,
  });
  Future<SafetyPolicyDto> fetchSafety(int id);
  Future<void> setSafety(int id, Map<String, dynamic> body);
  Future<void> reconsent(int id);
  Future<void> applyAgePreset(int id);
  Future<List<ContentCategoryDto>> fetchContentCategories();
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

  @override
  Future<ChildProfileDto> fetchById(int id) => runApi(() async {
        final response = await dio.get<dynamic>('/ChildProfile/$id');
        final data = _unwrap(response);
        return ChildProfileDto.fromJson(data as Map<String, dynamic>);
      });

  @override
  Future<ChildProfileDto> create({
    required String nickname,
    required String ageBand,
    String language = 'vi',
  }) =>
      runApi(() async {
        final response = await dio.post<dynamic>(
          '/ChildProfile',
          data: {
            'nickname': nickname,
            'ageBand': ageBand,
            'language': language,
          },
        );
        final data = _unwrap(response);
        return ChildProfileDto.fromJson(data as Map<String, dynamic>);
      });

  @override
  Future<ChildProfileDto> update(
    int id, {
    required String nickname,
    required String ageBand,
    int? avatarId,
  }) =>
      runApi(() async {
        final response = await dio.put<dynamic>(
          '/ChildProfile/$id',
          data: {
            'nickname': nickname,
            'ageBand': ageBand,
            'avatarId': avatarId,
          },
        );
        final data = _unwrap(response);
        return ChildProfileDto.fromJson(data as Map<String, dynamic>);
      });

  @override
  Future<void> activate(int id) => runApi(() async {
        final response = await dio.patch<dynamic>('/ChildProfile/$id/activate');
        _unwrap(response);
      });

  @override
  Future<void> suspend(int id) => runApi(() async {
        final response = await dio.patch<dynamic>('/ChildProfile/$id/suspend');
        _unwrap(response);
      });

  @override
  Future<void> resume(int id, {required bool acceptCurrentConsent}) =>
      runApi(() async {
        final response = await dio.patch<dynamic>(
          '/ChildProfile/$id/resume',
          data: {
            'acceptCurrentConsent': acceptCurrentConsent,
          },
        );
        _unwrap(response);
      });

  @override
  Future<void> archive(int id) => runApi(() async {
        final response = await dio.delete<dynamic>('/ChildProfile/$id');
        _unwrap(response);
      });

  @override
  Future<void> restore(int id) => runApi(() async {
        final response = await dio.patch<dynamic>('/ChildProfile/$id/restore');
        _unwrap(response);
      });

  @override
  Future<({List<AuditLogEntryDto> items, int totalPages})> auditLog(
    int id, {
    int pageIndex = 1, // Backend đánh số trang từ 1
  }) =>
      runApi(() async {
        final response = await dio.get<dynamic>(
          '/ChildProfile/$id/audit-log',
          queryParameters: {
            'pageIndex': pageIndex,
            'pageSize': 20,
            'isDescending': true,
          },
        );
        final data = _unwrap(response);
        final map = (data as Map<String, dynamic>?) ?? <String, dynamic>{};
        final rawItems = (map['items'] as List<dynamic>?) ?? <dynamic>[];
        final items = rawItems
            .map((e) => AuditLogEntryDto.fromJson(e as Map<String, dynamic>))
            .toList();
        final totalPages = (map['totalPages'] as num?)?.toInt() ?? 1;
        return (items: items, totalPages: totalPages);
      });

  @override
  Future<LearningProfileDto> fetchLearning(int id) => runApi(() async {
        final response = await dio.get<dynamic>('/LearningProfile/$id');
        final data = _unwrap(response);
        return LearningProfileDto.fromJson(data as Map<String, dynamic>);
      });

  @override
  Future<LearningProfileDto> setLearning(
    int id, {
    required int readingLevel,
    String? readingMode,
    String? comprehensionGoal,
    required List<LearningTopicDto> topics,
  }) =>
      runApi(() async {
        final response = await dio.put<dynamic>(
          '/LearningProfile/$id',
          data: {
            'readingLevel': readingLevel,
            'readingMode': readingMode,
            'comprehensionGoal': comprehensionGoal,
            'topics': topics
                .map((t) => {
                      'topic': t.topic,
                      'relation': t.relation,
                    })
                .toList(),
          },
        );
        final data = _unwrap(response);
        return LearningProfileDto.fromJson(data as Map<String, dynamic>);
      });

  @override
  Future<SafetyPolicyDto> fetchSafety(int id) => runApi(() async {
        final response = await dio.get<dynamic>('/SafetyPolicy/$id');
        final data = _unwrap(response);
        return SafetyPolicyDto.fromJson(data as Map<String, dynamic>);
      });

  @override
  Future<void> setSafety(int id, Map<String, dynamic> body) => runApi(() async {
        final response = await dio.put<dynamic>(
          '/SafetyPolicy/$id',
          data: body,
        );
        _unwrap(response);
      });

  @override
  Future<void> reconsent(int id) => runApi(() async {
        final response = await dio.post<dynamic>('/SafetyPolicy/$id/reconsent');
        _unwrap(response);
      });

  @override
  Future<void> applyAgePreset(int id) => runApi(() async {
        final response =
            await dio.post<dynamic>('/SafetyPolicy/$id/age-preset/apply');
        _unwrap(response);
      });

  @override
  Future<List<ContentCategoryDto>> fetchContentCategories() => runApi(() async {
        final response = await dio.get<dynamic>('/ContentCategory');
        final data = _unwrap(response);
        if (data == null) return <ContentCategoryDto>[];
        final list = data as List<dynamic>;
        return list
            .map((e) => ContentCategoryDto.fromJson(e as Map<String, dynamic>))
            .toList();
      });
}

// ─── Provider ────────────────────────────────────────────────────────────────

final childProfileRepositoryProvider = Provider<ChildProfileRepository>(
  (ref) => ApiChildProfileRepository(dio: ref.watch(dioProvider)),
);
