import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/widgets/tt_child_avatar.dart';
import 'package:ai_storytelling_mobile/features/children/data/archived_children_store.dart';

void main() {
  group('childAvatarOf (giống avatarOf của web)', () {
    test('mã khớp trả đúng con vật', () {
      expect(childAvatarOf('avatar-cat').emoji, '🐱');
      expect(childAvatarOf('avatar-whale').label, 'Cá voi');
    });

    test('mã lạ, avatar-default, rỗng hoặc null đều là ếch', () {
      for (final id in ['avatar-default', 'xyz', '', null]) {
        expect(childAvatarOf(id).id, 'avatar-frog', reason: '$id');
      }
    });

    test('đủ 14 con vật, mã không trùng', () {
      expect(kChildAvatars.length, 14);
      expect(kChildAvatars.map((a) => a.id).toSet().length, 14);
    });
  });

  group('ArchivedChild.fromJson', () {
    test('đọc avatarId dạng chuỗi', () {
      final c = ArchivedChild.fromJson(
        {'id': 3, 'nickname': 'Bé An', 'avatarId': 'avatar-fox'},
      );
      expect(c.avatarId, 'avatar-fox');
      expect(ArchivedChild.fromJson(c.toJson()), c);
    });

    test('bản lưu cũ ghi avatarId là số thì bỏ qua, không lỗi', () {
      final c = ArchivedChild.fromJson(
        {'id': 3, 'nickname': 'Bé An', 'avatarId': 5},
      );
      expect(c.avatarId, isNull);
      expect(c.nickname, 'Bé An');
    });
  });
}
