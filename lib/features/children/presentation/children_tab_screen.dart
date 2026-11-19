import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../models/child_profile_dto.dart';
import '../../auth/application/auth_controller.dart';
import '../../kid/data/handover_action.dart';
import '../data/archived_children_store.dart';
import 'child_lifecycle_actions.dart';
import 'child_tab_widgets.dart';
import 'children_providers.dart';

/// Màn Quản lý bé (mở từ tab Học tập, có nút quay lại): dải chọn bé gồm cả bé
/// tạm dừng / lưu trữ, thẻ bé, Hồ sơ · Học tập · An toàn · Mã QR, thêm bé.
class ChildrenTabScreen extends ConsumerStatefulWidget {
  const ChildrenTabScreen({super.key});

  @override
  ConsumerState<ChildrenTabScreen> createState() => _ChildrenTabScreenState();
}

class _ChildrenTabScreenState extends ConsumerState<ChildrenTabScreen> {
  bool _handoverLoading = false;

  Future<void> _handover(ChildProfileDto child) async {
    if (_handoverLoading) return;
    setState(() => _handoverLoading = true);
    try {
      await handoverChildToKid(context, ref, child);
    } finally {
      if (mounted) setState(() => _handoverLoading = false);
    }
  }

  Future<void> _onRefresh() async {
    ref.invalidate(childrenListProvider);
    ref.invalidate(archivedChildrenProvider);
    try {
      final children = await ref.read(childrenListProvider.future);
      for (final c in children) {
        ref.invalidate(childOverviewProvider(c.id));
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final childrenAsync = ref.watch(childrenListProvider);
    final archivedAsync = ref.watch(archivedChildrenProvider);

    return Scaffold(
      backgroundColor: tt.bg,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Quản lý bé'),
      ),
      body: SafeArea(
        child: childrenAsync.when(
          loading: () => _buildSkeleton(),
          error: (error, _) {
            final msg = error is ApiException
                ? error.message
                : 'Có lỗi xảy ra. Vui lòng thử lại.';
            return TtErrorState(
              title: 'Chưa tải được danh sách bé',
              message: msg,
              onRetry: () => ref.invalidate(childrenListProvider),
            );
          },
          data: (children) {
            final archived = archivedAsync.value ?? [];

            // Nếu cả hai danh sách đều rỗng → empty state
            if (children.isEmpty && archived.isEmpty) {
              return _buildEmpty();
            }

            return _buildContent(context, children, archived);
          },
        ),
      ),
    );
  }

  Widget _buildSkeleton() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (_, _) => const TtSkeleton(
        height: 120,
        radius: BorderRadius.all(Radius.circular(16)),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: TtEmptyState(
        icon: Icons.child_care_rounded,
        title: 'Chưa có hồ sơ bé',
        message: 'Thêm hồ sơ bé để bắt đầu.',
        actionLabel: 'Thêm bé',
        onAction: () => context.push('/kids/new'),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<ChildProfileDto> children,
    List<ArchivedChild> archived,
  ) {
    // Xác định bé đang chọn (tính trong build, không ghi lại provider)
    final rawSelectedId = ref.watch(selectedChildIdProvider);
    final int? effectiveSelectedId;
    if (rawSelectedId != null &&
        children.any((c) => c.id == rawSelectedId)) {
      effectiveSelectedId = rawSelectedId;
    } else if (children.isNotEmpty) {
      effectiveSelectedId = children.first.id;
    } else {
      effectiveSelectedId = null;
    }

    final selectedChild = effectiveSelectedId != null
        ? children.where((c) => c.id == effectiveSelectedId).firstOrNull
        : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 840;
        Widget content = RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),

                // 1) ChildPickerStrip
                ChildPickerStrip(
                  children: children,
                  archived: archived,
                  selectedId: effectiveSelectedId,
                  onSelect: (id) =>
                      ref.read(selectedChildIdProvider.notifier).select(id),
                  onOpenArchived: (id) =>
                      context.push('/kids/$id/profile'),
                  onAdd: () => context.push('/kids/new'),
                ).animate().fadeIn(duration: 280.ms).slideY(
                      begin: 0.06,
                      end: 0,
                      duration: 280.ms,
                      curve: Curves.easeOut,
                    ),

                const SizedBox(height: 16),

                if (selectedChild != null) ...[
                  // 2) PrimaryChildCard
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildPrimaryCard(context, selectedChild),
                  ).animate(delay: 60.ms).fadeIn(duration: 320.ms).slideY(
                        begin: 0.05,
                        end: 0,
                        duration: 320.ms,
                        curve: Curves.easeOut,
                      ),

                  const SizedBox(height: 16),

                  // 3) ChildGroupGrid
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildGroupGrid(selectedChild),
                  ).animate(delay: 120.ms).fadeIn(duration: 350.ms).slideY(
                        begin: 0.04,
                        end: 0,
                        duration: 350.ms,
                        curve: Curves.easeOut,
                      ),
                ],

