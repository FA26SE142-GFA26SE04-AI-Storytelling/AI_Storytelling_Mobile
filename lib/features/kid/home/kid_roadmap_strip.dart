import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/kid_panel.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/my_roadmap_dto.dart';

enum _RoadmapItemType {
  done,
  current,
  upcoming,
}

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

/// Dải hiển thị lộ trình học / đọc truyện "Hành trình của em" dạng đường nối các chặng cuộn ngang.
class KidRoadmapStrip extends StatelessWidget {
  const KidRoadmapStrip({
    super.key,
    required this.roadmap,
    required this.onRead,
  });

  final MyRoadmapDto roadmap;
  final void Function(int storyId) onRead;

  void _handleTap(BuildContext context, _RoadmapItemData item) {
    switch (item.type) {
      case _RoadmapItemType.done:
        onRead(item.storyId);
      case _RoadmapItemType.current:
        if (item.isLocked) {
          showTtToast(context, 'Truyện này chưa mở, em chờ bố mẹ nhé.');
        } else {
          onRead(item.storyId);
        }
      case _RoadmapItemType.upcoming:
        showTtToast(context, 'Đọc xong truyện trước để mở nhé!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasNoItems = roadmap.done.isEmpty &&
        roadmap.open == null &&
        roadmap.upcoming.isEmpty;

    final tt = context.tt;

    final items = <_RoadmapItemData>[
      for (final doneItem in roadmap.done)
        _RoadmapItemData(
          storyId: doneItem.storyId,
          title: doneItem.title,
          coverImageUrl: doneItem.coverImageUrl,
          type: _RoadmapItemType.done,
          isLocked: false,
        ),
      if (roadmap.open != null)
        _RoadmapItemData(
          storyId: roadmap.open!.storyId,
          title: roadmap.open!.title,
          coverImageUrl: roadmap.open!.coverImageUrl,
          type: _RoadmapItemType.current,
          isLocked: roadmap.open!.isLocked,
        ),
      for (final upcomingItem in roadmap.upcoming)
        _RoadmapItemData(
          storyId: upcomingItem.storyId,
          title: upcomingItem.title,
          coverImageUrl: upcomingItem.coverImageUrl,
          type: _RoadmapItemType.upcoming,
          isLocked: upcomingItem.isLocked,
        ),
    ];

    final isFinished = roadmap.isFinished && roadmap.totalCount > 0;

    return KidPanel(
      borderColor: tt.primary,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          KidPanelHeader(
            title: 'Hành trình của em',
            color: tt.primary,
            icon: Icons.route_rounded,
            textColor: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              height: 156,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                // items + connectors between them + end marker
                itemCount: items.length * 2 + 1,
                itemBuilder: (context, index) {
                  // Even indices: connectors/end; odd indices: step items
                  // Pattern: [connector, item, connector, item, ..., connector, end]
                  if (index == items.length * 2) {
                    // End marker (lotus-style)
                    return _JourneyEndMarker(isFinished: isFinished);
                  }
                  if (index.isEven) {
                    // Connector before item at items[index ~/ 2]
                    final itemIndex = index ~/ 2;
                    final walked = itemIndex > 0 &&
                        items[itemIndex - 1].type == _RoadmapItemType.done;
                    return _JourneyConnector(walked: walked);
                  }
                  // Step item
                  final item = items[index ~/ 2];
                  return _RoadmapStepItem(
                    item: item,
                    index: index ~/ 2,
                    onTap: () => _handleTap(context, item),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 10),
            child: Align(
              alignment: hasNoItems ? Alignment.center : Alignment.centerRight,
              child: Text(
                // Chưa có lộ trình vẫn hiện khung, kèm lời nhắn cho bé.
                hasNoItems
                    ? 'Bố mẹ chưa chọn truyện cho em'
                    : '${roadmap.completedCount}/${roadmap.totalCount}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'Baloo2',
                      fontWeight: FontWeight.w600,
                      color: tt.muted,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoadmapStepItem extends StatelessWidget {
  const _RoadmapStepItem({
    required this.item,
    required this.index,
    required this.onTap,
  });

  final _RoadmapItemData item;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    Color borderColor;
    double borderWidth;

    switch (item.type) {
      case _RoadmapItemType.done:
        borderColor = tt.primary;
        borderWidth = 2.5;
      case _RoadmapItemType.current:
        borderColor = tt.gold;
        borderWidth = 3.5;
      case _RoadmapItemType.upcoming:
        borderColor = tt.line;
        borderWidth = 1.5;
    }

    Widget leafCore = Container(
      width: 84,
      height: 84,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        color: item.type == _RoadmapItemType.current
            ? tt.gold.withValues(alpha: 0.08)
            : null,
      ),
      child: ClipOval(
        child: TtNetworkImage(
          url: item.coverImageUrl,
          width: 84,
          height: 84,
          fit: BoxFit.cover,
          radius: BorderRadius.circular(TtRadius.full),
        ),
      ),
    );

    if (item.isLocked) {
      leafCore = Opacity(
        opacity: 0.45,
        child: leafCore,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(TtRadius.lg),
        child: SizedBox(
          width: 110,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 84,
                height: 96,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 84,
                      child: leafCore,
                    ),
                    if (item.isLocked)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 84,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.35),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.lock_rounded,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    if (item.type == _RoadmapItemType.done)
                      Positioned(
                        top: 14,
                        right: 2,
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
                    if (item.type == _RoadmapItemType.current)
                      Positioned(
                        top: 0,
                        left: (84 - 56) / 2,
                        child: TtFrog(
                          mood: item.isLocked
                              ? TtFrogMood.think
                              : TtFrogMood.happy,
                          faceOnly: true,
                          size: 56,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 110,
                child: Text(
                  item.title ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Baloo2',
                        fontWeight: FontWeight.w600,
                        color: item.type == _RoadmapItemType.current
                            ? tt.goldDeep
                            : tt.text,
                        height: 1.2,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Đường nối ngang giữa các chặng; [walked] = true khi chặng trước đó đã xong.
class _JourneyConnector extends StatelessWidget {
  const _JourneyConnector({required this.walked});

  final bool walked;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return SizedBox(
      width: 24,
      height: 156,
      child: Center(
        child: Container(
          height: 4,
          decoration: BoxDecoration(
            color: walked ? tt.primary : tt.line,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

/// Điểm đích cuối hành trình (hoa / ngôi sao).
class _JourneyEndMarker extends StatelessWidget {
  const _JourneyEndMarker({required this.isFinished});

  final bool isFinished;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return SizedBox(
      width: 64,
      height: 156,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: isFinished ? 56 : 44,
              height: isFinished ? 56 : 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFinished
                    ? tt.gold.withValues(alpha: 0.18)
                    : tt.surface,
                border: Border.all(
                  color: isFinished ? tt.gold : tt.line,
                  width: isFinished ? 3 : 2,
                ),
              ),
              child: Icon(
                isFinished ? Icons.auto_awesome_rounded : Icons.flag_rounded,
                size: isFinished ? 28 : 22,
                color: isFinished ? tt.gold : tt.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
