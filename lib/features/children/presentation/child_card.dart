import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/storage/token_storage.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_profile_dto.dart';
import '../../kid/data/kid_repository.dart';
import '../../kid/data/kid_session_controller.dart';
import '../../kid/data/stored_kid_session.dart';

/// Thẻ hiển thị thông tin một bé trong tab Bé của phụ huynh.
class ChildCard extends ConsumerStatefulWidget {
  const ChildCard({
    super.key,
    required this.child,
  });

  final ChildProfileDto child;

  @override
  ConsumerState<ChildCard> createState() => _ChildCardState();
}

class _ChildCardState extends ConsumerState<ChildCard> {
  bool _isLoading = false;

  String _formatAgeBand(String ageBand) {
    switch (ageBand) {
      case 'Age_6_8':
        return '6 đến 8 tuổi';
      case 'Age_9_10':
        return '9 đến 10 tuổi';
      default:
        return '';
    }
  }

  String _formatStatus(String status) {
    switch (status) {
      case 'Active':
        return 'Đang hoạt động';
      case 'Draft':
        return 'Chưa kích hoạt';
      case 'Suspended':
        return 'Tạm dừng';
      default:
        return 'Chưa sẵn sàng';
    }
  }

  Color _statusColor(BuildContext context, String status) {
    final tt = context.tt;
    switch (status) {
      case 'Active':
        return tt.primaryStrong;
      case 'Suspended':
        return tt.danger;
      case 'Draft':
      default:
        return tt.muted;
    }
  }

  Future<void> _handover() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      final refresh = await ref.read(tokenStorageProvider).readRefreshToken();
      if (refresh == null || refresh.trim().isEmpty) {
        if (mounted) {
          showTtToast(
            context,
            'Phiên đăng nhập đã hết hạn. Hãy đăng nhập lại.',
            type: TtToastType.error,
          );
        }
        return;
      }

      final repo = ref.read(kidRepositoryProvider);
      final login = await repo.startHandover(
        childId: widget.child.id,
        supervisorRefreshToken: refresh.trim(),
      );

      var gate = true;
      try {
        final policy = await repo.getSafetyPolicy(widget.child.id);
        gate = policy.parentalGateEnabled;
      } catch (_) {
        gate = true;
      }

      await ref.read(kidSessionProvider.notifier).start(
            StoredKidSession.fromChildSession(
              login,
              via: KidSessionVia.handover,
              parentalGateEnabled: gate,
            ),
          );

      if (mounted) {
        context.go('/kid');
      }
    } on ApiException catch (e) {
      if (mounted) {
        showTtToast(context, e.message, type: TtToastType.error);
      }
    } catch (_) {
      if (mounted) {
        showTtToast(
          context,
          'Có lỗi xảy ra. Vui lòng thử lại.',
          type: TtToastType.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final ageText = _formatAgeBand(widget.child.ageBand);

    return TtCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              TtNetworkImage(
                url: null,
                width: 72,
                height: 72,
                radius: BorderRadius.circular(TtRadius.lg),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.child.nickname,
                      style: TextStyle(
                        fontFamily: 'Baloo2',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: tt.text,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (ageText.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        ageText,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: tt.muted,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      _formatStatus(widget.child.status),
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: _statusColor(context, widget.child.status),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (widget.child.status == 'Active') ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 64,
              child: TtButton(
                label: 'Cho bé đọc',
                icon: Icons.child_care_rounded,
                expanded: true,
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _handover,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
