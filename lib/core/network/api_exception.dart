import 'package:dio/dio.dart';

class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final List<String> errors;

  static const String serverErrorMessage = 'Hệ thống đang bận. Vui lòng thử lại sau.';
  static const String defaultFallbackMessage = 'Có lỗi xảy ra. Vui lòng thử lại.';

  static const Map<int, String> statusMessages = {
    0: 'Không có kết nối mạng. Kiểm tra mạng rồi thử lại.',
    400: 'Dữ liệu chưa hợp lệ. Vui lòng kiểm tra lại các trường đã nhập.',
    401: 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
    403: 'Bạn không có quyền thực hiện thao tác này.',
    404: 'Không tìm thấy nội dung này.',
    409: 'Thao tác đang xung đột với dữ liệu hiện có. Vui lòng tải lại rồi thử lại.',
    429: 'Bạn thao tác quá nhanh. Đợi một lát rồi thử lại.',
    500: serverErrorMessage,
  };

  const ApiException({
    this.statusCode,
    required this.message,
    this.errors = const [],
  });

  factory ApiException.fromResponse({
    int? statusCode,
    Object? data,
    String fallbackMessage = defaultFallbackMessage,
  }) {
    final List<String> extractedErrors = [];
    String? backendMessage;

    if (data is Map) {
      final rawErrors = data['errors'];
      if (rawErrors is List) {
        for (final item in rawErrors) {
          if (item is String && item.trim().isNotEmpty) {
            extractedErrors.add(item.trim());
          }
        }
      } else if (rawErrors is Map) {
        for (final value in rawErrors.values) {
          if (value is String && value.trim().isNotEmpty) {
            extractedErrors.add(value.trim());
          } else if (value is List) {
            for (final subItem in value) {
              if (subItem is String && subItem.trim().isNotEmpty) {
                extractedErrors.add(subItem.trim());
              }
            }
          }
        }
      }

      String? getNonEmptyString(dynamic val) {
        if (val is String) {
          final trimmed = val.trim();
          if (trimmed.isNotEmpty && !_isTechnicalOrJson(trimmed)) {
            return trimmed;
          }
        }
        return null;
      }

      final detail = getNonEmptyString(data['detail']);
      final title = getNonEmptyString(data['title']);
      final msg = getNonEmptyString(data['message']);

      if (extractedErrors.isEmpty) {
        if (detail != null) {
          extractedErrors.add(detail);
        } else if (title != null) {
          extractedErrors.add(title);
        } else if (msg != null) {
          extractedErrors.add(msg);
        }
      }

      if (extractedErrors.isNotEmpty) {
        backendMessage = extractedErrors.first;
      } else {
        backendMessage = detail ?? title ?? msg;
      }
    } else if (data is String) {
      final trimmed = data.trim();
      if (trimmed.isNotEmpty && !_isTechnicalOrJson(trimmed)) {
        backendMessage = trimmed;
        extractedErrors.add(trimmed);
      }
    }

    String? tableMessage;
    if (statusCode == null || statusCode == 0) {
      tableMessage = statusMessages[0];
    } else if (statusCode >= 500) {
      tableMessage = serverErrorMessage;
    } else if (statusMessages.containsKey(statusCode)) {
      tableMessage = statusMessages[statusCode];
    }

    // Giống web (apiClient.ts): ưu tiên câu của Backend; mất mạng và lỗi 5xx
    // luôn dùng câu chung để không lộ lỗi kỹ thuật.
    final useTableFirst = statusCode == null || statusCode == 0 || statusCode >= 500;
    String chosenMessage = useTableFirst
        ? (tableMessage ?? fallbackMessage)
        : (backendMessage ?? tableMessage ?? fallbackMessage);
    if (_isTechnicalOrJson(chosenMessage)) {
      chosenMessage = fallbackMessage;
    }

    return ApiException(
      statusCode: statusCode,
      message: chosenMessage,
      errors: extractedErrors,
    );
  }

  factory ApiException.fromDioException(
    DioException error, {
    String fallbackMessage = defaultFallbackMessage,
  }) {
    final isConnectionIssue =
        error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout;

    final statusCode = isConnectionIssue ? 0 : error.response?.statusCode;
    final data = error.response?.data;

    return ApiException.fromResponse(
      statusCode: statusCode,
      data: data,
      fallbackMessage: fallbackMessage,
    );
  }

  static bool _isTechnicalOrJson(String str) {
    final trimmed = str.trim();
    if (trimmed.isEmpty) return true;
    if (trimmed.startsWith('{') || trimmed.startsWith('[') || trimmed.startsWith('<')) {
      return true;
    }
    if (trimmed.contains('Traceback') ||
        trimmed.contains('stack trace') ||
        trimmed.contains('Exception:') ||
        trimmed.contains('NullPointerException')) {
      return true;
    }
    return false;
  }

  @override
  String toString() => message;
}
