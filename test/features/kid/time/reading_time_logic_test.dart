import 'package:ai_storytelling_mobile/features/kid/time/reading_time_logic.dart';
import 'package:ai_storytelling_mobile/models/reading_time_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('secondsUntil', () {
    test('trả về số giây làm tròn lên khi target ở tương lai', () {
      final now = DateTime(2026, 11, 26, 10, 0, 0);
      final target1 = DateTime(2026, 11, 26, 10, 0, 5);
      expect(secondsUntil(target1, now), 5);

      final target2 = DateTime(2026, 11, 26, 10, 0, 1, 200);
      expect(secondsUntil(target2, now), 2);
    });

    test('trả về 0 khi target bằng hoặc trước now', () {
      final now = DateTime(2026, 11, 26, 10, 0, 0);
      expect(secondsUntil(now, now), 0);

      final past = DateTime(2026, 11, 26, 9, 59, 50);
      expect(secondsUntil(past, now), 0);
    });
  });

  group('formatCountdown', () {
    test('đúng định dạng cho các mốc 0, 59, 61, 3600 giây', () {
      expect(formatCountdown(0), '0:00');
      expect(formatCountdown(59), '0:59');
      expect(formatCountdown(61), '1:01');
      expect(formatCountdown(3600), '1 giờ');
      expect(formatCountdown(3660), '1 giờ 1 phút');
    });
  });

  group('restCopy', () {
    test('Break state trả về tiêu đề và gợi ý theo breakActivity', () {
      final until = DateTime(2026, 11, 26, 10, 15);
      final eyesStatus = ReadingTimeStatusDto(
        state: 'Break',
        breakActivity: 'Eyes',
        breakUntil: until,
      );
      final eyesCopy = restCopy(eyesStatus);
      expect(eyesCopy.title, 'Nghỉ một chút nhé');
      expect(eyesCopy.hint, 'Nhìn ra xa một chút cho mắt nghỉ nhé!');
      expect(eyesCopy.mood, 'idle');
      expect(eyesCopy.label, 'Em đọc tiếp được sau');
      expect(eyesCopy.until, until);

      final waterCopy = restCopy(
        ReadingTimeStatusDto(state: 'Break', breakActivity: 'Water'),
      );
      expect(waterCopy.hint, 'Em uống một ngụm nước nhé!');

      final moveCopy = restCopy(
        ReadingTimeStatusDto(state: 'Break', breakActivity: 'Move'),
      );
      expect(moveCopy.hint, 'Em đứng dậy vươn vai, đi lại vài bước nhé!');
    });

    test('Bedtime state trả về đúng tiêu đề và câu gợi ý', () {
      final nextAllowed = DateTime(2026, 11, 27, 7, 0);
      final copy = restCopy(
        ReadingTimeStatusDto(state: 'Bedtime', nextAllowedAt: nextAllowed),
      );
      expect(copy.title, 'Đến giờ đi ngủ rồi');
      expect(copy.hint, 'Chúc em ngủ ngon! Mai mình đọc tiếp nhé.');
      expect(copy.mood, 'idle');
      expect(copy.label, 'Em đọc tiếp được sau');
      expect(copy.until, nextAllowed);
    });

    test('ScreenLimitReached state trả về đúng tiêu đề và câu gợi ý', () {
      final nextAllowed = DateTime(2026, 11, 27, 7, 0);
      final copy = restCopy(
        ReadingTimeStatusDto(
          state: 'ScreenLimitReached',
          nextAllowedAt: nextAllowed,
        ),
      );
      expect(copy.title, 'Hôm nay em đọc đủ rồi');
      expect(copy.hint, 'Mai mình đọc tiếp nhé!');
      expect(copy.mood, 'happy');
      expect(copy.label, 'Em đọc tiếp được sau');
      expect(copy.until, nextAllowed);
    });

    test('Outside state trả về đúng tiêu đề và câu gợi ý', () {
      final nextAllowed = DateTime(2026, 11, 26, 18, 0);
      final copy = restCopy(
        ReadingTimeStatusDto(state: 'Outside', nextAllowedAt: nextAllowed),
      );
      expect(copy.title, 'Chưa tới giờ đọc');
      expect(
        copy.hint,
        'Giờ đọc hôm nay đã hết, hẹn em ở giờ đọc sau nhé!',
      );
      expect(copy.mood, 'think');
      expect(copy.label, 'Giờ đọc kế tiếp sau');
      expect(copy.until, nextAllowed);
    });
  });

  group('warnLine', () {
    test('EndingSoon: có endsAt và không có endsAt', () {
      final now = DateTime(2026, 11, 26, 10, 0, 0);
      final endsAt = DateTime(2026, 11, 26, 10, 3, 0); // 180s = 3 phút
      final statusWithEnds = ReadingTimeStatusDto(
        state: 'EndingSoon',
        endsAt: endsAt,
      );
      expect(
        warnLine(statusWithEnds, now),
        'Sắp hết giờ đọc rồi, còn khoảng 3 phút nhé!',
      );

      final statusNoEnds = const ReadingTimeStatusDto(state: 'EndingSoon');
      expect(warnLine(statusNoEnds, now), 'Sắp hết giờ đọc rồi nhé!');
    });

    test('Grace: có graceEndsAt và không có graceEndsAt', () {
      final now = DateTime(2026, 11, 26, 10, 0, 0);
      final graceEndsAt = DateTime(2026, 11, 26, 10, 0, 45); // 45s
      final statusWithGrace = ReadingTimeStatusDto(
        state: 'Grace',
        graceEndsAt: graceEndsAt,
      );
      expect(
        warnLine(statusWithGrace, now),
        'Đến giờ nghỉ rồi, em đọc nốt đoạn này nhé! (còn 0:45)',
      );

      final statusNoGrace = const ReadingTimeStatusDto(state: 'Grace');
      expect(
        warnLine(statusNoGrace, now),
        'Đến giờ nghỉ rồi, em đọc nốt đoạn này nhé!',
      );
    });

    test('trạng thái khác hoặc null trả về null', () {
      final now = DateTime(2026, 11, 26, 10, 0, 0);
      expect(warnLine(const ReadingTimeStatusDto(state: 'Break'), now), isNull);
      expect(warnLine(null, now), isNull);
    });
  });

  group('blockedStateOf', () {
    test('map 4 mã 403 sang state tương ứng', () {
      expect(blockedStateOf('READING_TIME_BREAK'), 'Break');
      expect(blockedStateOf('READING_TIME_BEDTIME'), 'Bedtime');
      expect(blockedStateOf('READING_TIME_SCREEN_LIMIT'), 'ScreenLimitReached');
      expect(blockedStateOf('READING_TIME_OUTSIDE'), 'Outside');
    });

    test('mã lạ hoặc null trả về null', () {
      expect(blockedStateOf('UNKNOWN_ERROR'), isNull);
      expect(blockedStateOf('OTHER_403'), isNull);
      expect(blockedStateOf(null), isNull);
    });
  });

  group('isQuiet', () {
    final periods = [
      HabitQuietPeriodDto(
        from: DateTime(2026, 11, 26, 21, 0),
        to: DateTime(2026, 11, 27, 7, 0),
      ),
    ];

    test('trả về true khi now nằm trong khung yên lặng', () {
      final now = DateTime(2026, 11, 26, 22, 0);
      expect(isQuiet(periods, now), isTrue);

      final boundaryStart = DateTime(2026, 11, 26, 21, 0);
      expect(isQuiet(periods, boundaryStart), isTrue);
    });

    test('trả về false khi now nằm ngoài khung yên lặng', () {
      final before = DateTime(2026, 11, 26, 20, 59);
      expect(isQuiet(periods, before), isFalse);

      final boundaryEnd = DateTime(2026, 11, 27, 7, 0);
      expect(isQuiet(periods, boundaryEnd), isFalse);

      final after = DateTime(2026, 11, 27, 8, 0);
      expect(isQuiet(periods, after), isFalse);

      expect(isQuiet(<HabitQuietPeriodDto>[], DateTime(2026, 11, 26, 22, 0)), isFalse);
    });
  });

  group('nextReminder', () {
    test('trả về null khi habit null hoặc disabled hoặc không có nhắc nhở', () {
      final now = DateTime(2026, 11, 26, 10, 0);
      expect(nextReminder(null, now), isNull);
      expect(
        nextReminder(const ChildHabitDto(enabled: false), now),
        isNull,
      );
      expect(
        nextReminder(const ChildHabitDto(enabled: true, reminders: []), now),
        isNull,
      );
    });

    test('bỏ qua nhắc nhở quá khứ hoặc rơi vào giờ yên lặng, lấy mốc hợp lệ sớm nhất', () {
      final now = DateTime(2026, 11, 26, 10, 0);
      final habit = ChildHabitDto(
        enabled: true,
        quietPeriods: [
          HabitQuietPeriodDto(
            from: DateTime(2026, 11, 26, 21, 0),
            to: DateTime(2026, 11, 27, 7, 0),
          ),
        ],
        reminders: [
          HabitReminderDto(
            at: DateTime(2026, 11, 26, 9, 0),
            message: 'Đã qua',
          ),
          HabitReminderDto(
            at: DateTime(2026, 11, 26, 21, 30),
            message: 'Rơi vào giờ ngủ',
          ),
          HabitReminderDto(
            at: DateTime(2026, 11, 26, 19, 0),
            message: 'Đọc tối nhé',
          ),
          HabitReminderDto(
            at: DateTime(2026, 11, 26, 15, 0),
            message: 'Đọc chiều nhé',
          ),
        ],
      );

      final next = nextReminder(habit, now);
      expect(next, isNotNull);
      expect(next!.message, 'Đọc chiều nhé');
      expect(next.at, DateTime(2026, 11, 26, 15, 0));
    });
  });

  group('weekProgressText', () {
    test('khi có weeklyGoalDays trả về tiến độ dạng x / y ngày', () {
      const habitWithGoal = ChildHabitDto(
        daysReadThisWeek: 2,
        weeklyGoalDays: 3,
      );
      expect(weekProgressText(habitWithGoal), '2 / 3 ngày');
    });

    test('khi không có weeklyGoalDays chỉ trả về số ngày', () {
      const habitNoGoal = ChildHabitDto(
        daysReadThisWeek: 4,
        weeklyGoalDays: null,
      );
      expect(weekProgressText(habitNoGoal), '4 ngày');
    });
  });

  group('timeChip', () {
    final now = DateTime.utc(2026, 11, 26, 9);
    DateTime inMin(int m) => now.add(Duration(minutes: m));

    test('giới hạn màn hình → còn N phút', () {
      final chip = timeChip(
        ReadingTimeStatusDto(state: 'Allowed', endReason: 'ScreenLimit', endsAt: inMin(25)),
        now,
      );
      expect(chip?.text, 'Còn 25 phút');
      expect(chip?.warn, false);
    });

    test('khung giờ / giờ ngủ → đọc đến giờ máy; sắp hết thì warn', () {
      final end = inMin(90);
      final l = end.toLocal();
      final hhmm =
          '${l.hour.toString().padLeft(2, '0')}:${l.minute.toString().padLeft(2, '0')}';
      expect(
        timeChip(ReadingTimeStatusDto(state: 'Allowed', endReason: 'Window', endsAt: end), now)?.text,
        'Đọc đến $hhmm',
      );
      expect(
        timeChip(ReadingTimeStatusDto(state: 'EndingSoon', endReason: 'Bedtime', endsAt: inMin(4)), now)?.warn,
        true,
      );
    });

    test('đọc nốt → đếm ngược, warn', () {
      final chip = timeChip(ReadingTimeStatusDto(state: 'Grace', graceEndsAt: inMin(2)), now);
      expect(chip?.text, 'Đọc nốt 2:00');
      expect(chip?.warn, true);
    });

    test('không giới hạn, đang bị chặn hoặc không có trạng thái → null', () {
      expect(timeChip(ReadingTimeStatusDto(state: 'Allowed'), now), isNull);
      expect(timeChip(ReadingTimeStatusDto(state: 'Bedtime', endsAt: inMin(5)), now), isNull);
      expect(timeChip(null, now), isNull);
    });
  });
}
