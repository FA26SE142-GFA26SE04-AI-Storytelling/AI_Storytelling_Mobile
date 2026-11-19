import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../models/library_story_dto.dart';
import '../data/library_logic.dart';
import 'story_preview_screen.dart';

/// Kiểu chữ tên truyện trên thẻ (nhỏ, đậm, 2 dòng).
TextStyle libraryCardTitleStyle(BuildContext context) =>
    Theme.of(context).textTheme.titleSmall!
        .copyWith(fontSize: 13, height: 1.25);

/// Chiều cao thẻ khi bìa rộng [width]: bìa 3:4 + khoảng cách + 2 dòng tên.
double libraryCardHeight(BuildContext context, double width) =>
    width * 4 / 3 + 4 + MediaQuery.textScalerOf(context).scale(13) * 1.25 * 2;

/// Thẻ truyện bìa dọc 3:4 + tên tối đa 2 dòng. Góc bìa: [rank] (số hạng vàng),
/// nhãn "MỚI" khi truyện tạo trong 7 ngày; [showStatus] hiện trạng thái
/// (chỉ dùng ở kệ "Đang chuẩn bị"). Nhấn thì thẻ thu nhỏ nhẹ.
class LibraryStoryCard extends StatefulWidget {
  const LibraryStoryCard({
    super.key,
    required this.story,
    this.rank,
    this.showStatus = false,
  });

  final LibraryStoryDto story;
  final int? rank;
  final bool showStatus;

  @override
  State<LibraryStoryCard> createState() => _LibraryStoryCardState();
}

class _LibraryStoryCardState extends State<LibraryStoryCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final story = widget.story;
    final title = libraryCardTitleStyle(context);
    final titleHeight =
        MediaQuery.textScalerOf(context).scale(title.fontSize!) * 1.25 * 2;
    final radius = BorderRadius.circular(TtRadius.sm);
    final badge = Theme.of(context).textTheme.labelLarge;
    void open() => openStoryPreview(context, story);

    return Semantics(
      button: true,
      label: story.title,
      excludeSemantics: true,
      // excludeSemantics bỏ cả hành động bấm của con, nên gắn lại để TalkBack/VoiceOver bấm được.
      onTap: open,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1,
        duration: const Duration(milliseconds: 120),
        child: InkWell(
          onTap: open,
          onHighlightChanged: (v) => setState(() => _pressed = v),
          borderRadius: radius,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    border: Border.all(color: tt.line2, width: 1.2),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      TtNetworkImage(
                        url: story.coverImageUrl,
                        radius: BorderRadius.circular(TtRadius.sm - 1.2),
                      ),
                      if (widget.rank != null)
                        Positioned(
                          left: 4,
                          top: 4,
                          child: _Badge(
                            text: '${widget.rank}',
                            fill: tt.gold,
                            style: badge,
                          ),
                        ),
                      if (story.isNewAt(DateTime.now()))
                        Positioned(
                          right: widget.rank == null ? null : 4,
                          left: widget.rank == null ? 4 : null,
                          top: 4,
                          child: _Badge(
                            text: 'MỚI',
                            fill: tt.primary,
                            style: badge,
                          ),
                        ),
                      if (widget.showStatus)
                        Positioned(
                          left: 4,
                          right: 4,
                          bottom: 4,
                          child: _Badge(
                            text: story.statusLabel,
                            fill: tt.panel,
                            style: badge,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: titleHeight,
                child: Text(
                  story.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: title,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text, required this.fill, this.style});

  final String text;
  final Color fill;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    // Nền vàng giống nhau ở hai theme nên chữ luôn tối; nền primary thì chữ trắng.
    final ink = fill == tt.gold
        ? TtColors.light.inkWarm
        : fill == tt.primary
        ? Colors.white
        : tt.text;
    return Align(
      alignment: Alignment.topLeft,
      widthFactor: 1,
      heightFactor: 1,
      child: Container(
        constraints: const BoxConstraints(minWidth: 22),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
        decoration: BoxDecoration(
          color: fill.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(TtRadius.xs),
          border: fill == tt.gold
              ? Border.all(color: tt.goldDeep, width: 1.2)
              : null,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: style?.copyWith(color: ink, height: 1.3),
        ),
      ),
    );
  }
}
