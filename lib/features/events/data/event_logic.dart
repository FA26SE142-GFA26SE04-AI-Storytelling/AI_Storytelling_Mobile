import '../../../models/event_dto.dart';

// Hàm thuần cho Sự kiện, chép theo web: types/event.ts,
// features/events/eventTime.ts, eventRewards.ts, EventListView.tsx (groupOf).

// ─── Nhãn ────────────────────────────────────────────────────────────────────

const eventStatusLabel = <String, String>{
  'Draft': 'Bản nháp',
  'PendingApproval': 'Chờ Admin duyệt',
  'Approved': 'Đã duyệt ngân sách',
  'Published': 'Đang mở',
  'Paused': 'Tạm dừng',
  'Closed': 'Đã kết thúc',
  'Archived': 'Lưu trữ',
};

const participationStatusLabel = <String, String>{
  'Registered': 'Đã đăng ký',
  'MissionCompleted': 'Đã hoàn thành nhiệm vụ',
  'PendingVerification': 'Đang xác minh',
  'Verified': 'Đã xác minh đạt',
  'VerificationFailed': 'Chưa đạt điều kiện',
  'ManualReview': 'Đang rà soát thủ công',
  'Disqualified': 'Bị loại',
};

const eventActivityLabel = <String, String>{
  'Submission': 'Sáng tác / Nộp bài',
  'ReadingMissions': 'Đọc truyện & Làm nhiệm vụ',
  'Voting': 'Bình chọn truyện',
};

const eventAudienceLabel = <String, String>{
  'Creator': 'Creator',
  'Parent': 'Parent',
  'Both': 'Cả Creator và Parent',
};

const completionModeLabel = <String, String>{
  'AllMandatory': 'Hoàn thành tất cả nhiệm vụ bắt buộc',
  'MinimumTasksCount': 'Hoàn thành tối thiểu N nhiệm vụ',
  'MinimumPointsThreshold': 'Đạt ngưỡng điểm tích lũy',
};

const verifierTypeLabel = <String, String>{
  'ReadEventStories': 'Đọc truyện trong sự kiện',
  'CompleteStoryQuiz': 'Hoàn thành câu đố cuối truyện',
  'SaveStoryVocabulary': 'Lưu từ vựng mới',
  'AnswerChildQuestion': 'Giải đáp thắc mắc của bé',
  'GuidedDiscussionCheckin': 'Thảo luận câu chuyện cùng con',
  'RealLifePracticeCheckin': 'Thực hành bài học thực tế',
  'RateAndReviewStory': 'Đánh giá & nhận xét truyện',
  'ActiveDaysCount': 'Số ngày tham gia hợp lệ',
  'SubmitApprovedStory': 'Nộp truyện được duyệt',
  'VoteEventStories': 'Đọc & bình chọn truyện',
};

const rewardTypeLabel = <String, String>{
  'PhysicalGift': 'Quà hiện vật',
  'PlatformCredits': 'Lượt tạo truyện AI',
  'CashTransfer': 'Tiền thưởng chuyển khoản',
  'CreatorPackage': 'Gói Creator (AI + Gửi duyệt)',
};

const awardStatusLabel = <String, String>{
  'AwardProposed': 'Chờ đề xuất / duyệt giải',
  'AwardApproved': 'Đã duyệt giải',
  'AwaitingClaim': 'Chờ người thắng nhận',
  'Claimed': 'Đã xác nhận nhận',
  'FulfillmentProcessing': 'Đang giao / chuyển thưởng',
  'Fulfilled': 'Đã trao xong',
  'Expired': 'Quá hạn nhận',
  'UnclaimedBudgetReturned': 'Đã hoàn ngân sách',
  'Failed': 'Trao thưởng thất bại',
};

// ─── Giờ Việt Nam ────────────────────────────────────────────────────────────

DateTime _vn(DateTime value) => value.toUtc().add(const Duration(hours: 7));
String _two(int n) => n.toString().padLeft(2, '0');

/// dd/MM/yyyy theo giờ Việt Nam; thiếu ngày thì '—'.
String formatVnDate(DateTime? value) {
  if (value == null) return '—';
  final d = _vn(value);
  return '${_two(d.day)}/${_two(d.month)}/${d.year}';
}

/// dd/MM/yyyy HH:mm:ss theo giờ Việt Nam; thiếu ngày thì '—'.
String formatVnDateTime(DateTime? value) {
  if (value == null) return '—';
  final d = _vn(value);
  return '${formatVnDate(value)} ${_two(d.hour)}:${_two(d.minute)}:${_two(d.second)}';
}

// ─── Lịch và nhóm ────────────────────────────────────────────────────────────

