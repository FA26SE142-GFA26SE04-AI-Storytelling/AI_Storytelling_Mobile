import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../data/event_logic.dart';
import '../data/event_repository.dart';
import 'event_widgets.dart';

/// Banner sự kiện đang mở ở Trang chủ (như EventHighlightBanner của web).
/// Chỉ hiện khi có sự kiện Published; đang tải / lỗi thì ẩn. Tự cách dưới 12.
class EventHomeBanner extends ConsumerWidget {
  const EventHomeBanner({super.key, this.side = 16});

  final double side;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final published = (ref.watch(eventListProvider).value ?? const [])
        .where((e) => e.status == 'Published')
        .toList();
    if (published.isEmpty) return const SizedBox.shrink();
    final featured = published.first;
    final tt = context.tt;
    final ink = TtColors.light.inkWarm;
    final textTheme = Theme.of(context).textTheme;
    final radius = BorderRadius.circular(TtRadius.lg);
    void open() => context.go(AppRoutes.eventPath(featured.id));

    return Padding(
      padding: EdgeInsets.fromLTRB(side, 0, side, 12),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: tt.goldDeep, width: 1.2),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [tt.gold, Color.lerp(tt.gold, tt.panel, 0.7)!],
            ),
          ),
          child: InkWell(
            borderRadius: radius,
            onTap: open,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (isNewEvent(featured)) EventTag.isNew(context),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.emoji_events_rounded,
                            size: 18,
                            color: ink,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Sự kiện đang mở',
                            style: textTheme.labelLarge?.copyWith(
                              color: ink,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      if (published.length > 1)
                        EventTag(
                          '+${published.length - 1} sự kiện khác',
                          bg: Colors.white.withValues(alpha: 0.55),
                          fg: ink,
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    featured.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headlineMedium?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: ink,
                    ),
                  ),
                  if (featured.description.isNotEmpty)
                    Text(
                      featured.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium?.copyWith(
                        color: ink.withValues(alpha: 0.8),
                      ),
                    ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TtButton(
                      label: 'Tham gia cùng bé',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: open,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.05, end: 0);
  }
}
