import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/features/notifications/notification_text.dart';
import 'package:ai_storytelling_mobile/models/notification_dto.dart';

NotificationDto _n(String type, {String? payload, String group = ''}) =>
    NotificationDto(
      id: 1,
      type: type,
      group: group,
      payload: payload,
      createdAt: DateTime(2026),
    );

void main() {
  test('đủ câu tiếng Việt cho mọi loại thông báo của Backend (như web)', () {
    for (final type in [
      'EventAwardApproved',
      'CreatorApplicationApproved',
      'CreatorApplicationRejected',
      'CreatorTierChanged',
      'CreatorPayoutPaid',
      'CreatorPayoutCancelled',
      'StoryCreditReleased',
    ]) {
      expect(notificationText(_n(type)), isNot('Bạn có thông báo mới'), reason: type);
    }
  });

  test('câu chi tiết theo payload', () {
    expect(
      notificationText(_n('CreatorPayoutPaid', payload: '{"amountVnd":1500000}')),
      'Bạn vừa được chi trả 1.500.000 đ',
    );
    expect(
      notificationText(_n('StoryRatingPublished', payload: '{"rating":5}')),
      'Truyện của bạn vừa nhận đánh giá 5 sao từ phụ huynh',
    );
  });

  test('notificationKey đổi PascalCase sang snake_case', () {
    expect(notificationKey('StoryWishSubmitted'), 'story_wish_submitted');
    expect(notificationKey('RoadmapCompleted'), 'roadmap_completed');
  });

  test('các Type chính có câu dễ hiểu', () {
    expect(notificationText(_n('StoryWishSubmitted')), 'Bé vừa gửi một điều ước');
    expect(notificationText(_n('StoryWishExpiring')),
        'Điều ước của bé sắp hết hạn');
    expect(notificationText(_n('StorySummarySent')),
        'Bé vừa gửi tóm tắt sau khi đọc truyện');
    expect(notificationText(_n('RoadmapStoryAdded')),
        'Có truyện mới trong lộ trình của con');
    expect(notificationText(_n('RoadmapCompleted')),
        'Con đã đọc hết truyện trong lộ trình');
    expect(notificationText(_n('PaymentConfirmed')),
        'Thanh toán thành công, gói đã được áp');
    expect(notificationText(_n('SubscriptionExpiring')),
        contains('sắp hết hạn'));
    expect(notificationText(_n('AccountSecurityChanged')),
        'Bảo mật tài khoản vừa thay đổi');
  });

  test('ContentModerationResult đọc payload gỡ truyện', () {
    const ok =
        '{"itemType":"PublicStoryRemoval","decision":"approved","storyTitle":" Rùa và Thỏ "}';
    const no = '{"itemType":"PublicStoryRemoval","decision":"rejected"}';
    expect(notificationText(_n('ContentModerationResult', payload: ok)),
        'Yêu cầu gỡ truyện “Rùa và Thỏ” đã được chấp thuận');
    expect(notificationText(_n('ContentModerationResult', payload: no)),
        'Yêu cầu gỡ truyện đã bị từ chối');
  });

  test('payload hỏng/null/không phải object: không ném lỗi, không trả JSON', () {
    for (final payload in [null, '', '{hỏng', '[1,2]', '"chuỗi"', 'null']) {
      final text =
          notificationText(_n('ContentModerationResult', payload: payload));
      expect(text, 'Nội dung đã được kiểm duyệt', reason: '$payload');
    }
  });

  test('Type lạ hoặc rỗng: câu chung, không lộ payload', () {
    for (final type in ['SomethingNew', '', '???']) {
      final text = notificationText(_n(type, payload: '{"secret":1}'));
      expect(text, 'Bạn có thông báo mới');
      expect(text, isNot(contains('{')));
    }
  });

  test('đích điều hướng', () {
    expect(notificationTarget(_n('StoryWishSubmitted')), '/learning');
    expect(notificationTarget(_n('StorySummarySent')), '/learning');
    expect(notificationTarget(_n('RoadmapCompleted')), '/learning');
    expect(
      notificationTarget(_n('SupervisionInvite', group: 'supervisors')),
      '/kids',
    );
    expect(notificationTarget(_n('AccountSecurityChanged')), '/account');
    expect(notificationTarget(_n('PaymentConfirmed')), isNull);
    expect(notificationTarget(_n('SomethingNew')), isNull);
  });

  test('thời gian tương đối', () {
    final now = DateTime(2026, 11, 16, 15, 0);
    expect(relativeTime(now.subtract(const Duration(seconds: 20)), now: now),
        'Vừa xong');
    expect(relativeTime(now.subtract(const Duration(minutes: 5)), now: now),
        '5 phút trước');
    expect(relativeTime(now.subtract(const Duration(hours: 3)), now: now),
        '3 giờ trước');
    expect(relativeTime(DateTime(2026, 11, 15, 23), now: now), 'Hôm qua');
    expect(relativeTime(DateTime(2026, 11, 13, 9), now: now), '3 ngày trước');
    expect(relativeTime(DateTime(2026, 3, 2, 9), now: now), '02/03/2026');
  });
}
