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
}
