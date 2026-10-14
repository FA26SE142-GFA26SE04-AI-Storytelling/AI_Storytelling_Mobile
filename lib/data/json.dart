/// Đọc JSON từ backend một cách chặt chẽ: sai kiểu thì ném lỗi để ApiClient báo "dữ liệu không hợp lệ".
typedef Json = Map<String, dynamic>;

Json asJson(Object? v) => Map<String, dynamic>.from(v as Map);

int asInt(Object? v) => (v as num).toInt();

int? asIntOrNull(Object? v) => v == null ? null : (v as num).toInt();

double? asDoubleOrNull(Object? v) => v == null ? null : (v as num).toDouble();

List<String> asStrings(Object? v) => (v as List?)?.map((e) => '$e').toList() ?? <String>[];

List<T> asList<T>(Object? v, T Function(Json json) parse) => (v as List?)?.map((e) => parse(asJson(e))).toList() ?? <T>[];

DateTime asDate(Object? v) => DateTime.parse(v as String);

DateTime? asDateOrNull(Object? v) => v == null ? null : DateTime.tryParse(v as String);
