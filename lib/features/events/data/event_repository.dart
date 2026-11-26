import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/event_dto.dart';

/// Sự kiện của phụ huynh: xem, đăng ký, làm nhiệm vụ, nhận thưởng.
abstract class EventRepository {
  /// GET /events?includeDrafts=false
  Future<List<EventSummaryDto>> list();

  /// GET /events/{id}
  Future<EventDetailDto> detail(int eventId);

  /// POST /events/{id}/register, chỉ gửi trường khác null.
  Future<EventParticipationDto> register(
    int eventId, {
    String? trackType,
    String? activityType,
    int? eventActivityId,
  });

  /// GET /events/my-participations
  Future<List<EventParticipationDto>> myParticipations();

  /// GET /events/{id}/mission-dashboard
  Future<EventMissionDashboardDto> missionDashboard(int eventId);

  /// POST /events/{id}/tasks/{taskDefinitionId}/complete
  Future<EventMissionDashboardDto> completeTask(
    int eventId,
    int taskDefinitionId, {
    int? storyId,
    String? selfDeclaredPayloadJson,
  });

  /// GET /events/my-rewards
  Future<List<EventAwardSlotDto>> myRewards();

  /// POST /events/awards/{awardId}/claim, payload lấy từ `buildClaimRequest`.
  Future<EventAwardSlotDto> claimReward(
    int awardId,
    Map<String, String> payload,
  );
}

class ApiEventRepository implements EventRepository {
  ApiEventRepository({required this.dio});

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

  Map<String, dynamic> _map(Response<dynamic> response) =>
      _unwrap(response) as Map<String, dynamic>;

  List<T> _list<T>(
    Response<dynamic> response,
    T Function(Map<String, dynamic>) fromJson,
  ) => (_unwrap(response) as List<dynamic>? ?? const [])
      .map((e) => fromJson(e as Map<String, dynamic>))
      .toList();

  @override
  Future<List<EventSummaryDto>> list() => runApi(
    () async => _list(
      await dio.get<dynamic>(
        '/events',
        queryParameters: {'includeDrafts': false},
      ),
      EventSummaryDto.fromJson,
    ),
  );

  @override
  Future<EventDetailDto> detail(int eventId) => runApi(
    () async => EventDetailDto.fromJson(
      _map(await dio.get<dynamic>('/events/$eventId')),
    ),
  );

  @override
  Future<EventParticipationDto> register(
    int eventId, {
    String? trackType,
    String? activityType,
    int? eventActivityId,
  }) => runApi(
    () async => EventParticipationDto.fromJson(
      _map(
        await dio.post<dynamic>(
          '/events/$eventId/register',
          data: {
            'trackType': ?trackType,
            'activityType': ?activityType,
            'eventActivityId': ?eventActivityId,
            'acceptRules': true,
          },
        ),
      ),
    ),
  );

  @override
  Future<List<EventParticipationDto>> myParticipations() => runApi(
    () async => _list(
      await dio.get<dynamic>('/events/my-participations'),
      EventParticipationDto.fromJson,
    ),
  );

  @override
  Future<EventMissionDashboardDto> missionDashboard(int eventId) => runApi(
    () async => EventMissionDashboardDto.fromJson(
      _map(await dio.get<dynamic>('/events/$eventId/mission-dashboard')),
    ),
  );

  @override
  Future<EventMissionDashboardDto> completeTask(
    int eventId,
    int taskDefinitionId, {
    int? storyId,
    String? selfDeclaredPayloadJson,
  }) => runApi(
    () async => EventMissionDashboardDto.fromJson(
      _map(
        await dio.post<dynamic>(
          '/events/$eventId/tasks/$taskDefinitionId/complete',
          data: {
            'storyId': ?storyId,
            'selfDeclaredPayloadJson': ?selfDeclaredPayloadJson,
          },
        ),
      ),
    ),
  );

  @override
  Future<List<EventAwardSlotDto>> myRewards() => runApi(
    () async => _list(
      await dio.get<dynamic>('/events/my-rewards'),
      EventAwardSlotDto.fromJson,
    ),
  );

  @override
  Future<EventAwardSlotDto> claimReward(
    int awardId,
    Map<String, String> payload,
  ) => runApi(
    () async => EventAwardSlotDto.fromJson(
      _map(
        await dio.post<dynamic>('/events/awards/$awardId/claim', data: payload),
      ),
    ),
  );
}

final eventRepositoryProvider = Provider<EventRepository>(
  (ref) => ApiEventRepository(dio: ref.watch(dioProvider)),
);

final eventListProvider = FutureProvider.autoDispose<List<EventSummaryDto>>(
  (ref) => ref.watch(eventRepositoryProvider).list(),
);

final myParticipationsProvider =
    FutureProvider.autoDispose<List<EventParticipationDto>>(
      (ref) => ref.watch(eventRepositoryProvider).myParticipations(),
    );

final myRewardsProvider = FutureProvider.autoDispose<List<EventAwardSlotDto>>(
  (ref) => ref.watch(eventRepositoryProvider).myRewards(),
);

final eventDetailProvider = FutureProvider.autoDispose
    .family<EventDetailDto, int>(
      (ref, id) => ref.watch(eventRepositoryProvider).detail(id),
    );

final missionDashboardProvider = FutureProvider.autoDispose
    .family<EventMissionDashboardDto, int>(
      (ref, id) => ref.watch(eventRepositoryProvider).missionDashboard(id),
    );
