import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/features/events/data/event_logic.dart';
import 'package:ai_storytelling_mobile/models/event_dto.dart';

void main() {
  final now = DateTime.utc(2026, 11, 26, 12);
  DateTime days(int n) => now.add(Duration(days: n));

  group('formatVnDate', () {
    test('đổi sang giờ Việt Nam, dd/MM/yyyy', () {
      expect(formatVnDate(DateTime.utc(2026, 11, 30, 18)), '01/12/2026');
      expect(
        formatVnDateTime(DateTime.utc(2026, 1, 2, 3, 4, 5)),
        '02/01/2026 10:04:05',
      );
      expect(formatVnDate(null), '—');
    });
  });

  group('eventScheduleWindow', () {
    test('ưu tiên opensAt/closesAt', () {
      final e = EventSummaryDto(id: 1, opensAt: days(-1), closesAt: days(2));
      final w = eventScheduleWindow(e, null);
      expect(w.start, days(-1));
      expect(w.end, days(2));
    });

    test('không có thì lấy mốc sớm nhất / muộn nhất của hoạt động', () {
      final detail = EventDetailDto(
        id: 1,
        activities: [
          EventActivityDto(
            id: 1,
            registrationStartAt: days(-3),
            startAt: days(-2),
            endAt: days(4),
          ),
          EventActivityDto(
            id: 2,
            registrationStartAt: days(-1),
            reviewCutoffAt: days(9),
          ),
        ],
        tracks: [EventTrackDto(id: 9, registrationStartAt: days(-30))],
      );
      final w = eventScheduleWindow(null, detail);
      expect(w.start, days(-3));
      expect(w.end, days(9));
    });

    test('kiểu cũ dùng nhánh tham gia', () {
      final detail = EventDetailDto(
        id: 1,
        tracks: [
          EventTrackDto(
            id: 1,
            registrationStartAt: days(1),
            executionEndAt: days(5),
          ),
        ],
      );
      final w = eventScheduleWindow(null, detail);
      expect(w.start, days(1));
      expect(w.end, days(5));
    });

    test('không có mốc nào thì null', () {
      final w = eventScheduleWindow(const EventSummaryDto(id: 1), null);
      expect(w.start, isNull);
      expect(w.end, isNull);
    });
  });

  group('groupOf', () {
    test('Closed luôn là ended', () {
      expect(
        groupOf(
          EventSummaryDto(id: 1, status: 'Closed', closesAt: days(5)),
          null,
          now,
        ),
        'ended',
      );
    });
    test('quá hạn là ended, chưa mở là upcoming, còn lại open', () {
      expect(
        groupOf(
          EventSummaryDto(id: 1, status: 'Published', closesAt: days(-1)),
          null,
          now,
        ),
        'ended',
      );
      expect(
        groupOf(
          EventSummaryDto(id: 1, status: 'Published', opensAt: days(1)),
          null,
          now,
        ),
        'upcoming',
      );
      expect(
        groupOf(
          EventSummaryDto(
            id: 1,
            status: 'Published',
            opensAt: days(-1),
            closesAt: days(1),
          ),
          null,
          now,
        ),
        'open',
      );
      expect(
        groupOf(const EventSummaryDto(id: 1, status: 'Published'), null, now),
        'open',
      );
    });
  });

  group('isNewEvent', () {
    test('đã công bố trong 7 ngày là mới', () {
      expect(
        isNewEvent(
          EventSummaryDto(
            id: 1,
            status: 'Published',
            publishedAt: days(-2),
            createdAt: days(-20),
          ),
          now,
        ),
        isTrue,
      );
      expect(
        isNewEvent(
          EventSummaryDto(id: 1, status: 'Published', publishedAt: days(-8)),
          now,
        ),
        isFalse,
      );
    });
    test('Published không có publishedAt thì dùng createdAt', () {
      expect(
        isNewEvent(
          EventSummaryDto(id: 1, status: 'Published', createdAt: days(-1)),
          now,
        ),
        isTrue,
      );
    });
    test(
      'đã kết thúc, thiếu ngày hoặc ngày tương lai quá 5 phút thì không mới',
      () {
        expect(
          isNewEvent(
            EventSummaryDto(id: 1, status: 'Closed', publishedAt: days(-1)),
            now,
          ),
          isFalse,
        );
        expect(
          isNewEvent(const EventSummaryDto(id: 1, status: 'Published'), now),
          isFalse,
        );
        expect(
          isNewEvent(
            EventSummaryDto(
              id: 1,
              status: 'Draft',
              createdAt: now.add(const Duration(minutes: 10)),
            ),
            now,
          ),
          isFalse,
        );
        expect(
          isNewEvent(
            EventSummaryDto(
              id: 1,
              status: 'Draft',
              createdAt: now.add(const Duration(minutes: 3)),
            ),
            now,
          ),
          isTrue,
        );
      },
    );
  });

  test('rewardsForEvent lọc theo awards của sự kiện', () {
    const detail = EventDetailDto(
      id: 1,
      awards: [EventAwardSlotDto(id: 10), EventAwardSlotDto(id: 11)],
    );
    final mine = rewardsForEvent(const [
      EventAwardSlotDto(id: 11),
      EventAwardSlotDto(id: 99),
    ], detail);
    expect(mine.map((a) => a.id), [11]);
  });

  group('claimFieldsFor / buildClaimRequest', () {
    test('ô cần nhập theo loại thưởng', () {
      expect(claimFieldsFor('PhysicalGift'), [
        'recipientName',
        'phoneNumber',
        'shippingAddress',
      ]);
      expect(claimFieldsFor('CashTransfer'), [
        'bankName',
        'bankAccountNumber',
        'bankAccountHolder',
      ]);
      expect(claimFieldsFor('PlatformCredits'), isEmpty);
      for (final f in [
        ...claimFieldsFor('PhysicalGift'),
        ...claimFieldsFor('CashTransfer'),
      ]) {
        expect(claimFieldLabels[f], isNotNull);
      }
    });

    test('quà hiện vật thiếu ô thì báo lỗi', () {
      final r = buildClaimRequest('PhysicalGift', {
        'recipientName': 'An',
        'phoneNumber': '  ',
      });
      expect(r.request, isNull);
      expect(r.error, 'Cần nhập họ tên, số điện thoại và địa chỉ nhận quà.');
    });

    test('quà hiện vật đủ ô thì cắt khoảng trắng', () {
      final r = buildClaimRequest('PhysicalGift', {
        'recipientName': ' An ',
        'phoneNumber': '0901',
        'shippingAddress': 'HN',
        'bankName': 'bỏ qua',
      });
      expect(r.error, isNull);
      expect(r.request, {
        'recipientName': 'An',
        'phoneNumber': '0901',
        'shippingAddress': 'HN',
      });
    });

    test('chuyển khoản: để trống hết được, nhập dở thì lỗi', () {
      expect(buildClaimRequest('CashTransfer', {}).request, isEmpty);
      final r = buildClaimRequest('CashTransfer', {'bankName': 'VCB'});
      expect(r.request, isNull);
      expect(r.error, 'Cần nhập ngân hàng, số tài khoản và tên chủ tài khoản.');
    });

    test('lượt tạo truyện không cần nhập gì', () {
      final r = buildClaimRequest('PlatformCredits', {'recipientName': 'An'});
      expect(r.error, isNull);
      expect(r.request, isEmpty);
    });
  });
}
