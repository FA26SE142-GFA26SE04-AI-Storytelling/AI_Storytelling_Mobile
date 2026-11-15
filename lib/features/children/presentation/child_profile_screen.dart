import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_text_field.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../core/widgets/tt_confirm_dialog.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../features/auth/application/auth_controller.dart';
import '../data/child_profile_repository.dart';
import 'child_audit_section.dart';
import 'child_lifecycle_actions.dart';
import 'children_providers.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

String _ageBandLabel(String ageBand) {
  switch (ageBand) {
    case 'Age_6_8':
      return '6–8 tuổi';
    case 'Age_9_10':
      return '9–10 tuổi';
    default:
      return ageBand;
  }
}

String _statusLabel(String status) {
  switch (status) {
    case 'Draft':
      return 'Nháp';
    case 'Active':
      return 'Đang hoạt động';
    case 'Suspended':
      return 'Tạm dừng';
    case 'Archived':
      return 'Đã lưu trữ';
    default:
      return status;
  }
}

Color _statusColor(String status, TtColors tt) {
  switch (status) {
    case 'Draft':
      return tt.gold;
    case 'Active':
      return tt.mint;
    case 'Suspended':
      return tt.goldDeep;
    case 'Archived':
      return tt.muted;
    default:
      return tt.muted;
  }
}

