import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../../app/theme/tt_theme.dart';
import '../../data/models/child_models.dart';
import '../../data/models/story_models.dart';
import '../../domain/story_view.dart';
import '../../shared/motion/motion.dart';
import '../../shared/widgets/async_view.dart';
import '../../shared/widgets/feedback.dart';
import '../../shared/widgets/frog.dart';
import '../../shared/widgets/story_cover.dart';
import '../../shared/widgets/tt_button.dart';
import '../auth/auth_controller.dart';
import '../shell/tt_page.dart';
import '../workspace/child_switcher.dart';
import '../workspace/workspace_providers.dart';

/// Trang chủ: truyện để bé đọc, truyện đang làm dở, chỉ số, biểu đồ 7 ngày và việc cần làm.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children = ref.watch(childrenProvider);
    final child = ref.watch(selectedChildProvider).value;
    final stories = ref.watch(storiesProvider);

    return TtPage(
      title: 'Taletale',
      showLogo: true,
      actions: const [ChildSwitcher()],
      body: AsyncView(
        value: children,
        onRetry: () => ref.invalidate(childrenProvider),
        loading: const _HomeSkeleton(),
        data: (kids) => kids.isEmpty || child == null
            ? const EmptyState(
                title: 'Chưa có hồ sơ bé',
                message: 'Tạo hồ sơ bé để bắt đầu tạo truyện. Bạn có thể tạo hồ sơ từ trang quản trị phụ huynh trên web.',
                mood: FrogMood.think,
              )
            : AsyncView(
                value: stories,
                onRetry: () => ref.invalidate(storiesProvider),
                loading: const _HomeSkeleton(),
                data: (list) => RefreshIndicator(
                  onRefresh: () => ref.refresh(storiesProvider.future),
                  child: _HomeBody(child: child, stories: list),
                ),
              ),
      ),
    );
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody({required this.child, required this.stories});

  final ChildProfile child;
  final List<Story> stories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.tt;
    final text = Theme.of(context).textTheme;
    final user = ref.watch(authControllerProvider).value;
    final readable = stories.where(isReadable).toList();
    final queue = stories.where(awaitsReview).toList();
    final unfinished = stories.where((s) => !isReadable(s)).firstOrNull;
    final wide = MediaQuery.sizeOf(context).width >= 600;

    final continueCards = [
      _ContinueCard(
        story: readable.firstOrNull,
        eyebrow: 'Cho ${child.nickname} đọc',
        title: readable.firstOrNull?.title ?? 'Chưa có truyện sẵn sàng',
        subtitle: readable.isEmpty ? 'Hãy tạo truyện đầu tiên trong Studio' : '${readable.length} truyện đã sẵn sàng',
        icon: Icons.menu_book_rounded,
        onTap: readable.isEmpty ? null : () => context.push('/home/story/${readable.first.id}'),
      ),
      _ContinueCard(
        story: unfinished,
        eyebrow: unfinished == null ? 'Bắt đầu mới' : 'Truyện đang làm dở',
        title: unfinished?.title ?? 'Tạo truyện mới',
        subtitle: unfinished == null ? 'Mô tả ý tưởng, AI sẽ viết cùng bạn' : storyStatus(unfinished).$2,
        icon: unfinished != null && awaitsReview(unfinished) ? Icons.fact_check_rounded : Icons.auto_awesome_rounded,
        onTap: () => unfinished == null ? context.push('/studio') : context.push('/home/story/${unfinished.id}'),
      ),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
      children: riseIn(context, [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Chào ${user?.givenName ?? 'bạn'}', style: text.displaySmall),
                  const SizedBox(height: 4),
                  Text(
                    '${child.nickname} (${ageLabel(child.ageBand)}) có ${stories.length} truyện, ${readable.length} truyện đã sẵn sàng để đọc.',
                    style: text.bodyMedium?.copyWith(color: c.muted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Frog(size: 76, mood: FrogMood.happy),
          ],
        ),
        const SizedBox(height: 20),
        if (wide)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: continueCards[0]),
                const SizedBox(width: 12),
                Expanded(child: continueCards[1]),
              ],
            ),
          )
        else ...[
          continueCards[0],
          const SizedBox(height: 10),
          continueCards[1],
        ],
        const SizedBox(height: 16),
        _Stats(
          items: [
            (stories.length, 'truyện của ${child.nickname}', c.text),
            (readable.length, 'đã duyệt, sẵn sàng đọc', c.okInk),
            (queue.length, 'đang chờ bạn duyệt', c.warnInk),
          ],
        ),
        const SizedBox(height: 24),
        Text('Truyện được tạo trong 7 ngày qua', style: text.titleMedium),
        const SizedBox(height: 10),
        _WeekBars(stories: stories),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: Text('Việc cần làm', style: text.titleMedium)),
            if (queue.isNotEmpty) StatusPill(label: '${queue.length} truyện chờ duyệt', tone: PillTone.wait),
          ],
        ),
        const SizedBox(height: 8),
        if (queue.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Không có truyện nào đang chờ duyệt.', style: text.bodyMedium?.copyWith(color: c.muted)),
          )
        else
          for (final s in queue)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: StoryListTile(story: s, onTap: () => context.push('/home/story/${s.id}')),
            ),
        const SizedBox(height: 16),
        _CreateCard(nickname: child.nickname),
      ]),
    );
  }
}

