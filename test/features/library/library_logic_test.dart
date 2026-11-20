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
  String? cover,
}) =>
    LibraryStoryDto(
      id: id,
      title: 'Truyện $id',
      genre: genre,
      source: source,
      status: 'Ready',
      isPublished: published,
      createdAt: DateTime(2026, 1, day),
      viewCount: views,
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

    test('gộp lại cùng dữ liệu không nhân đôi', () {
      final a = [_s(1), _s(2)];
      expect(mergeLibrary(a, a).length, 2);
    });
  });

  test('LibraryShelves: 10 mới nhất, chủ đề, nguồn, tìm không phân biệt hoa thường', () {
    final sorted = mergeLibrary(
      [
        for (var i = 1; i <= 12; i++)
          _s(i, day: i, genre: i.isEven ? 'Tình bạn' : '', source: i == 3 ? 'Manual' : 'Ai'),
      ],
      const [],
    );
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

  test('splitScenes: theo đoạn, một đoạn thì gom 3 câu', () {
    expect(splitScenes('A.\n\nB.'), ['A.', 'B.']);
    expect(splitScenes('Một. Hai! Ba? Bốn.'), ['Một. Hai! Ba?', 'Bốn.']);
    expect(splitScenes(''), isEmpty);
  });

  test('previewPages: xếp cảnh, chỉ lấy media Ready, chữ dự phòng', () {
    const pack = StoryMediaPackageDto(scenes: [
      MediaSceneDto(sceneIndex: 1, audio: [
        MediaAudioDto(segmentOrder: 1, text: 'b', status: 'Ready', url: 'a2'),
        MediaAudioDto(segmentOrder: 0, text: 'a', status: 'Ready', url: 'a1'),
      ]),
      MediaSceneDto(sceneIndex: 0, text: 'Cảnh đầu', illustrations: [
        MediaIllustrationDto(beatOrder: 1, status: 'Ready', url: 'i2'),
        MediaIllustrationDto(beatOrder: 0, status: 'Pending', url: 'i1'),
      ]),
    ]);
    final pages = previewPages('X.\n\nY.', pack);
    expect(pages.map((p) => p.text), ['Cảnh đầu', 'a b']);
    expect(pages[0].images, ['i2']);
    expect(pages[1].audio, ['a1', 'a2']);
    expect(previewPages('X.\n\nY.', null).map((p) => p.text), ['X.', 'Y.']);
  });
}

void bannerAndNewTests() {
  test('banner: tối đa 5 truyện mới nhất có ảnh bìa, không có ảnh thì rỗng', () {
    final sorted = mergeLibrary([
      for (var i = 1; i <= 8; i++) _s(i, day: i, cover: i == 2 ? '' : 'http://x/$i.png'),
    ], const []);
    expect(LibraryShelves(sorted).banner.map((s) => s.id), [8, 7, 6, 5, 4]);
    expect(LibraryShelves(mergeLibrary([_s(1)], const [])).banner, isEmpty);
  });

  test('isNewAt: tạo trong 7 ngày gần đây', () {
    final s = _s(1, day: 10);
    expect(s.isNewAt(DateTime(2026, 1, 16)), isTrue);
    expect(s.isNewAt(DateTime(2026, 1, 17)), isFalse);
    expect(const LibraryStoryDto(id: 1).isNewAt(DateTime(2026)), isFalse);
  });

  test('foldVietnamese bỏ dấu để tìm không dấu', () {
    expect(foldVietnamese('Đêm Hội Trông Trăng Ở Làng Quê'),
        'dem hoi trong trang o lang que');
    expect(foldVietnamese('Chú Cuội ước được bay'), 'chu cuoi uoc duoc bay');
  });
}
