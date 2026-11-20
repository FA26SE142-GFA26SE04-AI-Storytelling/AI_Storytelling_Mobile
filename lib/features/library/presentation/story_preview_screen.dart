import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/library_story_dto.dart';
import '../../kid/reader/kid_reader_audio.dart';
import '../data/library_logic.dart';
import 'library_providers.dart';
import 'story_preview_actions.dart';

/// Mở màn xem trước toàn màn hình (che cả thanh điều hướng dưới).
Future<void> openStoryPreview(BuildContext context, LibraryStoryDto story) =>
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => StoryPreviewScreen(story: story),
      ),
    );

/// Xem trước truyện như bé thấy (không tính lượt đọc): thông tin + từng trang
/// gồm chữ, tranh và giọng đọc đã sẵn sàng.
class StoryPreviewScreen extends ConsumerStatefulWidget {
  const StoryPreviewScreen({super.key, required this.story});

  final LibraryStoryDto story;

  @override
  ConsumerState<StoryPreviewScreen> createState() => _StoryPreviewScreenState();
}

class _StoryPreviewScreenState extends ConsumerState<StoryPreviewScreen> {
  int _page = 0;
  int _shot = 0;
  bool _playing = false;

  // Tạo khi bấm nghe lần đầu, để mở xem trước không cần khởi động trình phát.
  KidReaderAudio? _audio;

  @override
  void dispose() {
    _audio?.dispose();
    super.dispose();
  }

  void _go(int page) {
    _audio?.stop();
    setState(() {
      _page = page;
      _shot = 0;
      _playing = false;
    });
  }

  void _toggleAudio(List<String> urls) {
    if (_playing) {
      _audio?.stop();
      setState(() => _playing = false);
      return;
    }
    try {
      _audio ??= KidReaderAudio();
    } catch (_) {
      showTtToast(
        context,
        'Chưa phát được giọng đọc. Bạn thử lại sau nhé.',
        type: TtToastType.error,
      );
      return;
    }
    setState(() => _playing = true);
    _audio!.playUrls(
      urls,
      onCompleted: () {
        if (mounted) setState(() => _playing = false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final s = widget.story;

    final muted = textTheme.bodyMedium?.copyWith(color: tt.muted);
    final strong = textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700);
    Widget line(String label, String value) => Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '$label: ', style: muted),
            TextSpan(text: value, style: strong),
          ],
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );

    final info = TtCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TtNetworkImage(
                url: s.coverImageUrl,
                width: 104,
                height: 139,
                radius: BorderRadius.circular(TtRadius.md),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    line('Nguồn', sourceLabels[s.sourceKey]!),
                    if (s.ageBand.isNotEmpty)
                      line('Độ tuổi', ageLabel(s.ageBand)),
                    line('Chủ đề', s.topic),
                    if ((s.moralLesson ?? '').trim().isNotEmpty)
                      line('Bài học', s.moralLesson!.trim()),
                    if (s.words > 0) line('Độ dài', '${s.words} tiếng'),
                    line('Người tạo', s.by),
                  ],
                ),
              ),
            ],
          ),
          if ((s.description ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(s.description!.trim(), style: textTheme.bodyMedium),
          ],
        ],
      ),
    );

    final pagesAsync = ref.watch(
      storyPreviewProvider((id: s.id, creator: s.isCreator)),
    );
    final pages = pagesAsync.value;
    final Widget reader;
    if (pagesAsync.hasError && pages == null) {
      final e = pagesAsync.error;
      reader = TtErrorState(
        title: 'Chưa mở được truyện',
        message: e is ApiException
            ? e.message
            : 'Có lỗi khi tải nội dung truyện. Vui lòng thử lại.',
        onRetry: () => ref.invalidate(storyPreviewProvider),
      );
    } else if (pages == null) {
      reader = const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: TtSkeleton(
              radius: BorderRadius.all(Radius.circular(TtRadius.md)),
            ),
          ),
          SizedBox(height: 12),
          TtSkeleton(height: 16),
          SizedBox(height: 8),
          TtSkeleton(height: 16, width: 200),
        ],
      );
    } else if (pages.isEmpty) {
      reader = const TtEmptyState(
        icon: Icons.menu_book_rounded,
        title: 'Truyện chưa có nội dung',
      );
    } else {
      final index = _page.clamp(0, pages.length - 1);
      final p = pages[index];
      final shot = _shot.clamp(0, p.images.isEmpty ? 0 : p.images.length - 1);
      reader = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: TtNetworkImage(
                      url: p.images.isEmpty ? s.coverImageUrl : p.images[shot],
                      radius: BorderRadius.circular(TtRadius.md),
                    ),
                  ),
                  if (p.audio.isNotEmpty)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: TtIconButton(
                        icon: _playing
                            ? Icons.stop_rounded
                            : Icons.volume_up_rounded,
                        tooltip: _playing ? 'Dừng đọc' : 'Nghe giọng đọc',
                        size: 44,
                        onPressed: () => _toggleAudio(p.audio),
                      ),
                    ),
                ],
              ),
              if (p.images.length > 1) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (var i = 0; i < p.images.length; i++)
                      ChoiceChip(
                        label: Text('Tranh ${i + 1}'),
                        selected: i == shot,
                        showCheckmark: false,
                        selectedColor: tt.gold,
                        labelStyle: TextStyle(
                          color: i == shot ? TtColors.light.inkWarm : tt.text,
                        ),
                        onSelected: (_) => setState(() => _shot = i),
                      ),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              Text(
                p.text.isEmpty ? 'Trang này chưa có chữ.' : p.text,
                style: textTheme.bodyLarge?.copyWith(fontSize: 17),
              ),
            ],
          ).animate(key: ValueKey(index)).fadeIn(duration: 240.ms),
          const SizedBox(height: 12),
          Row(
            children: [
              TtIconButton(
                icon: Icons.chevron_left_rounded,
                tooltip: 'Trang trước',
                onPressed: index > 0 ? () => _go(index - 1) : null,
              ),
              Expanded(
                child: Text(
                  'Trang ${index + 1} / ${pages.length}',
                  textAlign: TextAlign.center,
                  style: textTheme.titleSmall,
                ),
              ),
              TtIconButton(
                icon: Icons.chevron_right_rounded,
                tooltip: 'Trang sau',
                onPressed: index < pages.length - 1
                    ? () => _go(index + 1)
                    : null,
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: tt.bg,
      bottomNavigationBar: StoryPreviewActionBar(storyId: s.id),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        s.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(width: 8),
                    TtIconButton(
                      icon: Icons.close_rounded,
                      tooltip: 'Đóng xem trước',
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                info.animate().fadeIn(duration: 260.ms),
                const SizedBox(height: 16),
                TtCard(padding: const EdgeInsets.all(12), child: reader)
                    .animate()
                    .fadeIn(delay: 80.ms, duration: 260.ms)
                    .slideY(begin: 0.04, end: 0, duration: 260.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
