import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/library_story_dto.dart';
import '../data/library_logic.dart';
import '../data/library_repository.dart';

/// Dữ liệu của thư viện: các kệ theo danh sách đã gộp và hai kệ xếp hạng.
class LibraryData {
  const LibraryData({
    required this.shelves,
    required this.mostViewed,
    required this.mostFavorited,
  });

  final LibraryShelves shelves;
  final List<LibraryStoryDto> mostViewed;
  final List<LibraryStoryDto> mostFavorited;
}

/// Tải lần lượt mọi trang (mỗi trang tối đa 100 truyện, giới hạn của Backend).
Future<List<LibraryStoryDto>> _allPages(
  Future<LibraryStoryPageDto> Function(int pageIndex) fetch,
) async {
  final items = <LibraryStoryDto>[];
  for (var i = 1; i <= 50; i++) {
    final page = await fetch(i);
    items.addAll(page.items);
    if (page.items.isEmpty ||
        !page.hasNextPage ||
        items.length >= page.totalCount) {
      break;
    }
  }
  return items;
}

/// Hai kệ xếp hạng; lỗi thì ẩn kệ (như web), không chặn cả thư viện.
Future<List<LibraryStoryDto>> _ranked(
  LibraryRepository repo,
  String orderBy,
  int? Function(LibraryStoryDto) count,
) async {
  try {
    final page = await repo.community(pageSize: 10, orderBy: orderBy);
    return page.items.where((s) => (count(s) ?? 0) > 0).toList();
  } catch (_) {
    return const [];
  }
}

final libraryProvider = FutureProvider.autoDispose<LibraryData>((ref) async {
  final repo = ref.watch(libraryRepositoryProvider);
  final results = await Future.wait<List<LibraryStoryDto>>([
    _allPages((i) => repo.stories(pageIndex: i)),
    _allPages((i) => repo.community(pageIndex: i)),
    _ranked(repo, 'views', (s) => s.viewCount),
    _ranked(repo, 'favorites', (s) => s.favoriteCount),
  ]);
  return LibraryData(
    shelves: LibraryShelves(mergeLibrary(results[0], results[1])),
    mostViewed: results[2],
    mostFavorited: results[3],
  );
});

/// Các trang xem trước của một truyện. Lỗi tải nội dung thì báo lỗi;
/// lỗi gói media thì vẫn hiện chữ.
final storyPreviewProvider = FutureProvider.autoDispose
    .family<List<PreviewPage>, ({int id, bool creator})>((ref, arg) async {
      final repo = ref.watch(libraryRepositoryProvider);
      final results = await Future.wait<Object?>([
        repo.story(arg.id).then((s) => s.content ?? ''),
        repo
            .media(arg.id, creator: arg.creator)
            .then<Object?>((p) => p, onError: (_) => null),
      ]);
      return previewPages(
        results[0] as String,
        results[1] as StoryMediaPackageDto?,
      );
    });