/// Khoảng diễn ra: ưu tiên opensAt/closesAt, không có thì lấy mốc sớm nhất /
/// muộn nhất của hoạt động (hoặc nhánh kiểu cũ).
({DateTime? start, DateTime? end}) eventScheduleWindow(
  EventSummaryDto? event,
  EventDetailDto? detail,
) {
  final activities = detail?.activities ?? const <EventActivityDto>[];
  final tracks = detail?.tracks ?? const <EventTrackDto>[];
  final starts = activities.isNotEmpty
      ? activities.expand((a) => [a.registrationStartAt, a.startAt])
      : tracks.map((t) => t.registrationStartAt);
  final ends = activities.isNotEmpty
      ? activities.expand(
          (a) => [a.registrationEndAt, a.endAt, a.reviewCutoffAt],
        )
      : tracks.map((t) => t.executionEndAt);
  DateTime? pick(Iterable<DateTime?> values, bool earliest) {
    DateTime? best;
    for (final v in values.whereType<DateTime>()) {
      if (best == null || (earliest ? v.isBefore(best) : v.isAfter(best))) {
        best = v;
      }
    }
    return best;
  }

  return (
    start: event?.opensAt ?? detail?.opensAt ?? pick(starts, true),
    end: event?.closesAt ?? detail?.closesAt ?? pick(ends, false),
  );
}

/// 'open' | 'upcoming' | 'ended' cho bộ lọc danh sách.
String groupOf(EventSummaryDto event, [EventDetailDto? detail, DateTime? now]) {
  if (event.status == 'Closed') return 'ended';
  final window = eventScheduleWindow(event, detail);
  final at = now ?? DateTime.now();
  if (window.end != null && window.end!.isBefore(at)) return 'ended';
  return window.start != null && window.start!.isAfter(at)
      ? 'upcoming'
      : 'open';
}

/// Sự kiện vừa tạo / vừa công bố trong 7 ngày thì gắn nhãn "Mới".
bool isNewEvent(EventSummaryDto event, [DateTime? now]) {
  if (event.status == 'Closed' || event.status == 'Archived') return false;
  final raw = event.status == 'Published' || event.status == 'Paused'
      ? event.publishedAt ?? event.createdAt
      : event.createdAt;
  if (raw == null) return false;
  final at = now ?? DateTime.now();
  // Cho phép lệch đồng hồ 5 phút như web.
  return !raw.isAfter(at.add(const Duration(minutes: 5))) &&
      at.difference(raw) < const Duration(days: 7);
}

// ─── Phần thưởng ─────────────────────────────────────────────────────────────

/// Giải thưởng của tôi thuộc đúng sự kiện đang xem.
List<EventAwardSlotDto> rewardsForEvent(
  List<EventAwardSlotDto> myRewards,
  EventDetailDto detail,
) {
  final ids = detail.awards.map((a) => a.id).toSet();
  return myRewards.where((a) => ids.contains(a.id)).toList();
}

const claimFieldLabels = <String, String>{
  'recipientName': 'Họ tên người nhận',
  'phoneNumber': 'Số điện thoại',
  'shippingAddress': 'Địa chỉ nhận quà',
  'bankName': 'Ngân hàng',
  'bankAccountNumber': 'Số tài khoản',
  'bankAccountHolder': 'Tên chủ tài khoản',
};

/// Các ô cần nhập khi nhận thưởng, theo rewardType.
List<String> claimFieldsFor(String rewardType) => switch (rewardType) {
  'PhysicalGift' => const ['recipientName', 'phoneNumber', 'shippingAddress'],
  'CashTransfer' => const [
    'bankName',
    'bankAccountNumber',
    'bankAccountHolder',
  ],
  _ => const [],
};

/// Body gửi POST /events/awards/{id}/claim. Chuyển khoản được để trống hết
/// (dùng tài khoản đã lưu) nhưng không được nhập dở.
({Map<String, String>? request, String? error}) buildClaimRequest(
  String rewardType,
  Map<String, String> fields,
) {
  final keys = claimFieldsFor(rewardType);
  final request = <String, String>{
    for (final key in keys)
      if ((fields[key]?.trim() ?? '').isNotEmpty) key: fields[key]!.trim(),
  };
  if (rewardType == 'PhysicalGift' && request.length != keys.length) {
    return (
      request: null,
      error: 'Cần nhập họ tên, số điện thoại và địa chỉ nhận quà.',
    );
  }
  if (rewardType == 'CashTransfer' &&
      request.isNotEmpty &&
      request.length != keys.length) {
    return (
      request: null,
      error: 'Cần nhập ngân hàng, số tài khoản và tên chủ tài khoản.',
    );
  }
  return (request: request, error: null);
}
