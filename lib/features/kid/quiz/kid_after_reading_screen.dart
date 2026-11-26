import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/core/theme/kid_metrics.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/kid_panel.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_reading_dto.dart';
import '../data/kid_reading_repository.dart';
import '../data/kid_rewards_repository.dart';
import './kid_emotion_step.dart';
import './kid_favorite_step.dart';
import './kid_feeling_step.dart';
import './kid_questions_step.dart';
import './kid_quiz_step.dart';
import './kid_scene_grid.dart';
import './kid_summary_step.dart';
import '../time/kid_status_provider.dart';

/// Màn hình wizard "Sau khi đọc xong" dành cho bé — 7 trang (6 khi truyện không có câu đố).
///
/// Trang 0: KidFeelingStep    — "Em thấy truyện này thế nào?"
/// Trang 1: KidEmotionStep    — "Truyện làm em cảm thấy gì?"
/// Trang 2: KidSceneGrid      — "Tranh em thích nhất"
/// Trang 3: KidFavoriteStep   — "Điều gì em thích ở tranh này?"
/// Trang 4: KidSummaryStep    — "Em kể lại cho bố mẹ nghe nhé"
/// Trang 5: KidQuestionsStep  — "Chỗ nào em còn thắc mắc?"
/// Trang 6: KidQuizStep       — "Câu đố về truyện"
class KidAfterReadingScreen extends ConsumerStatefulWidget {
  const KidAfterReadingScreen({
    super.key,
    required this.sessionId,
    required this.result,
    required this.scenes,
  });

  final int sessionId;
  final ReadingCompleted result;
  final List<ReadingScene> scenes;

  @override
  ConsumerState<KidAfterReadingScreen> createState() =>
      _KidAfterReadingScreenState();
}

class _KidAfterReadingScreenState extends ConsumerState<KidAfterReadingScreen> {
  /// Truyện không có câu đố (API trả danh sách câu rỗng) thì bỏ trang câu đố ở cuối.
  bool _hasQuiz = true;

  bool _on(String code) =>
      !ref.read(kidStatusProvider).disabledFeatures.contains(code);

  /// Các trang được hiện (như Web): bố mẹ tắt cảm nhận / giọng nói / câu đố thì bỏ trang đó; trang thắc mắc luôn có.
  List<int> get _pages => [
        if (_on(kKidFeatureReflection)) ...[0, 1, 2, 3],
        if (_on(kKidFeatureVoice)) 4,
        5,
        if (_on(kKidFeatureQuiz) && _hasQuiz) 6,
      ];

  /// Trang đang hiện; trang đang đứng bị ẩn (vừa nhận danh sách tắt) thì về trang hiện đầu tiên.
  int get _current => _pages.contains(_pageIndex) ? _pageIndex : _pages.first;
  int get _pos => _pages.indexOf(_current);

  int _pageIndex = 0;
  int _prevPageIndex = 0; // dùng để tính hướng animation
  bool _userNavigated = false; // true khi bé tự lật trang ít nhất 1 lần

  int _bonusExp = 0;

  // ── Trạng thái reflection ──────────────────────────────────────────────────
  ChildStoryReflection? _reflection;

  // ── Trạng thái trang 2–3 ──────────────────────────────────────────────────
  late final List<KidSceneTile> _tiles;
  KidSceneTile? _favoriteTile;
  bool _pickingFavorite = false;

  // ── Trạng thái trang 5 ────────────────────────────────────────────────────
  final Set<String> _askedKeys = {};

  @override
  void initState() {
    super.initState();
    _tiles = buildKidSceneTiles(widget.scenes);
    _loadReflection();
    _checkQuiz();
    // Kết quả đọc chỉ có mã huy hiệu: lấy tên từ bảng phần thưởng (như web).
    if (widget.result.newBadges.isNotEmpty) {
      ref.read(kidRewardsRepositoryProvider).rewards().then((r) {
        if (mounted) {
          setState(
            () => _badgeNames = {for (final b in r.badges) b.code: b.name},
          );
        }
      }, onError: (_) {}); // không lấy được tên thì hiện mã
    }
  }

