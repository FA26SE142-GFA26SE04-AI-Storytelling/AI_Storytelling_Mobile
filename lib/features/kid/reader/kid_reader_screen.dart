import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../data/kid_session_watcher.dart';
import '../home/kid_home_providers.dart';
import 'interaction/kid_interaction_sheet.dart';
import 'media/authed_media.dart';
import 'read_aloud_words.dart';
import 'reader_controller.dart';
import 'reader_pages.dart';
import 'reader_vocabulary_sheet.dart';

/// Màn hình đọc truyện dành cho bé (route `/kid/read/:storyId`).
class KidReaderScreen extends ConsumerStatefulWidget {
  const KidReaderScreen({
    super.key,
    required this.storyId,
  });

  /// Mã truyện cần đọc.
  final int storyId;

  @override
  ConsumerState<KidReaderScreen> createState() => _KidReaderScreenState();
}

class _KidReaderScreenState extends ConsumerState<KidReaderScreen> {
  PageController? _pageController;
  bool _pageReady = false;
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(readerControllerProvider(widget.storyId).notifier).open();
      }
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    _clearRecognizers();
    super.dispose();
  }

  void _clearRecognizers() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();
  }

  Future<void> _close() async {
    await ref.read(readerControllerProvider(widget.storyId).notifier).leave();
    if (mounted) {
      context.go('/kid');
    }
  }

  /// Chuyển sang trang tiếp theo, mở tương tác trước nếu có.
  Future<void> _goNext() async {
    final n = ref.read(readerControllerProvider(widget.storyId).notifier);
    if (n.needsInteraction()) {
      final q = n.currentInteraction!;
      final before = ref.read(readerControllerProvider(widget.storyId)).index;
      await showKidInteractionDialog(context, storyId: widget.storyId, q: q);
      if (!mounted) return;
      if (ref.read(readerControllerProvider(widget.storyId)).index != before) {
        return;
      }
    }
    n.next();
  }

  /// Hoàn thành truyện, kiểm tra tương tác trước khi ghi nhận xong.
  Future<void> _finish() async {
    final notifier =
        ref.read(readerControllerProvider(widget.storyId).notifier);
    if (notifier.needsInteraction()) {
      final q = notifier.currentInteraction!;
      final before = ref.read(readerControllerProvider(widget.storyId)).index;
      await showKidInteractionDialog(context, storyId: widget.storyId, q: q);
      if (!mounted) return;
      if (ref.read(readerControllerProvider(widget.storyId)).index != before) {
        return;
      }
    }
    final result = await notifier.complete();
    if (result != null && mounted) {
      ref.invalidate(kidHomeDataProvider);
      context.go('/kid/read-done', extra: result);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(kidSessionWatcherProvider);
    _clearRecognizers();

    // Lắng nghe exitMessage: thông báo và quay về trang của bé
    ref.listen<String?>(
      readerControllerProvider(widget.storyId).select((s) => s.exitMessage),
      (previous, next) {
        if (next != null && next.isNotEmpty) {
          showTtToast(context, next, type: TtToastType.info);
          if (context.mounted) {
            context.go('/kid');
          }
        }
      },
    );

    // Lắng nghe error để báo toast lỗi
    ref.listen<String?>(
      readerControllerProvider(widget.storyId).select((s) => s.error),
      (previous, next) {
        if (next != null && next.isNotEmpty) {
          showTtToast(context, next, type: TtToastType.error);
        }
      },
    );

    // Lắng nghe notice để báo toast thông báo
    ref.listen<String?>(
      readerControllerProvider(widget.storyId).select((s) => s.notice),
      (previous, next) {
        if (next != null && next.isNotEmpty) {
          showTtToast(context, next, type: TtToastType.info);
          ref
              .read(readerControllerProvider(widget.storyId).notifier)
              .clearNotice();
        }
      },
    );

    // Đồng bộ PageController khi index của state thay đổi từ nút điều khiển
    ref.listen<int>(
      readerControllerProvider(widget.storyId).select((s) => s.index),
      (previous, next) {
        final controller = _pageController;
        if (controller != null &&
            controller.hasClients &&
            controller.page?.round() != next) {
          controller.animateToPage(
            next,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
    );

    final state = ref.watch(readerControllerProvider(widget.storyId));
    final tt = context.tt;

    if (state.pages.isNotEmpty && (!_pageReady || _pageController == null)) {
      _pageController?.dispose();
      _pageController = PageController(initialPage: state.index);
      _pageReady = true;
    }

    // Trạng thái đang tải truyện
    if (state.loading && state.pages.isEmpty) {
      return Scaffold(
        backgroundColor: tt.bg,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TtFrog(
                mood: TtFrogMood.think,
                size: 120,
              ),
              const SizedBox(height: 16),
              Text(
                'Đang mở cuốn truyện…',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: tt.text,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Trạng thái lỗi khi không tải được trang truyện
    if (state.pages.isEmpty && state.error != null) {
      return Scaffold(
        backgroundColor: tt.bg,
        body: Center(
          child: TtErrorState(
            title: 'Chưa mở được truyện',
            message: state.error!,
            onRetry: () => ref
                .read(readerControllerProvider(widget.storyId).notifier)
                .open(),
          ),
        ),
      );
    }

    // Giao diện đọc truyện chính
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _close();
        }
      },
      child: Scaffold(
        backgroundColor: tt.bg,
        body: SafeArea(
          child: Column(
            children: [
              _buildTopBar(state, tt),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: state.pages.length,
                  onPageChanged: (i) {
                    if (_pageController?.hasClients != true) return;
                    if (i == state.index) return;
                    ref
                        .read(readerControllerProvider(widget.storyId).notifier)
                        .goTo(i);
                  },
                  itemBuilder: (context, i) {
                    final page = state.pages[i];
                    return _buildPageItem(context, page, state, tt);
                  },
                ),
              ),
              if (state.index == state.pages.length - 1)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SizedBox(
                    height: 64,
                    child: TtButton(
                      label: 'Em đọc xong rồi!',
                      icon: Icons.emoji_events_rounded,
                      expanded: true,
                      isLoading: state.completing,
                      onPressed: state.completing ? null : _finish,
                    ),
                  ),
                ),
              if (() {
                final aloudResult = state.aloudResult;
                if (aloudResult == null ||
                    state.pages.isEmpty ||
                    state.index < 0 ||
                    state.index >= state.pages.length) {
                  return false;
                }
                final segments = state.pages[state.index].segments;
                return segments.isNotEmpty &&
                    aloudResult.segmentId == segments.first.segmentId;
              }())
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.sizeOf(context).height * 0.3,
                    ),
                    child: SingleChildScrollView(
                      child: ReadAloudWordsView(
                        result: state.aloudResult!,
                        onRetry: () {
                          ref
                              .read(readerControllerProvider(widget.storyId)
                                  .notifier)
                              .clearReadAloud();
                        },
                      ),
                    ),
                  ),
                ),
              _buildBottomBar(state, tt),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(ReaderState state, TtColors tt) {
    final notifier =
        ref.read(readerControllerProvider(widget.storyId).notifier);
    final countText = state.pages.isNotEmpty
        ? '${state.index + 1} / ${state.pages.length}'
        : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildCircleButton(
            icon: Icons.close_rounded,
            tooltip: 'Về trang của em',
            onPressed: _close,
            tt: tt,
          ),
          Expanded(
            child: Text(
              countText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Baloo2',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: tt.text,
              ),
            ),
          ),
          _buildCircleButton(
            icon: state.isBookmarked
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            tooltip: 'Dấu trang',
            iconColor: state.isBookmarked ? tt.gold : tt.text,
            onPressed: () => notifier.toggleBookmark(),
            tt: tt,
          ),
          const SizedBox(width: 12),
          _buildCircleButton(
            icon: state.isFavorited
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            tooltip: 'Yêu thích',
            iconColor: state.isFavorited ? tt.rose : tt.text,
            onPressed: () => notifier.toggleFavorite(),
            tt: tt,
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
    required TtColors tt,
    Color? iconColor,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: tt.panel,
        shape: CircleBorder(
          side: BorderSide(color: tt.line2, width: 1.5),
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: SizedBox(
            width: 56,
            height: 56,
            child: Icon(
              icon,
              size: 28,
              color: iconColor ?? tt.text,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageItem(
    BuildContext context,
    ReaderPage page,
    ReaderState state,
    TtColors tt,
  ) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscapeWide = mediaQuery.orientation == Orientation.landscape &&
        mediaQuery.size.width >= 840;

    final textWidget = _ReaderTextPane(
      key: ObjectKey(page),
      children: _buildTextSpans(
        page: page,
        state: state,
        context: context,
        tt: tt,
      ),
      tt: tt,
    );

    final hasImage = page.imageUrl != null && page.imageUrl!.trim().isNotEmpty;
    if (!hasImage) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: textWidget),
          ],
        ),
      );
    }

    // Nền + viền cho khung tranh: tranh lớn (~2 MB) tải lâu, không để khung trống trùng màu nền.
    final imageWidget = DecoratedBox(
      decoration: BoxDecoration(
        color: context.tt.surface2,
        borderRadius: BorderRadius.circular(TtRadius.xl),
        border: Border.all(color: context.tt.line2, width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(TtRadius.xl),
        child: AuthedAwareImage(
          url: page.imageUrl,
          fit: BoxFit.cover,
          radius: BorderRadius.circular(TtRadius.xl),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: isLandscapeWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 1, child: imageWidget),
                const SizedBox(width: 16),
                Expanded(flex: 1, child: textWidget),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 5, child: imageWidget),
                const SizedBox(height: 16),
                Expanded(flex: 5, child: textWidget),
              ],
            ),
    );
  }

  List<InlineSpan> _buildTextSpans({
    required ReaderPage page,
    required ReaderState state,
    required BuildContext context,
    required TtColors tt,
  }) {
    final vocabulary = state.content?.vocabulary ?? const [];
    final vocabSpans = splitByVocabulary(page.pageText, vocabulary);

    int? activeStart;
    int? activeEnd;

    if (state.activeSegmentId != null) {
      final activeSeg = page.segments
          .where((s) => s.segmentId == state.activeSegmentId)
          .firstOrNull;
      if (activeSeg != null) {
        if (activeSeg.startOffset != null) {
          final s = activeSeg.startOffset! - page.textStart;
          final e = s + activeSeg.text.length;
          if (s >= 0 && e <= page.pageText.length) {
            activeStart = s;
            activeEnd = e;
          }
        }
        if (activeStart == null) {
          final idx = page.pageText.indexOf(activeSeg.text);
          if (idx != -1) {
            activeStart = idx;
            activeEnd = idx + activeSeg.text.length;
          }
        }
      }
    }

    if (state.playing &&
        (page.segments.length <= 1 ||
            activeStart == null ||
            activeEnd == null)) {
      activeStart = 0;
      activeEnd = page.pageText.length;
    }

    final resultSpans = <InlineSpan>[];
    var cursor = 0;

    for (final vSpan in vocabSpans) {
      final spanStart = cursor;
      final spanEnd = cursor + vSpan.text.length;
      cursor = spanEnd;

      if (activeStart == null ||
          activeEnd == null ||
          spanEnd <= activeStart ||
          spanStart >= activeEnd) {
        resultSpans.add(
          _createSpan(
            text: vSpan.text,
            vocabularyId: vSpan.vocabularyId,
            isActive: false,
            state: state,
            context: context,
            tt: tt,
          ),
        );
      } else {
        final cut1 = max(spanStart, activeStart);
        final cut2 = min(spanEnd, activeEnd);

        if (cut1 > spanStart) {
          final prefixText = vSpan.text.substring(0, cut1 - spanStart);
          resultSpans.add(
            _createSpan(
              text: prefixText,
              vocabularyId: vSpan.vocabularyId,
              isActive: false,
              state: state,
              context: context,
              tt: tt,
            ),
          );
        }

        if (cut2 > cut1) {
          final midText =
              vSpan.text.substring(cut1 - spanStart, cut2 - spanStart);
          resultSpans.add(
            _createSpan(
              text: midText,
              vocabularyId: vSpan.vocabularyId,
              isActive: true,
              state: state,
              context: context,
              tt: tt,
            ),
          );
        }

        if (spanEnd > cut2) {
          final suffixText = vSpan.text.substring(cut2 - spanStart);
          resultSpans.add(
            _createSpan(
              text: suffixText,
              vocabularyId: vSpan.vocabularyId,
              isActive: false,
              state: state,
              context: context,
              tt: tt,
            ),
          );
        }
      }
    }

    return resultSpans;
  }

  InlineSpan _createSpan({
    required String text,
    required int? vocabularyId,
    required bool isActive,
    required ReaderState state,
    required BuildContext context,
    required TtColors tt,
  }) {
    final hasVocab = vocabularyId != null;
    TapGestureRecognizer? recognizer;

    if (hasVocab && state.sessionId != null) {
      recognizer = TapGestureRecognizer()
        ..onTap = () {
          showReaderVocabularySheet(
            context,
            ref,
            sessionId: state.sessionId!,
            vocabularyId: vocabularyId,
            term: text,
          );
        };
      _recognizers.add(recognizer);
    }

    return TextSpan(
      text: text,
      recognizer: recognizer,
      style: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 22,
        height: 1.6,
        color: tt.text,
        backgroundColor:
            isActive ? tt.gold.withValues(alpha: 0.25) : null,
        decoration: hasVocab ? TextDecoration.underline : TextDecoration.none,
        decorationColor: hasVocab ? tt.gold : null,
        decorationThickness: hasVocab ? 2.5 : null,
        fontWeight: hasVocab ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildBottomBar(ReaderState state, TtColors tt) {
    final notifier =
        ref.read(readerControllerProvider(widget.storyId).notifier);
    final canPrev = state.index > 0;
    final canNext = state.index < state.pages.length - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomButton(
            icon: Icons.chevron_left_rounded,
            tooltip: 'Trang trước',
            onPressed: canPrev ? () => notifier.prev() : null,
            tt: tt,
          ),
          _buildBottomButton(
            icon: state.playing ? Icons.stop_rounded : Icons.volume_up_rounded,
            tooltip: 'Nghe đọc',
            onPressed: () => notifier.togglePlay(),
            activeColor: state.playing ? tt.primaryStrong : null,
            tt: tt,
          ),
          if (state.voiceEnabled) _buildMicButton(state, tt),
          _buildBottomButton(
            icon: Icons.chevron_right_rounded,
            tooltip: 'Trang sau',
            onPressed: canNext ? _goNext : null,
            tt: tt,
          ),
        ],
      ),
    );
  }

  /// Nút đọc to qua micro cho bé khi tính năng được phụ huynh bật.
  Widget _buildMicButton(ReaderState state, TtColors tt) {
    final notifier =
        ref.read(readerControllerProvider(widget.storyId).notifier);
    final isBusy = state.aloudState == AloudState.busy;
    final isRecording = state.aloudState == AloudState.recording;

    final Widget micChild;
    if (isBusy) {
      micChild = SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: tt.primary,
        ),
      );
    } else if (isRecording) {
      micChild = Icon(
        Icons.stop_circle_rounded,
        size: 36,
        color: tt.danger,
      ).animate(
        onPlay: (controller) => controller.repeat(count: 2, reverse: true),
      ).fade(
        begin: 0.3,
        end: 1.0,
        duration: const Duration(milliseconds: 300),
      );
    } else {
      micChild = Icon(
        Icons.mic_rounded,
        size: 36,
        color: tt.text,
      );
    }

    return _buildBottomButton(
      customIcon: micChild,
      tooltip: 'Đọc to',
      onPressed: isBusy ? null : () => notifier.toggleReadAloud(),
      tt: tt,
    );
  }

  Widget _buildBottomButton({
    IconData? icon,
    Widget? customIcon,
    required String tooltip,
    required VoidCallback? onPressed,
    required TtColors tt,
    Color? activeColor,
  }) {
    assert(icon != null || customIcon != null);
    final isEnabled = onPressed != null;

    return Tooltip(
      message: tooltip,
      child: SizedBox(
        width: 64,
        height: 64,
        child: Material(
          color: isEnabled ? tt.panel : tt.panel.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TtRadius.lg),
            side: BorderSide(
              color: tt.line2.withValues(alpha: isEnabled ? 1.0 : 0.5),
              width: 2,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(TtRadius.lg),
            onTap: onPressed,
            child: Center(
              child: customIcon ??
                  Icon(
                    icon,
                    size: 36,
                    color: isEnabled
                        ? (activeColor ?? tt.text)
                        : tt.muted.withValues(alpha: 0.4),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ReaderTextPane extends StatefulWidget {
  const _ReaderTextPane({
    super.key,
    this.children,
    this.textSpan,
    required this.tt,
  }) : assert(children != null || textSpan != null);

  final List<InlineSpan>? children;
  final InlineSpan? textSpan;
  final TtColors tt;

  @override
  State<_ReaderTextPane> createState() => _ReaderTextPaneState();
}

class _ReaderTextPaneState extends State<_ReaderTextPane> {
  late final ScrollController _scrollController;
  bool _canScrollMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkScroll());
  }

  @override
  void didUpdateWidget(covariant _ReaderTextPane oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkScroll());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    _checkScroll();
  }

  void _checkScroll() {
    if (!mounted || !_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (!position.hasContentDimensions) return;
    final canScroll = (position.maxScrollExtent - _scrollController.offset) > 4;
    if (canScroll != _canScrollMore) {
      setState(() {
        _canScrollMore = canScroll;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textSpan = widget.textSpan ?? TextSpan(children: widget.children);

    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text.rich(textSpan),
        ),
        if (_canScrollMore)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 48,
            child: IgnorePointer(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      widget.tt.bg.withValues(alpha: 0.0),
                      widget.tt.bg,
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
