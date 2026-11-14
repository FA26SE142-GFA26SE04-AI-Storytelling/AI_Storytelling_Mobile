import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_knowledge_tree.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_rewards_dto.dart';
import '../data/kid_rewards_repository.dart';

/// Màn hình Phần thưởng của bé (Cây tri thức và EXP).
class KidRewardsScreen extends ConsumerStatefulWidget {
  const KidRewardsScreen({super.key});

  @override
  ConsumerState<KidRewardsScreen> createState() => _KidRewardsScreenState();
}

class _KidRewardsScreenState extends ConsumerState<KidRewardsScreen> {
  ChildRewards? _rewards;
  bool _isLoading = true;
  bool _isWatering = false;
  String? _errorMessage;

  int? _lastExpPoured;
  int _floatingExpKey = 0;
  int _treePopKey = 0;

  @override
  void initState() {
    super.initState();
    _loadRewards();
  }

  Future<void> _loadRewards({bool silent = false}) async {
    if (!silent) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    try {
      final data = await ref.read(kidRewardsRepositoryProvider).rewards();
      if (!mounted) return;
      setState(() {
        _rewards = data;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;
      final message = e is ApiException
          ? e.message
          : 'Không thể tải thông tin phần thưởng. Vui lòng thử lại sau.';
      setState(() {
        if (!silent || _rewards == null) {
          _errorMessage = message;
        }
        _isLoading = false;
      });
      if (silent && _rewards != null) {
        showTtToast(context, message, type: TtToastType.error);
      }
    }
  }

  Future<void> _waterTree() async {
    final exp = _rewards?.knowledgeTree.expToWater ?? 0;
    if (_isWatering || exp <= 0) return;

    final oldStageIndex = _rewards != null
        ? kTreeStageCodes.indexOf(_rewards!.knowledgeTree.stage).clamp(0, 4)
        : 0;

    setState(() {
      _isWatering = true;
    });

    try {
      final result = await ref.read(kidRewardsRepositoryProvider).waterTree();
      if (!mounted) return;

      final newStageIndex = kTreeStageCodes
          .indexOf(result.tree.stage)
          .clamp(0, 4);
      final bool stageIncreased = newStageIndex > oldStageIndex;

      setState(() {
        if (_rewards != null) {
          _rewards = _rewards!.copyWith(knowledgeTree: result.tree);
        }
        _lastExpPoured = result.expPoured;
        _floatingExpKey++;
        if (stageIncreased) {
          _treePopKey++;
        }
      });

      if (result.newTreePlanted) {
        showTtToast(
          context,
          'Cây đã ra hoa! Em vừa trồng một hạt giống mới.',
          type: TtToastType.success,
        );
      }

      await _loadRewards(silent: true);
    } catch (e) {
      if (!mounted) return;
      final message = e is ApiException
          ? e.message
          : 'Không thể tưới cây lúc này. Vui lòng thử lại sau.';
      showTtToast(context, message, type: TtToastType.error);
    } finally {
      if (mounted) {
        setState(() {
          _isWatering = false;
        });
      }
    }
  }

  void _showBadgeDetail(RewardBadge badge, TtColors tt) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: tt.panel,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(TtRadius.xl)),
      ),
      builder: (ctx) {
        final earnedAtText =
            badge.earned && badge.earnedAt != null && badge.earnedAt!.isNotEmpty
            ? badge.earnedAt!
            : (badge.earned ? 'Đã mở khoá' : 'Chưa mở khoá');

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: tt.line2,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: badge.earned
                        ? tt.gold.withValues(alpha: 0.15)
                        : tt.surface2,
                    border: Border.all(
                      color: badge.earned ? tt.gold : tt.line2,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.emoji_events,
                    size: 48,
                    color: badge.earned ? tt.goldDeep : tt.muted,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  badge.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: tt.text,
                  ),
                ),
                if (badge.description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    badge.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: tt.muted,
                      height: 1.4,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: badge.earned
                        ? tt.gold.withValues(alpha: 0.12)
                        : tt.surface,
                    borderRadius: BorderRadius.circular(TtRadius.md),
                  ),
                  child: Text(
                    earnedAtText,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: badge.earned ? tt.goldDeep : tt.muted,
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

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return Scaffold(
      backgroundColor: tt.bg,
      appBar: AppBar(
        backgroundColor: tt.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Quay lại',
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Phần thưởng',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (_rewards != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: tt.goldDeep,
                    size: 24,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${_rewards!.streakDays}',
                    style: TextStyle(
                      color: tt.text,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: _buildBody(tt)
            .animate()
            .fadeIn(duration: 400.ms, curve: Curves.easeOut)
            .slideY(
              begin: 0.05,
              end: 0,
              duration: 400.ms,
              curve: Curves.easeOut,
            ),
      ),
    );
  }

  Widget _buildBody(TtColors tt) {
    if (_isLoading) {
      return _buildLoading(tt);
    }

    if (_errorMessage != null) {
      return TtErrorState(
        message: _errorMessage!,
        onRetry: () => _loadRewards(),
      );
    }

    final rewards = _rewards;
    if (rewards == null || rewards.knowledgeTree.stage.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              TtFrog(size: 120),
              SizedBox(height: 16),
              TtEmptyState(
                icon: Icons.spa_outlined,
                title: 'Chưa có Cây tri thức',
                message: 'Bé hãy đọc truyện để ươm mầm cây đầu tiên nhé!',
              ),
            ],
          ),
        ),
      );
    }

    return _buildContent(rewards, tt);
  }

  Widget _buildLoading(TtColors tt) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        children: [
          TtCard(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              children: [
                TtSkeleton(
                  width: 220,
                  height: 220,
                  radius: BorderRadius.circular(TtRadius.xl),
                ),
                const SizedBox(height: 20),
                const TtSkeleton(width: 180, height: 26),
                const SizedBox(height: 16),
                const TtSkeleton(width: double.infinity, height: 12),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (_) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: TtSkeleton(
                        width: 28,
                        height: 28,
                        radius: BorderRadius.all(Radius.circular(14)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          TtSkeleton(
            width: double.infinity,
            height: 64,
            radius: BorderRadius.circular(TtRadius.lg),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(ChildRewards rewards, TtColors tt) {
    final knowledgeTree = rewards.knowledgeTree;
    final int stageIndex = kTreeStageCodes
        .indexOf(knowledgeTree.stage)
        .clamp(0, 4);
    final bool canWater = knowledgeTree.expToWater > 0 && !_isWatering;

    final badges = rewards.badges;
    final earnedCount = badges.where((b) => b.earned).length;

    Widget treeWidget = TtKnowledgeTree(stage: stageIndex, size: 220);

    if (_treePopKey > 0) {
      treeWidget = KeyedSubtree(
        key: ValueKey('tree_pop_$_treePopKey'),
        child: treeWidget
            .animate()
            .scale(
              begin: const Offset(1.0, 1.0),
              end: const Offset(1.12, 1.12),
              duration: 250.ms,
              curve: Curves.easeOut,
            )
            .then()
            .scale(
              begin: const Offset(1.12, 1.12),
              end: const Offset(1.0, 1.0),
              duration: 250.ms,
              curve: Curves.easeIn,
            ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _loadRewards(silent: true),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TtCard(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                children: [
                  treeWidget,
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${rewards.expTotal} ',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: tt.text,
                          ),
                        ),
                        TextSpan(
                          text: 'EXP',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: tt.goldDeep,
                          ),
                        ),
                        TextSpan(
                          text: ' · ${knowledgeTree.stageName}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: tt.text,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (knowledgeTree.nextStageAt != null) ...[
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value:
                            (knowledgeTree.nextStageAt! > 0
                                    ? knowledgeTree.currentTreeExp /
                                          knowledgeTree.nextStageAt!
                                    : 0.0)
                                .clamp(0.0, 1.0),
                        minHeight: 12,
                        backgroundColor: tt.surface2,
                        valueColor: AlwaysStoppedAnimation<Color>(tt.primary),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  _buildStageDots(stageIndex: stageIndex, tt: tt),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 64),
                  child: SizedBox(
                    height: 64,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        filledButtonTheme: FilledButtonThemeData(
                          style: ButtonStyle(
                            textStyle: const WidgetStatePropertyAll(
                              TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      child: TtButton(
                        label: 'Tưới cây (+${knowledgeTree.expToWater})',
                        icon: Icons.water_drop,
                        expanded: true,
                        isLoading: _isWatering,
                        onPressed: canWater ? _waterTree : null,
                      ),
                    ),
                  ),
                ),
                if (_lastExpPoured != null && _floatingExpKey > 0)
                  Positioned(
                    top: -20,
                    child: IgnorePointer(
                      child: KeyedSubtree(
                        key: ValueKey('floating_exp_$_floatingExpKey'),
                        child:
                            Text(
                                  '+$_lastExpPoured EXP',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color: tt.goldDeep,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.15,
                                        ),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                )
                                .animate()
                                .moveY(
                                  begin: 0,
                                  end: -45,
                                  duration: 1200.ms,
                                  curve: Curves.easeOut,
                                )
                                .fadeOut(
                                  duration: 1200.ms,
                                  curve: Curves.easeIn,
                                ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 28),
            Text(
              'Huy hiệu của em  $earnedCount/${badges.length}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: tt.text,
              ),
            ),
            const SizedBox(height: 16),
            if (badges.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    'Chưa có thông tin huy hiệu',
                    style: TextStyle(color: tt.muted, fontSize: 14),
                  ),
                ),
              )
            else
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.15,
                children: badges.map((badge) {
                  final Widget cardChild = Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: 38,
                        color: badge.earned ? tt.goldDeep : tt.muted,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        badge.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: tt.text,
                        ),
                      ),
                    ],
                  );

                  Widget card = TtCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    onTap: () => _showBadgeDetail(badge, tt),
                    child: cardChild,
                  );

                  if (badge.earned) {
                    card = Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(TtRadius.lg),
                        border: Border.all(color: tt.gold, width: 2.0),
                      ),
                      child: card,
                    );
                  } else {
                    card = Opacity(opacity: 0.45, child: card);
                  }

                  return card;
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageDots({required int stageIndex, required TtColors tt}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        Widget dot;
        if (index < stageIndex) {
          dot = Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: tt.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 18, color: Colors.white),
          );
        } else if (index == stageIndex) {
          dot = Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: tt.primaryStrong,
              shape: BoxShape.circle,
            ),
          );
        } else {
          dot = Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: tt.line2, width: 2.5),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: dot,
        );
      }),
    );
  }
}
