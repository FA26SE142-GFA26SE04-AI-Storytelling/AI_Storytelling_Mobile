import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../../app/theme/tt_theme.dart';
import '../../data/models/story_models.dart';
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

class _Filter {
  const _Filter(this.id, this.label, this.test);
  final String id;
  final String label;
  final bool Function(Story s) test;
}

/// Thư viện truyện của bé: tìm theo tên, lọc theo nguồn / chủ đề / độ tuổi, lưới ảnh bìa.
class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  final _search = TextEditingController();
  String _filter = 'all';
  String? _age;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<_Filter> _filters(List<Story> stories) => [
    _Filter('all', 'Tất cả', (_) => true),
    _Filter('ai', 'Do AI tạo', (s) => s.fromAi),
    _Filter('manual', 'Tự viết', (s) => !s.fromAi),
    for (final t in {for (final s in stories) storyTopic(s)}) _Filter('t:$t', t, (s) => storyTopic(s) == t),
  ];

  @override
  Widget build(BuildContext context) {
    return TtPage(
      title: 'Thư viện truyện',
      actions: const [ChildSwitcher()],
      body: AsyncView(value: ref.watch(storiesProvider), onRetry: () => ref.invalidate(storiesProvider), loading: const _GridSkeleton(), data: _content),
    );
  }

  Widget _content(List<Story> stories) {
    final c = context.tt;
    final filters = _filters(stories);
    final active = filters.where((f) => f.id == _filter).firstOrNull ?? filters.first;
    final q = _search.text.trim().toLowerCase();
    final ages = {for (final s in stories) s.ageBand}.toList()..sort();
    final list = stories.where((s) => active.test(s) && (_age == null || s.ageBand == _age) && s.title.toLowerCase().contains(q)).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: TextField(
            controller: _search,
            onChanged: (_) => setState(() {}),
            textInputAction: TextInputAction.search,
            style: const TextStyle(fontFamily: TtFonts.ui, fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Tìm theo tên truyện',
              prefixIcon: Icon(Icons.search_rounded, color: c.muted),
              suffixIcon: _search.text.isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'Xoá tìm kiếm',
                      icon: Icon(Icons.close_rounded, color: c.muted),
                      onPressed: () => setState(_search.clear),
                    ),
            ),
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              for (final f in filters)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(label: Text(f.label), selected: f.id == active.id, showCheckmark: false, onSelected: (_) => setState(() => _filter = f.id)),
                ),
              if (ages.length > 1)
                ActionChip(
                  avatar: Icon(Icons.tune_rounded, size: 18, color: _age == null ? c.muted : c.primaryStrong),
                  label: Text(_age == null ? 'Mọi độ tuổi' : ageLabel(_age!)),
                  onPressed: () => _pickAge(ages),
                ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => ref.refresh(storiesProvider.future),
            child: list.isEmpty
                ? ListView(
                    children: [
                      SizedBox(
                        height: 360,
                        child: stories.isEmpty
                            ? EmptyState(
                                title: 'Chưa có truyện nào',
                                message: 'Hãy tạo truyện đầu tiên trong Studio.',
                                actions: [TtButton(label: 'Tạo truyện', icon: Icons.auto_awesome_rounded, onPressed: () => context.push('/studio'))],
                              )
                            : const EmptyState(
                                title: 'Không tìm thấy truyện phù hợp',
                                message: 'Thử bỏ bớt bộ lọc hoặc tìm bằng tên khác.',
                                mood: FrogMood.think,
                              ),
                      ),
                    ],
                  )
                : _Grid(stories: list),
          ),
        ),
      ],
    );
  }

  Future<void> _pickAge(List<String> ages) async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: Text('Độ tuổi', style: Theme.of(ctx).textTheme.headlineSmall),
              ),
              for (final (value, label) in [('', 'Mọi độ tuổi'), for (final a in ages) (a, ageLabel(a))])
                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TtRadius.md)),
                  title: Text(label),
                  trailing: (_age ?? '') == value ? Icon(Icons.check_rounded, color: ctx.tt.primaryStrong) : null,
                  onTap: () => Navigator.pop(ctx, value),
                ),
            ],
          ),
        ),
      ),
    );
    if (picked != null) setState(() => _age = picked.isEmpty ? null : picked);
  }
}

class _Grid extends StatelessWidget {
  const _Grid({required this.stories});
  final List<Story> stories;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      const pad = 16.0, gap = 12.0;
      final cols = box.maxWidth < 360 ? 1 : math.max(2, ((box.maxWidth - pad * 2 + gap) / 220).floor());
      final tile = (box.maxWidth - pad * 2 - gap * (cols - 1)) / cols;
      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(pad, 8, pad, 32),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          mainAxisSpacing: gap,
          crossAxisSpacing: gap,
          // Ảnh bìa 4:3 cộng phần chữ bên dưới (chữ to theo cài đặt máy).
          mainAxisExtent: tile * 0.75 + 30 + 58 * MediaQuery.textScalerOf(context).scale(1),
        ),
        itemCount: stories.length,
        itemBuilder: (context, i) => StoryCard(story: stories[i], onTap: () => context.push('/library/story/${stories[i].id}')),
      );
    },
  );
}

/// Thẻ truyện trong lưới thư viện: bìa 4:3, tên, độ tuổi và trạng thái.
class StoryCard extends StatelessWidget {
  const StoryCard({super.key, required this.story, required this.onTap});

  final Story story;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: StoryCover(story: story, radius: 0, hero: true),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(story.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: text.titleLarge?.copyWith(fontSize: 15, height: 1.2)),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(ageLabel(story.ageBand), style: text.bodySmall, overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(width: 4),
                        StoryStatusPill(story),
                      ],
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

class _GridSkeleton extends StatelessWidget {
  const _GridSkeleton();

  @override
  Widget build(BuildContext context) => GridView.count(
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(16),
    crossAxisCount: 2,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    childAspectRatio: 0.78,
    children: riseIn(context, List.generate(6, (_) => const Skeleton(radius: 18))),
  );
}
