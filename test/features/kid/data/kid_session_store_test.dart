import 'package:flutter_test/flutter_test.dart';
import 'package:ai_storytelling_mobile/core/storage/token_storage.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_session_store.dart';
import 'package:ai_storytelling_mobile/features/kid/data/stored_kid_session.dart';

class FakeTokenStorage implements TokenStorage {
  String? childSession;

  @override
  Future<void> saveChildSession(String json) async {
    childSession = json;
  }

  @override
  Future<String?> readChildSession() async {
    return childSession;
  }

  @override
  Future<void> clearChildSession() async {
    childSession = null;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('KidSessionStore', () {
    late FakeTokenStorage fakeTokenStorage;
    late KidSessionStore store;

    final fixedNow = DateTime(2026, 11, 12, 10, 0, 0);

    setUp(() {
      fakeTokenStorage = FakeTokenStorage();
      store = KidSessionStore(fakeTokenStorage);
    });

    test(
      'save rồi read trước khi hết hạn: trả đúng childProfileId, accessToken, via, parentalGateEnabled',
      () async {
        final session = StoredKidSession(
          childProfileId: 101,
          accessToken: 'test_token_123',
          expiresAtMs:
              fixedNow.add(const Duration(hours: 1)).millisecondsSinceEpoch,
          via: KidSessionVia.easyLogin,
          parentalGateEnabled: true,
        );

        await store.save(session);
        final readSession = await store.read(now: fixedNow);

        expect(readSession, isNotNull);
        expect(readSession!.childProfileId, 101);
        expect(readSession.accessToken, 'test_token_123');
        expect(readSession.via, KidSessionVia.easyLogin);
        expect(readSession.parentalGateEnabled, isTrue);
      },
    );

    test(
      'read khi đã hết hạn (now sau expiresAtMs): trả null VÀ childSession fake đã bị xoá về null',
      () async {
        final session = StoredKidSession(
          childProfileId: 102,
          accessToken: 'expired_token',
          expiresAtMs: fixedNow.millisecondsSinceEpoch,
          via: KidSessionVia.handover,
          parentalGateEnabled: false,
        );

        await store.save(session);
        final laterTime = fixedNow.add(const Duration(minutes: 5));
        final readSession = await store.read(now: laterTime);

        expect(readSession, isNull);
        expect(fakeTokenStorage.childSession, isNull);
      },
    );

    test('read khi chưa lưu gì: trả null', () async {
      final readSession = await store.read(now: fixedNow);

      expect(readSession, isNull);
      expect(fakeTokenStorage.childSession, isNull);
    });

    test('JSON hỏng (set fake.childSession = "not json"): read trả null và xoá',
        () async {
      fakeTokenStorage.childSession = 'not json';

      final readSession = await store.read(now: fixedNow);

      expect(readSession, isNull);
      expect(fakeTokenStorage.childSession, isNull);
    });

    test('clear: sau save rồi clear, read trả null', () async {
      final session = StoredKidSession(
        childProfileId: 103,
        accessToken: 'valid_token',
        expiresAtMs:
            fixedNow.add(const Duration(hours: 1)).millisecondsSinceEpoch,
        via: KidSessionVia.easyLogin,
        parentalGateEnabled: true,
      );

      await store.save(session);
      expect(fakeTokenStorage.childSession, isNotNull);

      await store.clear();
      expect(fakeTokenStorage.childSession, isNull);

      final readSession = await store.read(now: fixedNow);
      expect(readSession, isNull);
    });
  });
}