  Map<String, String> _badgeNames = const {};

  Future<void> _checkQuiz() async {
    if (!_on(kKidFeatureQuiz)) return;
    try {
      final quiz = await ref
          .read(kidReadingRepositoryProvider)
          .quiz(widget.sessionId.toString());
      if (!mounted || quiz.questions.isNotEmpty) return;
      setState(() {
        _hasQuiz = false;
        if (_pageIndex > 5) _pageIndex = _pages.last;
      });
    } catch (_) {} // không tải được thì giữ trang câu đố, trang đó tự báo lỗi
  }

  Future<void> _loadReflection() async {
    if (!_on(kKidFeatureReflection)) return;
    try {
      final repo = ref.read(kidReadingRepositoryProvider);
      final r = await repo.reflection(widget.sessionId);
      if (!mounted) return;

      // Khởi tạo _favoriteTile nếu đã có favoriteSceneId
      KidSceneTile? favTile;
      if (r.favoriteSceneId != null) {
        for (final t in _tiles) {
          if (t.sceneId == r.favoriteSceneId) {
            favTile = t;
            break;
          }
        }
      }

      setState(() {
        _reflection = r;
        _favoriteTile = favTile;
      });

      // Nhảy tới trang chưa làm (chỉ khi bé chưa tự lật trang)
      if (!_userNavigated) {
        final target = _resumePage(r);
        if (target > 0) {
          _goToPage(target, markUserNav: false);
        }
      }
    } catch (e) {
      if (!mounted) return;
      showTtToast(
        context,
        e is ApiException ? e.message : 'Chưa tải được cảm nhận của em.',
        type: TtToastType.error,
      );
    }
  }

  /// Tính trang bé nên nhảy vào dựa trên phản hồi từ server.
  int _resumePage(ChildStoryReflection r) {
    if (r.noteText != null || r.hasNoteRecording) return 4;
    if (r.favoriteSceneId != null) return 3;
    if (r.emotions.isNotEmpty) return 2;
    return 0;
  }

  void _onExpGained(int delta) {
    if (delta <= 0) return;
    setState(() => _bonusExp += delta);
  }

  void _goToPage(int index, {bool markUserNav = true}) {
    if (!_pages.contains(index)) return;
    if (index == _current) return;
    setState(() {
      _prevPageIndex = _current;
      _pageIndex = index;
      if (markUserNav) _userNavigated = true;
    });
  }

  void _goNext() {
    final pages = _pages;
    if (_pos < pages.length - 1) _goToPage(pages[_pos + 1]);
  }

  void _goPrev() {
    if (_pos > 0) _goToPage(_pages[_pos - 1]);
  }

