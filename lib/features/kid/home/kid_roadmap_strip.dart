import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
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

/// Dải hiển thị lộ trình học / đọc truyện "Hành trình của em" dạng các lá sen cuộn ngang.
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

    if (hasNoItems) {
      return const SizedBox.shrink();
    }

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'Hành trình của em',
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: tt.text,
                ),
              ),
              const Spacer(),
              Text(
                '${roadmap.completedCount}/${roadmap.totalCount}',
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: tt.muted,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 156,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return _RoadmapStepItem(
                item: item,
                onTap: () => _handleTap(context, item),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RoadmapStepItem extends StatelessWidget {
  const _RoadmapStepItem({
    required this.item,
    required this.onTap,
  });

  final _RoadmapItemData item;
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
        borderWidth = 3.0;
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
                  style: TextStyle(
                    fontFamily: 'Baloo2',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: tt.text,
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
