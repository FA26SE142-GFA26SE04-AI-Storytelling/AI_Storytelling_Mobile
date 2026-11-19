import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../models/library_story_dto.dart';
import 'library_story_card.dart';

const _gap = 10.0;
const _rowCardWidth = 104.0;
const _gridMaxWidth = 130.0;

/// Một kệ truyện (sliver), không khung: tiêu đề + "Xem thêm ›" (hoặc nút
/// Quay lại), chip chọn, rồi hàng ngang cuộn sát mép màn hoặc lưới thẻ.
/// [side] là lề ngang của trang; hàng ngang cuộn tràn qua lề này.
class LibraryShelf extends StatelessWidget {
  const LibraryShelf({
    super.key,
    required this.title,
    required this.items,
    this.side = 16,
    this.grid = false,
    this.ranked = false,
    this.showStatus = false,
    this.onAll,
    this.onBack,
    this.pills,
    this.selectedPill,
    this.onPill,
    this.emptyText,
    this.maxRows,
  });

  /// Lưới nhiều hơn số hàng này thì giới hạn chiều cao và cuộn bên trong kệ.
  final int? maxRows;

  final String title;
  final List<LibraryStoryDto> items;
  final double side;
  final bool grid;
  final bool ranked;
  final bool showStatus;
  final VoidCallback? onAll;
  final VoidCallback? onBack;

  /// Danh sách (id, nhãn) của chip chọn; null thì không có chip.
  final List<(String, String)>? pills;
  final String? selectedPill;
  final ValueChanged<String>? onPill;

  /// Câu hiện khi kệ dạng lưới không có truyện nào.
  final String? emptyText;

  Widget _card(int i) => LibraryStoryCard(
    key: ValueKey('lib-${items[i].id}'),
    story: items[i],
    rank: ranked ? i + 1 : null,
    showStatus: showStatus,
  );

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;

    final header = Padding(
      padding: EdgeInsets.symmetric(horizontal: side),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              if (onBack != null) ...[
                TtIconButton(
                  icon: Icons.arrow_back_rounded,
                  tooltip: 'Quay lại thư viện',
                  size: 36,
                  onPressed: onBack,
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(fontSize: 18),
                ),
              ),
              if (onAll != null)
                Semantics(
                  button: true,
                  label: 'Xem thêm $title',
                  excludeSemantics: true,
                  onTap: onAll,
                  child: InkWell(
                    onTap: onAll,
                    borderRadius: BorderRadius.circular(TtRadius.xs),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Xem thêm',
                            style: textTheme.labelLarge?.copyWith(
                              fontSize: 13,
                              color: tt.primaryStrong,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 18,
                            color: tt.primaryStrong,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (pills != null && pills!.isNotEmpty) ...[
            const SizedBox(height: 6),
            // Xuống dòng thay vì cuộn ngang để không chip nào bị che mất.
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final (id, label) in pills!)
                  libraryChip(
                    context,
                    label: label,
                    selected: id == selectedPill,
                    onSelected: () => onPill?.call(id),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 6),
        ],
      ),
    ).animate().fadeIn(duration: 280.ms);

    final Widget content;
    if (items.isEmpty) {
      content = SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            emptyText ?? '',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(color: tt.muted),
          ),
        ),
      );
    } else if (grid) {
      content = SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: side),
        sliver: SliverLayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.crossAxisExtent;
            final cols = math.max(
              3,
              ((w + _gap) / (_gridMaxWidth + _gap)).ceil(),
            );
            final cardWidth = (w - _gap * (cols - 1)) / cols;
            final cardHeight = libraryCardHeight(context, cardWidth);
            final delegate = SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: _gap,
              mainAxisSpacing: _gap,
              mainAxisExtent: cardHeight,
            );
            Widget cell(BuildContext context, int i) =>
                _card(i)
                    .animate(delay: (math.min(i, 8) * 30).ms)
                    .fadeIn(duration: 260.ms)
                    .slideY(begin: 0.06, end: 0, duration: 260.ms);
            final rows = (items.length / cols).ceil();
            if (maxRows case final max? when rows > max) {
              // Lộ thêm nửa hàng để người dùng thấy còn truyện bên dưới.
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: (max + 0.5) * (cardHeight + _gap),
                  // Không hiện thanh cuộn; nửa hàng lộ ra đã báo còn truyện.
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: GridView.builder(
                      primary: false,
                      gridDelegate: delegate,
                      itemCount: items.length,
                      itemBuilder: cell,
                    ),
                  ),
                ),
              );
            }
            return SliverGrid(
              gridDelegate: delegate,
              delegate: SliverChildBuilderDelegate(
                cell,
                childCount: items.length,
              ),
            );
          },
        ),
      );
    } else {
      content = SliverToBoxAdapter(
        child:
            SizedBox(
                  height: libraryCardHeight(context, _rowCardWidth),
                  // Không hiện thanh cuộn (web/desktop tự thêm); thẻ lộ mép đã báo cuộn được.
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: side),
                      itemCount: items.length,
                      separatorBuilder: (_, _) => const SizedBox(width: _gap),
                      itemBuilder: (context, i) =>
                          SizedBox(width: _rowCardWidth, child: _card(i)),
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 320.ms)
                .slideX(
                  begin: 0.04,
                  end: 0,
                  duration: 320.ms,
                  curve: Curves.easeOut,
                ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 12),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(child: header),
          content,
        ],
      ),
    );
  }
}

/// Chip chọn của thư viện (chip nguồn, chip chủ đề ở Tìm kiếm): đang chọn thì vàng.
Widget libraryChip(
  BuildContext context, {
  required String label,
  required bool selected,
  required VoidCallback onSelected,
}) {
  final tt = context.tt;
  return ChoiceChip(
    label: Text(label),
    selected: selected,
    showCheckmark: false,
    visualDensity: VisualDensity.compact,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    onSelected: (_) => onSelected(),
    selectedColor: tt.gold,
    backgroundColor: tt.panel,
    labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
      fontSize: 13,
      // Nền vàng giống nhau ở hai theme nên chữ luôn tối.
      color: selected ? TtColors.light.inkWarm : tt.text,
    ),
    side: BorderSide(color: selected ? tt.goldDeep : tt.line2, width: 1.2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TtRadius.full),
    ),
  );
}