                const SizedBox(height: 24),
              ],
            ),
          ),
        );

        if (wide) {
          content = Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: content,
            ),
          );
        }

        return content;
      },
    );
  }

  Widget _buildPrimaryCard(BuildContext context, ChildProfileDto child) {
    final tt = context.tt;
    final authState = ref.watch(authControllerProvider);
    final currentUserId =
        authState is AuthSignedIn ? authState.user.id : null;
    final isOwner = currentUserId != null && child.ownerUserId == currentUserId;

    final overviewAsync = ref.watch(childOverviewProvider(child.id));
    final overview = overviewAsync.value;

    final String statusLabel;
    final Color statusColor;
    String? primaryLabel;
    VoidCallback? onPrimaryAction;
    bool showMissingHint = false;

    switch (child.status) {
      case 'Active':
        statusLabel = 'Đang hoạt động';
        statusColor = tt.mint;
        primaryLabel = 'Cho bé đọc';
        onPrimaryAction = _handoverLoading ? null : () => _handover(child);
        showMissingHint = false;

      case 'Draft':
        statusLabel = 'Nháp';
        statusColor = tt.gold;
        if (isOwner) {
          primaryLabel = 'Kích hoạt';
          final canActivate = overview != null &&
              overview.learning != null &&
              overview.safety != null &&
              (overview.safety!.consentRecorded == true);
          if (canActivate) {
            onPrimaryAction = () => runChildLifecycleAction(
                  context: context,
                  ref: ref,
                  child: child,
                  action: ChildLifecycleAction.activate,
                );
            showMissingHint = false;
          } else {
            onPrimaryAction = null;
            showMissingHint = true;
          }
        }

      case 'Suspended':
        statusLabel = 'Tạm dừng';
        statusColor = tt.goldDeep;
        if (isOwner) {
          primaryLabel = 'Tiếp tục';
          onPrimaryAction = () => runChildLifecycleAction(
                context: context,
                ref: ref,
                child: child,
                action: ChildLifecycleAction.resume,
              );
        }

      case 'Archived':
        statusLabel = 'Đã lưu trữ';
        statusColor = tt.muted;
        if (isOwner) {
          primaryLabel = 'Khôi phục';
          onPrimaryAction = () => runChildLifecycleAction(
                context: context,
                ref: ref,
                child: child,
                action: ChildLifecycleAction.restore,
              );
        }

      default:
        statusLabel = child.status;
        statusColor = tt.muted;
    }

    return PrimaryChildCard(
      child: child,
      statusLabel: statusLabel,
      statusColor: statusColor,
      primaryLabel: primaryLabel,
      onPrimaryAction: onPrimaryAction,
      showMissingHint: showMissingHint,
    );
  }

  Widget _buildGroupGrid(ChildProfileDto child) {
    final overviewAsync = ref.watch(childOverviewProvider(child.id));
    final loading = overviewAsync.isLoading;
    final overview = overviewAsync.value;

    return ChildGroupGrid(
      child: child,
      overview: overview,
      loading: loading,
      onOpen: (section) => context.push('/kids/${child.id}/$section'),
    );
  }
}
