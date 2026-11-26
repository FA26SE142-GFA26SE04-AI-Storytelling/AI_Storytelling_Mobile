import '../../../models/library_story_dto.dart';

/// Hàm thuần của thư viện, chép theo web (LibraryWorkspace.tsx, storyView.ts).

/// Nguồn truyện, dùng cho chip "Tất cả truyện" và dòng "Nguồn" khi xem trước.
const sourceLabels = {
  'creator': 'Của creator',
  'ai': 'Do AI tạo',
  'manual': 'Nhập sẵn',
  'family': 'Tự soạn',
};

/// Truyện có số lượt (viewCount/favoriteCount) là truyện lấy từ GET /Story/community.
extension LibraryStoryX on LibraryStoryDto {
  bool get isCreator => viewCount != null || favoriteCount != null;

  String get topic => (genre ?? '').trim().isEmpty ? 'Khác' : genre!.trim();

  // Thư viện không tải truyện tự soạn của gia đình nên không có nguồn 'family'.
  String get sourceKey => isCreator
      ? 'creator'
      : source.toLowerCase().contains('ai')
      ? 'ai'
      : 'manual';

  int get words {
    final t = (content ?? '').trim();
    return t.isEmpty ? 0 : t.split(RegExp(r'\s+')).length;
  }

  String get by => (authorName ?? '').trim().isEmpty ? 'Bạn' : authorName!;

  /// Truyện tạo trong 7 ngày gần [now] (nhãn "MỚI" trên thẻ).
  bool isNewAt(DateTime now) =>
      createdAt != null && now.difference(createdAt!).inDays < 7;

  /// `published`, hoặc trạng thái Backend đổi sang snake_case (MediaReview → media_review).
  String get statusKey => isPublished
      ? 'published'
      : (status.isEmpty ? 'draft' : status)
            .replaceAllMapped(
              RegExp('([a-z])([A-Z])'),
              (m) => '${m[1]}_${m[2]}',
            )
            .toLowerCase();

  /// Nhóm `ready` (sẵn sàng), `media` (đang chuẩn bị tranh/giọng đọc) hoặc `other`.
  String get statusGroup => const {'ready', 'published'}.contains(statusKey)
      ? 'ready'
      : const {
          'approved',
          'media_processing',
          'media_review',
        }.contains(statusKey)
      ? 'media'
      : 'other';

  String get statusLabel => switch (statusKey) {
    'approved' => 'Đã duyệt',
    'media_processing' => 'Đang tạo minh hoạ',
    'media_review' => 'Chờ xác nhận tranh',
    _ => 'Sẵn sàng',
  };
}

/// Số có dấu chấm ngăn hàng nghìn như web (toLocaleString vi-VN): 1234 → "1.234".
String groupThousands(int n) =>
    '$n'.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '.');

String ageLabel(String band) => switch (band) {
  'Age_6_8' => '6–8 tuổi',
  'Age_9_10' => '9–10 tuổi',
  '' => '',
  _ => '${band.replaceFirst(RegExp('^Age_'), '').replaceFirst('_', '–')} tuổi',
};

/// Gộp GET /Story và GET /Story/community theo id (bản community giữ số lượt),
/// chỉ giữ truyện đã công khai ở nhóm hiển thị, mới tạo xếp trước.
List<LibraryStoryDto> mergeLibrary(
  List<LibraryStoryDto> mine,
  List<LibraryStoryDto> community,
) {
  final byId = {for (final s in community) s.id: s};
  final ids = {for (final s in mine) s.id};
  final all = [
    for (final s in mine)
      byId[s.id] == null
          ? s
          : s.copyWith(
              viewCount: byId[s.id]!.viewCount ?? 0,
              favoriteCount: byId[s.id]!.favoriteCount ?? 0,
              hasQuiz: byId[s.id]!.hasQuiz ?? s.hasQuiz,
            ),
    for (final s in community)
      if (!ids.contains(s.id))
        s.copyWith(
          viewCount: s.viewCount ?? 0,
          favoriteCount: s.favoriteCount ?? 0,
        ),
  ];
  final epoch = DateTime.fromMillisecondsSinceEpoch(0);
  return all.where((s) => s.isPublished && s.statusGroup != 'other').toList()
    ..sort((a, b) => (b.createdAt ?? epoch).compareTo(a.createdAt ?? epoch));
}

