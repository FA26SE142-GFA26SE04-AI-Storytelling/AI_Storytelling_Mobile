import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/kid_panel.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/my_roadmap_dto.dart';
import 'kid_stage_button.dart';

/// Thông báo khi bé bấm vào truyện bố mẹ chưa mở.
const String kKidLockedStoryMessage = 'Truyện này chưa mở, em chờ bố mẹ nhé.';

/// Thẻ "Hôm nay" gọn trên sảnh của bé: bìa + tên truyện bố mẹ chọn, bấm vào là đọc.
/// Chưa có truyện thì mời bé chọn truyện trong Kho truyện.
class KidTodayCard extends StatelessWidget {
  const KidTodayCard({
    super.key,
    required this.roadmap,
    required this.onRead,
    required this.onChooseStory,
  });

  final MyRoadmapDto roadmap;
  final void Function(int storyId) onRead;
  final VoidCallback onChooseStory;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final open = roadmap.open;
    final finishedAll = roadmap.isFinished && roadmap.totalCount > 0;

    final String tag;
    final String title;
    final IconData actionIcon;
    final VoidCallback onTap;
    if (open != null) {
      final name = open.title?.trim();
      tag = 'Hôm nay';
      title = (name == null || name.isEmpty) ? 'Truyện bố mẹ chọn' : name;
      actionIcon = open.isLocked
          ? Icons.lock_rounded
          : Icons.play_arrow_rounded;
      onTap = open.isLocked
          ? () => showTtToast(context, kKidLockedStoryMessage)
          : () => onRead(open.storyId);
    } else {
      tag = finishedAll ? 'Giỏi quá!' : 'Chọn truyện';
      title = finishedAll
          ? 'Em đã đọc hết truyện bố mẹ chọn rồi'
          : 'Hôm nay em muốn đọc truyện gì?';
      actionIcon = Icons.search_rounded;
      onTap = onChooseStory;
    }
    final note = open?.note?.trim();

    return Semantics(
      button: true,
      label: open != null ? 'Đọc truyện hôm nay: $title' : title,
      excludeSemantics: true,
      // excludeSemantics bỏ cả hành động bấm của con, nên gắn lại để TalkBack/VoiceOver bấm được.
      onTap: onTap,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: KidPanel(
          borderColor: tt.goldDeep,
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              if (open != null)
                // SizedBox cố định: sảnh đo chiều cao nội tại, ảnh có crop dùng LayoutBuilder.
                SizedBox(
                  width: 54,
                  height: 72,
                  child: TtNetworkImage(
                    url: open.coverImageUrl,
                    width: 54,
                    height: 72,
                    radius: BorderRadius.circular(TtRadius.md),
                  ),
                )
              else
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: tt.gold.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    finishedAll
                        ? Icons.emoji_events_rounded
                        : Icons.auto_stories_rounded,
                    size: 30,
                    color: tt.goldDeep,
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: tt.gold,
                        borderRadius: BorderRadius.circular(TtRadius.full),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontFamily: 'Baloo2',
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          height: 1.3,
                          color: kKidInkOnBright,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Baloo2',
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                        color: tt.text,
                      ),
                    ),
                    if (note != null && note.isNotEmpty)
                      Text(
                        '💌 $note',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: open?.isLocked == true ? tt.line2 : tt.gold,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: tt.goldDeep.withValues(alpha: 0.6),
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(actionIcon, size: 28, color: kKidInkOnBright),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
