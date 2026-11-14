import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_confirm_dialog.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_reading_dto.dart';
import '../data/kid_rewards_repository.dart';

/// Màn hình Sổ tay từ vựng lưu trữ các từ mới bé đã thu thập khi đọc truyện.
class KidNotebookScreen extends ConsumerStatefulWidget {
  const KidNotebookScreen({super.key});

  @override
  ConsumerState<KidNotebookScreen> createState() => _KidNotebookScreenState();
}

class _KidNotebookScreenState extends ConsumerState<KidNotebookScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  List<NotebookEntry> _entries = [];
  final Set<int> _deletingIds = {};

  @override
  void initState() {
    super.initState();
    _fetchNotebook();
  }

  Future<void> _fetchNotebook() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final items = await ref.read(kidRewardsRepositoryProvider).notebook();
      if (!mounted) return;
      setState(() {
        _entries = items;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      final message = e is ApiException
          ? e.message
          : 'Không thể tải sổ tay từ vựng. Vui lòng thử lại sau.';
      setState(() {
        _errorMessage = message;
        _isLoading = false;
      });
    }
  }

  Future<void> _onDeleteEntry(NotebookEntry entry) async {
    if (_deletingIds.contains(entry.entryId)) return;

    final confirmed = await showConfirmDialog(
      context,
      title: 'Xoá từ vựng',
      message: 'Bé có chắc muốn xoá từ "${entry.term}" khỏi sổ tay không?',
      confirmLabel: 'Xoá',
      cancelLabel: 'Giữ lại',
      destructive: true,
    );

    if (!confirmed || !mounted) return;

    setState(() {
      _deletingIds.add(entry.entryId);
    });

    try {
      await ref
          .read(kidRewardsRepositoryProvider)
          .removeNotebookEntry(entry.entryId);

      if (!mounted) return;
      setState(() {
        _entries.removeWhere((item) => item.entryId == entry.entryId);
        _deletingIds.remove(entry.entryId);
      });
      showTtToast(
        context,
        'Đã xoá từ "${entry.term}" khỏi sổ tay',
        type: TtToastType.success,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _deletingIds.remove(entry.entryId);
      });
      final message = e is ApiException
          ? e.message
          : 'Không thể xoá từ vựng. Vui lòng thử lại.';
      showTtToast(context, message, type: TtToastType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(tt),
            Expanded(child: _buildBody(tt)),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(TtColors tt) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          Material(
            color: tt.panel,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/kid');
                }
              },
              customBorder: const CircleBorder(),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: tt.line2, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: tt.shadow.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.arrow_back_rounded, color: tt.text, size: 24),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Sổ tay từ vựng',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: tt.text),
            ),
          ),
          if (!_isLoading && _errorMessage == null && _entries.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: tt.gold.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(TtRadius.full),
                border: Border.all(
                  color: tt.goldDeep.withValues(alpha: 0.35),
                  width: 1,
                ),
              ),
              child: Text(
                '${_entries.length} từ',
                style: Theme.of(context).textTheme.labelMedium
                    ?.copyWith(fontWeight: FontWeight.bold, color: tt.goldDeep),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBody(TtColors tt) {
    if (_isLoading) {
      return _buildLoadingState(tt);
    }

    if (_errorMessage != null) {
      return TtErrorState(
        title: 'Chưa thể tải sổ tay',
        message: _errorMessage!,
        onRetry: _fetchNotebook,
      );
    }

    if (_entries.isEmpty) {
      return _buildEmptyState(tt);
    }

    return RefreshIndicator(
      onRefresh: _fetchNotebook,
      color: tt.primary,
      backgroundColor: tt.panel,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _entries.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final entry = _entries[index];
          return _buildEntryCard(entry, index, tt);
        },
      ),
    );
  }

  Widget _buildEntryCard(NotebookEntry entry, int index, TtColors tt) {
    final isDeleting = _deletingIds.contains(entry.entryId);

    return Opacity(
          opacity: isDeleting ? 0.5 : 1.0,
          child: TtCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: tt.gold.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(TtRadius.sm),
                      ),
                      child: Icon(
                        Icons.star_rounded,
                        size: 20,
                        color: tt.goldDeep,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        entry.term,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: tt.text,
                            ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (isDeleting)
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: Center(
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: tt.danger,
                            ),
                          ),
                        ),
                      )
                    else
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: tt.muted,
                          size: 22,
                        ),
                        tooltip: 'Xoá từ vựng',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                        onPressed: () => _onDeleteEntry(entry),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  entry.definition,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: tt.inkWarm, height: 1.45),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.auto_stories_rounded, size: 14, color: tt.muted),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        entry.storyTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: tt.muted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 350.ms, delay: (index * 40).clamp(0, 400).ms)
        .slideY(begin: 0.05, end: 0, duration: 350.ms, curve: Curves.easeOut);
  }

  Widget _buildLoadingState(TtColors tt) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, _) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: tt.panel,
          borderRadius: BorderRadius.circular(TtRadius.lg),
          border: Border.all(color: tt.line2, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TtSkeleton(
                  width: 32,
                  height: 32,
                  radius: BorderRadius.circular(TtRadius.sm),
                ),
                const SizedBox(width: 10),
                const TtSkeleton(width: 140, height: 20),
                const Spacer(),
                const TtSkeleton(width: 24, height: 24),
              ],
            ),
            const SizedBox(height: 14),
            const TtSkeleton(height: 16),
            const SizedBox(height: 8),
            const TtSkeleton(width: 220, height: 16),
            const SizedBox(height: 14),
            const TtSkeleton(width: 130, height: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(TtColors tt) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TtFrog(mood: TtFrogMood.idle, size: 130),
            const SizedBox(height: 20),
            Text(
              'Đọc truyện và cất từ mới vào sổ tay nhé',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: tt.muted, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}