const _vnFrom =
    'àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ';
const _vnTo =
    'aaaaaaaaaaaaaaaaaeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyd';

/// Chữ thường, bỏ dấu tiếng Việt để tìm "dem hoi" ra "Đêm Hội".
String foldVietnamese(String s) {
  final lower = s.toLowerCase();
  final out = StringBuffer();
  for (final ch in lower.split('')) {
    final i = _vnFrom.indexOf(ch);
    out.write(i < 0 ? ch : _vnTo[i]);
  }
  return out.toString();
}

/// Banner đầu trang (giống web): tối đa 5 truyện có ảnh bìa, trước hết theo bảng
/// xếp hạng yêu thích từ API ([ranked]), thiếu thì bù bằng truyện nhiều lượt yêu thích
/// rồi nhiều lượt đọc; bằng nhau thì truyện mới hơn trước (thứ tự của [sorted]).
List<LibraryStoryDto> bannerStories(
  List<LibraryStoryDto> ranked,
  List<LibraryStoryDto> sorted,
) {
  final order = {for (var i = 0; i < sorted.length; i++) sorted[i].id: i};
  final byCount = [...sorted]
    ..sort((a, b) {
      final fav = (b.favoriteCount ?? 0).compareTo(a.favoriteCount ?? 0);
      if (fav != 0) return fav;
      final views = (b.viewCount ?? 0).compareTo(a.viewCount ?? 0);
      return views != 0 ? views : order[a.id]!.compareTo(order[b.id]!);
    });
  final seen = <int>{};
  final out = <LibraryStoryDto>[];
  for (final s in [...ranked, ...byCount]) {
    if (out.length >= 5) break;
    if ((s.coverImageUrl ?? '').trim().isEmpty || !seen.add(s.id)) continue;
    out.add(s);
  }
  return out;
}

/// Mã tác giả cộng đồng (như communityAuthorKey của web): truyện creator đã công
/// khai có authorUserId > 0; còn lại null.
int? communityAuthorId(LibraryStoryDto s) =>
    s.isCreator && s.isPublished && (s.authorUserId ?? 0) > 0
    ? s.authorUserId
    : null;

typedef LibraryAuthor = ({int id, String name, int count});

/// Tác giả của truyện cộng đồng (như collectLibraryAuthors của web): bỏ tác giả
/// không có tên, nhiều truyện trước, bằng nhau thì theo tên.
List<LibraryAuthor> collectLibraryAuthors(List<LibraryStoryDto> stories) {
  final names = <int, String>{};
  final counts = <int, int>{};
  for (final s in stories) {
    final id = communityAuthorId(s);
    if (id == null) continue;
    if ((names[id] ?? '').isEmpty) names[id] = (s.authorName ?? '').trim();
    counts[id] = (counts[id] ?? 0) + 1;
  }
  return [
    for (final MapEntry(key: id, value: name) in names.entries)
      if (name.isNotEmpty) (id: id, name: name, count: counts[id]!),
  ]..sort((a, b) {
    final byCount = b.count.compareTo(a.count);
    if (byCount != 0) return byCount;
    final byName = foldVietnamese(a.name).compareTo(foldVietnamese(b.name));
    return byName != 0 ? byName : a.name.compareTo(b.name);
  });
}

/// Các kệ của thư viện, tính từ danh sách đã gộp ([sorted] mới trước).
class LibraryShelves {
  LibraryShelves(this.sorted, {List<LibraryStoryDto> ranked = const []})
    : latest = sorted.take(10).toList(),
      inProgress = sorted.where((s) => s.statusGroup == 'media').toList(),
      topics = sorted.map((s) => s.topic).toSet().toList(),
      banner = bannerStories(ranked, sorted),
      authors = collectLibraryAuthors(sorted);

