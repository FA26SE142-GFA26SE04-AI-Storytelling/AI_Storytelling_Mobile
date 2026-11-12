/// Phân tích chuỗi đầu vào từ QR code hoặc nhập tay để trích xuất kid secret.
///
/// Trả về chuỗi secret hợp lệ hoặc `null` nếu định dạng không đúng.
String? parseKidSecret(String raw) {
  // 1. t = raw.trim(). Rỗng thì trả null.
  final t = raw.trim();
  if (t.isEmpty) {
    return null;
  }

  // 2. Nếu t chứa "://" hoặc chứa "?" thì coi là URL.
  if (t.contains('://') || t.contains('?')) {
    final u = Uri.tryParse(t);
    if (u == null) {
      return null;
    }
    final kid = u.queryParameters['kid']?.trim();
    if (kid == null || kid.isEmpty) {
      return null;
    }
    return kid;
  }

  // 3. Ngược lại là chuỗi secret trần: nếu chứa khoảng trắng thì null; nếu không trả t.
  if (t.contains(RegExp(r'\s'))) {
    return null;
  }
  return t;
}
