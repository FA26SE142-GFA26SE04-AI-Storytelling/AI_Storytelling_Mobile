import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/library_story_dto.dart';
import '../../events/presentation/event_home_banner.dart';
import '../data/library_logic.dart';
import 'library_banner.dart';
import 'library_providers.dart';
import 'library_shelf.dart';
import 'library_top_bar.dart';
import 'search_screen.dart';

const librarySourcePills = [
  ('all', 'Tất cả'),
  ('creator', 'Của creator'),
  ('ai', 'Do AI tạo'),
  ('manual', 'Nhập sẵn'),
  ('family', 'Tự soạn'),
];

/// Slivers cho lúc thư viện đang tải / lỗi / chưa có truyện; null khi đã có
/// truyện để hiện. Dùng chung cho Trang chủ và màn Tìm kiếm.
List<Widget>? libraryStatusSlivers(
  WidgetRef ref,
  AsyncValue<LibraryData> async,
  double side,
) {
  Widget padded(Widget child) => SliverPadding(
    padding: EdgeInsets.symmetric(horizontal: side),
    sliver: SliverToBoxAdapter(child: child),
  );
  final data = async.value;
  if (async.hasError && data == null) {
    final e = async.error;
    return [
      padded(
        TtErrorState(
          title: 'Chưa tải được thư viện truyện',
          message: e is ApiException
              ? e.message
              : 'Có lỗi xảy ra. Vui lòng thử lại.',
          onRetry: () => ref.invalidate(libraryProvider),
        ),
      ),
    ];
  }
  if (data == null) {
    return [
      padded(
        Column(
          children: [
            for (final h in const [34.0, 190.0, 170.0, 170.0]) ...[
              TtSkeleton(
                height: h,
                radius: const BorderRadius.all(Radius.circular(TtRadius.md)),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    ];
  }
  if (data.shelves.sorted.isEmpty) {
    return [
      padded(
        const TtEmptyState(
          icon: Icons.menu_book_rounded,
          title: 'Thư viện chưa có truyện',
        ),
      ),
    ];
  }
  return null;
}

/// Thư viện truyện ở Trang chủ phụ huynh (trả về sliver): thanh trên dính đầu
/// (tên app, nút tìm → màn Tìm kiếm, [trailing]), chip chủ đề, banner sự kiện,
/// banner truyện, các kệ;
/// "Xem thêm" mở lưới đầy đủ; bấm thẻ để xem trước. [side] là lề ngang của trang.
class LibraryBody extends ConsumerStatefulWidget {
  const LibraryBody({super.key, this.side = 16, this.trailing = const []});

  final double side;

  /// Widget đặt bên phải thanh trên, sau nút tìm (vd. chuông, avatar).
  final List<Widget> trailing;

  @override
  ConsumerState<LibraryBody> createState() => _LibraryBodyState();
}

class _LibraryBodyState extends ConsumerState<LibraryBody> {
  String _source = 'all';
  ({String title, List<LibraryStoryDto> items})? _expanded;

  void _expand(String title, List<LibraryStoryDto> items) =>
      setState(() => _expanded = (title: title, items: items));

  void _openSearch() {
    ref.read(searchFocusRequestProvider.notifier).request();
    context.push(AppRoutes.search);
  }

  Widget _topicChips(
    BuildContext context,
    List<String> topics,
    List<LibraryStoryDto> Function(String) byTopic,
  ) {
    final tt = context.tt;
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: widget.side),
        itemCount: topics.length,
        separatorBuilder: (_, _) => const SizedBox(width: 6),
        itemBuilder: (context, i) => ActionChip(
          label: Text(topics[i]),
          tooltip: 'Chủ đề ${topics[i]}',
          onPressed: () => _expand('Chủ đề: ${topics[i]}', byTopic(topics[i])),
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: tt.panel,
          labelStyle: Theme.of(context).textTheme.titleSmall
              ?.copyWith(fontSize: 13),
          side: BorderSide(color: tt.line2, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TtRadius.full),
          ),
        ),
      ),
    );
  }

  /// Hàng "Tác giả nổi bật" (như LibraryTopAuthors của web): tối đa 6 tác giả,
  /// bấm ô mở lưới truyện của tác giả đó.
  Widget _topAuthors(BuildContext context, LibraryShelves s) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final side = widget.side;
    final authors = s.authors.take(6).toList();
    final radius = BorderRadius.circular(TtRadius.md);
    Widget tile(LibraryAuthor a) => Semantics(
      button: true,
      label: 'Xem truyện của tác giả ${a.name}',
      excludeSemantics: true,
      onTap: () => _expand('Tác giả: ${a.name}', s.byAuthor(a.id)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: radius,
          onTap: () => _expand('Tác giả: ${a.name}', s.byAuthor(a.id)),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 180),
            padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
            decoration: BoxDecoration(
              color: tt.panel.withValues(alpha: 0.9),
              borderRadius: radius,
              border: Border.all(color: tt.line2, width: 1.2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: tt.gold,
                    shape: BoxShape.circle,
                    border: Border.all(color: tt.goldDeep, width: 1.2),
                  ),
                  child: Text(
                    a.name.characters.first.toUpperCase(),
                    maxLines: 1,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      // Nền vàng giống nhau ở hai theme nên chữ luôn tối.
                      color: TtColors.light.inkWarm,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        a.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleSmall?.copyWith(fontSize: 13),
                      ),
                      Text(
                        '${a.count} truyện',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 11.5,
                          color: tt.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: side),
          child: Row(
            children: [
              Icon(
                Icons.workspace_premium_rounded,
                color: tt.goldDeep,
                size: 20,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Tác giả nổi bật',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          // 60 ở cỡ chữ thường; giãn theo cỡ chữ để hai dòng chữ không tràn.
          height: 16 + MediaQuery.textScalerOf(context).scale(44),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context)
                .copyWith(scrollbars: false),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: side),
              itemCount: authors.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, i) => tile(authors[i]),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.04, end: 0);
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(libraryProvider);
    final side = widget.side;

    final List<Widget> slivers;
    if (libraryStatusSlivers(ref, async, side) case final status?) {
      slivers = status;
    } else if (_expanded case final e?) {
      slivers = [
        LibraryShelf(
          title: e.title,
          items: e.items,
          side: side,
          grid: true,
          onBack: () => setState(() => _expanded = null),
        ),
      ];
    } else {
      final data = async.value!;
      final s = data.shelves;
      final bySource = s.bySource(_source);
      slivers = [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (s.topics.isNotEmpty) ...[
                _topicChips(context, s.topics, s.byTopic),
                const SizedBox(height: 10),
              ],
              EventHomeBanner(side: side),
              if (s.banner.isNotEmpty) ...[
                Padding(
                  // Banner rộng hơn lề trang một chút để lộ mép banner kế bên.
                  padding: EdgeInsets.symmetric(horizontal: side - 16),
                  child: LibraryBanner(items: s.banner),
                ),
                const SizedBox(height: 14),
              ],
              if (s.authors.isNotEmpty) ...[
                _topAuthors(context, s),
                const SizedBox(height: 14),
              ],
            ],
          ),
        ),
        if (data.mostViewed.isNotEmpty)
          LibraryShelf(
            title: 'Đọc nhiều nhất',
            items: data.mostViewed,
            side: side,
            ranked: true,
            onAll: () => _expand('Đọc nhiều nhất', data.mostViewed),
          ),
        LibraryShelf(
          title: 'Mới nhất',
          items: s.latest,
          side: side,
          onAll: s.sorted.length > s.latest.length
              ? () => _expand('Mới nhất', s.sorted)
              : null,
        ),
        if (data.mostFavorited.isNotEmpty)
          LibraryShelf(
            title: 'Được yêu thích',
            items: data.mostFavorited,
            side: side,
            ranked: true,
            onAll: () => _expand('Được yêu thích', data.mostFavorited),
          ),
        if (s.inProgress.isNotEmpty)
          LibraryShelf(
            title: 'Đang chuẩn bị',
            items: s.inProgress,
            side: side,
            showStatus: true,
            onAll: () => _expand('Đang chuẩn bị', s.inProgress),
          ),
        LibraryShelf(
          title: 'Tất cả truyện',
          items: bySource,
          side: side,
          onAll: bySource.isEmpty
              ? null
              : () => _expand('Tất cả truyện', bySource),
          pills: librarySourcePills,
          selectedPill: _source,
          onPill: (id) => setState(() => _source = id),
          emptyText: 'Chưa có truyện nào trong nhóm này.',
        ),
      ];
    }

    // Đang mở "Xem thêm" thì nút Back của máy đóng lưới, không thoát trang.
    return PopScope(
      canPop: _expanded == null,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) setState(() => _expanded = null);
      },
      child: SliverMainAxisGroup(
        slivers: [
          PinnedHeaderSliver(
            child: LibraryTopBar(
              onOpenSearch: _openSearch,
              side: side,
              trailing: widget.trailing,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 4)),
          ...slivers,
        ],
      ),
    );
  }
}

/// Kéo làm mới thư viện; lỗi mà vẫn còn dữ liệu cũ thì giữ nguyên và báo toast.
Future<void> refreshLibrary(BuildContext context, WidgetRef ref) async {
  ref.invalidate(libraryProvider);
  try {
    await ref.read(libraryProvider.future);
  } catch (e) {
    if (context.mounted && ref.read(libraryProvider).hasValue) {
      showTtToast(
        context,
        e is ApiException ? e.message : 'Chưa làm mới được thư viện truyện.',
        type: TtToastType.error,
      );
    }
  }
}
