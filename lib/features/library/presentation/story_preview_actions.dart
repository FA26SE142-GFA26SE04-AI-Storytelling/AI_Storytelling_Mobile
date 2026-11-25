import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_child_avatar.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_profile_dto.dart';
import '../../../models/story_handover_dto.dart';
import '../../children/presentation/children_providers.dart';
import '../../home/data/home_repository.dart';
import '../../kid/data/handover_action.dart';
import '../../kid/data/kid_repository.dart';
import '../../learning/presentation/learning_providers.dart';

/// Thanh cố định ở đáy màn xem trước: thêm vào lộ trình / cho bé đọc ngay.
class StoryPreviewActionBar extends ConsumerWidget {
  const StoryPreviewActionBar({super.key, required this.storyId});

  final int storyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tt = context.tt;
    return Container(
      decoration: BoxDecoration(
        color: tt.panel.withValues(alpha: 0.94),
        border: Border(top: BorderSide(color: tt.line2, width: 1.5)),
      ),
      child: SafeArea(
        top: false,
        // heightFactor 1: không giãn hết màn (bottomNavigationBar không giới hạn chiều cao).
        child: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TtButton(
                      label: 'Lộ trình',
                      icon: Icons.route,
                      variant: TtButtonVariant.secondary,
                      onPressed: () => _addToRoadmap(context, ref),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TtButton(
                      label: 'Đọc ngay',
                      icon: Icons.menu_book,
                      onPressed: () => _readNow(context, ref),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 160.ms, duration: 260.ms).slideY(
      begin: 0.3,
      end: 0,
      duration: 260.ms,
    );
  }

  /// Kiểm tra trước khi mở popup: chưa có bé đang hoạt động thì chỉ báo toast.
  /// Tải danh sách lỗi thì vẫn mở để popup hiện nút thử lại.
  Future<bool> _hasActiveChild(BuildContext context, WidgetRef ref) async {
    final List<ChildProfileDto> kids;
    try {
      kids = await ref.read(childrenListProvider.future);
    } catch (_) {
      return true;
    }
    if (!context.mounted) return false;
    final reason = kids.isEmpty
        ? 'Bạn chưa có hồ sơ bé. Hãy thêm hồ sơ bé trước nhé.'
        : kids.any((k) => k.status == 'Active')
            ? null
            : 'Chưa có bé nào dùng được chức năng này. Hãy kiểm tra hồ sơ bé đang hoạt động.';
    if (reason != null) showTtToast(context, reason);
    return reason == null;
  }

  Future<void> _readNow(BuildContext context, WidgetRef ref) async {
    if (!await _hasActiveChild(context, ref) || !context.mounted) return;
    final childId = await showDialog<int>(
      context: context,
      builder: (_) => _HandoverDialog(storyId: storyId, rootContext: context),
    );
    if (childId != null && context.mounted) {
      await handoverStoryToKid(context, ref, childId, storyId);
    }
  }

  Future<void> _addToRoadmap(BuildContext context, WidgetRef ref) async {
    if (!await _hasActiveChild(context, ref) || !context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (_) => _RoadmapDialog(storyId: storyId, rootContext: context),
    );
  }
}

/// Khung popup chung của hai hộp thoại (cùng kiểu với showConfirmDialog).
class _PopupShell extends StatelessWidget {
  const _PopupShell({
    required this.title,
    required this.body,
    required this.actions,
  });

  final String title;
  final Widget body;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Dialog(
      backgroundColor: tt.panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TtRadius.xl),
        side: BorderSide(color: tt.line2, width: 1.5),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460, maxHeight: 560),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              Flexible(child: body),
              const SizedBox(height: 16),
              Row(
                children: [
                  for (var i = 0; i < actions.length; i++) ...[
                    if (i > 0) const SizedBox(width: 12),
                    Expanded(child: actions[i]),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Một dòng bé trong popup: avatar, tên, lý do khoá (nếu có), phần đuôi.
class _ChildTile extends StatelessWidget {
  const _ChildTile({
    required this.avatarId,
    required this.name,
    required this.enabled,
    required this.onTap,
    this.reason,
    this.trailing,
    this.selected = false,
  });

  final String? avatarId;
  final String name;
  final bool enabled;
  final bool selected;
  final String? reason;
  final Widget? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    return Opacity(
      opacity: enabled ? 1 : 0.6,
      child: Material(
        color: selected ? tt.gold.withValues(alpha: 0.18) : tt.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TtRadius.md),
          side: BorderSide(
            color: selected ? tt.goldDeep : tt.line2,
            width: 1.5,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: enabled ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                TtChildAvatar(avatarId: avatarId, size: 40, selected: selected),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleSmall,
                      ),
                      if (reason != null)
                        Row(
                          children: [
                            Icon(Icons.lock_rounded, size: 14, color: tt.muted),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                reason!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodySmall?.copyWith(
                                  color: tt.muted,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                ?trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _list(List<Widget> tiles) => ListView.separated(
  shrinkWrap: true,
  itemCount: tiles.length,
  separatorBuilder: (_, _) => const SizedBox(height: 8),
  itemBuilder: (_, i) => tiles[i]
      .animate()
      .fadeIn(delay: (40 * i).ms, duration: 200.ms)
      .slideX(begin: 0.05, end: 0, duration: 200.ms),
);

const _loading = Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    TtSkeleton(height: 60),
    SizedBox(height: 8),
    TtSkeleton(height: 60),
  ],
);

String? _avatarOf(List<ChildProfileDto>? kids, int id) {
  for (final k in kids ?? const <ChildProfileDto>[]) {
    if (k.id == id) return k.avatarId;
  }
  return null;
}

/// Chọn bé để giao máy và mở thẳng truyện. Trả về id bé qua Navigator.pop.
class _HandoverDialog extends ConsumerStatefulWidget {
  const _HandoverDialog({required this.storyId, required this.rootContext});

  final int storyId;
  final BuildContext rootContext;

  @override
  ConsumerState<_HandoverDialog> createState() => _HandoverDialogState();
}

class _HandoverDialogState extends ConsumerState<_HandoverDialog> {
  StoryHandoverOptionsDto? _options;

  @override
  void initState() {
    super.initState();
    ref
        .read(kidRepositoryProvider)
        .getStoryHandoverOptions(widget.storyId)
        .then(
          (o) {
            if (mounted) setState(() => _options = o);
          },
          onError: (Object e) {
            if (!mounted) return;
            Navigator.of(context).pop();
            if (widget.rootContext.mounted) {
              showTtToast(
                widget.rootContext,
                e is ApiException
                    ? e.message
                    : 'Chưa kiểm tra được bé nào đọc được truyện này. Bạn thử lại nhé.',
                type: TtToastType.error,
              );
            }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final options = _options;
    final kids = ref.watch(childrenListProvider).value;
    final Widget body;
    if (options == null) {
      body = _loading;
    } else if (options.children.isEmpty) {
      body = const TtEmptyState(
        icon: Icons.child_care_rounded,
        title: 'Bạn chưa có hồ sơ bé nào',
      );
    } else {
      body = _list([
        for (final c in options.sorted)
          _ChildTile(
            avatarId: _avatarOf(kids, c.childProfileId),
            name: c.nickname,
            enabled: c.canRead,
            reason: c.canRead
                ? null
                : (c.message ?? 'Bé chưa đọc được truyện này'),
            selected:
                c.canRead && c.childProfileId == options.suggestedChildProfileId,
            trailing: c.canRead
                ? Icon(Icons.menu_book_rounded, color: tt.goldDeep)
                : null,
            onTap: () => Navigator.of(context).pop(c.childProfileId),
          ),
      ]);
    }
    return _PopupShell(
      title: 'Bé nào đọc truyện này?',
      body: body,
      actions: [
        TtButton(
          label: 'Đóng',
          icon: Icons.close_rounded,
          variant: TtButtonVariant.secondary,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

/// Chọn một hoặc nhiều bé rồi thêm truyện vào cuối lộ trình của từng bé.
class _RoadmapDialog extends ConsumerStatefulWidget {
  const _RoadmapDialog({required this.storyId, required this.rootContext});

  final int storyId;
  final BuildContext rootContext;

  @override
  ConsumerState<_RoadmapDialog> createState() => _RoadmapDialogState();
}

class _RoadmapDialogState extends ConsumerState<_RoadmapDialog> {
  final _picked = <int>{};
  bool _saving = false;

  Future<void> _submit(List<ChildProfileDto> kids) async {
    setState(() => _saving = true);
    try {
      final results = await ref
          .read(homeRepositoryProvider)
          .addRoadmapStory(storyId: widget.storyId, childIds: _picked.toList());
      for (final r in results) {
        ref.invalidate(learningRoadmapProvider(r.childProfileId));
      }
      if (!mounted) return;
      Navigator.of(context).pop();
      final summary = roadmapAddSummary(results, {
        for (final k in kids) k.id: k.nickname,
      });
      if (widget.rootContext.mounted) {
        showTtToast(
          widget.rootContext,
          summary.message,
          type: summary.anyAdded ? TtToastType.success : TtToastType.info,
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      showTtToast(
        context,
        e is ApiException
            ? e.message
            : 'Chưa thêm được truyện vào lộ trình. Bạn thử lại nhé.',
        type: TtToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final async = ref.watch(childrenListProvider);
    final kids = async.value;
    final Widget body;
    if (kids == null && async.hasError) {
      body = TtErrorState(
        message: 'Chưa tải được danh sách bé.',
        onRetry: () => ref.invalidate(childrenListProvider),
      );
    } else if (kids == null) {
      body = _loading;
    } else if (kids.isEmpty) {
      body = const TtEmptyState(
        icon: Icons.child_care_rounded,
        title: 'Bạn chưa có hồ sơ bé nào',
      );
    } else {
      body = _list([
        for (final k in kids)
          _ChildTile(
            avatarId: k.avatarId,
            name: k.nickname,
            enabled: k.status == 'Active' && !_saving,
            reason: k.status == 'Active'
                ? null
                : 'Hồ sơ của bé không hoạt động nên chưa thêm được',
            selected: _picked.contains(k.id),
            trailing: k.status == 'Active'
                ? Icon(
                    _picked.contains(k.id)
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: _picked.contains(k.id) ? tt.goldDeep : tt.muted,
                  )
                : null,
            onTap: () => setState(
              () => _picked.contains(k.id)
                  ? _picked.remove(k.id)
                  : _picked.add(k.id),
            ),
          ),
      ]);
    }
    return _PopupShell(
      title: 'Thêm vào lộ trình của bé',
      body: body,
      actions: [
        TtButton(
          label: 'Huỷ',
          variant: TtButtonVariant.secondary,
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
        ),
        TtButton(
          label: 'Thêm',
          icon: Icons.add_rounded,
          isLoading: _saving,
          onPressed: _picked.isEmpty || kids == null
              ? null
              : () => _submit(kids),
        ),
      ],
    );
  }
}

/// Câu tổng kết sau khi thêm: bé nào đã thêm, bé nào bị bỏ qua và vì sao.
({String message, bool anyAdded}) roadmapAddSummary(
  List<RoadmapAddResult> results,
  Map<int, String> names,
) {
  String name(int id) => names[id] ?? 'bé';
  final added = [
    for (final r in results)
      if (r.outcome == 'Added') name(r.childProfileId),
  ];
  final skipped = [
    for (final r in results)
      if (r.outcome != 'Added')
        '${name(r.childProfileId)}: ${r.message ?? 'chưa thêm được'}',
  ];
  final parts = [
    if (added.isNotEmpty) 'Đã thêm vào lộ trình của ${added.join(', ')}.',
    if (skipped.isNotEmpty) 'Bỏ qua ${skipped.join('; ')}.',
  ];
  return (
    message: parts.isEmpty ? 'Chưa thêm được truyện vào lộ trình.' : parts.join(' '),
    anyAdded: added.isNotEmpty,
  );
}
