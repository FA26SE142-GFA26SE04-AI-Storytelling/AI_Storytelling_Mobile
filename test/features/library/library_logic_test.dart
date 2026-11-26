import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/features/library/data/library_logic.dart';
import 'package:ai_storytelling_mobile/models/library_story_dto.dart';

LibraryStoryDto _s(
  int id, {
  int day = 1,
  bool published = true,
  String genre = 'Phiêu lưu',
  String source = 'AiGenerated',
  int? views,
  int? favs,
  String? cover,
}) => LibraryStoryDto(
  id: id,
  title: 'Truyện $id',
  genre: genre,
  source: source,
  status: 'Ready',
  isPublished: published,
  createdAt: DateTime(2026, 1, day),
  viewCount: views,
  favoriteCount: favs,
  coverImageUrl: cover,
);

void main() {
  bannerAndNewTests();
  group('mergeLibrary', () {
    test('gộp theo id, giữ số lượt của bản community, bỏ truyện chưa công khai, mới trước', () {
      final merged = mergeLibrary(
        [_s(1, day: 1), _s(2, day: 3), _s(3, day: 5, published: false)],
        [_s(2, day: 3, views: 7), _s(4, day: 2, views: 0)],
      );
      expect(merged.map((s) => s.id), [2, 4, 1]);
      expect(merged.first.viewCount, 7);
      expect(merged.first.sourceKey, 'creator');
      expect(merged.last.sourceKey, 'ai');
    });

    test('giữ hasQuiz của bản community', () {
      final merged = mergeLibrary(
        [_s(1, day: 1), _s(2, day: 2)],
        [
          _s(1, day: 1, views: 1).copyWith(hasQuiz: true),
          _s(3, day: 3, views: 0).copyWith(hasQuiz: false),
        ],
      );
      expect(
        {for (final s in merged) s.id: s.hasQuiz},
        {3: false, 2: null, 1: true},
      );
    });

    test('DTO đọc hasQuiz true/false, thiếu trường thì null', () {
      LibraryStoryDto parse(Map<String, dynamic> extra) =>
          LibraryStoryDto.fromJson({'id': 1, ...extra});
      expect(parse({'hasQuiz': true}).hasQuiz, isTrue);
      expect(parse({'hasQuiz': false}).hasQuiz, isFalse);
      expect(parse({}).hasQuiz, isNull);
    });

    test('groupThousands', () {
      expect(groupThousands(7), '7');
      expect(groupThousands(1234), '1.234');
      expect(groupThousands(1234567), '1.234.567');
    });

    test('gộp lại cùng dữ liệu không nhân đôi', () {
      final a = [_s(1), _s(2)];
      expect(mergeLibrary(a, a).length, 2);
    });
  });

  test('LibraryShelves: 10 mới nhất, chủ đề, nguồn, tìm không phân biệt hoa thường', () {
    final sorted = mergeLibrary([
      for (var i = 1; i <= 12; i++)
        _s(
          i,
          day: i,
          genre: i.isEven ? 'Tình bạn' : '',
          source: i == 3 ? 'Manual' : 'Ai',
        ),
    ], const []);
    final shelves = LibraryShelves(sorted);
    expect(shelves.latest.length, 10);
    expect(shelves.latest.first.id, 12);
    expect(shelves.topics, ['Tình bạn', 'Khác']);
    expect(shelves.byTopic('Khác').every((s) => s.id.isOdd), isTrue);
    expect(shelves.bySource('manual').single.id, 3);
    expect(shelves.inProgress, isEmpty);
    expect(shelves.search('TRUYỆN 1').map((s) => s.id), [12, 11, 10, 1]);
    expect(shelves.filter('truyện 1', 'Tình bạn').map((s) => s.id), [12, 10]);
    expect(shelves.filter('', 'Khác').every((s) => s.id.isOdd), isTrue);
  });

  test('collectLibraryAuthors: chỉ truyện creator đã công khai có id > 0 và tên; nhiều truyện trước rồi theo tên', () {
    LibraryStoryDto a(
      int id,
      int? user,
      String? name, {
      bool creator = true,
      bool published = true,
    }) => _s(
      id,
      day: id,
      published: published,
      views: creator ? 1 : null,
    ).copyWith(authorUserId: user, authorName: name);
    final stories = [
      a(1, 10, 'Ánh'),
      a(2, 20, ' Bình '),
      a(3, 20, 'Bình'),
      a(4, 30, 'An'),
      a(5, 30, 'An'),
      a(6, 40, 'Đức'),
      a(7, 50, 'Không creator', creator: false),
      a(8, 60, 'Chưa công khai', published: false),
      a(9, null, 'Không id'),
      a(10, 0, 'Id 0'),
      a(11, 70, '  '),
      a(12, 80, null),
    ];
    expect(collectLibraryAuthors(stories), [
      (id: 30, name: 'An', count: 2),
      (id: 20, name: 'Bình', count: 2),
      (id: 10, name: 'Ánh', count: 1),
      (id: 40, name: 'Đức', count: 1),
    ]);
    final shelves = LibraryShelves(mergeLibrary(const [], stories));
    expect(shelves.authors.first.id, 30);
    expect(shelves.byAuthor(30).map((s) => s.id), [5, 4]);
    expect(shelves.byAuthor(60), isEmpty);
    expect(
      LibraryStoryDto.fromJson({'id': 1, 'authorUserId': 7}).authorUserId,
      7,
    );
  });

  test('splitScenes: theo đoạn, một đoạn thì gom 3 câu', () {
    expect(splitScenes('A.\n\nB.'), ['A.', 'B.']);
    expect(splitScenes('Một. Hai! Ba? Bốn.'), ['Một. Hai! Ba?', 'Bốn.']);
    expect(splitScenes(''), isEmpty);
  });

  test('previewPages: xếp cảnh, chỉ lấy media Ready, chữ dự phòng', () {
    const pack = StoryMediaPackageDto(
      scenes: [
        MediaSceneDto(
          sceneIndex: 1,
          audio: [
            MediaAudioDto(
              segmentOrder: 1,
              text: 'b',
              status: 'Ready',
              url: 'a2',
            ),
            MediaAudioDto(
              segmentOrder: 0,
              text: 'a',
              status: 'Ready',
              url: 'a1',
            ),
          ],
        ),
        MediaSceneDto(
          sceneIndex: 0,
          text: 'Cảnh đầu',
          illustrations: [
            MediaIllustrationDto(beatOrder: 1, status: 'Ready', url: 'i2'),
            MediaIllustrationDto(beatOrder: 0, status: 'Pending', url: 'i1'),
          ],
        ),
      ],
    );
    final pages = previewPages('X.\n\nY.', pack);
    expect(pages.map((p) => p.text), ['Cảnh đầu', 'a b']);
    expect(pages[0].images, ['i2']);
    expect(pages[1].audio, ['a1', 'a2']);
    expect(previewPages('X.\n\nY.', null).map((p) => p.text), ['X.', 'Y.']);
  });
}

