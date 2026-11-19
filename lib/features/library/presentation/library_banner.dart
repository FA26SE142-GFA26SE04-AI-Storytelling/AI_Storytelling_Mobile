import 'dart:async';
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../models/library_story_dto.dart';
import '../data/library_logic.dart';
import 'story_preview_screen.dart';

/// Banner đầu trang: vuốt ngang qua các truyện mới có ảnh bìa, tự chuyển 5 giây
/// (dừng khi đang chạm hoặc máy tắt hiệu ứng); bấm để xem trước.
class LibraryBanner extends StatefulWidget {
  const LibraryBanner({super.key, required this.items});

  final List<LibraryStoryDto> items;

  @override
  State<LibraryBanner> createState() => _LibraryBannerState();
}

class _LibraryBannerState extends State<LibraryBanner> {
  // Hơi lộ mép banner kế bên để người dùng biết vuốt được.
  final _controller = PageController(viewportFraction: 0.92);
  Timer? _timer;
  int _page = 0;
  bool _touching = false;

  @override
  void initState() {
    super.initState();
    if (widget.items.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 5), (_) => _next());
    }
  }

  void _next() {
    if (_touching ||
        !_controller.hasClients ||
        MediaQuery.of(context).disableAnimations) {
      return;
    }
    _controller.animateToPage(
      (_page + 1) % widget.items.length,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final items = widget.items;

    Widget tag(String text) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(TtRadius.full),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
      ),
      child: Text(
        text,
        maxLines: 1,
        style: textTheme.labelLarge?.copyWith(color: Colors.white),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth * 0.92;
        return SizedBox(
          height: width * 9 / 16,
          child: Listener(
            onPointerDown: (_) => _touching = true,
            onPointerUp: (_) => _touching = false,
            onPointerCancel: (_) => _touching = false,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  itemCount: items.length,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (context, i) {
                    final s = items[i];
                    void open() => openStoryPreview(context, s);
                    return Padding(
                      key: ValueKey('banner-${s.id}'),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Semantics(
                        button: true,
                        label: 'Truyện nổi bật: ${s.title}',
                        excludeSemantics: true,
                        onTap: open,
                        child: GestureDetector(
                          onTap: open,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(TtRadius.lg),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Nền: chính ảnh đó phủ kín + làm mờ, để ảnh chính hiện trọn
                                // (không cắt, không méo) mà hai bên không trống.
                                ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                    sigmaX: 18,
                                    sigmaY: 18,
                                  ),
                                  child: TtNetworkImage(
                                    url: splitCover(s.coverImageUrl).src,
                                    radius: BorderRadius.zero,
                                  ),
                                ),
                                // Bỏ đuôi #crop (vùng cắt dọc 3:4 cho thẻ truyện): ảnh có vùng
                                // cắt luôn bị kéo cho đầy khung, sang khung 16:9 thì méo.
                                TtNetworkImage(
                                  url: splitCover(s.coverImageUrl).src,
                                  radius: BorderRadius.zero,
                                  fit: BoxFit.contain,
                                ),
                                // Lớp tối phía dưới để chữ trắng đọc rõ trên mọi ảnh.
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.35, 1],
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.72),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 14,
                                  right: 90,
                                  bottom: 12,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        s.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.titleMedium?.copyWith(
                                          color: Colors.white,
                                          fontSize: 18,
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Wrap(
                                        spacing: 6,
                                        runSpacing: 4,
                                        children: [
                                          if (s.ageBand.isNotEmpty)
                                            tag(ageLabel(s.ageBand)),
                                          tag(s.topic),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (items.length > 1)
                  Positioned(
                    right: constraints.maxWidth * 0.04 + 16,
                    bottom: 16,
                    child: ExcludeSemantics(
                      child: Row(
                        children: [
                          for (var i = 0; i < items.length; i++)
                            AnimatedContainer(
                              key: ValueKey('banner-dot-$i'),
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.only(left: 4),
                              width: i == _page ? 16 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: i == _page
                                    ? tt.gold
                                    : Colors.white.withValues(alpha: 0.7),
                                borderRadius: BorderRadius.circular(
                                  TtRadius.full,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