class _ContinueCard extends StatelessWidget {
  const _ContinueCard({required this.story, required this.eyebrow, required this.title, required this.subtitle, required this.icon, required this.onTap});

  final Story? story;
  final String eyebrow;
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    final text = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(
                width: 84,
                height: 72,
                child: story == null
                    ? DecoratedBox(
                        decoration: BoxDecoration(color: c.surface2, borderRadius: BorderRadius.circular(12)),
                        child: Icon(icon, color: c.faint),
                      )
                    : StoryCover(story: story!, radius: 12),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(eyebrow, style: text.labelMedium),
                    const SizedBox(height: 2),
                    Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: text.titleLarge?.copyWith(fontSize: 17, height: 1.2)),
                    const SizedBox(height: 2),
                    Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: text.bodySmall),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: c.primary.withValues(alpha: onTap == null ? 0.06 : 0.14),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: onTap == null ? c.faint : c.primaryStrong),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({required this.items});
  final List<(int, String, Color)> items;

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    final text = Theme.of(context).textTheme;
    return Card(
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (final (i, (value, label, color)) in items.indexed) ...[
              if (i > 0) VerticalDivider(width: 1, color: c.line, indent: 12, endIndent: 12),
              Expanded(
                child: Semantics(
                  label: '$value $label',
                  excludeSemantics: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$value', style: text.headlineMedium?.copyWith(color: color, height: 1.1)),
                        Text(label, style: text.bodySmall, maxLines: 2),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Biểu đồ cột: số truyện được tạo mỗi ngày trong 7 ngày gần nhất, cột hôm nay tô đậm.
class _WeekBars extends StatelessWidget {
  const _WeekBars({required this.stories});
  final List<Story> stories;

  static const _labels = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    final text = Theme.of(context).textTheme;
    final today = DateUtils.dateOnly(DateTime.now());
    final days = [for (var i = 6; i >= 0; i--) today.subtract(Duration(days: i))];
    final counts = [for (final d in days) stories.where((s) => DateUtils.isSameDay(s.createdAt.toLocal(), d)).length];
    final max = counts.fold(1, (a, b) => b > a ? b : a);
    final animate = !reduceMotion(context);

    return Semantics(
      label: 'Biểu đồ truyện được tạo trong 7 ngày: ${[for (var i = 0; i < 7; i++) '${_labels[days[i].weekday - 1]} ${counts[i]}'].join(', ')}',
      excludeSemantics: true,
      child: SizedBox(
        height: 140,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (var i = 0; i < 7; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${counts[i]}', style: text.labelMedium?.copyWith(color: counts[i] > 0 ? c.text : c.faint)),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: animate ? 0 : 1, end: 1),
                            duration: Duration(milliseconds: animate ? 500 + i * 40 : 0),
                            curve: Curves.easeOutCubic,
                            builder: (context, t, _) => FractionallySizedBox(
                              heightFactor: (counts[i] / max * t).clamp(0.03, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: i == 6 ? c.primaryStrong : c.primary.withValues(alpha: 0.35),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _labels[days[i].weekday - 1],
                        style: text.labelMedium?.copyWith(color: i == 6 ? c.text : c.muted, fontWeight: i == 6 ? FontWeight.w800 : null),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CreateCard extends StatelessWidget {
  const _CreateCard({required this.nickname});
  final String nickname;

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    final text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.alphaBlend(c.primary.withValues(alpha: 0.10), c.panel),
        borderRadius: BorderRadius.circular(TtRadius.lg),
        border: Border.all(color: c.primary.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome_rounded, color: c.primaryStrong, size: 20),
              const SizedBox(width: 8),
              Expanded(child: Text('Tạo truyện cho $nickname', style: text.titleMedium)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'AI viết trong khuôn khổ chính sách an toàn của $nickname, và mọi truyện đều qua bước duyệt của bạn.',
            style: text.bodyMedium?.copyWith(color: c.muted),
          ),
          const SizedBox(height: 12),
          TtButton(label: 'Tạo trong Studio', icon: Icons.auto_awesome_rounded, onPressed: () => context.push('/studio')),
        ],
      ),
    );
  }
}

class _HomeSkeleton extends StatelessWidget {
  const _HomeSkeleton();

  @override
  Widget build(BuildContext context) => ListView(
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
    children: const [
      Skeleton(width: 180, height: 32),
      SizedBox(height: 10),
      Skeleton(height: 14),
      SizedBox(height: 24),
      Skeleton(height: 92, radius: 18),
      SizedBox(height: 10),
      Skeleton(height: 92, radius: 18),
      SizedBox(height: 16),
      Skeleton(height: 80, radius: 18),
      SizedBox(height: 24),
      Skeleton(height: 140, radius: 18),
    ],
  );
}
