import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../../domain/story_view.dart';
import '../../shared/motion/motion.dart';
import '../../shared/widgets/async_view.dart';
import '../../shared/widgets/feedback.dart';
import '../../shared/widgets/frog.dart';
import '../../shared/widgets/story_cover.dart';
import '../../shared/widgets/tt_button.dart';
import '../shell/tt_page.dart';
import '../workspace/child_switcher.dart';
import '../workspace/workspace_providers.dart';

/// Hàng chờ duyệt: truyện AI đã viết xong, chờ phụ huynh xem trước khi đến tay bé.
/// Màn duyệt chi tiết (sửa, duyệt, lưu trữ) làm ở P3; hiện chạm vào truyện để xem nội dung.
class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    return TtPage(
      title: 'Duyệt nội dung',
      actions: const [ChildSwitcher()],
      body: AsyncView(
        value: ref.watch(storiesProvider),
        onRetry: () => ref.invalidate(storiesProvider),
        loading: ListView(
          padding: const EdgeInsets.all(16),
          children: [for (var i = 0; i < 3; i++) const Padding(padding: EdgeInsets.only(bottom: 8), child: Skeleton(height: 72, radius: 18))],
        ),
        data: (stories) {
          final queue = stories.where(awaitsReview).toList();
          return RefreshIndicator(
            onRefresh: () => ref.refresh(storiesProvider.future),
            child: queue.isEmpty
                ? ListView(
                    children: [
                      SizedBox(
                        height: 420,
                        child: EmptyState(
                          title: 'Đã xử lý hết hàng chờ',
                          message: 'Truyện mới sẽ xuất hiện ở đây khi AI viết xong và chờ bạn duyệt.',
                          mood: FrogMood.happy,
                          actions: [
                            TtButton(
                              label: 'Tạo truyện mới',
                              icon: Icons.auto_awesome_rounded,
                              variant: TtButtonVariant.secondary,
                              onPressed: () => context.push('/studio'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : ListView(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                    children: [
                      Text(
                        'AI đã viết xong ${queue.length} truyện. Bé chỉ thấy truyện sau khi bạn duyệt.',
                        style: text.bodyMedium?.copyWith(color: context.tt.muted),
                      ),
                      const SizedBox(height: 12),
                      ...riseIn(context, [
                        for (final s in queue)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: StoryListTile(story: s, onTap: () => context.push('/review/story/${s.id}')),
                          ),
                      ]),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
