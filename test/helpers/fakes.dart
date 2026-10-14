import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ai_storytelling_mobile/core/storage/session_storage.dart';
import 'package:dio/dio.dart';

class MemorySecureStore implements SecureStore {
  final values = <String, String>{};

  @override
  Future<String?> read(String key) async => values[key];
  @override
  Future<void> write(String key, String value) async => values[key] = value;
  @override
  Future<void> delete(String key) async => values.remove(key);
}

/// Phản hồi giả: (mã HTTP, thân JSON). Trả về null để giả lập mất mạng.
typedef FakeRoute = (int, Object?)? Function(RequestOptions req);

/// HttpClientAdapter giả cho dio: ghi lại các request và trả lời theo [routes] (khoá = "METHOD /path").
class FakeAdapter implements HttpClientAdapter {
  FakeAdapter(this.routes);

  final Map<String, FakeRoute> routes;
  final calls = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    calls.add(options);
    final route = routes['${options.method} ${options.path}'];
    final res = route?.call(options);
    if (route == null) return ResponseBody.fromString('{"success":false,"message":"Không có route giả"}', 404, headers: _json);
    if (res == null) throw const SocketException('offline');
    return ResponseBody.fromString(jsonEncode(res.$2), res.$1, headers: _json);
  }

  static final _json = {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  };

  @override
  void close({bool force = false}) {}
}

Map<String, Object?> envelope(Object? data, {bool success = true, String message = ''}) => {'success': success, 'message': message, 'data': data};

Map<String, Object?> sessionJson({String access = 'a1', String refresh = 'r1'}) => {
  'accessToken': access,
  'refreshToken': refresh,
  'tokenType': 'Bearer',
  'expiresInSeconds': 3600,
  'user': {'id': 7, 'username': 'mai', 'email': 'mai@taletale.site', 'fullName': 'Trần Thị Mai', 'role': 'Parent', 'status': 'Active'},
};
