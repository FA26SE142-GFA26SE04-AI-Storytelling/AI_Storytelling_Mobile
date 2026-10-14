/// Cấu hình lúc build, truyền bằng `--dart-define`:
///
///   flutter run --dart-define=USE_MOCK=false --dart-define=API_URL=https://api.taletale.site
///
/// Tương đương NEXT_PUBLIC_USE_MOCK và NEXT_PUBLIC_API_URL bên web.
abstract final class Env {
  /// Mặc định dùng dữ liệu mẫu, không gọi API thật (giống web).
  static const bool useMock = bool.fromEnvironment('USE_MOCK', defaultValue: true);

  static const String _rawApiUrl = String.fromEnvironment('API_URL');

  static final String apiBaseUrl = normalizeBaseUrl(_rawApiUrl);
}

const _fallbackBaseUrl = 'https://api.taletale.site/api/v1';

/// Chuẩn hoá địa chỉ API: bỏ /index.html, /swagger, dấu / ở cuối và đảm bảo hậu tố /api/v1.
String normalizeBaseUrl(String raw) {
  var url = raw.trim();
  if (url.isEmpty) return _fallbackBaseUrl;
  url = url
      .replaceFirst(RegExp(r'/index\.html/?$', caseSensitive: false), '')
      .replaceFirst(RegExp(r'/swagger/?$', caseSensitive: false), '')
      .replaceFirst(RegExp(r'/+$'), '');
  if (!url.endsWith('/api/v1')) url = '$url/api/v1';
  return url;
}
