import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/kid_panel.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/my_roadmap_dto.dart';
import 'kid_lobby.dart' show kKidLockedStoryMessage;

enum _RoadmapItemType { done, current, upcoming }

class _RoadmapItemData {
  const _RoadmapItemData({
    required this.storyId,
    required this.title,
    required this.coverImageUrl,
    required this.type,
    required this.isLocked,
  });

  final int storyId;
  final String? title;
  final String? coverImageUrl;
  final _RoadmapItemType type;
  final bool isLocked;
}

/// Bề rộng cột trái (ảnh bìa + đường nối) của mỗi chặng.
const double _rail = 84;

/// Ảnh bìa tròn của một chặng.
const double _cover = 68;

/// Cao một chặng: ảnh bìa + hai đoạn đường nối trên/dưới.
const double _rowHeight = 104;

/// "Hành trình của em" dạng đường dọc từ trên xuống: chặng đã đọc → truyện đang mở
/// (viền vàng + ếch) → truyện sắp tới (khoá, mờ) → đích. Mở màn thì tự cuộn tới chặng đang đọc.
class KidRoadmapStrip extends StatefulWidget {
  const KidRoadmapStrip({
    super.key,
    required this.roadmap,
    required this.onRead,
  });

  final MyRoadmapDto roadmap;
  final void Function(int storyId) onRead;

  @override
  State<KidRoadmapStrip> createState() => _KidRoadmapStripState();
}

