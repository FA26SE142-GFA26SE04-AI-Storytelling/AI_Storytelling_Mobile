import 'package:ai_storytelling_mobile/core/api/api_client.dart';
import 'package:ai_storytelling_mobile/core/storage/session_storage.dart';
import 'package:ai_storytelling_mobile/data/auth/auth_models.dart';
import 'package:ai_storytelling_mobile/data/auth/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fakes.dart';

void main() {
  late MemorySecureStore store;
  late SessionStorage session;

  setUp(() {
    store = MemorySecureStore();
    session = SessionStorage(store);
  });

  (ApiAuthRepository, FakeAdapter) build(Map<String, FakeRoute> routes) {
    final adapter = FakeAdapter(routes);
    final api = ApiClient(baseUrl: 'https://test/api/v1', session: session, adapter: adapter);
    return (ApiAuthRepository(api, session), adapter);
  }

  test('đăng nhập thành công thì lưu token và hồ sơ', () async {
    final (repo, adapter) = build({'POST /Auth/login': (_) => (200, envelope(sessionJson()))});

    final res = await repo.login(identifier: 'mai', password: 'pw');

    expect(res.success, isTrue);
    expect(res.data!.user.givenName, 'Mai');
    expect(store.values[SessionStorage.accessKey], 'a1');
    expect(adapter.calls.single.headers['Authorization'], isNull, reason: 'endpoint công khai không gắn token');
  });

  test('đăng nhập sai thì trả thông báo của máy chủ và xoá phiên', () async {
    store.values[SessionStorage.accessKey] = 'old';
    final (repo, _) = build({'POST /Auth/login': (_) => (400, envelope(null, success: false, message: 'Sai mật khẩu.'))});

    final res = await repo.login(identifier: 'mai', password: 'x');

    expect(res.success, isFalse);
    expect(res.message, 'Sai mật khẩu.');
    expect(store.values, isEmpty);
  });

  test('401 thì làm mới token một lần rồi gọi lại với token mới', () async {
    await session.save(expiredSession());
    var meCalls = 0;
    final (repo, adapter) = build({
      'GET /Auth/me': (req) {
        meCalls++;
        return req.headers['Authorization'] == 'Bearer a2' ? (200, envelope(sessionJson()['user'])) : (401, null);
      },
      'POST /Auth/refresh-token': (req) => (200, envelope(sessionJson(access: 'a2', refresh: 'r2'))),
    });

    final user = await repo.restore();

    expect(user?.email, 'mai@taletale.site');
    expect(meCalls, 2);
    expect(adapter.calls.where((c) => c.path == '/Auth/refresh-token').single.data, {'refreshToken': 'r0'});
    expect(store.values[SessionStorage.refreshKey], 'r2', reason: 'token rotation');
  });

  test('refresh token bị từ chối thì xoá phiên và báo hết hạn', () async {
    await session.save(expiredSession());
    final (repo, _) = build({'GET /Auth/me': (_) => (401, null), 'POST /Auth/refresh-token': (_) => (401, envelope(null, success: false, message: 'Hết hạn'))});
    final expired = expectLater(session.onExpired, emits(null));

    final user = await repo.restore();

    expect(user, isNull);
    expect(store.values, isEmpty);
    await expired;
  });

  test('mất mạng khi mở app thì vẫn vào bằng hồ sơ đã lưu', () async {
    await session.save(expiredSession());
    final (repo, _) = build({'GET /Auth/me': (_) => null});

    final user = await repo.restore();

    expect(user?.username, 'mai');
    expect(store.values[SessionStorage.refreshKey], 'r0');
  });

  test('lỗi mạng được đánh dấu isNetworkError', () async {
    final (repo, _) = build({'POST /Auth/forgot-password': (_) => null});

    final res = await repo.forgotPassword(email: 'a@b.vn');

    expect(res.success, isFalse);
    expect(res.isNetworkError, isTrue);
    expect(res.message, networkErrorMessage);
  });
}

AuthSession expiredSession() => AuthSession.fromJson(sessionJson(access: 'a0', refresh: 'r0'));