  final List<LibraryStoryDto> sorted;
  final List<LibraryStoryDto> latest;
  final List<LibraryStoryDto> inProgress;
  final List<String> topics;

  /// Banner đầu trang: xem [bannerStories].
  final List<LibraryStoryDto> banner;

  /// Tác giả nổi bật: xem [collectLibraryAuthors].
  final List<LibraryAuthor> authors;

  /// Truyện của một tác giả cộng đồng, mới trước.
  List<LibraryStoryDto> byAuthor(int id) =>
      sorted.where((s) => communityAuthorId(s) == id).toList();

  List<LibraryStoryDto> byTopic(String? topic) =>
      sorted.where((s) => s.topic == topic).toList();

  List<LibraryStoryDto> bySource(String source) => source == 'all'
      ? sorted
      : sorted.where((s) => s.sourceKey == source).toList();

  List<LibraryStoryDto> search(String query) {
    final needle = foldVietnamese(query.trim());
    return sorted
        .where((s) => foldVietnamese(s.title).contains(needle))
        .toList();
  }

  /// Tìm theo tên, thêm lọc theo chủ đề khi [topic] khác null.
  List<LibraryStoryDto> filter(String query, String? topic) =>
      search(query).where((s) => topic == null || s.topic == topic).toList();
}

/// Một trang khi xem trước: chữ, tranh và giọng đọc (đã sẵn sàng) của cảnh đó.
typedef PreviewPage = ({String text, List<String> images, List<String> audio});

/// Tách nội dung thành các cảnh: theo đoạn; nếu chỉ có một đoạn thì gom mỗi 3 câu.
List<String> splitScenes(String content) {
  final paragraphs = content
      .split(RegExp(r'\n\s*\n'))
      .map((p) => p.trim())
      .where((p) => p.isNotEmpty)
      .toList();
  if (paragraphs.length > 1) return paragraphs;
  final sentences =
      RegExp(
            r'[^.!?…]+[.!?…]+["”'
            "'"
            r']?\s*|[^.!?…]+$',
          )
          .allMatches(paragraphs.isEmpty ? '' : paragraphs.first)
          .map((m) => m[0]!)
          .toList();
  return [
    for (var i = 0; i < sentences.length; i += 3)
      sentences.skip(i).take(3).join().trim(),
  ].where((s) => s.isNotEmpty).toList();
}

/// Ghép nội dung với gói media như hàm Preview của web; không có cảnh thì chỉ hiện chữ.
List<PreviewPage> previewPages(String content, StoryMediaPackageDto? pack) {
  final texts = splitScenes(content);
  final scenes = [...?pack?.scenes]
    ..sort((a, b) => a.sceneIndex.compareTo(b.sceneIndex));
  if (scenes.isEmpty) {
    return [
      for (final t in texts) (text: t, images: const [], audio: const []),
    ];
  }
  return [
    for (var i = 0; i < scenes.length; i++)
      () {
        final scene = scenes[i];
        final audio = [...scene.audio]
          ..sort((a, b) => a.segmentOrder.compareTo(b.segmentOrder));
        final images = [...scene.illustrations]
          ..sort((a, b) => a.beatOrder.compareTo(b.beatOrder));
        final spoken = audio.map((a) => a.text).join(' ').trim();
        final own = (scene.text ?? '').trim();
        return (
          text: own.isNotEmpty
              ? own
              : spoken.isNotEmpty
              ? spoken
              : (i < texts.length ? texts[i] : ''),
          images: [
            for (final x in images)
              if (x.status == 'Ready' && (x.url ?? '').isNotEmpty) x.url!,
          ],
          audio: [
            for (final a in audio)
              if (a.status == 'Ready' && (a.url ?? '').isNotEmpty) a.url!,
          ],
        );
      }(),
  ];
}
