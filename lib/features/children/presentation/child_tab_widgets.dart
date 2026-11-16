import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_child_avatar.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../models/child_profile_dto.dart';
import '../data/archived_children_store.dart';
import 'children_providers.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

String _ageBandLabel(String ageBand) {
  switch (ageBand) {
    case 'Age_6_8':
      return '6–8 tuổi';
    case 'Age_9_10':
      return '9–10 tuổi';
    default:
      return ageBand;
  }
}

String _readingModeLabel(String? mode) {
  switch (mode) {
    case 'ListenFirst':
      return 'Nghe là chính';
    case 'ReadFirst':
      return 'Tự đọc';
    default:
      return mode ?? '';
  }
}

// ---------------------------------------------------------------------------
// 1. ChildPickerStrip
// ---------------------------------------------------------------------------

/// Hàng cuộn ngang chọn bé – bé đang chọn có viền vàng honey, cuối dãy có
/// nút "Thêm bé" và hồ sơ lưu trữ (mờ 50 %).
class ChildPickerStrip extends StatelessWidget {
  const ChildPickerStrip({
    super.key,
    required this.children,
    required this.archived,
    required this.selectedId,
    required this.onSelect,
    required this.onOpenArchived,
    required this.onAdd,
  });

  final List<ChildProfileDto> children;
  final List<ArchivedChild> archived;
  final int? selectedId;
  final ValueChanged<int> onSelect;
  final ValueChanged<int> onOpenArchived;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 96,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // Bé chính
          ...children.map((c) => _ChildAvatar(
                key: ValueKey('child-${c.id}'),
                avatarId: c.avatarId,
                nickname: c.nickname,
                isSelected: c.id == selectedId,
                opacity: 1.0,
                onTap: () => onSelect(c.id),
                tt: tt,
                textTheme: textTheme,
              )),

          // Hồ sơ lưu trữ
          ...archived.map((a) => _ChildAvatar(
                key: ValueKey('archived-${a.id}'),
                avatarId: a.avatarId,
                nickname: a.nickname,
                isSelected: false,
                opacity: 0.5,
                onTap: () => onOpenArchived(a.id),
                tt: tt,
                textTheme: textTheme,
              )),

          // Nút thêm bé
          _AddChildButton(onAdd: onAdd, tt: tt, textTheme: textTheme),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 280.ms)
        .slideY(begin: 0.06, end: 0, duration: 280.ms, curve: Curves.easeOut);
  }
}

class _ChildAvatar extends StatelessWidget {
  const _ChildAvatar({
    super.key,
    required this.avatarId,
    required this.nickname,
    required this.isSelected,
    required this.opacity,
    required this.onTap,
    required this.tt,
    required this.textTheme,
  });

