import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/features/kid/reader/kid_reader_pages.dart';
import 'package:ai_storytelling_mobile/models/child_interaction_dto.dart';
import 'package:ai_storytelling_mobile/models/child_reading_dto.dart';

// "Mot hai." [0,8) · "Ba bon." [9,16) · "Nam sau." [17,25)
const _text = 'Mot hai. Ba bon. Nam sau.';

ReadingScene _threePictures({List<ReadingSegment> segments = const []}) =>
    ReadingScene(
      sceneId: 30,
      sceneIndex: 2,
      text: _text,
      illustrationUrl: 'cover.png',
      illustrations: const [
        SceneIllustration(beatOrder: 2, startOffset: 9, endOffset: 16, url: 'b.png'),
        SceneIllustration(beatOrder: 1, startOffset: 0, endOffset: 8, url: 'a.png'),
        SceneIllustration(beatOrder: 4, startOffset: 20, endOffset: 25),
        SceneIllustration(beatOrder: 3, startOffset: 17, endOffset: 25, url: 'c.png'),
      ],
      segments: segments,
      interaction: const ReadingInteraction(id: 9),
    );

void main() {
  test('scenePictures: không có tranh riêng thì 1 tranh phủ cả cảnh', () {
    const scene = ReadingScene(sceneId: 1, sceneIndex: 0, text: 'abc', illustrationUrl: 'x.png');
    expect(scenePictures(scene), [(url: 'x.png', start: 0, end: 3)]);
  });

  test('scenePictures: bỏ tranh không có url, sắp theo beatOrder', () {
    expect(scenePictures(_threePictures()).map((p) => p.url), ['a.png', 'b.png', 'c.png']);
  });

  test('pictureParts: ghép đủ cả cảnh, bỏ khoảng trắng hai đầu', () {
    final parts = pictureParts(scenePictures(_threePictures()), _text);
    expect(parts, [(start: 0, end: 8), (start: 9, end: 16), (start: 17, end: 25)]);
  });

  test('pictureParts: mốc vượt độ dài chữ thì clamp, không lỗi', () {
    final parts = pictureParts(
      [(url: 'a', start: 0, end: 5), (url: 'b', start: 99, end: 120)],
      'abc ',
    );
    expect(parts, [(start: 0, end: 3), (start: 4, end: 4)]);
  });

  test('buildKidReaderPages: cảnh 0 tranh, 1 tranh, 3 tranh → 5 trang', () {
    final pages = buildKidReaderPages([
      const ReadingScene(sceneId: 10, sceneIndex: 0, text: 'Mot.', illustrationUrl: 'only.png'),
      const ReadingScene(
        sceneId: 20,
        sceneIndex: 1,
        text: 'Hai.',
        illustrations: [SceneIllustration(beatOrder: 1, startOffset: 0, endOffset: 4, url: 'one.png')],
      ),
      _threePictures(),
    ]);
    expect(pages.length, 5);
    expect(pages.map((p) => p.sceneIndex), [0, 1, 2, 2, 2]);
    expect(pages.map((p) => p.scene.sceneId), [10, 20, 30, 30, 30]);
    expect(pages.map((p) => p.scene.text), ['Mot.', 'Hai.', 'Mot hai.', 'Ba bon.', 'Nam sau.']);
    expect(pages.map((p) => p.scene.illustrationUrl), ['only.png', 'one.png', 'a.png', 'b.png', 'c.png']);
    // Tương tác chỉ ở trang cuối của cảnh.
    expect(pages.map((p) => p.scene.interaction?.id), [null, null, null, null, 9]);
    expect(firstPageOfScene(pages, 2), 2);
    expect(firstPageOfScene(pages, 7), 0);
  });

  test('buildKidReaderPages: segment chia theo tranh, offset tính theo đoạn con', () {
    final pages = buildKidReaderPages([
      _threePictures(segments: const [
        ReadingSegment(segmentId: 3, segmentOrder: 3, startOffset: 17, endOffset: 25, text: 'Nam sau.'),
        ReadingSegment(segmentId: 1, segmentOrder: 1, startOffset: 0, endOffset: 8, text: 'Mot hai.'),
        // Không có offset: dò indexOf theo thứ tự → 9.
        ReadingSegment(segmentId: 2, segmentOrder: 2, text: 'Ba bon.'),
      ]),
    ]);
    List<(int, int?, int?)> segs(int i) => [
      for (final s in pages[i].scene.segments) (s.segmentId, s.startOffset, s.endOffset),
    ];
    expect(segs(0), [(1, 0, 8)]);
    expect(segs(1), [(2, 0, 7)]);
    expect(segs(2), [(3, 0, 8)]);
  });

  test('buildKidReaderPages: segment vắt qua 2 tranh thuộc tranh chứa startOffset', () {
    final pages = buildKidReaderPages([
      _threePictures(segments: const [
        ReadingSegment(segmentId: 5, segmentOrder: 1, startOffset: 12, endOffset: 20, text: 'bon. Nam'),
      ]),
    ]);
    expect(pages[0].scene.segments, isEmpty);
    expect(pages[1].scene.segments.single.startOffset, 3);
    expect(pages[1].scene.segments.single.endOffset, 7); // clamp vào đoạn "Ba bon."
    expect(pages[2].scene.segments, isEmpty);
  });
}
