import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/kid_panel.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_network_image.dart';
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
    final tt = context.tt;

    final headerColor = open != null ? tt.primary : tt.gold;
    const headerTitle = 'Hôm nay em đọc';
    final headerIcon =
        open != null ? Icons.menu_book_rounded : Icons.auto_stories_rounded;

    return KidPanel(
      borderColor: headerColor,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          KidPanelHeader(
            title: headerTitle,
            color: headerColor,
            icon: headerIcon,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: open != null
                ? _buildOpenStoryContent(context, open)
                : _buildNoOpenStoryContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildOpenStoryContent(
    BuildContext context,
    MyRoadmapOpenStoryDto open,
  ) {
    final tt = context.tt;
    final completedCount = roadmap.completedCount;
    final totalCount = roadmap.totalCount;
    final progress =
        (totalCount > 0) ? (completedCount / totalCount).clamp(0.0, 1.0) : 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TtNetworkImage(
          url: open.coverImageUrl,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          radius: BorderRadius.circular(TtRadius.lg),
        ),
        const SizedBox(height: 12),
        Text(
          open.title ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Baloo2',
                fontWeight: FontWeight.bold,
                color: tt.text,
              ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(TtRadius.full),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: tt.line,
                  valueColor: AlwaysStoppedAnimation<Color>(tt.primary),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '$completedCount/$totalCount',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: tt.muted,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        if (open.note != null && open.note!.trim().isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: tt.gold.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(TtRadius.md),
            ),
            child: Text(
              '💌 ${open.note!.trim()}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontFamily: 'Nunito',
                    color: tt.text,
                  ),
            ),
          ),
        ],
        if (open.isLocked) ...[
          const SizedBox(height: 12),
          Text(
            'Truyện này chưa mở, em chờ bố mẹ nhé.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: tt.muted,
                ),
          ),
        ],
        const SizedBox(height: 16),
        KidBtn3D(
          label: 'Đọc ngay',
          icon: Icons.menu_book_rounded,
          color: tt.primary,
          expand: true,
          onPressed: open.isLocked ? null : () => onRead(open.storyId),
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
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontFamily: 'Baloo2',
                color: tt.text,
              ),
        ),
        const SizedBox(height: 16),
        KidBtn3D(
          label: 'Chọn truyện',
          icon: Icons.search_rounded,
          color: tt.gold,
          expand: true,
          onPressed: () => context.go('/kid/library'),
        ),
      ],
    );
  }
}
