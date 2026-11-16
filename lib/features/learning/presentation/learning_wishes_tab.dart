import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/config/env.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_profile_dto.dart';
import '../../../models/story_wish_dto.dart';
import 'learning_providers.dart';
import 'learning_widgets.dart';

const _groupLabel = {
  'Character': 'Nhân vật',
  'Place': 'Nơi chốn',
  'Challenge': 'Thử thách',
  'Lesson': 'Bài học',
};

/// Mô tả điều ước từ các thẻ bé chọn, vd "Nhân vật: Thỏ con · Nơi chốn: Khu rừng".
String wishLabel(ParentWish w) {
  final parts = [
    for (final c in w.cards) '${_groupLabel[c.group] ?? c.group}: ${c.label}',
    if (w.lessonLeftToParent) 'Bài học: bé để bố mẹ chọn',
  ];
  return parts.isEmpty ? 'Điều ước của bé' : parts.join(' · ');
}

/// Mở web để xử lý điều ước (dùng truyện có sẵn / tạo truyện / từ chối).
Future<void> openWishesOnWeb(BuildContext context) async {
  var opened = false;
  try {
    opened = await launchUrl(
      Uri.parse(Env.webUrl),
      mode: LaunchMode.externalApplication,
    );
  } catch (_) {
    opened = false;
  }
  if (!opened && context.mounted) {
    showTtToast(
      context,
      'Không mở được trình duyệt. Bạn hãy vào taletale.site để xử lý điều ước nhé.',
      type: TtToastType.error,
    );
  }
}

/// Tab "Điều ước": chỉ xem; xử lý điều ước làm trên web.
class LearningWishesTab extends ConsumerWidget {
  const LearningWishesTab({super.key, required this.child});

  final ChildProfileDto child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(learningWishesProvider(child.id));

    Future<void> refresh() async {
      ref.invalidate(learningWishesProvider(child.id));
      try {
        await ref.read(learningWishesProvider(child.id).future);
      } catch (_) {}
    }

    final List<Widget> body;
    if (async.hasError && !async.hasValue) {
      body = [
        learningError(
          async.error,
          () => ref.invalidate(learningWishesProvider(child.id)),
          title: 'Chưa tải được điều ước',
        ),
      ];
    } else if (!async.hasValue) {
      body = learningSkeleton(height: 90);
    } else if (async.value!.isEmpty) {
      body = [
        LearningEmpty(
          title: '${child.nickname} chưa gửi điều ước nào',
          mood: TtFrogMood.happy,
        ),
      ];
    } else {
      body = [
        for (final w in async.value!)
          _WishCard(key: ValueKey('wish-${w.wishId}'), wish: w),
      ];
    }
    return LearningTabList(onRefresh: refresh, children: body);
  }
}

class _WishCard extends StatelessWidget {
  const _WishCard({super.key, required this.wish});

  final ParentWish wish;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final w = wish;
    final pending = w.status == 'Pending';
    final (label, color) = switch (w.status) {
      'Pending' => ('Đang chờ', tt.goldDeep),
      'Accepted' => ('Đang tạo truyện', tt.sky),
      'Fulfilled' => ('Đã có truyện', tt.okInk),
      'Declined' => ('Đã từ chối', tt.danger),
      'Expired' => ('Hết hạn', tt.muted),
      'Cancelled' => ('Đã huỷ', tt.muted),
      _ => (w.status, tt.muted),
    };
    final due = w.expiresAt;
    final soon = due != null &&
        due.difference(DateTime.now()) < const Duration(hours: 24);

    return TtCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.auto_awesome_rounded, color: tt.goldDeep),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(wishLabel(w), style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    LearningChip(
                      label: label,
                      color: color,
                      fill: pending ? tt.gold : null,
                    ),
                    if (w.submittedAt != null)
                      LearningChip(
                        label: learningDate(w.submittedAt),
                        color: tt.muted,
                        icon: Icons.event_rounded,
                      ),
                    if (pending && due != null)
                      LearningChip(
                        label: 'Hạn ${learningDate(due)}',
                        color: soon ? tt.danger : tt.muted,
                        icon: Icons.schedule_rounded,
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (pending) ...[
            const SizedBox(width: 8),
            TtIconButton(
              icon: Icons.open_in_new_rounded,
              tooltip: 'Xử lý trên web',
              size: 40,
              onPressed: () => openWishesOnWeb(context),
            ),
          ],
        ],
      ),
    );
  }
}
