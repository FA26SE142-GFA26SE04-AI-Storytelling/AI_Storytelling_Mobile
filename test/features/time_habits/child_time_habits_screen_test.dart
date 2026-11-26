import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_models.dart';
import 'package:ai_storytelling_mobile/features/children/data/child_profile_repository.dart';
import 'package:ai_storytelling_mobile/features/time_habits/data/reading_schedule_repository.dart';
import 'package:ai_storytelling_mobile/features/time_habits/presentation/child_time_habits_screen.dart';
import 'package:ai_storytelling_mobile/models/child_profile_dto.dart';
import 'package:ai_storytelling_mobile/models/reading_schedule_dto.dart';

import '../../support/ipad_sizes.dart';

class _FakeChildProfileRepository extends Fake
    implements ChildProfileRepository {
  @override
  Future<ChildProfileDto> fetchById(int id) async {
    return const ChildProfileDto(
      id: 1,
      nickname: 'Bé An',
      avatarId: 'avatar-cat',
      ageBand: 'Age_6_8',
      status: 'Active',
      ownerUserId: 7,
    );
  }
}

class _FakeReadingScheduleRepository extends Fake
    implements ReadingScheduleRepository {
  @override
  Future<ReadingScheduleDto> fetch(int childId) async {
    return const ReadingScheduleDto(
      childProfileId: 1,
      enabled: true,
      bedtimeWeekday: '21:00',
      bedtimeWeekend: '21:30',
      breakEnabled: true,
      breakAfterMinutes: 30,
      breakDurationMinutes: 5,
      breakRemindEyes: true,
      breakRemindWater: false,
      breakRemindMove: false,
      screenLimitEnabled: true,
      screenLimitWeekdayMinutes: 60,
      screenLimitWeekendMinutes: 90,
      habitEnabled: true,
      readingReminderWeekday: '19:00',
      readingReminderWeekend: '19:30',
      weeklyGoalDays: 5,
      windows: [],
      isSuggested: false,
    );
  }

  @override
  Future<ReadingScheduleDto> save(
      int childId, Map<String, dynamic> body) async {
    return fetch(childId);
  }
}

class _FakeAuthController extends AuthController {
  final UserProfile _user;

  _FakeAuthController(this._user);

  @override
  AuthState build() {
    return AuthSignedIn(_user);
  }
}

Future<void> _pumpChildTimeHabitsScreen(
  WidgetTester tester, {
  required ChildProfileRepository childRepo,
  required ReadingScheduleRepository schedRepo,
  int currentUserId = 7,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        childProfileRepositoryProvider.overrideWithValue(childRepo),
        readingScheduleRepositoryProvider.overrideWithValue(schedRepo),
        authControllerProvider.overrideWith(
          () => _FakeAuthController(
            UserProfile(
              id: currentUserId,
              username: 'parent',
              email: 'parent@example.com',
              fullName: 'Parent User',
              role: 'User',
              status: 'Active',
            ),
          ),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const ChildTimeHabitsScreen(childId: 1),
      ),
    ),
  );
}

void main() {
  group('iPad không tràn', () {
    for (final entry in kIpadSizes.entries) {
      testWidgets('${entry.key}: không tràn', (tester) async {
        tester.view.physicalSize = entry.value;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final childRepo = _FakeChildProfileRepository();
        final schedRepo = _FakeReadingScheduleRepository();

        await _pumpChildTimeHabitsScreen(
          tester,
          childRepo: childRepo,
          schedRepo: schedRepo,
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);

        if (entry.key.contains('1366')) {
          // Tiêu đề section và tiêu đề thẻ lệch vài px nhưng cùng hàng.
          expect(
            tester.getTopLeft(find.text('Màn hình & nghỉ giữa giờ')).dy,
            closeTo(
              tester.getTopLeft(find.text('Giới hạn thời gian đọc')).dy,
              20,
            ),
          );
        }
      });
    }
  });
}