  final String? avatarId;
  final String nickname;
  final bool isSelected;
  final double opacity;
  final VoidCallback onTap;
  final TtColors tt;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          width: 68,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TtChildAvatar(
                avatarId: avatarId,
                size: 56,
                selected: isSelected,
              ),
              const SizedBox(height: 4),
              Text(
                nickname,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: textTheme.labelSmall?.copyWith(
                  fontFamily: 'Nunito',
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? tt.text : tt.muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddChildButton extends StatelessWidget {
  const _AddChildButton({
    required this.onAdd,
    required this.tt,
    required this.textTheme,
  });

  final VoidCallback onAdd;
  final TtColors tt;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        width: 68,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: tt.line2, width: 2),
                color: tt.surface,
              ),
              child: Icon(
                Icons.add_rounded,
                size: 28,
                color: tt.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Thêm bé',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: textTheme.labelSmall?.copyWith(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
                color: tt.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. PrimaryChildCard
// ---------------------------------------------------------------------------

/// Thẻ nổi bật hiển thị thông tin chính của bé đang được chọn, kèm nút hành
/// động chính và gợi ý hoàn tất nếu thiếu thông tin.
class PrimaryChildCard extends StatelessWidget {
  const PrimaryChildCard({
    super.key,
    required this.child,
    required this.statusLabel,
    required this.statusColor,
    required this.primaryLabel,
    required this.onPrimaryAction,
    required this.showMissingHint,
  });

  final ChildProfileDto child;
  final String statusLabel;
  final Color statusColor;
  final String? primaryLabel;
  final VoidCallback? onPrimaryAction;
  final bool showMissingHint;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final ageBandText = _ageBandLabel(child.ageBand);

    return TtCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TtChildAvatar(avatarId: child.avatarId, size: 64),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tên bé
                    Text(
                      child.nickname,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleLarge?.copyWith(
                        fontFamily: 'Baloo2',
                        fontWeight: FontWeight.w700,
                        color: tt.text,
                      ),
                    ),
                    if (ageBandText.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        ageBandText,
                        style: textTheme.bodySmall?.copyWith(
                          fontFamily: 'Nunito',
                          color: tt.muted,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    // Chip trạng thái
                    _StatusChip(
                      label: statusLabel,
                      color: statusColor,
                      tt: tt,
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (primaryLabel != null) ...[
            const SizedBox(height: 14),

            // Gợi ý "Cần hoàn tất"
            if (showMissingHint) ...[
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: tt.gold,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Cần hoàn tất',
                    style: textTheme.labelSmall?.copyWith(
                      fontFamily: 'Nunito',
                      color: tt.goldDeep,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],

            TtButton(
              label: primaryLabel!,
              onPressed: onPrimaryAction,
              expanded: true,
            ),
          ],
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 320.ms)
        .slideY(begin: 0.05, end: 0, duration: 320.ms, curve: Curves.easeOut);
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.color,
    required this.tt,
  });

  final String label;
  final Color color;
  final TtColors tt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(TtRadius.sm),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. ChildGroupGrid
// ---------------------------------------------------------------------------

/// Lưới 2×2 hiển thị 4 nhóm thông tin của bé: hồ sơ, học tập, an toàn, mã
/// QR. Mỗi ô bấm được; ô thiếu dữ liệu hiện chấm vàng cảnh báo.
class ChildGroupGrid extends StatelessWidget {
  const ChildGroupGrid({
    super.key,
    required this.child,
    required this.overview,
    required this.loading,
    required this.onOpen,
  });

  final ChildProfileDto child;
  final ChildOverview? overview;
  final bool loading;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final ageBandText = _ageBandLabel(child.ageBand);
    final learning = overview?.learning;
    final safety = overview?.safety;
    final access = overview?.access;

    // Giá trị ô học tập
    String learningValue;
    if (loading) {
      learningValue = '';
    } else if (learning != null) {
      final modeLabel = _readingModeLabel(learning.readingMode);
      if (modeLabel.isNotEmpty) {
        learningValue = 'Mức ${learning.readingLevel} · $modeLabel';
      } else {
        learningValue = 'Mức ${learning.readingLevel}';
      }
    } else {
      learningValue = 'Chưa thiết lập';
    }

    // Giá trị ô an toàn
    String safetyValue;
    if (loading) {
      safetyValue = '';
    } else if (safety != null) {
      safetyValue = safety.parentalGateEnabled
          ? 'Cổng phụ huynh: Bật'
          : 'Cổng phụ huynh: Tắt';
    } else {
      safetyValue = 'Chưa thiết lập';
    }

    // Giá trị ô mã QR
    String accessValue;
    if (loading) {
      accessValue = '';
    } else {
      accessValue =
          (access?.hasEasyLogin == true) ? 'Đã có mã' : 'Chưa có mã';
    }

    final tiles = [
      _GridTileData(
        key: 'profile',
        icon: Icons.badge_rounded,
        title: 'Hồ sơ',
        value: ageBandText,
        showSkeleton: false,
        showWarning: false,
      ),
      _GridTileData(
        key: 'learning',
        icon: Icons.menu_book_rounded,
        title: 'Học tập',
        value: learningValue,
        showSkeleton: loading,
        showWarning: !loading && learning == null,
      ),
      _GridTileData(
        key: 'safety',
        icon: Icons.shield_rounded,
        title: 'An toàn',
        value: safetyValue,
        showSkeleton: loading,
        showWarning: !loading && safety == null,
      ),
      _GridTileData(
        key: 'access',
        icon: Icons.qr_code_2_rounded,
        title: 'Mã QR',
        value: accessValue,
        showSkeleton: loading,
        showWarning: false,
      ),
    ];

    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // Chiều cao cố định: màn rộng không kéo ô cao lên.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: 112,
      ),
      children: tiles
          .map((t) => _GroupTile(
                data: t,
                onTap: () => onOpen(t.key),
              ))
          .toList(),
    )
        .animate()
        .fadeIn(duration: 350.ms)
        .slideY(begin: 0.04, end: 0, duration: 350.ms, curve: Curves.easeOut);
  }
}

class _GridTileData {
  const _GridTileData({
    required this.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.showSkeleton,
    required this.showWarning,
  });

  final String key;
  final IconData icon;
  final String title;
  final String value;
  final bool showSkeleton;
  final bool showWarning;
}

class _GroupTile extends StatelessWidget {
  const _GroupTile({
    required this.data,
    required this.onTap,
  });

  final _GridTileData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;

    return TtCard(
      padding: const EdgeInsets.all(12),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon trong vòng tròn nền honey nhạt
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: tt.gold.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(data.icon, size: 18, color: tt.goldDeep),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelMedium?.copyWith(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    color: tt.text,
                  ),
                ),
              ),
              // Chấm cảnh báo vàng khi thiếu dữ liệu
              if (data.showWarning) ...[
                const SizedBox(width: 4),
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: tt.gold,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          // Giá trị hoặc skeleton
          if (data.showSkeleton)
            const TtSkeleton(height: 13, width: 90)
          else
            Text(
              data.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodySmall?.copyWith(
                fontFamily: 'Nunito',
                color: tt.muted,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}
