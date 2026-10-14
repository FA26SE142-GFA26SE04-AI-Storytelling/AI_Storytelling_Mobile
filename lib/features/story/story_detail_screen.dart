import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../../app/theme/tt_theme.dart';
import '../../data/models/story_models.dart';
import '../../domain/story_view.dart';
import '../../shared/motion/motion.dart';
import '../../shared/widgets/async_view.dart';
import '../../shared/widgets/story_cover.dart';
import '../../shared/widgets/tt_button.dart';
import '../workspace/workspace_providers.dart';

/// Chi tiết một truyện: ảnh bìa, thông tin, nội dung từng trang.
class StoryDetailScreen extends ConsumerWidget {
  const StoryDetailScreen({super.key, required this.storyId});
  final int storyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.tt;
    // Lấy bản đã có trong danh sách để hiện ngay (ảnh bìa bay sang), rồi thay bằng bản chi tiết.
    final cached = ref.watch(storiesProvider).value?.where((s) => s.id == storyId).firstOrNull;
    final detail = ref.watch(storyDetailProvider(storyId));
    final story = detail.value ?? cached;

    return DecoratedBox(
      decoration: BoxDecoration(gradient: c.water),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // Tên truyện đã nằm ngay dưới ảnh bìa nên thanh tiêu đề chỉ có nút quay lại.
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: story != null
            ? _Body(story: story)
            : AsyncView(
                value: detail,
                onRetry: () => ref.invalidate(storyDetailProvider(storyId)),
                loading: const Center(child: CircularProgressIndicator()),
                data: (s) => _Body(story: s),
              ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.story});
  final Story story;

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    final text = Theme.of(context).textTheme;
    final pages = readingPages(story);
    final words = wordCount(storyText(story));
    final wide = MediaQuery.sizeOf(context).width >= 840;

    final info = <Widget>[
      Row(
        children: [
          StoryStatusPill(story),
          const SizedBox(width: 8),
          if (story.fromAi) Text('Do AI tạo', style: text.labelMedium),
        ],
      ),
      const SizedBox(height: 8),
      Text(story.title, style: text.headlineMedium),
      // Bỏ tóm tắt nếu nó chỉ là nguyên văn trang đầu (backend thường lấy đoạn đầu làm tóm tắt).
      if ((story.synopsis ?? '').isNotEmpty && story.synopsis!.trim() != pages.firstOrNull?.trim()) ...[
        const SizedBox(height: 6),
        Text(story.synopsis!, style: text.bodyLarge?.copyWith(color: c.muted)),
      ],
      const SizedBox(height: 16),
      Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              _Meta('Độ tuổi', ageLabel(story.ageBand)),
              _Meta('Chủ đề', storyTopic(story)),
              if ((story.moralLesson ?? '').isNotEmpty) _Meta('Bài học', story.moralLesson!),
              if (words > 0) _Meta('Độ dài', '$words từ · ${pages.length} trang'),
              _Meta('Người tạo', story.authorName ?? 'Bạn'),
              _Meta('Ngày tạo', shortDate(story.createdAt, withYear: true)),
            ],
          ),
        ),
      ),
      if (awaitsReview(story)) ...[
        const SizedBox(height: 16),
        _Callout(
          icon: Icons.fact_check_rounded,
          title: 'Truyện đang chờ bạn duyệt',
          message: 'Bé chỉ thấy truyện sau khi bạn duyệt nội dung và hệ thống tạo xong minh hoạ.',
          action: TtButton(label: 'Đến hàng chờ duyệt', icon: Icons.inbox_rounded, variant: TtButtonVariant.secondary, onPressed: () => context.go('/review')),
        ),
      ],
    ];

    final content = <Widget>[
      Text('Nội dung', style: text.titleMedium),
      const SizedBox(height: 8),
      for (final (i, p) in pages.indexed)
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            decoration: BoxDecoration(
              color: c.paper,
              borderRadius: BorderRadius.circular(TtRadius.lg),
              border: Border.all(color: c.line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Trang ${i + 1}', style: text.labelMedium),
                const SizedBox(height: 4),
                Text(p, style: text.bodyLarge?.copyWith(color: c.inkWarm, height: 1.6)),
              ],
            ),
          ),
        ),
      if (pages.isEmpty) Text('Truyện này chưa có nội dung.', style: text.bodyMedium?.copyWith(color: c.muted)),
    ];

    final cover = AspectRatio(
      aspectRatio: 16 / 10,
      child: StoryCover(story: story, radius: TtRadius.xl, hero: true),
    );

    if (wide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 380,
            child: ListView(padding: const EdgeInsets.fromLTRB(24, 8, 12, 32), children: [cover, const SizedBox(height: 16), ...info]),
          ),
          Expanded(
            child: ListView(padding: const EdgeInsets.fromLTRB(12, 8, 24, 32), children: content),
          ),
        ],
      );
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        cover,
        const SizedBox(height: 16),
        ...riseIn(context, [...info, const SizedBox(height: 24), ...content]),
      ],
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(label, style: text.bodyMedium?.copyWith(color: context.tt.muted)),
          ),
          Expanded(child: Text(value, style: text.titleSmall)),
        ],
      ),
    );
  }
}

class _Callout extends StatelessWidget {
  const _Callout({required this.icon, required this.title, required this.message, required this.action});

  final IconData icon;
  final String title;
  final String message;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    final text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: c.gold.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(TtRadius.lg),
        border: Border.all(color: c.gold.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: c.warnInk, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title, style: text.titleMedium?.copyWith(color: c.warnInk)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(message, style: text.bodyMedium),
          const SizedBox(height: 12),
          action,
        ],
      ),
    );
  }
}