void bannerAndNewTests() {
  test('banner: tối đa 5 truyện có ảnh bìa, xếp hạng yêu thích trước, rồi nhiều yêu thích / lượt đọc, bằng nhau thì mới trước', () {
    String cover(int i) => 'http://x/$i.png';
    final sorted = mergeLibrary(
      [
        for (var i = 1; i <= 8; i++)
          _s(i, day: i, cover: i == 2 ? '' : cover(i)),
      ],
      [
        _s(3, day: 3, favs: 5, cover: cover(3)),
        _s(5, day: 5, views: 9, favs: 1, cover: cover(5)),
        _s(6, day: 6, views: 2, favs: 1, cover: cover(6)),
      ],
    );
    // Chưa có lượt nào: giữ thứ tự mới trước như trước đây.
    expect(
      LibraryShelves(
        mergeLibrary([
          for (var i = 1; i <= 8; i++)
            _s(i, day: i, cover: i == 2 ? '' : cover(i)),
        ], const []),
      ).banner.map((s) => s.id),
      [8, 7, 6, 5, 4],
    );
    expect(
      LibraryShelves(
        sorted,
        ranked: [
          _s(1, cover: cover(1)),
          _s(2, favs: 9, cover: ''),
        ],
      ).banner.map((s) => s.id),
      [1, 3, 5, 6, 8],
    );
    expect(LibraryShelves(mergeLibrary([_s(1)], const [])).banner, isEmpty);
  });

  test('isNewAt: tạo trong 7 ngày gần đây', () {
    final s = _s(1, day: 10);
    expect(s.isNewAt(DateTime(2026, 1, 16)), isTrue);
    expect(s.isNewAt(DateTime(2026, 1, 17)), isFalse);
    expect(const LibraryStoryDto(id: 1).isNewAt(DateTime(2026)), isFalse);
  });

  test('foldVietnamese bỏ dấu để tìm không dấu', () {
    expect(
      foldVietnamese('Đêm Hội Trông Trăng Ở Làng Quê'),
      'dem hoi trong trang o lang que',
    );
    expect(foldVietnamese('Chú Cuội ước được bay'), 'chu cuoi uoc duoc bay');
  });
}
