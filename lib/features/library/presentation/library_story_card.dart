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

/// Kiểu chữ hai dòng thông tin dưới tên (chủ đề · tuổi, tác giả · số chữ).
TextStyle libraryCardMetaStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodySmall!
        .copyWith(fontSize: 11.5, height: 1.3, color: context.tt.muted);

/// Chiều cao thẻ khi bìa rộng [width]: bìa 3:4 + 2 dòng tên + 2 dòng thông tin.
double libraryCardHeight(BuildContext context, double width) {
  final scale = MediaQuery.textScalerOf(context);
  return width * 4 / 3 +
      4 +
      scale.scale(13) * 1.25 * 2 +
      2 +
      scale.scale(11.5) * 1.3 * 2;
}

/// Thẻ truyện bìa dọc 3:4, tên tối đa 2 dòng, dòng "chủ đề · tuổi" (+ icon câu đố)
/// và dòng "tác giả · N chữ". Góc bìa: [rank] (số hạng vàng), nhãn "MỚI" khi
/// truyện tạo trong 7 ngày, lượt đọc / yêu thích (truyện community) ở góc dưới;
/// [showStatus] hiện trạng thái (chỉ dùng ở kệ "Đang chuẩn bị"). Nhấn thì thẻ thu nhỏ nhẹ.
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
    final meta = libraryCardMetaStyle(context);
    final metaHeight = MediaQuery.textScalerOf(context).scale(11.5) * 1.3;
    final age = ageLabel(story.ageBand);
    final quiz = story.hasQuiz == true;
    final words = story.words > 0 ? '${groupThousands(story.words)} chữ' : null;
    final hasStats = !widget.showStatus &&
        (story.viewCount != null || story.favoriteCount != null);
    void open() => openStoryPreview(context, story);

    // Một dòng thông tin: [first] bên trái, cắt "..." khi chật; [rest] dồn phải,
    // luôn hiện đủ (thẻ quá hẹp / chữ quá to thì [rest] thu nhỏ thay vì tràn).
    Widget metaLine(String first, List<Widget> rest) => SizedBox(
      height: metaHeight,
      child: LayoutBuilder(
        builder: (context, c) => Row(
          children: [
            Expanded(
              child: Text(
                first,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: meta,
              ),
            ),
            if (rest.isNotEmpty) const SizedBox(width: 4),
            if (rest.isNotEmpty)
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: (c.maxWidth - 4).clamp(0, double.infinity),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(mainAxisSize: MainAxisSize.min, children: rest),
                ),
              ),
          ],
        ),
      ),
    );

    return Semantics(
      button: true,
      label: story.title,
      value: [
        story.topic,
        if (age.isNotEmpty) age,
        if (quiz) 'có câu đố sau khi đọc',
        story.cardAuthor,
        ?words,
        if (story.viewCount != null) '${story.viewCount} lượt đọc',
        if (story.favoriteCount != null) '${story.favoriteCount} lượt yêu thích',
      ].join(', '),
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
                      if (hasStats)
                        Positioned(
                          left: 4,
                          right: 4,
                          bottom: 4,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            // Số lượt lớn thì thu nhỏ huy hiệu thay vì tràn khỏi bìa.
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: _Stats(story: story, style: badge),
                            ),
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
              const SizedBox(height: 2),
              metaLine(story.topic, [
                if (age.isNotEmpty) Text(age, maxLines: 1, style: meta),
                if (quiz) ...[
                  const SizedBox(width: 4),
                  Tooltip(
                    message: 'Có câu đố sau khi đọc',
                    child: Container(
                      key: const ValueKey('lib-card-quiz'),
                      width: metaHeight,
                      height: metaHeight,
                      decoration: BoxDecoration(
                        color: tt.gold,
                        shape: BoxShape.circle,
                        border: Border.all(color: tt.goldDeep),
                      ),
                      child: Icon(
                        Icons.checklist_rounded,
                        size: metaHeight * 0.65,
                        // Nền vàng giống nhau ở hai theme nên icon luôn tối.
                        color: TtColors.light.inkWarm,
                      ),
                    ),
                  ),
                ],
              ]),
              metaLine(story.cardAuthor, [
                if (words != null) Text(words, maxLines: 1, style: meta),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

/// Huy hiệu lượt đọc / yêu thích của truyện community ở góc dưới bìa.
class _Stats extends StatelessWidget {
  const _Stats({required this.story, this.style});

  final LibraryStoryDto story;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final text = style?.copyWith(color: tt.text, height: 1.3);
    Widget item(IconData icon, int n) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: tt.goldDeep),
        const SizedBox(width: 2),
        Text(groupThousands(n), maxLines: 1, style: text),
      ],
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: tt.panel.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(TtRadius.xs),
        border: Border.all(color: tt.line2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (story.viewCount != null)
            item(Icons.visibility_outlined, story.viewCount!),
          if (story.viewCount != null && story.favoriteCount != null)
            const SizedBox(width: 6),
          if (story.favoriteCount != null)
            item(Icons.favorite_border_rounded, story.favoriteCount!),
        ],
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
