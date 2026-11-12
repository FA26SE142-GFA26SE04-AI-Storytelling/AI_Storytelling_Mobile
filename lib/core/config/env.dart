/// Cấu hình môi trường cho ứng dụng.
class Env {
  Env._();

  static const String _rawApiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://api.taletale.site/api/v1',
  );

  static const bool useMock = bool.fromEnvironment(
    'USE_MOCK',
    defaultValue: false,
  );

  /// Chuẩn hóa URL base của API, đảm bảo luôn kết thúc bằng /api/v1.
  static String normalizeApiBaseUrl(String raw) {
    var url = raw.trim();
    if (url.isEmpty) {
      return 'https://api.taletale.site/api/v1';
    }

    // Bỏ đuôi /index.html rồi đến /swagger (nếu có)
    url = url.replaceAll(RegExp(r'/index\.html/?$', caseSensitive: false), '');
    url = url.replaceAll(RegExp(r'/swagger/?$', caseSensitive: false), '');

    // Bỏ các dấu / ở cuối
    url = url.replaceAll(RegExp(r'/+$'), '');

    // Nếu chưa kết thúc bằng /api/v1 thì nối thêm /api/v1
    if (!url.toLowerCase().endsWith('/api/v1')) {
      url = '$url/api/v1';
    }

    return url;
  }

  static final String apiBaseUrl = normalizeApiBaseUrl(_rawApiUrl);
}
