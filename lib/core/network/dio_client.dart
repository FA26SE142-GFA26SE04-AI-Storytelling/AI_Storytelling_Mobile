import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';

import '../config/env.dart';
import '../storage/token_storage.dart';
import 'api_exception.dart';

// ─── Provider chính ──────────────────────────────────────────────────────────

/// Cung cấp instance Dio đã gắn AuthInterceptor.
final dioProvider = Provider<Dio>((ref) {
  final storage = ref.watch(tokenStorageProvider);

  // Dio riêng để gọi refresh, không có interceptor → tránh vòng lặp vô tận.
  final refreshDio = Dio(
    BaseOptions(
      baseUrl: Env.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  final dio = Dio(
    BaseOptions(
      baseUrl: Env.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    AuthInterceptor(
      storage: storage,
      refreshDio: refreshDio,
      dio: dio,
      onSessionExpired: () =>
          ref.read(authControllerProvider.notifier).sessionExpired(),
    ),
  );

  return dio;
});

// ─── AuthInterceptor ─────────────────────────────────────────────────────────

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.storage,
    required this.refreshDio,
    required this.dio,
    this.onSessionExpired,
  });

  final TokenStorage storage;

  /// Dio không interceptor — chỉ dùng để gọi endpoint refresh token.
  final Dio refreshDio;

  /// Dio gốc — dùng để retry request sau khi refresh thành công.
  final Dio dio;

  /// Callback tuỳ chọn, được gọi khi phiên hết hạn hoàn toàn.
  final void Function()? onSessionExpired;

  /// Single-flight: đảm bảo mọi request 401 đồng thời chỉ trigger một lần refresh.
  Future<String?>? _refreshing;

  // ── onRequest ───────────────────────────────────────────────────────────────

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Bỏ qua nếu request được đánh dấu anonymous hoặc đã có Authorization.
    final isAnonymous = options.extra['anonymous'] == true;
    final hasAuth = options.headers.containsKey('Authorization');

    if (!isAnonymous && !hasAuth) {
      final token = await storage.readAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }

  // ── onError ─────────────────────────────────────────────────────────────────

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final options = err.requestOptions;

    final bool is401 = statusCode == 401;
    final bool isAnonymous = options.extra['anonymous'] == true;
    final bool alreadyRetried = options.extra['retried'] == true;
    final bool isRefreshEndpoint = options.path.contains('/Auth/refresh-token');

    if (is401 && !isAnonymous && !alreadyRetried && !isRefreshEndpoint) {
      final refreshToken = await storage.readRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        // Không có refresh token → phiên hết hạn ngay.
        await storage.clearTokens();
        onSessionExpired?.call();
        return handler.next(err);
      }

      try {
        // Single-flight: dùng chung một Future nếu đang refresh.
        _refreshing ??= _doRefresh(refreshToken);
        final newAccessToken = await _refreshing;

        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          // Lưu token mới (refresh rotation: response trả cả cặp).
          // saveTokens đã được gọi bên trong _doRefresh.
          // Retry request gốc với token mới.
          options.headers['Authorization'] = 'Bearer $newAccessToken';
          options.extra['retried'] = true;

          final retryResponse = await dio.fetch(options);
          return handler.resolve(retryResponse);
        } else {
          // Refresh thất bại do session hết hạn (đã xử lý trong _doRefresh).
          return handler.next(err);
        }
      } catch (_) {
        // Lỗi không mong đợi từ bước refresh — chuyển tiếp lỗi gốc.
        return handler.next(err);
      }
    }

    handler.next(err);
  }

  // ── Hàm nội bộ refresh token ─────────────────────────────────────────────

  /// Gọi API refresh token. Trả về accessToken mới nếu thành công, null nếu thất bại.
  /// Token bị xoá ngay bên trong nếu server trả 400/401/403.
  Future<String?> _doRefresh(String refreshToken) async {
    try {
      final response = await refreshDio.post<Map<String, dynamic>>(
        '/Auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      final body = response.data;
      final success = body?['success'] == true;
      final newAccess = body?['data']?['accessToken'] as String?;
      final newRefresh = body?['data']?['refreshToken'] as String?;

      if (success && newAccess != null && newRefresh != null) {
        await storage.saveTokens(
          accessToken: newAccess,
          refreshToken: newRefresh,
        );
        return newAccess;
      }

      // Response không hợp lệ → coi như hết phiên.
      await storage.clearTokens();
      onSessionExpired?.call();
      return null;
    } on DioException catch (e) {
      final code = e.response?.statusCode;

      // 400/401/403 → phiên hết hạn thực sự.
      if (code == 400 || code == 401 || code == 403) {
        await storage.clearTokens();
        onSessionExpired?.call();
      }
      // Lỗi mạng hoặc 5xx → KHÔNG xoá token.
      return null;
    } finally {
      _refreshing = null;
    }
  }
}

// ─── Hàm tiện ích ────────────────────────────────────────────────────────────

/// Bọc mọi lời gọi API, chuyển DioException thành ApiException.
///
/// Trên Flutter Web, lỗi CORS hoặc mạng đôi khi là [TypeError] (JS native)
/// hoặc [Exception] thông thường, không phải [DioException].
/// Chúng bị bắt bởi nhánh thứ hai và chuyển thành [ApiException] mã 0
/// (mất mạng) để UI luôn hiển thị đúng thông báo.
Future<T> runApi<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on DioException catch (e) {
    throw ApiException.fromDioException(e);
  } on ApiException {
    // ApiException từ _unwrap() hoặc tầng khác: giữ nguyên, không bọc lại.
    rethrow;
  } catch (e) {
    // Lỗi không xác định (TypeError CORS trên web, v.v.) → coi là mất mạng.
    throw ApiException(
      statusCode: 0,
      message: ApiException.statusMessages[0] ??
          'Không có kết nối mạng. Kiểm tra mạng rồi thử lại.',
    );
  }
}
