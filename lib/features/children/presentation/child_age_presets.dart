import '../../../models/content_category_dto.dart';
import '../../../models/safety_policy_dto.dart';

class AgeBandInfo {
  final String id;
  final String label;
  final String hint;

  const AgeBandInfo({
    required this.id,
    required this.label,
    required this.hint,
  });
}

const List<AgeBandInfo> kAgeBands = [
  AgeBandInfo(
    id: 'Age_6_8',
    label: '6–8 tuổi',
    hint: 'Đang học đọc, nghe là chính',
  ),
  AgeBandInfo(id: 'Age_9_10', label: '9–10 tuổi', hint: 'Đã tự đọc được'),
];

int defaultReadingLevel(String ageBand) {
  return ageBand == 'Age_9_10' ? 3 : 1;
}

String defaultReadingMode(String ageBand) {
  return ageBand == 'Age_9_10' ? 'ReadFirst' : 'ListenFirst';
}

int storyLengthFor(String ageBand, int level) {
  return (ageBand == 'Age_9_10' || level >= 4) ? 1500 : 900;
}

List<SafetyCategoryRuleDto> presetBlocked(
  List<ContentCategoryDto> categories,
  String ageBand,
) {
  // Backend đã gắn sẵn nhóm tuổi cần chặn cho danh mục thì dùng luôn, không đoán theo tên.
  if (categories.any((c) => c.defaultBlockedAgeBands.isNotEmpty)) {
    return [
      for (final c in categories)
        if (c.isActive && c.defaultBlockedAgeBands.contains(ageBand))
          SafetyCategoryRuleDto(contentCategoryId: c.id, rule: 'Blocked'),
    ];
  }

  // Regex keywords theo logic web:
  final sensitiveReg = RegExp(
    r'violen|bao.?luc|bạo lực|hate|thu.?ghet|thù ghét|kỳ thị|adult|nguoi.?lon|người lớn|sex|tình dục|alcohol|rượu|drug|chất kích thích|personal|ca.?nhan|cá nhân|danger|nguy hiểm|relig|tôn giáo|politic|chính trị',
    caseSensitive: false,
  );
  final horrorReg = RegExp(r'horror|kinh dị|ma quỷ', caseSensitive: false);
  final mildFearReg = RegExp(
    r'scary|fear|sợ hãi|so.?hai',
    caseSensitive: false,
  );

  final List<SafetyCategoryRuleDto> rules = [];

  for (final cat in categories) {
    if (!cat.isActive) continue;

    bool shouldBlock = false;
    final textToMatch = '${cat.code} ${cat.displayName}';

    if (sensitiveReg.hasMatch(textToMatch)) {
      shouldBlock = true;
    } else if (horrorReg.hasMatch(textToMatch)) {
      shouldBlock = true;
    } else if (ageBand == 'Age_6_8' && mildFearReg.hasMatch(textToMatch)) {
      shouldBlock = true;
    }

    if (shouldBlock) {
      rules.add(
        SafetyCategoryRuleDto(contentCategoryId: cat.id, rule: 'Blocked'),
      );
    }
  }

  return rules;
}

/// Nội dung đồng ý (a)–(d) phụ huynh phải đọc trước khi bé dùng (theo web CONSENT_ITEMS).
const List<String> kConsentItems = [
  'Nền tảng chỉ lưu biệt danh, nhóm tuổi và cấu hình học tập của bé; không thu thập họ tên đầy đủ, ngày sinh, trường học hay địa chỉ.',
  'Truyện của bé do AI sinh ra và được kiểm tra an toàn tự động trước khi tới bước duyệt của bạn.',
  'Truyện bị AI gắn cờ nghi vấn có thể được kiểm duyệt viên của nền tảng đọc để kiểm tra an toàn. Kiểm duyệt viên không thấy biệt danh của bé hay thông tin gia đình. Bạn không nên đặt tên nhân vật trùng tên thật của con.',
  'Hệ thống tự phát hiện số điện thoại, địa chỉ, tên trường và biệt danh của bé trong truyện để cảnh báo bạn.',
];
