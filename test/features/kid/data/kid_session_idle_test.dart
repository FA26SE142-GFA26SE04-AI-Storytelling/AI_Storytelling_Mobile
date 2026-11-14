import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/features/kid/data/kid_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_session_controller.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_session_store.dart';
import 'package:ai_storytelling_mobile/features/kid/data/stored_kid_session.dart';
import 'package:ai_storytelling_mobile/models/child_session_dto.dart';

import 'kid_session_store_test.dart' show FakeTokenStorage;

/// Đếm số lần hỏi lại phiên (`GET /ChildAccessCredential/me`).
class _CountingKidRepository implements KidRepository {
  int pings = 0;

  @override
  Future<ChildSessionProfileDto> getSessionProfile(String childToken) async {
    pings++;
    return const ChildSessionProfileDto(
      childProfileId: 1,
      nickname: 'Bé',
      ageBand: 'Age_6_8',
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets(
    'hỏi lại phiên khi bé hoạt động, kết thúc sau 20 phút không chạm',
    (tester) async {
      final repo = _CountingKidRepository();
      final container = ProviderContainer(
        overrides: [
          kidSessionStoreProvider.overrideWithValue(
            KidSessionStore(FakeTokenStorage()),
          ),
          kidRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(container.dispose);

      var clock = DateTime(2026, 11, 14, 8);
      final controller = container.read(kidSessionProvider.notifier)
        ..now = () => clock;
      await tester.pump(); // để restore() chạy xong (không có phiên đã lưu)
      await controller.start(
        StoredKidSession(
          childProfileId: 1,
          accessToken: 'token',
          expiresAtMs: clock
              .add(const Duration(hours: 2))
              .millisecondsSinceEpoch,
          via: KidSessionVia.values.first,
        ),
      );

      // Bé chạm màn hình rồi hơn 1 phút sau tới lượt kiểm tra → hỏi backend một lần.
      clock = clock.add(const Duration(seconds: 5));
      controller.touch();
      clock = clock.add(const Duration(minutes: 1));
      await tester.pump(const Duration(seconds: 15));
      expect(repo.pings, 1);

      // Không chạm thêm thì không hỏi lại.
      clock = clock.add(const Duration(minutes: 2));
      await tester.pump(const Duration(seconds: 15));
      expect(repo.pings, 1);
      expect(container.read(kidSessionProvider), isA<KidActive>());

      // Đang nghe giọng đọc thì 20 phút không chạm vẫn giữ phiên.
      controller.narrating = true;
      clock = clock.add(const Duration(minutes: 20));
      await tester.pump(const Duration(seconds: 15));
      expect(container.read(kidSessionProvider), isA<KidActive>());
      controller.narrating = false;

      // Quá 20 phút không hoạt động → phiên kết thúc.
      clock = clock.add(const Duration(minutes: 20));
      await tester.pump(const Duration(seconds: 15));
      expect(container.read(kidSessionProvider), isA<KidEnded>());
    },
  );
}