  Future<void> _pickFavoriteScene(KidSceneTile tile) async {
    if (_pickingFavorite) return;
    setState(() => _pickingFavorite = true);
    try {
      final repo = ref.read(kidReadingRepositoryProvider);
      await repo.reflectionFavoriteScene(widget.sessionId, tile.sceneId);
      if (!mounted) return;
      setState(() {
        _favoriteTile = tile;
        _pickingFavorite = false;
      });
      _goToPage(3);
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _pickingFavorite = false);
      showTtToast(context, e.message, type: TtToastType.error);
    } catch (_) {
      if (!mounted) return;
      setState(() => _pickingFavorite = false);
      showTtToast(
        context,
        'Có lỗi xảy ra. Vui lòng thử lại.',
        type: TtToastType.error,
      );
    }
  }

  // ────────────────────────────────────────────────────────────────────────────
  // Build các trang — mỗi trang phải có thể expand để vừa với IndexedStack
  // ────────────────────────────────────────────────────────────────────────────

  Widget _buildPage(int index) {
    switch (index) {
      // 0 — Cảm nhận tổng thể
      case 0:
        return KidFeelingStep(sessionId: widget.sessionId, onNext: _goNext);

      // 1 — Cảm xúc chi tiết
      case 1:
        return KidEmotionStep(
          sessionId: widget.sessionId,
          initialCodes:
              _reflection?.emotions.map((e) => e.code).toList() ??
              const <String>[],
          onNext: _goNext,
        );

      // 2 — Chọn tranh yêu thích
      case 2:
        return _buildScenePickPage();

      // 3 — Chia sẻ về tranh đã chọn
      case 3:
        return KidFavoriteStep(
          sessionId: widget.sessionId,
          pickedTile: _favoriteTile,
          canRecord: _reflection?.canRecord ?? true,
          reflection: _reflection,
          onBackToPick: () => _goToPage(2),
          onSent: () => _goToPage(4),
        );

      // 4 — Kể lại truyện
      case 4:
        return KidSummaryStep(sessionId: widget.sessionId);

      // 5 — Thắc mắc
      // KidQuestionsStep tự trả về SingleChildScrollView nên cần bọc Expanded.
      case 5:
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: KidQuestionsStep(
                  sessionId: widget.sessionId,
                  tiles: _tiles,
                  askedKeys: _askedKeys,
                  onAsked: (tile) {
                    setState(() => _askedKeys.add(tile.key));
                  },
                ),
              ),
            ),
          ],
        );

      // 6 — Câu đố
      case 6:
        return KidQuizStep(
          sessionId: widget.sessionId,
          onExpGained: _onExpGained,
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildScenePickPage() {
    final tt = context.tt;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Tranh em thích nhất',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Baloo2',
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: tt.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Em bấm vào tranh em thích nhất nhé',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: tt.muted,
                  ),
                ),
                const SizedBox(height: 20),
                if (_tiles.isEmpty)
                  Center(
                    child: Text(
                      'Truyện này chưa có tranh minh hoạ.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: tt.muted,
                      ),
                    ),
                  )
                else
                  AbsorbPointer(
                    absorbing: _pickingFavorite,
                    child: KidSceneGrid(
                      tiles: _tiles,
                      pickedKey: _favoriteTile?.key,
                      onPick: _pickFavoriteScene,
                    ),
                  ),
                if (_pickingFavorite) ...[
                  const SizedBox(height: 20),
                  const Center(child: CircularProgressIndicator()),
                ],
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ────────────────────────────────────────────────────────────────────────────
  // Build UI
  // ────────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final res = widget.result;
    final totalExp = res.expGained + _bonusExp;
    final badges = res.newBadges.map((c) => _badgeNames[c] ?? c).toList();
    final rewards = [
      if (res.isRetake) 'Em đọc lại truyện này',
      if (totalExp > 0) '+$totalExp EXP',
      if (badges.isNotEmpty) 'Huy hiệu mới: ${badges.join(', ')}',
      if (res.roadmapStepCompleted) 'Thêm một bước hành trình',
    ];
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isNarrow = screenWidth < 400;
    // Theo dõi danh sách chức năng bố mẹ tắt để ẩn trang ngay khi /me trả về.
    ref.watch(kidStatusProvider.select((s) => s.disabledFeatures.join(',')));
    final pages = _pages;
    final goingForward = _current >= _prevPageIndex;

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Dòng phần thưởng (như web): EXP, huy hiệu mới, bước hành trình ──
            if (rewards.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child:
                    Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: tt.gold.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: tt.gold, width: 2),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.stars_rounded,
                                color: tt.goldDeep,
                                size: 26,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  rewards.join(' · '),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Baloo2',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: tt.warnInk,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 300.ms)
                        .scale(
                          begin: const Offset(0.96, 0.96),
                          duration: 300.ms,
                          curve: Curves.easeOutBack,
                        ),
              ),

            // ── Nội dung trang — IndexedStack giữ state, animate overlay ──────
            Expanded(
              child: _AnimatedIndexedStack(
                index: _pos,
                goingForward: goingForward,
                children: [for (final p in pages) _buildPage(p)],
              ),
            ),

            // ── Thanh điều hướng dưới ─────────────────────────────────────────
            _buildBottomBar(tt, isNarrow),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(TtColors tt, bool isNarrow) {
    // Dùng kích thước nút nhỏ hơn khi màn hẹp để tránh overflow
    final double navBtnSize = isNarrow ? 40.0 : kKidMinTap;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isNarrow ? 6 : 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: tt.bg,
        border: Border(top: BorderSide(color: tt.line2, width: 1)),
      ),
      child: Row(
        children: [
          // Nút ‹ — tắt ở trang 0
          SizedBox(
            width: navBtnSize,
            height: navBtnSize,
            child: _pos == 0
                ? const SizedBox.shrink()
                : IconButton(
                    icon: Icon(
                      Icons.chevron_left_rounded,
                      size: 32,
                      color: tt.text,
                    ),
                    tooltip: 'Trang trước',
                    padding: EdgeInsets.zero,
                    onPressed: _goPrev,
                  ),
          ),

          // Chấm tiến độ (7, hoặc 6 khi không có câu đố) — nằm trong Expanded, margin thu nhỏ khi hẹp
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (i) {
                final isCurrent = i == _pos;
                final isPast = i < _pos;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.symmetric(horizontal: isNarrow ? 2 : 3),
                  width: isCurrent ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isCurrent
                        ? tt.primary
                        : isPast
                        ? tt.gold
                        : tt.line2,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),

          // Nút › — tắt ở trang 6
          SizedBox(
            width: navBtnSize,
            height: navBtnSize,
            child: _pos == _pages.length - 1
                ? const SizedBox.shrink()
                : IconButton(
                    icon: Icon(
                      Icons.chevron_right_rounded,
                      size: 32,
                      color: tt.text,
                    ),
                    tooltip: 'Bỏ qua',
                    padding: EdgeInsets.zero,
                    onPressed: _goNext,
                  ),
          ),

          // Khoảng cách trước nút thư viện — ẩn khi màn hẹp
          if (!isNarrow) const SizedBox(width: 6),

          // Nút "Về thư viện"
          _buildLibraryButton(tt, isNarrow),
        ],
      ),
    );
  }

  Widget _buildLibraryButton(TtColors tt, bool isNarrow) {
    if (isNarrow) {
      return SizedBox(
        width: kKidMinTap,
        height: kKidMinTap,
        child: IconButton(
          icon: const Icon(
            Icons.local_library_rounded,
            color: Colors.white,
            size: 24,
          ),
          tooltip: 'Về thư viện',
          style: IconButton.styleFrom(
            backgroundColor: tt.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: () {
            if (mounted) context.go('/kid');
          },
        ),
      );
    }

    return KidBtn3D(
      label: 'Về thư viện',
      icon: Icons.local_library_rounded,
      color: tt.primary,
      onPressed: () {
        if (mounted) context.go('/kid');
      },
    );
  }
}

