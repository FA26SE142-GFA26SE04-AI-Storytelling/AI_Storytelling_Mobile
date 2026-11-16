import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/models/notification_dto.dart';

void main() {
  test('fromJson đủ trường', () {
    final n = NotificationDto.fromJson({
      'id': 7,
      'childProfileId': 3,
      'type': 'StoryWishSubmitted',
      'group': 'children',
      'payload': '{"childProfileId":3,"wishId":9}',
      'status': 'Read',
      'readAt': '2026-11-15T08:00:00Z',
      'createdAt': '2026-11-15T07:30:00Z',
    });
    expect(n.id, 7);
    expect(n.childProfileId, 3);
    expect(n.type, 'StoryWishSubmitted');
    expect(n.group, 'children');
    expect(n.payload, contains('wishId'));
    expect(n.readAt, DateTime.utc(2026, 11, 15, 8));
    expect(n.createdAt, DateTime.utc(2026, 11, 15, 7, 30));
    expect(n.isUnread, isFalse);
  });

  test('fromJson thiếu trường tuỳ chọn: dùng mặc định, coi là chưa đọc', () {
    final n = NotificationDto.fromJson({
      'id': 1,
      'createdAt': '2026-11-15T07:30:00Z',
    });
    expect(n.childProfileId, isNull);
    expect(n.type, '');
    expect(n.group, '');
    expect(n.payload, isNull);
    expect(n.status, '');
    expect(n.readAt, isNull);
    expect(n.isUnread, isTrue);
  });

  test('isUnread theo Status khi chưa có ReadAt', () {
    final base = NotificationDto(id: 1, createdAt: DateTime(2026));
    expect(base.copyWith(status: 'Unread').isUnread, isTrue);
    expect(base.copyWith(status: 'Read').isUnread, isFalse);
  });
}