String? _formatDate(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  try {
    final dt = DateTime.parse(raw).toLocal();
    final d = dt.day.toString().padLeft(2, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final y = dt.year.toString();
    return '$d/$m/$y';
  } catch (_) {
    return null;
  }
}

// ---------------------------------------------------------------------------
// Edit Dialog (private StatefulWidget)
// ---------------------------------------------------------------------------

class _EditChildDialog extends ConsumerStatefulWidget {
  const _EditChildDialog({required this.childId});
  final int childId;

  @override
  ConsumerState<_EditChildDialog> createState() => _EditChildDialogState();
}

class _EditChildDialogState extends ConsumerState<_EditChildDialog> {
  late TextEditingController _nicknameCtrl;
  late String _ageBand;
  late String _initialNickname;
  late String _initialAgeBand;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final child =
        ref.read(childDetailProvider(widget.childId)).value;
    _initialNickname = child?.nickname ?? '';
    _initialAgeBand = child?.ageBand ?? 'Age_6_8';
    _nicknameCtrl = TextEditingController(text: _initialNickname);
    _ageBand = _initialAgeBand;
    _nicknameCtrl.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  bool get _hasChanges =>
      _nicknameCtrl.text.trim() != _initialNickname ||
      _ageBand != _initialAgeBand;

  bool get _isValid =>
      _nicknameCtrl.text.trim().isNotEmpty &&
      _nicknameCtrl.text.trim().length <= 50;

  @override
  void dispose() {
    _nicknameCtrl.removeListener(_onChanged);
    _nicknameCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_isValid || !_hasChanges) return;
    setState(() => _isSaving = true);

    final child =
        ref.read(childDetailProvider(widget.childId)).value;
    if (child == null) {
      setState(() => _isSaving = false);
      return;
    }

    final repo = ref.read(childProfileRepositoryProvider);
    try {
      final avatarIdRaw = child.avatarId;
      final avatarId = int.tryParse(avatarIdRaw);

      final response = await repo.update(
        child.id,
        nickname: _nicknameCtrl.text.trim(),
        ageBand: _ageBand,
        avatarId: avatarId,
      );

      ref.invalidate(childDetailProvider(child.id));
      ref.invalidate(childrenListProvider);

      if (!mounted) return;

      showTtToast(context, 'Đã lưu thông tin bé.', type: TtToastType.success);

      // Check if should re-apply blocked preset
      if (response.shouldReapplyBlockedPreset == true) {
        final confirmed = await showConfirmDialog(
          context,
          title: 'Áp dụng danh sách chủ đề chặn theo nhóm tuổi mới?',
          message:
              'Danh sách chủ đề bị chặn sẽ được cập nhật theo nhóm tuổi mới.',
          confirmLabel: 'Áp dụng',
          cancelLabel: 'Bỏ qua',
        );
        if (confirmed && mounted) {
          try {
            await repo.applyAgePreset(child.id);
          } on ApiException catch (e) {
            if (mounted) {
              showTtToast(
                context,
                e.message.isNotEmpty ? e.message : 'Không thể áp dụng preset.',
                type: TtToastType.error,
              );
            }
          }
        }
      }

      // Check suggested reading mode hint
      if (response.suggestedReadingMode != null && mounted) {
        showTtToast(
          context,
          'Nhóm tuổi đã đổi. Bạn nên xem lại chế độ đọc trong mục Học tập.',
          type: TtToastType.info,
        );
      }

      if (mounted) Navigator.of(context).pop();
    } on ApiException catch (e) {
      if (mounted) {
        showTtToast(
          context,
          e.message.isNotEmpty ? e.message : 'Không thể lưu thông tin.',
          type: TtToastType.error,
        );
      }
    } catch (_) {
      if (mounted) {
        showTtToast(context, 'Không thể lưu thông tin.', type: TtToastType.error);
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      backgroundColor: tt.panel,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Sửa thông tin',
              style: textTheme.titleLarge?.copyWith(
                fontFamily: 'Baloo2',
                fontWeight: FontWeight.w700,
                color: tt.text,
              ),
            ),
            const SizedBox(height: 20),
            TtTextField(
              label: 'Tên',
              controller: _nicknameCtrl,
              autofocus: true,
              validator: (v) {
                final val = (v ?? '').trim();
                if (val.isEmpty) return 'Tên không được để trống';
                if (val.length > 50) return 'Tên tối đa 50 ký tự';
                return null;
              },
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 20),
            Text(
              'Nhóm tuổi',
              style: textTheme.titleSmall?.copyWith(
                fontFamily: 'Nunito',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: tt.text,
              ),
            ),
            const SizedBox(height: 10),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'Age_6_8',
                  label: Text('6–8 tuổi'),
                ),
                ButtonSegment(
                  value: 'Age_9_10',
                  label: Text('9–10 tuổi'),
                ),
              ],
              selected: {_ageBand},
              onSelectionChanged: (val) {
                setState(() => _ageBand = val.first);
              },
              style: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                  const TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
                  child: Text(
                    'Huỷ',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      color: tt.muted,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (_hasChanges && _isValid)
                  TtButton(
                    label: 'Lưu',
                    isLoading: _isSaving,
                    onPressed: _save,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ChildProfileScreen
// ---------------------------------------------------------------------------

class ChildProfileScreen extends ConsumerWidget {
  const ChildProfileScreen({super.key, required this.childId});

  final int childId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childAsync = ref.watch(childDetailProvider(childId));
    final authState = ref.watch(authControllerProvider);

    final int? currentUserId =
        authState is AuthSignedIn ? authState.user.id : null;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          childAsync.value?.nickname ?? '',
          style: const TextStyle(
            fontFamily: 'Baloo2',
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if (childAsync.value != null &&
              currentUserId != null &&
              childAsync.value!.ownerUserId == currentUserId)
            IconButton(
              icon: const Icon(Icons.edit_rounded),
              tooltip: 'Sửa thông tin',
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (_) => _EditChildDialog(childId: childId),
                );
              },
            ),
        ],
      ),
      body: childAsync.when(
        loading: () => _buildSkeleton(context),
        error: (err, _) => TtErrorState(
          message: err is ApiException
              ? err.message
              : 'Không thể tải thông tin bé.',
          onRetry: () => ref.invalidate(childDetailProvider(childId)),
        ),
        data: (child) {
          final isOwner =
              currentUserId != null && child.ownerUserId == currentUserId;
          return _ChildProfileBody(
            child: child,
            isOwner: isOwner,
          );
        },
      ),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const TtSkeleton(height: 20, width: 120),
        const SizedBox(height: 20),
        TtCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TtSkeleton(height: 16, width: 80),
              SizedBox(height: 14),
              TtSkeleton(height: 16, width: 140),
              SizedBox(height: 14),
              TtSkeleton(height: 16, width: 100),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TtCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TtSkeleton(height: 16, width: 100),
              SizedBox(height: 14),
              TtSkeleton(height: 48),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Body
// ---------------------------------------------------------------------------

class _ChildProfileBody extends ConsumerStatefulWidget {
  const _ChildProfileBody({
    required this.child,
    required this.isOwner,
  });

  final dynamic child;
  final bool isOwner;

  @override
  ConsumerState<_ChildProfileBody> createState() => _ChildProfileBodyState();
}

class _ChildProfileBodyState extends ConsumerState<_ChildProfileBody> {
  bool _isActioning = false;

  Future<void> _doLifecycle(ChildLifecycleAction action) async {
    if (_isActioning) return;
    setState(() => _isActioning = true);
    try {
      final success = await runChildLifecycleAction(
        context: context,
        ref: ref,
        child: widget.child,
        action: action,
      );
      if (!mounted) return;
      if (success) {
        if (action == ChildLifecycleAction.archive ||
            action == ChildLifecycleAction.restore) {
          Navigator.of(context).pop();
        }
      }
    } finally {
      if (mounted) setState(() => _isActioning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final child = widget.child;
    final isOwner = widget.isOwner;
    final formattedDate = _formatDate(child.createdAt as String?);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        // ── Khối thông tin ──
        TtCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeader(
                icon: Icons.person_rounded,
                label: 'Thông tin hồ sơ',
                tt: tt,
              ),
              const SizedBox(height: 14),
              _InfoRow(
                label: 'Nhóm tuổi',
                value: _ageBandLabel(child.ageBand as String),
                tt: tt,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Trạng thái',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: tt.muted,
                    ),
                  ),
                  const Spacer(),
                  _StatusChip(status: child.status as String, tt: tt),
                ],
              ),
              if (formattedDate != null) ...[
                const SizedBox(height: 10),
                _InfoRow(
                  label: 'Ngày tạo',
                  value: formattedDate,
                  tt: tt,
                ),
              ],
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 280.ms)
            .slideY(begin: 0.05, end: 0, duration: 280.ms),

        const SizedBox(height: 16),

        // ── Khối trạng thái hồ sơ (chỉ Owner) ──
        if (isOwner) ...[
          TtCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SectionHeader(
                  icon: Icons.manage_accounts_rounded,
                  label: 'Trạng thái hồ sơ',
                  tt: tt,
                ),
                const SizedBox(height: 14),
                _buildLifecycleButtons(child.status as String),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 300.ms, delay: 60.ms)
              .slideY(begin: 0.05, end: 0, duration: 300.ms, delay: 60.ms),
          const SizedBox(height: 16),
        ],

        // ── Lịch sử hoạt động (chỉ Owner) ──
        if (isOwner)
          ChildAuditSection(childId: child.id as int)
              .animate()
              .fadeIn(duration: 300.ms, delay: 120.ms)
              .slideY(begin: 0.05, end: 0, duration: 300.ms, delay: 120.ms),
      ],
    );
  }

  Widget _buildLifecycleButtons(String status) {
    switch (status) {
      case 'Draft':
        return TtButton(
          label: 'Kích hoạt',
          icon: Icons.play_circle_rounded,
          expanded: true,
          isLoading: _isActioning,
          onPressed: () => _doLifecycle(ChildLifecycleAction.activate),
        );
      case 'Active':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TtButton(
              label: 'Tạm dừng',
              icon: Icons.pause_circle_rounded,
              variant: TtButtonVariant.secondary,
              expanded: true,
              isLoading: _isActioning,
              onPressed: () => _doLifecycle(ChildLifecycleAction.suspend),
            ),
            const SizedBox(height: 10),
            TtButton(
              label: 'Lưu trữ',
              icon: Icons.archive_rounded,
              variant: TtButtonVariant.danger,
              expanded: true,
              isLoading: _isActioning,
              onPressed: () => _doLifecycle(ChildLifecycleAction.archive),
            ),
          ],
        );
      case 'Suspended':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TtButton(
              label: 'Tiếp tục',
              icon: Icons.play_circle_rounded,
              expanded: true,
              isLoading: _isActioning,
              onPressed: () => _doLifecycle(ChildLifecycleAction.resume),
            ),
            const SizedBox(height: 10),
            TtButton(
              label: 'Lưu trữ',
              icon: Icons.archive_rounded,
              variant: TtButtonVariant.danger,
              expanded: true,
              isLoading: _isActioning,
              onPressed: () => _doLifecycle(ChildLifecycleAction.archive),
            ),
          ],
        );
      case 'Archived':
        return TtButton(
          label: 'Khôi phục',
          icon: Icons.unarchive_rounded,
          expanded: true,
          isLoading: _isActioning,
          onPressed: () => _doLifecycle(ChildLifecycleAction.restore),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

// ---------------------------------------------------------------------------
// Small shared widgets
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.label,
    required this.tt,
  });

  final IconData icon;
  final String label;
  final TtColors tt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: tt.goldDeep),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Baloo2',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: tt.text,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.tt,
  });

  final String label;
  final String value;
  final TtColors tt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: tt.muted,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: tt.text,
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.tt});

  final String status;
  final TtColors tt;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(status, tt);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
      ),
      child: Text(
        _statusLabel(status),
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