// ── AnimatedIndexedStack ──────────────────────────────────────────────────────

/// IndexedStack giữ state tất cả các trang; trang đang hiện được animate
/// trượt + mờ mỗi khi [index] thay đổi.
class _AnimatedIndexedStack extends StatefulWidget {
  const _AnimatedIndexedStack({
    required this.index,
    required this.goingForward,
    required this.children,
  });

  final int index;
  final bool goingForward;
  final List<Widget> children;

  @override
  State<_AnimatedIndexedStack> createState() => _AnimatedIndexedStackState();
}

class _AnimatedIndexedStackState extends State<_AnimatedIndexedStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<double> _slide;

  int _displayedIndex = 0;
  bool _goingForward = true;

  @override
  void initState() {
    super.initState();
    _displayedIndex = widget.index;
    _goingForward = widget.goingForward;

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.value = 1.0; // bắt đầu đã hiện
  }

  @override
  void didUpdateWidget(covariant _AnimatedIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      _displayedIndex = widget.index;
      _goingForward = widget.goingForward;
      _ctrl.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        final slideBegin = _goingForward ? 0.06 : -0.06;
        final slide = slideBegin * (1.0 - _slide.value);
        return FractionalTranslation(
          translation: Offset(slide, 0),
          child: Opacity(
            opacity: _opacity.value.clamp(0.0, 1.0),
            child: IndexedStack(
              index: _displayedIndex,
              children: widget.children,
            ),
          ),
        );
      },
    );
  }
}
