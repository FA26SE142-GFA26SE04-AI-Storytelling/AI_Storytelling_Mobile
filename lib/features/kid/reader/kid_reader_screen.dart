import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_confirm_dialog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_reading_dto.dart';
import '../data/kid_reading_repository.dart';
import 'kid_reader_audio.dart';
import 'kid_reader_bottom_bar.dart';
import 'kid_reader_complete_view.dart';
import 'kid_reader_controller.dart';
import 'kid_reader_page.dart';
import 'kid_vocab_sheet.dart';

/// Màn đọc truyện của bé. Route: /kid/read/:storyId
class KidReaderScreen extends ConsumerStatefulWidget {
  const KidReaderScreen({super.key, required this.storyId});

  final String storyId;

  @override
  ConsumerState<KidReaderScreen> createState() => _KidReaderScreenState();
}

class _KidReaderScreenState extends ConsumerState<KidReaderScreen>
    with WidgetsBindingObserver {
  late final KidReaderAudio _audio;
  PageController? _pageController;
  StreamSubscription<bool>? _playingSub;

  bool _isAudioPlaying = false;
  int? _activeSegmentId;

  /// Cờ để chỉ tự động phát lần đầu khi chuyển sang ready một lần duy nhất.
  bool _didAutoPlay = false;

  @override
  void initState() {
    super.initState();
    _audio = KidReaderAudio();
    _playingSub = _audio.playingStream.listen((playing) {
      if (mounted) setState(() => _isAudioPlaying = playing);
    });
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(kidReaderControllerProvider(widget.storyId).notifier).load();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _playingSub?.cancel();
    _audio.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      _audio.stop();
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  KidReaderController get _notifier =>
      ref.read(kidReaderControllerProvider(widget.storyId).notifier);

  void _goTo(int i) {
    final state = ref.read(kidReaderControllerProvider(widget.storyId));
    final totalPages = state.totalPages;
    if (i < 0 || i >= totalPages) return;

    _audio.stop();
    setState(() => _activeSegmentId = null);

    _notifier.goToPage(i);

    final pc = _pageController;
    if (pc != null && pc.hasClients && pc.page?.round() != i) {
      pc.animateToPage(
        i,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    if (state.readingMode == KidReadingMode.listenFirst) {
      _playPage(i);
    }
  }

  void _playPage(int pageIndex) {
    final state = ref.read(kidReaderControllerProvider(widget.storyId));
    final content = state.content;
    if (content == null) return;
    if (pageIndex < 0 || pageIndex >= content.scenes.length) return;

    final scene = content.scenes[pageIndex];
    final segments = [...scene.segments]
      ..sort((a, b) => a.segmentOrder.compareTo(b.segmentOrder));
    final urls = segments.map((s) => s.audioUrl).toList();

    final hasAudio = segments.any(
      (s) => s.audioUrl != null && s.audioUrl!.trim().isNotEmpty,
    );

    _notifier.markTtsStarted();

    if (!hasAudio) {
      // Không có audio: vẫn auto-lật trong listenFirst
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        final cur = ref
            .read(kidReaderControllerProvider(widget.storyId))
            .currentPage;
        if (cur != pageIndex) return;
        final total = ref
            .read(kidReaderControllerProvider(widget.storyId))
            .totalPages;
        if (pageIndex < total - 1) {
          _goTo(pageIndex + 1);
        }
      });
      return;
    }

    _audio.playUrls(
      urls,
      onIndexChanged: (idx) {
        if (mounted) {
          setState(() => _activeSegmentId = segments[idx].segmentId);
        }
      },
      onCompleted: () {
        if (!mounted) return;
        _notifier.markTtsCompleted();
        _notifier.markPageCompleted();
        setState(() => _activeSegmentId = null);

        final curState =
            ref.read(kidReaderControllerProvider(widget.storyId));
        if (curState.readingMode == KidReadingMode.listenFirst &&
            curState.currentPage == pageIndex &&
            pageIndex < curState.totalPages - 1) {
          Future.delayed(const Duration(milliseconds: 600), () {
            if (!mounted) return;
            final nowPage = ref
                .read(kidReaderControllerProvider(widget.storyId))
                .currentPage;
            if (nowPage == pageIndex) {
              _goTo(pageIndex + 1);
            }
          });
        }
      },
    );
  }

  bool _isAudioAvailable(ReadingScene scene) {
    return scene.segments
        .any((s) => s.audioUrl != null && s.audioUrl!.trim().isNotEmpty);
  }

  void _onToggleAudio(int currentPage, ReadingContent content) {
    if (_isAudioPlaying) {
      _audio.stop();
      setState(() => _activeSegmentId = null);
    } else {
      _playPage(currentPage);
    }
  }

  Future<void> _confirmExit() async {
    final state = ref.read(kidReaderControllerProvider(widget.storyId));
    if (state.isFinished) {
      _audio.stop();
      if (mounted) context.go('/kid');
      return;
    }

    final confirmed = await showConfirmDialog(
      context,
      title: 'Em muốn thoát truyện?',
      message: 'Tiến độ đọc vẫn được lưu lại.',
      confirmLabel: 'Thoát',
      cancelLabel: 'Ở lại',
    );
    if (!confirmed) return;

    await _notifier.saveProgressNow();
    _audio.stop();
    if (mounted) context.go('/kid');
  }

  Future<void> _confirmComplete() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Em đọc xong truyện này rồi chứ?',
      message: '',
      confirmLabel: 'Đúng rồi',
      cancelLabel: 'Chưa',
    );
    if (!confirmed) return;
    _audio.stop();
    await _notifier.complete();
  }

  void _openVocab(ReadingVocabulary v) {
    final state = ref.read(kidReaderControllerProvider(widget.storyId));
    final sessionId = state.sessionId;
    if (sessionId == null) return;

    showKidVocabSheet(
      context,
      term: v.term,
      loadDefinition: () => ref
          .read(kidReadingRepositoryProvider)
          .definition(sessionId.toString(), vocabularyId: v.id),
      onCollect: () async {
        final ok = await _notifier.collectWord(v.id);
        if (!ok) throw Exception('Không thể cất từ');
      },
    );
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // Lắng nghe chuyển sang ready → auto play + jump page
    ref.listen(kidReaderControllerProvider(widget.storyId), (prev, next) {
      if (next.status == KidReaderStatus.ready) {
        // Jump PageController nếu đã tạo
        final pc = _pageController;
        if (pc != null && pc.hasClients) {
          final page = pc.page?.round();
          if (page != next.currentPage) {
            pc.jumpToPage(next.currentPage);
          }
        }

        // Auto play lần đầu khi listenFirst
        if (!_didAutoPlay &&
            next.readingMode == KidReadingMode.listenFirst) {
          _didAutoPlay = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _playPage(next.currentPage);
          });
        }
      }
    });

    // Lắng nghe lỗi → toast
    ref.listen(
      kidReaderControllerProvider(widget.storyId)
          .select((s) => s.lastErrorMessage),
      (prev, next) {
        if (next != null && next.isNotEmpty && mounted) {
          showTtToast(context, next, type: TtToastType.error);
        }
      },
    );

    // Lắng nghe exitReason → toast + điều hướng
    ref.listen(
      kidReaderControllerProvider(widget.storyId).select((s) => s.exitReason),
      (prev, next) {
        if (next != null && next.isNotEmpty && mounted) {
          _audio.stop();
          showTtToast(context, next, type: TtToastType.info);
          context.go('/kid');
        }
      },
    );

    final state = ref.watch(kidReaderControllerProvider(widget.storyId));
    final tt = context.tt;

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: switch (state.status) {
          KidReaderStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
          KidReaderStatus.error => TtErrorState(
              title: 'Chưa mở được truyện',
              message:
                  state.lastErrorMessage?.isNotEmpty == true
                      ? state.lastErrorMessage!
                      : 'Em thử lại nhé',
              onRetry: _notifier.load,
            ),
          KidReaderStatus.ready => _buildReadyBody(context, state, tt),
        },
      ),
    );
  }

  Widget _buildReadyBody(
    BuildContext context,
    KidReaderState state,
    TtColors tt,
  ) {
    final content = state.content;
    if (content == null) {
      return TtErrorState(
        title: 'Chưa mở được truyện',
        message: 'Em thử lại nhé',
        onRetry: _notifier.load,
      );
    }

    // Khởi tạo PageController lazy (chỉ một lần khi ready)
    _pageController ??= PageController(initialPage: state.currentPage);

    final orientation = MediaQuery.orientationOf(context);
    final width = MediaQuery.sizeOf(context).width;
    final isWide =
        orientation == Orientation.landscape || width >= 700;

    final currentPage = state.currentPage;
    final totalPages = state.totalPages;
    final scenes = content.scenes;

    final currentScene =
        (currentPage >= 0 && currentPage < scenes.length)
            ? scenes[currentPage]
            : null;
    final audioAvailable =
        currentScene != null && _isAudioAvailable(currentScene);

    // Nếu đã hoàn thành
    if (state.isFinished && state.completedResult != null) {
      return KidReaderCompleteView(
        result: state.completedResult!,
        onHome: () {
          _audio.stop();
          context.go('/kid');
        },
      );
    }

    return Column(
      children: [
        // ── Header ──
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
          child: Row(
            children: [
              // Nút thoát
              IconButton(
                onPressed: _confirmExit,
                icon: const Icon(Icons.close_rounded),
                tooltip: 'Thoát truyện',
                style: IconButton.styleFrom(
                  minimumSize: const Size(48, 48),
                ),
              ),
              const SizedBox(width: 4),

              // Tiêu đề
              Expanded(
                child: Text(
                  content.title,
                  style: TextStyle(
                    fontFamily: 'Baloo2',
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: tt.text,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),

              // Chỉ số trang
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: tt.gold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${currentPage + 1} / $totalPages',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: tt.goldDeep,
                  ),
                ),
              ),
              const SizedBox(width: 4),

              // Chế độ đọc
              IconButton(
                onPressed: () {
                  final newMode =
                      state.readingMode == KidReadingMode.listenFirst
                          ? KidReadingMode.readFirst
                          : KidReadingMode.listenFirst;
                  _notifier.setReadingMode(newMode);
                  if (newMode == KidReadingMode.listenFirst) {
                    _playPage(currentPage);
                  } else {
                    _audio.stop();
                  }
                },
                icon: Icon(
                  state.readingMode == KidReadingMode.listenFirst
                      ? Icons.headphones_rounded
                      : Icons.menu_book_rounded,
                ),
                tooltip: state.readingMode == KidReadingMode.listenFirst
                    ? 'Nghe truyện'
                    : 'Đọc cùng truyện',
                iconSize: 22,
              ),

              // Dấu trang
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: IconButton(
                  key: ValueKey(state.isBookmarked),
                  onPressed: _notifier.toggleBookmark,
                  icon: Icon(
                    state.isBookmarked
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    color:
                        state.isBookmarked ? tt.goldDeep : tt.muted,
                  ),
                  tooltip: state.isBookmarked
                      ? 'Bỏ dấu trang'
                      : 'Đánh dấu trang',
                  iconSize: 22,
                ),
              ),

              // Yêu thích
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: IconButton(
                  key: ValueKey(state.isFavorite),
                  onPressed: _notifier.toggleFavorite,
                  icon: Icon(
                    state.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: state.isFavorite ? tt.danger : tt.muted,
                  ),
                  tooltip: state.isFavorite
                      ? 'Bỏ yêu thích'
                      : 'Thêm yêu thích',
                  iconSize: 22,
                ),
              ),
            ],
          ),
        ),

        // ── PageView ──
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: totalPages,
            onPageChanged: (i) {
              if (i != state.currentPage) {
                _goTo(i);
              }
            },
            itemBuilder: (context, i) {
              if (i < 0 || i >= scenes.length) {
                return const SizedBox.shrink();
              }
              return KidReaderPage(
                scene: scenes[i],
                vocabulary: content.vocabulary,
                activeSegmentId:
                    i == currentPage ? _activeSegmentId : null,
                isWide: isWide,
                onVocabTap: _openVocab,
              );
            },
          ),
        ),

        // ── Bottom ──
        if (!state.isFinished) ...[
          // Nút hoàn thành khi ở trang cuối
          if (currentPage == totalPages - 1) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: TtButton(
                label: 'Em đọc xong rồi',
                icon: Icons.check_circle_rounded,
                expanded: true,
                isLoading: state.isCompleting,
                onPressed: state.isCompleting ? null : _confirmComplete,
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Thanh điều khiển
          KidReaderBottomBar(
            canGoPrev: currentPage > 0,
            canGoNext: currentPage < totalPages - 1,
            isAudioPlaying: _isAudioPlaying,
            isAudioAvailable: audioAvailable,
            onPrev: () => _goTo(currentPage - 1),
            onNext: () => _goTo(currentPage + 1),
            onToggleAudio: () => _onToggleAudio(currentPage, content),
            onMicTap: () => showTtToast(
              context,
              'Tính năng này sắp có',
              type: TtToastType.info,
            ),
          ),
        ],
      ],
    );
  }
}
