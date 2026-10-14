import 'package:dio/dio.dart';

import '../../data/auth/auth_models.dart';
import '../storage/session_storage.dart';
import 'api_result.dart';

const _kAuth = 'tt-auth';
const _kRetried = 'tt-retried';

const networkErrorMessage = 'Không thể kết nối đến máy chủ. Hãy kiểm tra mạng rồi thử lại.';

/// Client REST cho `/api/v1`: gắn Bearer token, tự làm mới token khi gặp 401
/// (dùng chung một lần làm mới cho các request đồng thời) và gói kết quả thành [ApiResult].
class ApiClient {
  ApiClient({required String baseUrl, required SessionStorage session, HttpClientAdapter? adapter})
    : dio = Dio(_options(baseUrl)),
      _refreshDio = Dio(_options(baseUrl)) {
    if (adapter != null) {
      dio.httpClientAdapter = adapter;
      _refreshDio.httpClientAdapter = adapter;
    }
    dio.interceptors.add(_AuthInterceptor(session, dio, _refreshDio));
  }

  static BaseOptions _options(String baseUrl) => BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );

  final Dio dio;
  final Dio _refreshDio;

  /// Gọi API và đọc khuôn `{ success, message, data, errors }`.
  /// [auth] = false cho các endpoint công khai (đăng nhập, đăng ký...): không gắn token, không thử làm mới.
  Future<ApiResult<T>> request<T>(
    String path, {
    String method = 'GET',
    Object? body,
    Map<String, dynamic>? query,
    T Function(Object? data)? parse,
    bool auth = true,
    CancelToken? cancelToken,
  }) async {
    try {
      final res = await dio.request<Object?>(
        path,
        data: body,
        queryParameters: query,
        cancelToken: cancelToken,
        options: Options(method: method, extra: {_kAuth: auth}),
      );
      return _read(res.data, parse);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) return const ApiResult.fail('Đã huỷ yêu cầu.');
      final res = e.response;
      if (res == null) return const ApiResult.fail(networkErrorMessage, isNetworkError: true);
      final failed = _read<T>(res.data, null);
      if (!failed.success && failed.message.isNotEmpty) return failed;
      return ApiResult.fail(
        res.statusCode == 401 ? 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.' : 'Máy chủ gặp lỗi (${res.statusCode}). Vui lòng thử lại.',
      );
    }
  }

  static ApiResult<T> _read<T>(Object? body, T Function(Object? data)? parse) {
    // 204 hoặc thân rỗng: coi như thành công, không có dữ liệu.
    if (body == null || (body is String && body.trim().isEmpty)) return const ApiResult.ok(null);
    if (body is! Map) return const ApiResult.fail('Dữ liệu từ máy chủ không hợp lệ.');
    final message = body['message'] as String? ?? '';
    final errors = (body['errors'] as List?)?.map((e) => '$e').toList() ?? const <String>[];
    if (body['success'] != true) return ApiResult.fail(message, errors: errors);
    try {
      return ApiResult.ok(parse == null ? null : parse(body['data']), message: message);
    } catch (_) {
      return const ApiResult.fail('Dữ liệu từ máy chủ không hợp lệ.');
    }
  }
}

class _AuthInterceptor extends Interceptor {
  _AuthInterceptor(this._session, this._dio, this._refreshDio);

  final SessionStorage _session;
  final Dio _dio;
  final Dio _refreshDio;
  Future<String?>? _refreshing;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _session.accessToken;
    if (options.extra[_kAuth] != false && token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final opts = err.requestOptions;
    if (err.response?.statusCode != 401 || opts.extra[_kAuth] == false || opts.extra[_kRetried] == true) {
      return handler.next(err);
    }
    if (_session.refreshToken == null) {
      await _session.clear(expired: true);
      return handler.next(err);
    }

    final token = await (_refreshing ??= _refresh().whenComplete(() => _refreshing = null));
    if (token == null) return handler.next(err);

    opts.headers['Authorization'] = 'Bearer $token';
    opts.extra[_kRetried] = true;
    try {
      handler.resolve(await _dio.fetch<Object?>(opts));
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  /// Làm mới token (token rotation). Trả về access token mới, hoặc null nếu thất bại.
  /// Mất mạng thì giữ phiên để thử lại sau; máy chủ từ chối thì xoá phiên.
  Future<String?> _refresh() async {
    try {
      final res = await _refreshDio.post<Object?>('/Auth/refresh-token', data: {'refreshToken': _session.refreshToken});
      final body = res.data;
      if (body is Map && body['success'] == true && body['data'] is Map) {
        final session = AuthSession.fromJson(Map<String, dynamic>.from(body['data'] as Map));
        await _session.save(session);
        return session.accessToken;
      }
    } on DioException catch (e) {
      if (e.response == null) return null;
    } catch (_) {
      // Dữ liệu trả về sai khuôn: coi như làm mới thất bại.
    }
    await _session.clear(expired: true);
    return null;
  }
}
