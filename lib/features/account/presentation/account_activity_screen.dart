import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/tt_colors.dart';
import 'package:ai_storytelling_mobile/core/theme/tt_radius.dart';
import 'package:ai_storytelling_mobile/core/utils/audit_labels.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_button.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_card.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_state_views.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_toast.dart';
import 'package:ai_storytelling_mobile/features/account/data/account_repository.dart';
import 'package:ai_storytelling_mobile/models/audit_log_entry_dto.dart';

/// Màn hình hiển thị lịch sử hoạt động của tài khoản (route: /account/activity).
class AccountActivityScreen extends ConsumerStatefulWidget {
  const AccountActivityScreen({super.key});

  @override
  ConsumerState<AccountActivityScreen> createState() =>
      _AccountActivityScreenState();
}

class _AccountActivityScreenState extends ConsumerState<AccountActivityScreen> {
  bool _isLoadingInitial = true;
  bool _isLoadingMore = false;
  Object? _initialError;

  final List<AuditLogEntryDto> _items = [];
  int _currentPage = 1;
  int _totalPages = 1;

  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  /// Trích xuất thông điệp lỗi chuẩn từ exception
  String _extractErrorMessage(Object error) {
    if (error is ApiException) {
      return error.message;
    }
    return 'Chưa kết nối được máy chủ. Bạn thử lại sau ít phút nhé.';
  }

  /// Định dạng ngày giờ dạng dd/MM/yyyy HH:mm theo giờ local
  String _formatDateTime(DateTime dt) {
    final local = dt.toLocal();
    final d = local.day.toString().padLeft(2, '0');
    final m = local.month.toString().padLeft(2, '0');
    final y = local.year.toString().padLeft(4, '0');
    final h = local.hour.toString().padLeft(2, '0');
    final min = local.minute.toString().padLeft(2, '0');
    return '$d/$m/$y $h:$min';
  }

  /// Tải dữ liệu trang đầu tiên
  Future<void> _loadInitial() async {
    setState(() {
      _isLoadingInitial = true;
      _initialError = null;
    });

    try {
      final result = await ref
          .read(accountRepositoryProvider)
          .accountAudit(pageIndex: 1);

      if (!mounted) return;
      setState(() {
        _items
          ..clear()
          ..addAll(result.items);
        _currentPage = 1;
        _totalPages = result.totalPages;
        _isLoadingInitial = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _initialError = e;
        _isLoadingInitial = false;
      });
    }
  }

  /// Làm mới danh sách và quay về trang 1
  Future<void> _onRefresh() async {
    try {
      final result = await ref
          .read(accountRepositoryProvider)
          .accountAudit(pageIndex: 1);

      if (!mounted) return;
      setState(() {
        _items
          ..clear()
          ..addAll(result.items);
        _currentPage = 1;
        _totalPages = result.totalPages;
        _initialError = null;
      });
    } catch (e) {
      if (mounted) {
        showTtToast(
          context,
          _extractErrorMessage(e),
          type: TtToastType.error,
        );
      }
    }
  }

  /// Tải thêm trang tiếp theo
  Future<void> _loadMore() async {
    if (_isLoadingMore || _currentPage >= _totalPages) return;

    setState(() => _isLoadingMore = true);

    try {
      final nextPage = _currentPage + 1;
      final result = await ref
          .read(accountRepositoryProvider)
          .accountAudit(pageIndex: nextPage);

      if (!mounted) return;
      setState(() {
        _items.addAll(result.items);
        _currentPage = nextPage;
        _totalPages = result.totalPages;
      });
    } catch (e) {
      if (mounted) {
        showTtToast(
          context,
          _extractErrorMessage(e),
          type: TtToastType.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Lịch sử hoạt động'),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: _buildBody(context),
          ),
        ),
      ),
    );
  }

  /// Điều hướng hiển thị theo trạng thái tải/lỗi/dữ liệu
  Widget _buildBody(BuildContext context) {
    if (_isLoadingInitial) {
      return _buildLoadingView();
    }
    if (_initialError != null) {
      return _buildErrorView(_initialError!);
    }
    return _buildDataView(context);
  }

  /// Giao diện danh sách hoạt động
  Widget _buildDataView(BuildContext context) {
    if (_items.isEmpty) {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: const [
            SizedBox(height: 60),
            TtEmptyState(
              icon: Icons.history_rounded,
              title: 'Chưa có hoạt động nào',
            ),
          ],
        ),
      );
    }

    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final hasMore = _currentPage < _totalPages;

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          ..._items.map((item) {
            final hasEntity = item.entityType.isNotEmpty;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TtCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      auditActionLabel(item.action, item.entityType),
                      style: textTheme.titleMedium?.copyWith(
                        color: tt.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (hasEntity) ...[
                      const SizedBox(height: 4),
                      Text(
                        auditEntityLabel(item.entityType),
                        style: textTheme.bodyMedium?.copyWith(
                          color: tt.muted,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      _formatDateTime(item.occurredAt),
                      style: textTheme.bodyMedium?.copyWith(
                        color: tt.muted,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          if (hasMore) ...[
            const SizedBox(height: 4),
            TtButton(
              label: 'Xem thêm',
              variant: TtButtonVariant.secondary,
              expanded: true,
              isLoading: _isLoadingMore,
              onPressed: _isLoadingMore ? null : _loadMore,
            ),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Giao diện tải lần đầu
  Widget _buildLoadingView() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, _) => const TtSkeleton(
        height: 80,
        radius: BorderRadius.all(Radius.circular(TtRadius.lg)),
      ),
    );
  }

  /// Giao diện khi xảy ra lỗi tải dữ liệu
  Widget _buildErrorView(Object error) {
    return Center(
      child: TtErrorState(
        message: _extractErrorMessage(error),
        onRetry: _loadInitial,
      ),
    );
  }
}
