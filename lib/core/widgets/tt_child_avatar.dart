import 'package:flutter/material.dart';

import '../theme/tt_colors.dart';

final class ChildAvatarOption {
  const ChildAvatarOption({
    required this.id,
    required this.emoji,
    required this.label,
  });

  final String id;
  final String emoji;
  final String label;
}

const List<ChildAvatarOption> kChildAvatars = [
  ChildAvatarOption(id: 'avatar-frog', emoji: '🐸', label: 'Ếch'),
  ChildAvatarOption(id: 'avatar-cat', emoji: '🐱', label: 'Mèo'),
  ChildAvatarOption(id: 'avatar-rabbit', emoji: '🐰', label: 'Thỏ'),
  ChildAvatarOption(id: 'avatar-bear', emoji: '🐻', label: 'Gấu'),
  ChildAvatarOption(id: 'avatar-fox', emoji: '🦊', label: 'Cáo'),
  ChildAvatarOption(id: 'avatar-panda', emoji: '🐼', label: 'Gấu trúc'),
  ChildAvatarOption(id: 'avatar-koala', emoji: '🐨', label: 'Gấu túi'),
  ChildAvatarOption(id: 'avatar-tiger', emoji: '🐯', label: 'Hổ'),
  ChildAvatarOption(id: 'avatar-lion', emoji: '🦁', label: 'Sư tử'),
  ChildAvatarOption(id: 'avatar-owl', emoji: '🦉', label: 'Cú'),
  ChildAvatarOption(id: 'avatar-eagle', emoji: '🦅', label: 'Đại bàng'),
  ChildAvatarOption(id: 'avatar-turtle', emoji: '🐢', label: 'Rùa'),
  ChildAvatarOption(id: 'avatar-dolphin', emoji: '🐬', label: 'Cá heo'),
  ChildAvatarOption(id: 'avatar-whale', emoji: '🐳', label: 'Cá voi'),
];

ChildAvatarOption childAvatarOf(String? id) {
  if (id == null || id.isEmpty) {
    return kChildAvatars[0];
  }
  for (final option in kChildAvatars) {
    if (option.id == id) {
      return option;
    }
  }
  return kChildAvatars[0];
}

class TtChildAvatar extends StatelessWidget {
  const TtChildAvatar({
    super.key,
    required this.avatarId,
    this.size = 48,
    this.selected = false,
  });

  final String? avatarId;
  final double size;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final option = childAvatarOf(avatarId);

    return Semantics(
      label: option.label,
      image: true,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: tt.gold.withValues(alpha: 0.25),
          border: Border.all(
            color: selected ? tt.goldDeep : tt.line,
            width: selected ? 3 : 2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          option.emoji,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size * 0.55,
          ),
        ),
      ),
    );
  }
}
