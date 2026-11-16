import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/child_roadmap_dto.dart';
import '../../../models/parent_reading_feedback_dto.dart';
import '../../../models/parent_story_summary_dto.dart';
import '../../../models/story_wish_dto.dart';
import '../../home/data/home_repository.dart';
import '../data/learning_repository.dart';

const learningPageSize = 20;

/// Một danh sách đánh số trang đã tải tới trang [page].
class PagedItems<T> {
  const PagedItems({
    required this.items,
    required this.totalCount,
    required this.page,
    required this.hasNext,
  });

  final List<T> items;
  final int totalCount;
  final int page;
  final bool hasNext;
}

/// Tải trang 1 khi mở, [loadMore] nối trang kế (trang đánh số từ 1 như Backend).
abstract class PagedNotifier<T> extends AsyncNotifier<PagedItems<T>> {
  PagedNotifier(this.childId);

  final int childId;
  bool _loadingMore = false;

  Future<({List<T> items, int total, bool hasNext})> fetchPage(int page);

  @override
  Future<PagedItems<T>> build() async {
    final r = await fetchPage(1);
    return PagedItems(
      items: r.items,
      totalCount: r.total,
      page: 1,
      hasNext: r.hasNext,
    );
  }

  /// Lỗi được ném lại để màn hiện nút thử lại; danh sách đã tải giữ nguyên.
  Future<void> loadMore() async {
    final cur = state.value;
    if (cur == null || !cur.hasNext || _loadingMore) return;
    _loadingMore = true;
    try {
      final r = await fetchPage(cur.page + 1);
      // Bỏ kết quả nếu danh sách vừa được tải lại từ đầu.
      if (!ref.mounted || !identical(state.value, cur)) return;
      state = AsyncData(PagedItems(
        items: [...cur.items, ...r.items],
        totalCount: r.total,
        page: cur.page + 1,
        hasNext: r.hasNext,
      ));
    } finally {
      _loadingMore = false;
    }
  }
}

class ReadingFeedbackNotifier
    extends PagedNotifier<ParentReadingFeedbackItemDto> {
  ReadingFeedbackNotifier(super.childId);

  @override
  Future<({List<ParentReadingFeedbackItemDto> items, int total, bool hasNext})>
      fetchPage(int page) async {
    final r = await ref.read(homeRepositoryProvider).fetchReadingFeedback(
          childId,
          pageIndex: page,
          pageSize: learningPageSize,
        );
    return (items: r.items, total: r.totalCount, hasNext: r.hasNextPage);
  }
}

class StorySummariesNotifier extends PagedNotifier<ParentStorySummaryItemDto> {
  StorySummariesNotifier(super.childId);

  @override
  Future<({List<ParentStorySummaryItemDto> items, int total, bool hasNext})>
      fetchPage(int page) async {
    final r = await ref.read(learningRepositoryProvider).fetchSummaries(
          childId,
          pageIndex: page,
          pageSize: learningPageSize,
        );
    return (items: r.items, total: r.totalCount, hasNext: r.hasNextPage);
  }
}

/// Truyện bé đã đọc xong (Tổng quan dùng chung trang 1).
final readingFeedbackProvider = AsyncNotifierProvider.autoDispose.family<
    ReadingFeedbackNotifier,
    PagedItems<ParentReadingFeedbackItemDto>,
    int>(ReadingFeedbackNotifier.new);

/// Phần bé kể lại cuối truyện.
final storySummariesProvider = AsyncNotifierProvider.autoDispose.family<
    StorySummariesNotifier,
    PagedItems<ParentStorySummaryItemDto>,
    int>(StorySummariesNotifier.new);

/// Lộ trình của bé; null khi bé chưa có lộ trình.
final learningRoadmapProvider =
    FutureProvider.autoDispose.family<ChildRoadmapDto?, int>(
  (ref, childId) => ref.watch(homeRepositoryProvider).fetchRoadmap(childId),
);

/// Mọi điều ước bé đã gửi.
final learningWishesProvider =
    FutureProvider.autoDispose.family<List<ParentWish>, int>(
  (ref, childId) => ref.watch(learningRepositoryProvider).fetchWishes(childId),
);

/// Ảnh bìa truyện; lỗi thì trả null để hiện bìa mặc định.
final storyCoverProvider =
    FutureProvider.autoDispose.family<String?, int>((ref, storyId) async {
  // Giữ lại để đổi bé / đổi tab không gọi lại /Story/{id}; kéo tải lại (LearningTabList) thì lấy mới.
  ref.keepAlive();
  try {
    return await ref.watch(learningRepositoryProvider).fetchStoryCover(storyId);
  } catch (_) {
    return null;
  }
});
