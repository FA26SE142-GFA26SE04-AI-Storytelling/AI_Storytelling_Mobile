import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/audit_log_entry_dto.dart';
import '../data/child_profile_repository.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

String _resolveEntityTypeLabel(String entityType) {
  final clean = entityType.trim().toLowerCase();
  switch (clean) {
    case 'childprofile':
    case 'child_profile':
    case 'child':
      return 'hồ sơ bé';
    case 'learningprofile':
    case 'learning_profile':
    case 'learning':
      return 'hồ sơ học tập';
    case 'safetypolicy':
    case 'safety_policy':
    case 'safety':
      return 'cài đặt an toàn';
    case 'easylogin':
    case 'easy_login':
    case 'childaccesscredential':
    case 'child_access_credential':
    case 'access':
      return 'mã đăng nhập của bé';
    case 'contentcategory':
    case 'content_category':
      return 'danh mục nội dung';
    default:
      return 'Mục khác';
  }
}

/// Chuyển đổi mã hành động kiểm toán sang nhãn tiếng Việt thân thiện với người dùng.
/// Không bao giờ trả về mã thô; trả về 'Thay đổi khác' nếu không nhận diện được.
String auditActionLabel(String action, [String entityType = '']) {
  final cleanAction = action.trim();
  switch (cleanAction) {
    case 'CREATE_CHILD_PROFILE':
      return 'Tạo hồ sơ bé';
    case 'UPDATE_CHILD_PROFILE':
      return 'Sửa hồ sơ bé';
    case 'ACTIVATE_CHILD_PROFILE':
      return 'Kích hoạt hồ sơ bé';
    case 'SUSPEND_CHILD_PROFILE':
      return 'Tạm dừng hồ sơ bé';
    case 'RESUME_CHILD_PROFILE':
      return 'Mở lại hồ sơ bé';
    case 'ARCHIVE_CHILD_PROFILE':
      return 'Lưu trữ hồ sơ bé';
    case 'RESTORE_CHILD_PROFILE':
      return 'Khôi phục hồ sơ bé';
    case 'CREATE_EASY_LOGIN':
      return 'Tạo mã đăng nhập cho bé';
    case 'REGENERATE_EASY_LOGIN':
      return 'Đổi mã đăng nhập của bé';
    case 'REVOKE_EASY_LOGIN':
      return 'Huỷ mã đăng nhập của bé';
    case 'SET_SAFETY_POLICY':
      return 'Đổi cài đặt an toàn';
    case 'APPLY_AGE_PRESET':
      return 'Áp dụng danh sách chặn theo nhóm tuổi';
  }

  // Ghép theo động từ trong action nếu chưa có trong danh mục cố định
  String? verb;
  if (cleanAction.contains('Created') || cleanAction.toUpperCase().contains('CREATE')) {
    verb = 'Tạo';
  } else if (cleanAction.contains('Updated') || cleanAction.toUpperCase().contains('UPDATE')) {
    verb = 'Sửa';
  } else if (cleanAction.contains('Deleted') || cleanAction.toUpperCase().contains('DELETE')) {
    verb = 'Xoá';
  } else if (cleanAction.contains('Activated') || cleanAction.toUpperCase().contains('ACTIVATE')) {
    verb = 'Kích hoạt';
  } else if (cleanAction.contains('Retired') || cleanAction.toUpperCase().contains('RETIRE')) {
    verb = 'Ngừng dùng';
  }

  if (verb != null) {
    final target = _resolveEntityTypeLabel(entityType);
    return '$verb $target';
  }

  return 'Thay đổi khác';
}

String _formatDateTime(DateTime dateTime) {
  final local = dateTime.toLocal();
  final day = local.day.toString().padLeft(2, '0');
  final month = local.month.toString().padLeft(2, '0');
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return '$day/$month $hour:$minute';
}

// ---------------------------------------------------------------------------
// ChildAuditSection Widget
// ---------------------------------------------------------------------------

/// Phần hiển thị lịch sử hoạt động của một bé trong thẻ TtCard.
class ChildAuditSection extends ConsumerStatefulWidget {
  const ChildAuditSection({
    super.key,
    required this.childId,
  });

  final int childId;

  @override
  ConsumerState<ChildAuditSection> createState() => _ChildAuditSectionState();
}

class _ChildAuditSectionState extends ConsumerState<ChildAuditSection> {
  List<AuditLogEntryDto> _items = [];
  int _pageIndex = 1;
  int _totalPages = 1;
  bool _isLoading = true;
  bool _isLoadingMore = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  @override
  void didUpdateWidget(covariant ChildAuditSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.childId != widget.childId) {
      _loadInitial();
    }
  }

  Future<void> _loadInitial() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final repo = ref.read(childProfileRepositoryProvider);
      final result = await repo.auditLog(widget.childId, pageIndex: 1);
      if (!mounted) return;
      setState(() {
        _items = result.items;
        _pageIndex = 1;
        _totalPages = result.totalPages;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e is ApiException
            ? e.message
            : 'Không thể tải lịch sử hoạt động. Vui lòng thử lại.';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || _pageIndex >= _totalPages) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final nextPage = _pageIndex + 1;
      final repo = ref.read(childProfileRepositoryProvider);
      final result = await repo.auditLog(widget.childId, pageIndex: nextPage);
      if (!mounted) return;
      setState(() {
        _items = [..._items, ...result.items];
        _pageIndex = nextPage;
        _totalPages = result.totalPages;
        _isLoadingMore = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingMore = false;
      });
      showTtToast(
        context,
        e is ApiException ? e.message : 'Không thể tải thêm hoạt động.',
        type: TtToastType.error,
      );
    }
  }

  Widget _buildContent(BuildContext context) {
    if (_isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          3,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                TtSkeleton(width: 140, height: 16),
                TtSkeleton(width: 70, height: 14),
              ],
            ),
          ),
        ),
      );
    }

    if (_errorMessage != null && _items.isEmpty) {
      return TtErrorState(
        message: _errorMessage!,
        onRetry: _loadInitial,
      );
    }

    if (_items.isEmpty) {
      return const TtEmptyState(
        icon: Icons.history_rounded,
        title: 'Chưa có hoạt động nào',
      );
    }

    final tt = context.tt;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _items.length,
          separatorBuilder: (context, index) => Divider(
            color: tt.line,
            height: 16,
            thickness: 1,
          ),
          itemBuilder: (context, index) {
            final item = _items[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: tt.goldDeep,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      auditActionLabel(item.action, item.entityType),
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: tt.text,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatDateTime(item.occurredAt),
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: tt.muted,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        if (_pageIndex < _totalPages) ...[
          const SizedBox(height: 14),
          TtButton(
            label: 'Xem thêm',
            variant: TtButtonVariant.secondary,
            isLoading: _isLoadingMore,
            expanded: true,
            onPressed: _loadMore,
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return TtCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.history_rounded,
                size: 18,
                color: tt.goldDeep,
              ),
              const SizedBox(width: 8),
              Text(
                'Lịch sử hoạt động',
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: tt.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildContent(context),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.05, end: 0, duration: 300.ms);
  }
}
