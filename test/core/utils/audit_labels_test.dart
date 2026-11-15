import 'package:ai_storytelling_mobile/core/utils/audit_labels.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('auditActionLabel', () {
    test('mã có sẵn trả về đúng nhãn định nghĩa sẵn', () {
      expect(
        auditActionLabel('UPDATE_PROFILE', 'UserAccount'),
        'Sửa thông tin tài khoản',
      );
    });

    test('mã động từ chung kết hợp với nhãn thực thể viết thường', () {
      expect(
        auditActionLabel('Created', 'ChildProfile'),
        'Tạo hồ sơ bé',
      );
    });

    test('mã không có trả về nhãn mặc định', () {
      expect(
        auditActionLabel('SOMETHING_NEW', 'UserAccount'),
        'Thay đổi khác',
      );
    });
  });

  group('auditEntityLabel', () {
    test('loại thực thể không tồn tại trả về Mục khác', () {
      expect(
        auditEntityLabel('NoSuchType'),
        'Mục khác',
      );
    });
  });
}
