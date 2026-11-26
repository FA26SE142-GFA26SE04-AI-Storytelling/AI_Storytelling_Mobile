import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_text_field.dart';
import 'library_body.dart';
import 'library_providers.dart';
import 'library_shelf.dart';
import 'library_top_bar.dart';

/// Cờ "mở màn Tìm kiếm thì focus sẵn ô tìm" (bật từ nút 🔍 ở Trang chủ).
class SearchFocusRequest extends Notifier<bool> {
  @override
  bool build() => false;

  void request() => state = true;

  void consume() => state = false;
}

final searchFocusRequestProvider = NotifierProvider<SearchFocusRequest, bool>(
  SearchFocusRequest.new,
);

/// Màn Tìm kiếm (mở chồng từ Trang chủ, có nút quay lại): ô tìm theo tên, chip chủ đề (bấm lại để bỏ lọc), lưới kết quả.
/// Chưa gõ và chưa chọn chủ đề thì hiện "Tất cả truyện" có chip nguồn.
/// Dữ liệu dùng chung [libraryProvider] với Trang chủ.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _search = TextEditingController();
  final _focus = FocusNode();
  String? _topic;
  String _source = 'all';

  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) => _consumeFocus());
  }

  void _consumeFocus() {
    if (!mounted || !ref.read(searchFocusRequestProvider)) return;
    ref.read(searchFocusRequestProvider.notifier).consume();
    _focus.requestFocus();
  }

  void _clear() {
    _search.clear();
    setState(() => _topic = null);
  }

  @override
  void dispose() {
    _search.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    ref.listen(searchFocusRequestProvider, (_, next) {
      // Đợi khung sau: lúc này tab Tìm kiếm mới thật sự hiện ra.
      if (next) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _consumeFocus());
      }
    });
    final async = ref.watch(libraryProvider);
    final query = _search.text.trim();

    List<Widget> body(double side) {
      if (libraryStatusSlivers(ref, async, side) case final status?) {
        return status;
      }
      final s = async.value!.shelves;
      final Widget content;
      if (query.isEmpty && _topic == null) {
        content = LibraryShelf(
          title: 'Tất cả truyện',
          items: s.bySource(_source),
          side: side,
          grid: true,
          pills: librarySourcePills,
          selectedPill: _source,
          onPill: (id) => setState(() => _source = id),
          emptyText: 'Chưa có truyện nào trong nhóm này.',
        );
      } else {
        final results = s.filter(query, _topic);
        content = results.isEmpty
            ? SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: side),
                sliver: SliverToBoxAdapter(
                  child: TtEmptyState(
                    icon: Icons.search_off_rounded,
                    title: 'Không tìm thấy truyện phù hợp',
                    message:
                        'Bạn thử gõ tên ngắn hơn hoặc chọn chủ đề khác nhé.',
                    actionLabel: 'Xoá tìm kiếm',
                    onAction: _clear,
                  ),
                ),
              )
            : LibraryShelf(
                title: query.isEmpty ? 'Chủ đề: $_topic' : 'Kết quả tìm kiếm',
                items: results,
                side: side,
                grid: true,
              );
      }
      return [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 34,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: side),
              itemCount: s.topics.length,
              separatorBuilder: (_, _) => const SizedBox(width: 6),
              itemBuilder: (context, i) => libraryChip(
                context,
                label: s.topics[i],
                selected: s.topics[i] == _topic,
                onSelected: () => setState(
                  () => _topic = _topic == s.topics[i] ? null : s.topics[i],
                ),
              ),
            ),
          ).animate().fadeIn(duration: 260.ms),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
        content,
      ];
    }

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => refreshLibrary(context, ref),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverLayoutBuilder(
                builder: (context, constraints) {
                  // Nội dung rộng tối đa 960 (1200 nếu >= 1100), căn giữa trên màn rộng.
                  final maxW = constraints.crossAxisExtent >= 1100
                      ? 1200.0
                      : 960.0;
                  final side = math.max(
                    16.0,
                    (constraints.crossAxisExtent - maxW) / 2,
                  );
                  return SliverPadding(
                    padding: const EdgeInsets.only(bottom: 16),
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        PinnedHeaderSliver(
                          child: LibraryFrostedBar(
                            side: side,
                            child: Row(
                              children: [
                                TtIconButton(
                                  icon: Icons.arrow_back_rounded,
                                  tooltip: 'Quay lại',
                                  size: 40,
                                  onPressed: () => context.canPop()
                                      ? context.pop()
                                      : context.go(AppRoutes.home),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TtTextField(
                                    label: 'Tìm truyện',
                                    hint: 'Nhập tên truyện',
                                    hideLabel: true,
                                    prefixIcon: Icons.search_rounded,
                                    controller: _search,
                                    focusNode: _focus,
                                    textInputAction: TextInputAction.search,
                                  ),
                                ),
                                if (_search.text.isNotEmpty) ...[
                                  const SizedBox(width: 8),
                                  TtIconButton(
                                    icon: Icons.close_rounded,
                                    tooltip: 'Xoá tìm kiếm',
                                    size: 40,
                                    onPressed: _search.clear,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 4)),
                        ...body(side),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