class _KidRoadmapStripState extends State<KidRoadmapStrip> {
  final GlobalKey _currentKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _currentKey.currentContext;
      if (ctx == null || !ctx.mounted) return;
      Scrollable.ensureVisible(
        ctx,
        alignment: 0.3,
        duration: MediaQuery.disableAnimationsOf(ctx)
            ? Duration.zero
            : const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    });
  }

  void _handleTap(_RoadmapItemData item) {
    switch (item.type) {
      case _RoadmapItemType.done:
        widget.onRead(item.storyId);
      case _RoadmapItemType.current:
        if (item.isLocked) {
          showTtToast(context, kKidLockedStoryMessage);
        } else {
          widget.onRead(item.storyId);
        }
      case _RoadmapItemType.upcoming:
        showTtToast(context, 'Đọc xong truyện trước để mở nhé!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final roadmap = widget.roadmap;
    final tt = context.tt;
    final reduce = MediaQuery.disableAnimationsOf(context);
    final open = roadmap.open;

    final items = <_RoadmapItemData>[
      for (final d in roadmap.done)
        _RoadmapItemData(
          storyId: d.storyId,
          title: d.title,
          coverImageUrl: d.coverImageUrl,
          type: _RoadmapItemType.done,
          isLocked: false,
        ),
      if (open != null)
        _RoadmapItemData(
          storyId: open.storyId,
          title: open.title,
          coverImageUrl: open.coverImageUrl,
          type: _RoadmapItemType.current,
          isLocked: open.isLocked,
        ),
      // Truyện sắp tới luôn khoá cho bé: phải đọc xong truyện trước.
      for (final u in roadmap.upcoming)
        _RoadmapItemData(
          storyId: u.storyId,
          title: u.title,
          coverImageUrl: u.coverImageUrl,
          type: _RoadmapItemType.upcoming,
          isLocked: true,
        ),
    ];
    final hasNoItems = items.isEmpty;
    final isFinished = roadmap.isFinished && roadmap.totalCount > 0;
    bool walked(int i) => i >= 0 && items[i].type == _RoadmapItemType.done;

    // Các chặng hiện dần lần lượt từ trên xuống.
    Widget reveal(Widget child, int order) => reduce
        ? child
        : child
              .animate(delay: (70 * order).ms)
              .fadeIn(duration: 300.ms)
              .moveY(
                begin: 12,
                end: 0,
                duration: 350.ms,
                curve: Curves.easeOut,
              );

    return KidPanel(
      borderColor: tt.primary,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          KidPanelHeader(
            title: 'Hành trình của em',
            color: tt.primary,
            icon: Icons.route_rounded,
            textColor: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < items.length; i++)
                  reveal(
                    _RoadmapStep(
                      key: items[i].type == _RoadmapItemType.current
                          ? _currentKey
                          : null,
                      item: items[i],
                      topWalked: walked(i - 1),
                      bottomWalked: walked(i),
                      isFirst: i == 0,
                      onTap: () => _handleTap(items[i]),
                    ),
                    i,
                  ),
                reveal(
                  _JourneyEndMarker(
                    isFinished: isFinished,
                    hasLine: !hasNoItems,
                    walked: walked(items.length - 1),
                  ),
                  items.length,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              // Chưa có lộ trình vẫn hiện khung, kèm lời nhắn cho bé.
              hasNoItems
                  ? 'Bố mẹ chưa chọn truyện cho em'
                  : '${roadmap.completedCount}/${roadmap.totalCount}',
              textAlign: hasNoItems ? TextAlign.center : TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: 'Baloo2',
                fontWeight: FontWeight.w600,
                color: tt.muted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Đoạn đường nối dọc; [walked] = đã đi qua (màu primary).
class _Line extends StatelessWidget {
  const _Line({required this.walked});

  final bool walked;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Container(
      width: 5,
      decoration: BoxDecoration(
        color: walked ? tt.primary : tt.line,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

/// Một chặng: cột trái là ảnh bìa tròn trên đường nối, bên phải là tên truyện.
class _RoadmapStep extends StatelessWidget {
  const _RoadmapStep({
    super.key,
    required this.item,
    required this.topWalked,
    required this.bottomWalked,
    required this.isFirst,
    required this.onTap,
  });

  final _RoadmapItemData item;
  final bool topWalked;
  final bool bottomWalked;
  final bool isFirst;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final isCurrent = item.type == _RoadmapItemType.current;
    final isDone = item.type == _RoadmapItemType.done;
    final dim = item.isLocked;

    final (borderColor, borderWidth) = switch (item.type) {
      _RoadmapItemType.done => (tt.primary, 3.0),
      _RoadmapItemType.current => (tt.gold, 4.0),
      _RoadmapItemType.upcoming => (tt.line2, 2.0),
    };

    Widget cover = Container(
      width: _cover,
      height: _cover,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: tt.surface,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: ClipOval(
        child: TtNetworkImage(
          url: item.coverImageUrl,
          width: _cover,
          height: _cover,
          fit: BoxFit.cover,
          radius: BorderRadius.circular(TtRadius.full),
        ),
      ),
    );
    if (dim) cover = Opacity(opacity: 0.45, child: cover);

    final rail = SizedBox(
      width: _rail,
      height: _rowHeight,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                child: isFirst
                    ? const SizedBox.shrink()
                    : _Line(walked: topWalked),
              ),
              Expanded(child: _Line(walked: bottomWalked)),
            ],
          ),
          cover,
          if (dim)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.35),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_rounded,
                size: 22,
                color: Colors.white,
              ),
            ),
          if (isDone)
            Positioned(
              top: (_rowHeight - _cover) / 2 - 2,
              right: (_rail - _cover) / 2 - 4,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: tt.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );

    final title = Text(
      item.title ?? '',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontFamily: 'Baloo2',
        fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
        color: isCurrent
            ? tt.goldDeep
            : (item.type == _RoadmapItemType.upcoming ? tt.muted : tt.text),
        height: 1.2,
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(TtRadius.lg),
        child: Row(
          children: [
            rail,
            const SizedBox(width: 8),
            Expanded(
              child: isCurrent
                  // Truyện đang mở nổi bật trong khung viền vàng.
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: tt.gold.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(TtRadius.lg),
                        border: Border.all(color: tt.gold, width: 3),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: title),
                          const SizedBox(width: 8),
                          Icon(
                            item.isLocked
                                ? Icons.lock_rounded
                                : Icons.play_circle_fill_rounded,
                            color: tt.goldDeep,
                            size: 32,
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: title,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Đích cuối hành trình: cờ (chưa xong) hoặc ngôi sao vàng (đã đọc hết).
class _JourneyEndMarker extends StatelessWidget {
  const _JourneyEndMarker({
    required this.isFinished,
    required this.hasLine,
    required this.walked,
  });

  final bool isFinished;
  final bool hasLine;
  final bool walked;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final d = isFinished ? 60.0 : 52.0;
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: _rail,
        child: Column(
          children: [
            if (hasLine) SizedBox(height: 20, child: _Line(walked: walked)),
            Container(
              width: d,
              height: d,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFinished
                    ? tt.gold.withValues(alpha: 0.25)
                    : tt.surface,
                border: Border.all(
                  color: isFinished ? tt.goldDeep : tt.gold,
                  width: 3,
                ),
              ),
              child: Icon(
                isFinished ? Icons.star_rounded : Icons.flag_rounded,
                size: d * 0.55,
                color: tt.goldDeep,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
