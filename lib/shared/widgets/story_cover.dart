import 'package:material_ui/material_ui.dart';

import '../../data/models/story_models.dart';
import '../../domain/story_view.dart';
import 'feedback.dart';

/// Ảnh bìa truyện. Chưa có minh hoạ thì vẽ bìa tạm: gradient theo id, mặt trăng và mặt nước (giống `.cover` bên web).
class StoryCover extends StatelessWidget {
  const StoryCover({super.key, required this.story, this.radius = 14, this.hero = false});

  final Story story;
  final double radius;

  /// Gắn Hero để ảnh bìa bay sang màn chi tiết. Chỉ bật ở nơi mỗi truyện xuất hiện một lần trên màn hình.
  final bool hero;

  @override
  Widget build(BuildContext context) {
    final url = story.coverImageUrl;
    final cover = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: url != null && url.isNotEmpty ? Image.network(url, fit: BoxFit.cover, errorBuilder: (_, _, _) => _Placeholder(story.id)) : _Placeholder(story.id),
    );
    return Semantics(
      image: true,
      label: 'Ảnh bìa truyện ${story.title}',
      child: hero ? Hero(tag: 'cover-${story.id}', child: cover) : cover,
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder(this.id);
  final int id;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(begin: const Alignment(-0.2, -1), end: const Alignment(0.2, 1), stops: const [0, 0.6, 1], colors: coverColors(id)),
    ),
    child: const CustomPaint(painter: _MoonAndWater(), child: SizedBox.expand()),
  );
}

class _MoonAndWater extends CustomPainter {
  const _MoonAndWater();

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width * 0.07;
    final moon = Offset(size.width * 0.83, size.height * 0.09 + r);
    const moonColor = Color(0xFFFFE7B8);
    canvas.drawCircle(
      moon,
      r * 1.6,
      Paint()
        ..color = moonColor.withValues(alpha: 0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    canvas.drawCircle(moon, r, Paint()..color = moonColor);
    final water = Rect.fromLTRB(-size.width * 0.2, size.height * 0.82, size.width * 1.2, size.height * 1.22);
    canvas.drawOval(water, Paint()..color = Colors.white.withValues(alpha: 0.26));
  }

  @override
  bool shouldRepaint(_MoonAndWater old) => false;
}

/// Nhãn trạng thái của truyện theo bảng trạng thái của web.
class StoryStatusPill extends StatelessWidget {
  const StoryStatusPill(this.story, {super.key});
  final Story story;

  @override
  Widget build(BuildContext context) {
    final (tone, label) = storyStatus(story);
    return StatusPill(
      label: label,
      tone: switch (tone) {
        StoryTone.ok => PillTone.ok,
        StoryTone.wait => PillTone.wait,
        StoryTone.draft => PillTone.draft,
      },
    );
  }
}

/// Dòng truyện gọn: bìa nhỏ, tên, người tạo · độ tuổi, nhãn trạng thái.
class StoryListTile extends StatelessWidget {
  const StoryListTile({super.key, required this.story, required this.onTap});

  final Story story;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox.square(dimension: 52, child: StoryCover(story: story, radius: 10)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(story.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: text.titleSmall),
                    const SizedBox(height: 2),
                    Text(
                      '${story.fromAi ? 'Do AI tạo' : 'Tự viết'} · ${ageLabel(story.ageBand)} · ${shortDate(story.createdAt)}',
                      style: text.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              StoryStatusPill(story),
            ],
          ),
        ),
      ),
    );
  }
}
