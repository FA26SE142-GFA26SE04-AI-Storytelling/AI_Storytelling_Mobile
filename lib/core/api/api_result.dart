/// Kết quả của một lời gọi API, theo khuôn `{ success, message, data, errors }` của backend.
class ApiResult<T> {
  const ApiResult.ok(this.data, {this.message = ''}) : success = true, errors = const [], isNetworkError = false;

  const ApiResult.fail(this.message, {this.errors = const [], this.isNetworkError = false}) : success = false, data = null;

  final bool success;
  final String message;
  final T? data;
  final List<String> errors;

  /// Không kết nối được máy chủ (khác với máy chủ trả lỗi).
  final bool isNetworkError;

  /// Đổi kiểu dữ liệu khi thất bại, giữ nguyên thông báo lỗi.
  ApiResult<R> castFailure<R>() => ApiResult<R>.fail(message, errors: errors, isNetworkError: isNetworkError);

  /// Lấy dữ liệu hoặc ném [ApiException] — dùng trong provider để Riverpod hiện trạng thái lỗi.
  T unwrap() {
    if (success && data != null) return data as T;
    throw ApiException(message.isEmpty ? 'Không tải được dữ liệu. Vui lòng thử lại.' : message, isNetworkError: isNetworkError);
  }
}

class ApiException implements Exception {
  const ApiException(this.message, {this.isNetworkError = false});
  final String message;
  final bool isNetworkError;

  @override
  String toString() => message;
}
