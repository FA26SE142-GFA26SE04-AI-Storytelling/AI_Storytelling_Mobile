import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/kid_panel.dart';
import '../../../core/widgets/tt_confirm_dialog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_reading_dto.dart';
import '../data/kid_reading_repository.dart';
import '../data/kid_session_controller.dart';
import '../interaction/kid_interaction_screen.dart';
import '../quiz/kid_after_reading_screen.dart';
import 'kid_read_aloud_controller.dart';
import 'kid_read_aloud_practice_page.dart';
import 'kid_reader_audio.dart';
import 'kid_reader_bottom_bar.dart';
import 'kid_reader_controller.dart';
import 'kid_reader_page.dart';
import 'kid_reader_pages.dart';
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

  /// Đoạn đang đọc có mốc thời gian từng chữ thì mới tô sáng.
  bool _highlightActive = true;

  /// Đã báo "chưa có tô sáng chữ" trong lần mở truyện này.
  bool _noHighlightTold = false;

  /// Cờ để chỉ tự động phát lần đầu khi chuyển sang ready một lần duy nhất.
  bool _didAutoPlay = false;

  /// Cờ chống mở chồng hộp thoại tương tác.
  bool _askingInteraction = false;

  /// Đang ở trang "Luyện đọc to" (sau trang cuối, không phải trang của controller).
  bool _onPractice = false;

  late final KidSessionController _kidSession;

  @override
  void initState() {
    super.initState();
    // Tắt thông báo khi bé đang đọc.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _audio = KidReaderAudio();
    _kidSession = ref.read(kidSessionProvider.notifier);
    _playingSub = _audio.playingStream.listen((playing) {
      // Đang nghe đọc cũng tính là bé đang dùng, phiên không hết hạn vì "không chạm".
      _kidSession.narrating = playing;
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
    _kidSession.narrating = false;
    _audio.dispose();
    _pageController?.dispose();
    // Trả về mặc định của app (hiện cả hai thanh), app chưa đặt edgeToEdge ở đâu.
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      _cancelAloud();
      _audio.stop();
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  void _toast(String message, {TtToastType type = TtToastType.info}) {
    showTtToast(
      context,
      message,
      type: type,
      bottomOffset: _kToastBottomOffset,
    );
  }

  KidReaderController get _notifier =>
      ref.read(kidReaderControllerProvider(widget.storyId).notifier);

  /// Huỷ bản ghi đọc to dở dang (không gửi chấm) và bỏ kết quả đang tô.
  void _cancelAloud() => unawaited(
    ref.read(kidReadAloudControllerProvider(widget.storyId).notifier).cancel(),
  );

  ReadingSegment? _aloudTarget(ReadingScene scene) {
    final segs = [...scene.segments]
      ..sort((a, b) => a.segmentOrder.compareTo(b.segmentOrder));
    if (segs.isEmpty) return null;

    final state = ref.read(kidReadAloudControllerProvider(widget.storyId));
    final res = state.result;
    if (res != null) {
      final idx = segs.indexWhere((s) => s.segmentId == res.segmentId);
      if (idx != -1) {
        return segs[(idx + 1) % segs.length];
      }
    }

    if (_activeSegmentId != null) {
      final idx = segs.indexWhere((s) => s.segmentId == _activeSegmentId);
      if (idx != -1) return segs[idx];
    }

    return segs.first;
  }

  /// [skipGuard]: bé vừa chọn "Đọc tiếp"/"Để sau" ở màn tương tác thì cho lật
  /// luôn, không hỏi lại (như `guarded → then` của web).
  void _goTo(int i, {bool skipGuard = false}) {
    final state = ref.read(kidReaderControllerProvider(widget.storyId));
    final totalPages = state.totalPages;
    final practiceText = state.content?.readAloudPractice?.text.trim() ?? '';
    final isPractice = i == totalPages && practiceText.isNotEmpty;
    if (i < 0 || (i >= totalPages && !isPractice)) return;

    final cur = state.currentPage;
    if (!skipGuard && i > cur && cur >= 0 && cur < state.pages.length) {
      // Tương tác chỉ gắn ở trang cuối của cảnh nên chỉ chặn ở trang đó.
      final curScene = state.pages[cur].scene;
      if (_notifier.isInteractionPending(curScene)) {
        final pc = _pageController;
        if (pc != null && pc.hasClients && pc.page?.round() != cur) {
          pc.jumpToPage(cur);
        }
        _askInteraction(cur, nextPage: i);
        return;
      }
    }

    _cancelAloud();
    _audio.stop();
    setState(() {
      _activeSegmentId = null;
      _onPractice = isPractice;
    });

    if (isPractice) {
      final pc = _pageController;
      if (pc != null && pc.hasClients && pc.page?.round() != i) {
        pc.animateToPage(
          i,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
      return;
    }

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

  /// [sceneIndex]: vị trí cảnh cần nghe lại → mở trang đầu của cảnh đó.
  void _replayScene(int sceneIndex) {
    final state = ref.read(kidReaderControllerProvider(widget.storyId));
    if (!state.pages.any((p) => p.sceneIndex == sceneIndex)) return;
    final idx = firstPageOfScene(state.pages, sceneIndex);

    _cancelAloud();
    _audio.stop();
    if (mounted) {
      setState(() {
        _activeSegmentId = null;
        _onPractice = false;
      });
    }

    _notifier.goToPage(idx);

    final pc = _pageController;
    if (pc != null && pc.hasClients && pc.page?.round() != idx) {
      pc.animateToPage(
        idx,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    _playPage(idx);
  }

  Future<void> _askInteraction(int pageIndex, {int? nextPage}) async {
    if (_askingInteraction) return;
    _askingInteraction = true;
    try {
      final state = ref.read(kidReaderControllerProvider(widget.storyId));
      if (pageIndex < 0 || pageIndex >= state.pages.length) return;

      final scene = state.pages[pageIndex].scene;
      if (!_notifier.isInteractionPending(scene) || scene.interaction == null) {
        return;
      }

      _audio.stop();
      if (mounted) {
        setState(() => _activeSegmentId = null);
      }

      final it = scene.interaction!;
      _cancelAloud();
      final r = await Navigator.of(context).push<KidInteractionResult>(
        PageRouteBuilder<KidInteractionResult>(
          opaque: true,
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, _, _) => KidInteractionScreen(
            interaction: it,
            onAttempt: ({optionId, answer, orderedOptionIds}) =>
                _notifier.attemptInteraction(
                  interactionId: it.id,
                  optionId: optionId,
                  answer: answer,
                  orderedOptionIds: orderedOptionIds,
                ),
            onPlayAudio: (url) => unawaited(_audio.playUrls([url])),
          ),
          transitionsBuilder: (_, anim, _, child) => SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .animate(
                  CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
                ),
            child: child,
          ),
        ),
      );

      _askingInteraction = false;
      if (!mounted) return;
      if (r == null) return;

      if (r.replaySceneIndex != null) {
        _replayScene(r.replaySceneIndex!);
      } else if (r.resume) {
        if (nextPage != null) {
          _goTo(nextPage, skipGuard: true);
        } else {
          final curState = ref.read(
            kidReaderControllerProvider(widget.storyId),
          );
          if (curState.readingMode == KidReadingMode.listenFirst &&
              pageIndex < curState.totalPages - 1) {
            _goTo(pageIndex + 1, skipGuard: true);
          }
        }
      }
    } finally {
      _askingInteraction = false;
    }
  }

  void _playPage(int pageIndex) {
    final state = ref.read(kidReaderControllerProvider(widget.storyId));
    if (pageIndex < 0 || pageIndex >= state.pages.length) return;

    // Chỉ phát các đoạn thuộc chữ của tranh này.
    final scene = state.pages[pageIndex].scene;
    final segments = [...scene.segments]
      ..sort((a, b) => a.segmentOrder.compareTo(b.segmentOrder));
    final urls = segments.map((s) => s.audioUrl).toList();

    final hasAudio = segments.any(
      (s) => s.audioUrl != null && s.audioUrl!.trim().isNotEmpty,
    );

    _notifier.markTtsStarted();

    if (!hasAudio) {
      if (_notifier.isInteractionPending(scene)) {
        _askInteraction(pageIndex);
        return;
      }

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
        if (!mounted) return;
        final timed = hasWordTimings(segments[idx].wordTimingsJson);
        setState(() {
          _activeSegmentId = segments[idx].segmentId;
          _highlightActive = timed;
        });
        // Như web: mỗi lần mở truyện chỉ báo một lần.
        if (!timed && !_noHighlightTold) {
          _noHighlightTold = true;
          _toast('Truyện này chưa có tô sáng chữ khi nghe đọc.');
        }
      },
      onCompleted: () {
        if (!mounted) return;
        _notifier.markTtsCompleted();
        _notifier.markPageCompleted();
        setState(() => _activeSegmentId = null);

        final curState = ref.read(kidReaderControllerProvider(widget.storyId));
        final pages = curState.pages;
        if (pageIndex >= 0 && pageIndex < pages.length) {
          final sceneNow = pages[pageIndex].scene;
          if (_notifier.isInteractionPending(sceneNow)) {
            _askInteraction(pageIndex);
            return;
          }
        }

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
    return scene.segments.any(
      (s) => s.audioUrl != null && s.audioUrl!.trim().isNotEmpty,
    );
  }

  void _onToggleAudio(int currentPage, ReadingContent content) {
    _cancelAloud();
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
      _cancelAloud();
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
    _cancelAloud();
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
    _cancelAloud();
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
      // Đọc xong thì tắt giọng đọc trước khi sang màn sau khi đọc.
      if (next.isFinished && !(prev?.isFinished ?? false)) _audio.stop();
      if (next.status == KidReaderStatus.ready) {
        // Jump PageController nếu đã tạo
        final pc = _pageController;
        if (pc != null && pc.hasClients) {
          final page = pc.page?.round();
          // Trang luyện đọc không phải trang của controller: đừng kéo về.
          if (!_onPractice && page != next.currentPage) {
            pc.jumpToPage(next.currentPage);
          }
        }

        // Auto play lần đầu khi listenFirst
        if (!_didAutoPlay && next.readingMode == KidReadingMode.listenFirst) {
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
          _toast(next, type: TtToastType.error);
        }
      },
    );

    // Lắng nghe exitReason → toast + điều hướng
    ref.listen(
      kidReaderControllerProvider(widget.storyId).select((s) => s.exitReason),
      (prev, next) {
        if (next != null && next.isNotEmpty && mounted) {
          _audio.stop();
          _toast(next, type: TtToastType.info);
          context.go('/kid');
        }
      },
    );

    // Lắng nghe lỗi đọc to → toast + clearError
    ref.listen(kidReadAloudControllerProvider(widget.storyId), (prev, next) {
      if (next.errorMessage != null &&
          next.errorMessage!.isNotEmpty &&
          mounted) {
        _toast(next.errorMessage!, type: TtToastType.error);
        ref
            .read(kidReadAloudControllerProvider(widget.storyId).notifier)
            .clearError();
      }
    });

    // Lắng nghe kết quả đọc to → toast chúc mừng
    ref.listen(kidReadAloudControllerProvider(widget.storyId), (prev, next) {
      if (next.result != null && prev?.result != next.result && mounted) {
        final msg = next.result!.message.trim();
        _toast(
          msg.isNotEmpty ? msg : 'Em đọc hay quá!',
          type: TtToastType.success,
        );
        final practiceAudio =
            ref
                .read(kidReaderControllerProvider(widget.storyId))
                .content
                ?.readAloudPractice
                ?.praiseAudioUrl ??
            '';
        if (next.practice &&
            next.result!.goodCount < next.result!.totalCount &&
            practiceAudio.trim().isNotEmpty) {
          _audio.playUrls([practiceAudio]);
        }
      }
    });

    final state = ref.watch(kidReaderControllerProvider(widget.storyId));
    final aloud = ref.watch(kidReadAloudControllerProvider(widget.storyId));
    final tt = context.tt;

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: switch (state.status) {
          KidReaderStatus.loading => Padding(
            padding: const EdgeInsets.all(24),
            child: KidPanel(
              borderColor: tt.primary,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TtSkeleton(height: 200),
                  SizedBox(height: 16),
                  TtSkeleton(height: 20),
                  SizedBox(height: 12),
                  TtSkeleton(height: 20),
                ],
              ),
            ),
          ),
          KidReaderStatus.error => TtErrorState(
            title: 'Chưa mở được truyện',
            message: state.lastErrorMessage?.isNotEmpty == true
                ? state.lastErrorMessage!
                : 'Em thử lại nhé',
            onRetry: _notifier.load,
          ),
          KidReaderStatus.ready => _buildReadyBody(context, state, tt, aloud),
        },
      ),
    );
  }

  Widget _buildReadyBody(
    BuildContext context,
    KidReaderState state,
    TtColors tt,
    KidReadAloudState aloud,
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

    final layout = kidReaderLayoutFor(MediaQuery.sizeOf(context));

    final currentPage = state.currentPage;
    final totalPages = state.totalPages;
    // Mỗi trang là một tranh: cảnh con chỉ gồm đoạn chữ của tranh đó.
    final scenes = [for (final p in state.pages) p.scene];

    final currentScene = (currentPage >= 0 && currentPage < scenes.length)
        ? scenes[currentPage]
        : null;
    final audioAvailable =
        currentScene != null && _isAudioAvailable(currentScene);
    final practice = content.readAloudPractice;
    final hasPractice = practice != null && practice.text.trim().isNotEmpty;
    void togglePractice() => ref
        .read(kidReadAloudControllerProvider(widget.storyId).notifier)
        .toggle(
          practice!.interactionId,
          practice: true,
          onStart: () => _audio.stop(),
        );

    // Nếu đã hoàn thành
    if (state.isFinished && state.completedResult != null) {
      return KidAfterReadingScreen(
        sessionId: content.sessionId,
        result: state.completedResult!,
        scenes: content.scenes,
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
                style: IconButton.styleFrom(minimumSize: const Size(48, 48)),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: tt.gold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _onPractice
                      ? '${totalPages + 1} / ${totalPages + 1}'
                      : '${currentPage + 1} / ${totalPages + (hasPractice ? 1 : 0)}',
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
                  if (newMode == KidReadingMode.listenFirst && !_onPractice) {
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
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: IconButton(
                  key: ValueKey(state.isBookmarked),
                  onPressed: _notifier.toggleBookmark,
                  icon: Icon(
                    state.isBookmarked
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    color: state.isBookmarked ? tt.goldDeep : tt.muted,
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
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: IconButton(
                  key: ValueKey(state.isFavorite),
                  onPressed: _notifier.toggleFavorite,
                  icon: Icon(
                    state.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: state.isFavorite ? tt.danger : tt.muted,
                  ),
                  tooltip: state.isFavorite ? 'Bỏ yêu thích' : 'Thêm yêu thích',
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
            itemCount: totalPages + (hasPractice ? 1 : 0),
            onPageChanged: (i) {
              if (i == totalPages
                  ? !_onPractice
                  : (i != state.currentPage || _onPractice)) {
                _goTo(i);
              }
            },
            itemBuilder: (context, i) {
              if (i == totalPages && hasPractice) {
                final audioUrl = practice.audioUrl ?? '';
                return KidReadAloudPracticePage(
                  practice: practice,
                  result: aloud.practice ? aloud.result : null,
                  recording: aloud.recording && aloud.practice,
                  sending: aloud.sending && aloud.practice,
                  onMic: togglePractice,
                  onRetry: () => ref
                      .read(
                        kidReadAloudControllerProvider(widget.storyId).notifier,
                      )
                      .clear(),
                  onPlaySample: audioUrl.trim().isEmpty
                      ? null
                      : () => _audio.playUrls([audioUrl]),
                );
              }
              if (i < 0 || i >= scenes.length) {
                return const SizedBox.shrink();
              }
              return KidReaderPage(
                scene: scenes[i],
                vocabulary: content.vocabulary,
                activeSegmentId: i == currentPage ? _activeSegmentId : null,
                highlightActive: _highlightActive,
                aloudSegmentId: i == currentPage && aloud.recording
                    ? aloud.segmentId
                    : null,
                aloudResult:
                    i == currentPage &&
                        !aloud.practice &&
                        aloud.result != null &&
                        scenes[i].segments.any(
                          (s) => s.segmentId == aloud.result!.segmentId,
                        )
                    ? aloud.result
                    : null,
                layout: layout,
                isNarrating: i == currentPage && _isAudioPlaying,
                isAloudBusy:
                    i == currentPage && (aloud.recording || aloud.sending),
                onVocabTap: _openVocab,
                onAloudHintTap: (message) =>
                    _toast(message, type: TtToastType.info),
              );
            },
          ),
        ),

        // ── Bottom ──
        if (!state.isFinished) ...[
          // Nút hoàn thành khi ở trang cuối
          if (hasPractice ? _onPractice : currentPage == totalPages - 1) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: KidBtn3D(
                label: 'Em đọc xong rồi',
                icon: Icons.check_circle_rounded,
                color: tt.primary,
                expand: true,
                onPressed: state.isCompleting ? null : _confirmComplete,
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Thanh điều khiển
          KidReaderBottomBar(
            canGoPrev: _onPractice || currentPage > 0,
            canGoNext:
                !_onPractice && (currentPage < totalPages - 1 || hasPractice),
            isAudioPlaying: _isAudioPlaying,
            isAudioAvailable: !_onPractice && audioAvailable,
            isRecording: aloud.recording,
            isSending: aloud.sending,
            onPrev: () => _goTo(_onPractice ? totalPages - 1 : currentPage - 1),
            onNext: () => _goTo(currentPage + 1),
            onToggleAudio: () => _onToggleAudio(currentPage, content),
            onMicTap: () {
              if (_onPractice) {
                togglePractice();
                return;
              }
              final scene = (currentPage >= 0 && currentPage < scenes.length)
                  ? scenes[currentPage]
                  : null;
              final target = scene == null ? null : _aloudTarget(scene);
              if (target == null) {
                _toast('Trang này chưa có chữ để đọc', type: TtToastType.info);
                return;
              }
              ref
                  .read(kidReadAloudControllerProvider(widget.storyId).notifier)
                  .toggle(
                    target.segmentId,
                    onStart: () {
                      _audio.stop();
                      setState(() => _activeSegmentId = null);
                    },
                  );
            },
          ),
        ],
      ],
    );
  }
}

// Khoảng cao thanh đáy màn đọc, để toast không đè lên.
const double _kToastBottomOffset = 96;
