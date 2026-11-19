import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../models/parent_reading_feedback_dto.dart';
import 'learning_providers.dart';

/// Câu lỗi dễ hiểu từ ApiException; lỗi khác dùng câu chung.
String learningErrorText(Object? error) =>
    error is ApiException ? error.message : ApiException.defaultFallbackMessage;

/// Ngày dạng dd/MM/yyyy theo giờ máy.
String learningDate(DateTime? d) {
  if (d == null) return '—';
  final l = d.toLocal();
  String two(int v) => v.toString().padLeft(2, '0');
  return '${two(l.day)}/${two(l.month)}/${l.year}';
}

const feelingFace = {
  'VeryLike': '😍',
  'Like': '🙂',
  'Neutral': '😐',
  'Dislike': '🙁',
};

/// Chip nhỏ có màu; [fill] tô đậm (chip vàng).
class LearningChip extends StatelessWidget {
  const LearningChip({
    super.key,
    required this.label,
    required this.color,
    this.fill,
    this.icon,
  });

  final String label;
  final Color color;
  final Color? fill;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final base = fill ?? color;
    final ink = fill != null ? context.tt.text : color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: base.withValues(alpha: fill != null ? 0.35 : 0.14),
        borderRadius: BorderRadius.circular(TtRadius.sm),
        border: Border.all(color: base.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: ink),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Chip cảm xúc và điểm câu đố của một truyện đã đọc xong (như web).
List<Widget> feedbackChips(
  BuildContext context,
  ParentReadingFeedbackItemDto i,
) {
  final tt = context.tt;
  final quiz = i.quizBestPercent?.round();
  return [
    if (i.feeling != null)
      LearningChip(
        label: '${feelingFace[i.feeling] ?? ''} ${i.feelingLabel ?? i.feeling}'
            .trim(),
        color: tt.rose,
      ),
    if (i.quizTotalQuestions > 0)
      quiz == null
          ? LearningChip(label: 'Chưa làm câu đố', color: tt.muted)
          : quiz >= 80
          ? LearningChip(
              label: '⭐ Câu đố $quiz%',
              color: tt.goldDeep,
              fill: tt.gold,
            )
          : LearningChip(
              label: 'Câu đố $quiz%',
              color: quiz >= 50 ? tt.okInk : tt.danger,
            ),
    LearningChip(
      label: learningDate(i.completedAt),
      color: tt.muted,
      icon: Icons.event_rounded,
    ),
  ];
}

/// Thẻ một nhóm nội dung: tiêu đề nổi bật, có thể kèm số đếm và nút bên phải.
class LearningSection extends StatelessWidget {
  const LearningSection({
    super.key,
    required this.title,
    required this.child,
    this.count,
    this.trailing,
  });

  final String title;
  final Widget child;
  final int? count;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return TtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: tt.gold,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              // Tiêu đề + số đếm chiếm hết phần còn lại để nút luôn sát mép phải.
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    if (count != null) ...[
                      const SizedBox(width: 8),
                      LearningChip(
                        label: '$count',
                        color: tt.goldDeep,
                        fill: tt.gold,
                      ),
                    ],
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// Trạng thái rỗng có ếch, dùng chung cho các tab.
class LearningEmpty extends StatelessWidget {
  const LearningEmpty({
    super.key,
    required this.title,
    this.mood = TtFrogMood.think,
    this.frogSize = 96,
  });

  final String title;
  final TtFrogMood mood;
  final double frogSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TtFrog(mood: mood, size: frogSize),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

/// Khung cuộn của một tab: kéo xuống để tải lại, các phần tử hiện dần.
class LearningTabList extends ConsumerWidget {
  const LearningTabList({
    super.key,
    required this.onRefresh,
    required this.children,
  });

  final Future<void> Function() onRefresh;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () {
        // Kéo tải lại thì lấy lại cả ảnh bìa (link ký sẵn có hạn).
        ref.invalidate(storyCoverProvider);
        return onRefresh();
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        itemCount: children.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (_, i) => children[i]
            .animate(delay: (40 * (i < 6 ? i : 6)).ms)
            .fadeIn(duration: 280.ms)
            .slideY(begin: 0.05, end: 0, duration: 280.ms),
      ),
    );
  }
}

/// Khung xương khi tab đang tải.
List<Widget> learningSkeleton({int count = 3, double height = 110}) => [
  for (var i = 0; i < count; i++)
    TtSkeleton(
      height: height,
      radius: const BorderRadius.all(Radius.circular(TtRadius.lg)),
    ),
];

/// Trạng thái lỗi + thử lại cho cả tab.
Widget learningError(
  Object? error,
  VoidCallback onRetry, {
  String title = 'Chưa tải được dữ liệu',
}) => TtErrorState(
  title: title,
  message: learningErrorText(error),
  onRetry: onRetry,
);

/// Lỗi gọn trong một thẻ (Tổng quan) kèm nút thử lại.
class LearningInlineError extends StatelessWidget {
  const LearningInlineError({
    super.key,
    required this.error,
    required this.onRetry,
  });

  final Object? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Row(
      children: [
        Icon(Icons.error_outline_rounded, size: 20, color: tt.danger),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            learningErrorText(error),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: tt.danger),
          ),
        ),
        const SizedBox(width: 8),
        TtIconButton(
          icon: Icons.refresh_rounded,
          tooltip: 'Thử lại',
          size: 40,
          onPressed: onRetry,
        ),
      ],
    );
  }
}

/// Bìa truyện lấy từ GET /Story/{id}; chưa có thì hiện bìa mặc định.
class StoryCover extends ConsumerWidget {
  const StoryCover({
    super.key,
    required this.storyId,
    this.width = 48,
    this.height = 64,
  });

  final int storyId;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = ref.watch(storyCoverProvider(storyId)).value;
    return TtNetworkImage(
      url: url,
      width: width,
      height: height,
      radius: const BorderRadius.all(Radius.circular(TtRadius.sm)),
    );
  }
}

/// Phần tử cuối danh sách: tự tải trang kế khi cuộn tới, lỗi thì hiện nút thử lại.
class LoadMoreTile extends StatefulWidget {
  const LoadMoreTile({super.key, required this.onLoadMore});

  final Future<void> Function() onLoadMore;

  @override
  State<LoadMoreTile> createState() => _LoadMoreTileState();
}

class _LoadMoreTileState extends State<LoadMoreTile> {
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    if (!mounted) return;
    setState(() => _failed = false);
    try {
      await widget.onLoadMore();
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _failed
          ? IconButton(
              tooltip: 'Tải thêm',
              onPressed: _load,
              icon: Icon(Icons.refresh_rounded, color: context.tt.danger),
            )
          : const SizedBox.square(
              dimension: 28,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
    );
  }
}
