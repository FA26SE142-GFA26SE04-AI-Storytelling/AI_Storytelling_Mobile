import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_adaptive.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../models/child_profile_dto.dart';
import '../../children/presentation/child_tab_widgets.dart';
import '../../children/presentation/children_providers.dart';
import '../../kid/data/handover_action.dart';
import 'learning_overview_tab.dart';
import 'learning_providers.dart';
import 'learning_results_tab.dart';
import 'learning_roadmap_tab.dart';
import 'learning_widgets.dart';
import 'learning_wishes_tab.dart';
import 'summary_audio.dart';

/// Tab "Học tập" của phụ huynh (Luồng 4 như web): chọn bé rồi xem
/// Tổng quan · Lộ trình · Kết quả đọc · Điều ước. Chỉ xem, sửa làm trên web.
class LearningScreen extends ConsumerStatefulWidget {
  const LearningScreen({super.key, this.audio, this.handover});

  /// Cho test truyền player giả; mặc định tự tạo.
  final SummaryAudio? audio;

  /// Cho test thay việc giao máy cho bé; mặc định [handoverChildToKid].
  final Future<void> Function(BuildContext, WidgetRef, ChildProfileDto)?
  handover;

  @override
  ConsumerState<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends ConsumerState<LearningScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 4, vsync: this)
    ..addListener(_onTabChanged);
  late final SummaryAudio _audio = widget.audio ?? SummaryAudio();
  bool _handoverLoading = false;

  /// "Vào học": cho bé đang chọn vào chế độ bé; chặn bấm đúp khi đang tải.
  Future<void> _handover(ChildProfileDto child) async {
    if (_handoverLoading) return;
    _audio.stop();
    setState(() => _handoverLoading = true);
    try {
      await (widget.handover ?? handoverChildToKid)(context, ref, child);
    } finally {
      if (mounted) setState(() => _handoverLoading = false);
    }
  }

  void _onTabChanged() {
    if (_tabs.index != 2) _audio.stop();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Thanh đáy chuyển sang tab khác thì nhánh này bị tắt ticker: dừng phát.
    if (!TickerMode.valuesOf(context).enabled) Future.microtask(_audio.stop);
  }

  @override
  void dispose() {
    _tabs.dispose();
    if (widget.audio == null) _audio.dispose();
    super.dispose();
  }

  void _goTab(int index) => _tabs.animateTo(index);

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final childrenAsync = ref.watch(childrenListProvider);

    final Widget body;
    if (childrenAsync.hasError && !childrenAsync.hasValue) {
      body = learningError(
        childrenAsync.error,
        () => ref.invalidate(childrenListProvider),
        title: 'Chưa tải được danh sách bé',
      );
    } else if (!childrenAsync.hasValue) {
      body = ListView(
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const TtSkeleton(height: 80),
          const SizedBox(height: 16),
          for (final w in learningSkeleton()) ...[
            w,
            const SizedBox(height: 12),
          ],
        ],
      );
    } else {
      final active = childrenAsync.value!
          .where((c) => c.status == 'Active')
          .toList();
      body = active.isEmpty ? _buildNoChild() : _buildContent(active);
    }

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: TtContentWidth(child: body),
      ),
    );
  }

  Widget _buildNoChild() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LearningEmpty(title: 'Chưa có bé nào đang hoạt động'),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                TtButton(
                  label: 'Quản lý bé',
                  icon: Icons.settings_rounded,
                  variant: TtButtonVariant.secondary,
                  onPressed: () => context.push(AppRoutes.kids),
                ),
                TtButton(
                  label: 'Thêm bé',
                  icon: Icons.add_rounded,
                  onPressed: () => context.push(AppRoutes.kidsNew),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(List<ChildProfileDto> active) {
    final tt = context.tt;
    final selected = ref.watch(selectedChildIdProvider);
    final child =
        active.where((c) => c.id == selected).firstOrNull ?? active.first;
    final id = child.id;

    // Giữ dữ liệu của bé đang chọn khi chuyển tab trong màn (không gọi lại API).
    ref.listen(readingFeedbackProvider(id), (_, _) {});
    ref.listen(storySummariesProvider(id), (_, _) {});
    ref.listen(learningRoadmapProvider(id), (_, _) {});
    final pending =
        ref
            .watch(learningWishesProvider(id))
            .value
            ?.where((w) => w.status == 'Pending')
            .length ??
        0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ChildPickerStrip(
                children: active,
                selectedId: id,
                onSelect: (newId) {
                  if (newId == id) return;
                  _audio.stop();
                  ref.read(selectedChildIdProvider.notifier).select(newId);
                },
              ),
            ),
            ChildStripAction(
              icon: Icons.play_arrow_rounded,
              label: 'Vào học',
              semanticsLabel: 'Cho ${child.nickname} vào học',
              fill: tt.gold,
              loading: _handoverLoading,
              onTap: () => _handover(child),
            ),
            ChildStripAction(
              icon: Icons.settings_rounded,
              label: 'Quản lý',
              semanticsLabel: 'Quản lý bé',
              onTap: () => context.push(AppRoutes.kids),
            ),
            const SizedBox(width: 12),
          ],
        ),
        TabBar(
          controller: _tabs,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          labelPadding: const EdgeInsets.symmetric(horizontal: 12),
          labelStyle: Theme.of(context).textTheme.titleSmall,
          labelColor: tt.text,
          unselectedLabelColor: tt.muted,
          indicatorColor: tt.goldDeep,
          indicatorWeight: 3,
          dividerColor: tt.line,
          tabs: [
            const Tab(text: 'Tổng quan'),
            const Tab(text: 'Lộ trình'),
            const Tab(text: 'Kết quả đọc'),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Điều ước'),
                  if (pending > 0) ...[
                    const SizedBox(width: 6),
                    LearningChip(
                      label: '$pending',
                      color: tt.goldDeep,
                      fill: tt.gold,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            key: ValueKey('learning-$id'),
            controller: _tabs,
            children: [
              LearningOverviewTab(child: child, onTab: _goTab),
              LearningRoadmapTab(child: child),
              LearningResultsTab(child: child, audio: _audio),
              LearningWishesTab(child: child),
            ],
          ),
        ),
      ],
    );
  }
}
