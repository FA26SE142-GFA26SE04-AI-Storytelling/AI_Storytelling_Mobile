import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/child_session_dto.dart';
import '../../../models/my_roadmap_dto.dart';
import '../../../models/safety_policy_dto.dart';
import 'kid_session_controller.dart';

// ─── Abstract contract ───────────────────────────────────────────────────────

abstract class KidRepository {
  Future<ChildSessionDto> loginWithEasyLogin(String secret);
  Future<ChildSessionProfileDto> getSessionProfile(String childToken);
  Future<MyRoadmapDto> getMyRoadmap(String childToken);
  Future<ChildSessionDto> startHandover({
    required int childId,
    required String supervisorRefreshToken,
  });
  Future<SafetyPolicyDto> getSafetyPolicy(int childId);
  Future<void> verifyParentalGate({
    required String email,
    required String password,
  });
}

// ─── Implementation ──────────────────────────────────────────────────────────

class ApiKidRepository implements KidRepository {
  final Dio dio;
  final void Function() onChildSessionEnded;

  ApiKidRepository({
    required this.dio,
    required this.onChildSessionEnded,
  });

  Options get _anonOptions => Options(extra: {'anonymous': true});

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
  Future<ChildSessionDto> loginWithEasyLogin(String secret) => runApi(() async {
        try {
          final response = await dio.post<dynamic>(
            '/ChildAccessCredential/easylogin/login',
            data: {'secret': secret},
            options: _anonOptions,
          );
          final data = _unwrap(response) as Map<String, dynamic>;
          return ChildSessionDto.fromJson(data);
        } on DioException catch (e) {
          throw ApiException.fromDioException(
            e,
            fallbackMessage:
                'Mã không đúng hoặc đã bị thu hồi. Hãy nhờ bố mẹ tạo mã mới nhé!',
          );
        }
      });

  @override
  Future<ChildSessionProfileDto> getSessionProfile(String childToken) =>
      _childCall(() async {
        final response = await dio.get<dynamic>(
          '/ChildAccessCredential/me',
          options: _childOptions(childToken),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ChildSessionProfileDto.fromJson(data);
      });

  @override
  Future<MyRoadmapDto> getMyRoadmap(String childToken) =>
      _childCall(() async {
        final response = await dio.get<dynamic>(
          '/MyRoadmap',
          options: _childOptions(childToken),
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return MyRoadmapDto.fromJson(data);
      });

  @override
  Future<ChildSessionDto> startHandover({
    required int childId,
    required String supervisorRefreshToken,
  }) =>
      runApi(() async {
        final response = await dio.post<dynamic>(
          '/ChildAccessCredential/$childId/handover',
          data: {'supervisorRefreshToken': supervisorRefreshToken},
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return ChildSessionDto.fromJson(data);
      });

  @override
  Future<SafetyPolicyDto> getSafetyPolicy(int childId) => runApi(() async {
        final response = await dio.get<dynamic>(
          '/SafetyPolicy/$childId',
        );
        final data = _unwrap(response) as Map<String, dynamic>;
        return SafetyPolicyDto.fromJson(data);
      });

  @override
  Future<void> verifyParentalGate({
    required String email,
    required String password,
  }) =>
      runApi(() async {
        final response = await dio.post<dynamic>(
          '/ParentalGate/verify',
          data: {'email': email, 'password': password},
          options: _anonOptions,
        );
        _unwrap(response);
      });
}

// ─── Provider ────────────────────────────────────────────────────────────────

final kidRepositoryProvider = Provider<KidRepository>(
  (ref) => ApiKidRepository(
    dio: ref.watch(dioProvider),
    onChildSessionEnded: () =>
        ref.read(kidSessionProvider.notifier).markEnded(),
  ),
);
