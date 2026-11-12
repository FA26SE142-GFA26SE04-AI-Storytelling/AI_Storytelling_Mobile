import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_cropped_image.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../models/my_roadmap_dto.dart';

/// Thẻ lớn "Hôm nay em đọc" cho Chế độ của bé (màn dọc điện thoại, chữ lớn, nút to).
class KidTodayCard extends StatelessWidget {
  const KidTodayCard({
    super.key,
    required this.roadmap,
    required this.onRead,
    required this.onChooseStory,
  });

  /// Thông tin lộ trình đọc hôm nay của bé.
  final MyRoadmapDto roadmap;

  /// Callback khi bé nhấn nút đọc truyện đang mở.
  final void Function(int storyId) onRead;

  /// Callback khi bé chọn truyện (khi không có truyện mở).
  final VoidCallback onChooseStory;

  @override
  Widget build(BuildContext context) {
    final open = roadmap.open;

    return TtCard(
      padding: const EdgeInsets.all(16),
      child: open != null
          ? _buildOpenStoryContent(context, open)
          : _buildNoOpenStoryContent(context),
    );
  }

  Widget _buildOpenStoryContent(
    BuildContext context,
    MyRoadmapOpenStoryDto open,
  ) {
    final tt = context.tt;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(
              Icons.star_rounded,
              color: tt.goldDeep,
              size: 32,
            ),
            const SizedBox(width: 8),
            Text(
              'Hôm nay em đọc',
              style: TextStyle(
                fontFamily: 'Baloo2',
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: tt.text,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        TtCroppedImage(
          url: open.coverImageUrl,
          height: 200,
          width: double.infinity,
          radius: BorderRadius.circular(TtRadius.lg),
        ),
        const SizedBox(height: 14),
        Text(
          open.title ?? '',
          style: TextStyle(
            fontFamily: 'Baloo2',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: tt.text,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (open.note != null && open.note!.trim().isNotEmpty) ...[
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: tt.gold.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(TtRadius.md),
            ),
            child: Text(
              '💌 ${open.note!.trim()}',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: tt.text,
              ),
            ),
          ),
        ],
        if (open.isLocked) ...[
          const SizedBox(height: 14),
          Text(
            'Truyện này chưa mở, em chờ bố mẹ nhé.',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: tt.muted,
            ),
          ),
        ],
        const SizedBox(height: 16),
        SizedBox(
          height: 64,
          child: TtButton(
            label: 'Đọc ngay',
            icon: Icons.menu_book_rounded,
            expanded: true,
            variant: TtButtonVariant.primary,
            onPressed: open.isLocked ? null : () => onRead(open.storyId),
          ),
        ),
      ],
    );
  }

  Widget _buildNoOpenStoryContent(BuildContext context) {
    final tt = context.tt;
    final isFinishedAll = roadmap.isFinished && roadmap.totalCount > 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TtFrog(
          mood: isFinishedAll ? TtFrogMood.happy : TtFrogMood.idle,
          size: 120,
        ),
        const SizedBox(height: 16),
        Text(
          isFinishedAll
              ? 'Em đã đọc hết truyện bố mẹ chọn rồi. Giỏi quá!'
              : 'Hôm nay em muốn đọc truyện gì?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Baloo2',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: tt.text,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 64,
          child: TtButton(
            label: 'Chọn truyện',
            icon: Icons.search_rounded,
            expanded: true,
            onPressed: onChooseStory,
          ),
        ),
      ],
    );
  }
}
