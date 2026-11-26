import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/features/events/data/event_repository.dart';
import 'package:ai_storytelling_mobile/models/event_dto.dart';

/// Repo Sự kiện giả cho test: dữ liệu đặt sẵn, ghi lại các lần gọi ghi.
class FakeEventRepository implements EventRepository {
  List<EventSummaryDto> events = [];
  bool failList = false;
  final details = <int, EventDetailDto>{};
  List<EventParticipationDto> participations = [];
  EventMissionDashboardDto dashboard = const EventMissionDashboardDto();
  List<EventAwardSlotDto> rewards = [];

  final registers = <Map<String, Object?>>[];
  final completes = <(int taskId, int? storyId)>[];
  final claims = <(int awardId, Map<String, String> payload)>[];

  @override
  Future<List<EventSummaryDto>> list() async {
    if (failList) throw const ApiException(message: 'Mất kết nối.');
    return events;
  }

  @override
  Future<EventDetailDto> detail(int eventId) async => details[eventId]!;

  @override
  Future<EventParticipationDto> register(
    int eventId, {
    String? trackType,
    String? activityType,
    int? eventActivityId,
  }) async {
    registers.add({
      'eventId': eventId,
      'trackType': trackType,
      'activityType': activityType,
      'eventActivityId': eventActivityId,
    });
    final p = EventParticipationDto(
      id: 100 + registers.length,
      eventId: eventId,
      trackType: trackType ?? '',
      activityType: activityType,
      eventActivityId: eventActivityId,
      status: 'Registered',
    );
    participations = [...participations, p];
    return p;
  }

  @override
  Future<List<EventParticipationDto>> myParticipations() async =>
      participations;

  @override
  Future<EventMissionDashboardDto> missionDashboard(int eventId) async =>
      dashboard;

  @override
  Future<EventMissionDashboardDto> completeTask(
    int eventId,
    int taskDefinitionId, {
    int? storyId,
    String? selfDeclaredPayloadJson,
  }) async {
    completes.add((taskDefinitionId, storyId));
    return dashboard;
  }

  @override
  Future<List<EventAwardSlotDto>> myRewards() async => rewards;

  @override
  Future<EventAwardSlotDto> claimReward(
    int awardId,
    Map<String, String> payload,
  ) async {
    claims.add((awardId, payload));
    return rewards.firstWhere((r) => r.id == awardId);
  }
}
