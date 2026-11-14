import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_reading_dto.dart';

/// Hiển thị modal bottom sheet tra từ vựng cho bé trong khi đọc truyện.
Future<void> showKidVocabSheet(
  BuildContext context, {
  required String term,
  required Future<VocabularyDefinition> Function() loadDefinition,
  required Future<void> Function() onCollect,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: context.tt.panel,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(TtRadius.xl),
      ),
    ),
    builder: (sheetContext) => _KidVocabSheetContent(
      term: term,
      loadDefinition: loadDefinition,
      onCollect: onCollect,
    ),
  );
}

class _KidVocabSheetContent extends StatefulWidget {
  const _KidVocabSheetContent({
    required this.term,
    required this.loadDefinition,
    required this.onCollect,
  });

  final String term;
  final Future<VocabularyDefinition> Function() loadDefinition;
  final Future<void> Function() onCollect;

  @override
  State<_KidVocabSheetContent> createState() => _KidVocabSheetContentState();
}

class _KidVocabSheetContentState extends State<_KidVocabSheetContent> {
  bool _isLoading = true;
  String? _errorMessage;
  VocabularyDefinition? _definition;
  bool _isCollecting = false;
  bool _isCollected = false;

  @override
  void initState() {
    super.initState();
    _fetchDefinition();
  }

  Future<void> _fetchDefinition() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await widget.loadDefinition();
      if (!mounted) return;
      setState(() {
        _definition = result;
        _isCollected = result.isCollected;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Không thể tải lời giải nghĩa của từ. Bé thử lại nhé!';
        _isLoading = false;
      });
    }
  }

  Future<void> _handleCollect() async {
    if (_isCollecting) return;

    setState(() {
      _isCollecting = true;
    });

    try {
      await widget.onCollect();
      if (!mounted) return;
      setState(() {
        _isCollecting = false;
        _isCollected = true;
      });
      showTtToast(
        context,
        'Đã cất từ vào sổ tay',
        type: TtToastType.success,
      );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isCollecting = false;
      });
      showTtToast(
        context,
        'Chưa thể cất từ lúc này. Bé thử lại nhé!',
        type: TtToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: 20 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tay kéo (drag handle)
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: tt.line2,
                  borderRadius: BorderRadius.circular(TtRadius.full),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Tiêu đề từ vựng nổi bật (Baloo 2)
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: tt.gold.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(TtRadius.md),
                  ),
                  child: Icon(
                    Icons.auto_stories_rounded,
                    color: tt.goldDeep,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.term,
                    style: TextStyle(
                      fontFamily: 'Baloo2',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: tt.text,
                      height: 1.25,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Trạng thái nội dung: Loading, Error hoặc Definition
            if (_isLoading) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: tt.surface,
                  borderRadius: BorderRadius.circular(TtRadius.lg),
                  border: Border.all(color: tt.line, width: 1.2),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TtSkeleton(width: double.infinity, height: 16),
                    SizedBox(height: 10),
                    TtSkeleton(width: double.infinity, height: 16),
                    SizedBox(height: 10),
                    TtSkeleton(width: 160, height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const TtButton(
                label: 'Cất vào sổ tay',
                icon: Icons.bookmark_add_rounded,
                onPressed: null,
                expanded: true,
              ),
            ] else if (_errorMessage != null) ...[
              TtErrorState(
                title: 'Có lỗi xảy ra',
                message: _errorMessage!,
                retryLabel: 'Thử lại',
                onRetry: _fetchDefinition,
              ),
            ] else ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: tt.surface,
                  borderRadius: BorderRadius.circular(TtRadius.lg),
                  border: Border.all(color: tt.line, width: 1.2),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 260),
                  child: SingleChildScrollView(
                    child: Text(
                      _definition?.definition.trim() ?? '',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        height: 1.5,
                        color: tt.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Nút hành động chính
              if (_isCollected)
                const TtButton(
                  label: 'Đã có trong sổ tay',
                  icon: Icons.bookmark_added_rounded,
                  variant: TtButtonVariant.secondary,
                  onPressed: null,
                  expanded: true,
                )
              else
                TtButton(
                  label: 'Cất vào sổ tay',
                  icon: Icons.bookmark_add_rounded,
                  variant: TtButtonVariant.primary,
                  isLoading: _isCollecting,
                  expanded: true,
                  onPressed: _handleCollect,
                ),
            ],
          ],
        ),
      ),
    );
  }
}
