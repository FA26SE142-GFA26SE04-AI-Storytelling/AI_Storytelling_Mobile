import '../../../models/child_reading_dto.dart';

/// Một tranh của cảnh và đoạn chữ [start, end) nó minh hoạ.
typedef ScenePicture = ({String? url, int start, int end});

/// Một trang của màn đọc = một tranh. [sceneIndex] là vị trí cảnh gốc trong
/// content.scenes (dùng cho tiến độ gửi Backend); [scene] là cảnh con chỉ gồm
/// đoạn chữ của tranh, offset segment đã tính lại theo đoạn con.
typedef KidReaderPageItem = ({int sceneIndex, ReadingScene scene});

/// Tranh của cảnh theo thứ tự; Backend cũ chỉ có illustrationUrl thì là một tranh phủ cả cảnh.
List<ScenePicture> scenePictures(ReadingScene scene) {
  final list =
      (scene.illustrations ?? const <SceneIllustration>[])
          .where((p) => p.url != null && p.url!.trim().isNotEmpty)
          .toList()
        ..sort((a, b) => a.beatOrder.compareTo(b.beatOrder));
  if (list.isEmpty) {
    return [(url: scene.illustrationUrl, start: 0, end: scene.text.length)];
  }
  return [
    for (final p in list) (url: p.url, start: p.startOffset, end: p.endOffset),
  ];
}

/// Đoạn chữ hiện cùng từng tranh: từ start của tranh (tranh đầu từ 0) tới ngay
/// trước start của tranh sau (tranh cuối tới hết cảnh); bỏ khoảng trắng hai đầu.
List<({int start, int end})> pictureParts(
  List<ScenePicture> pictures,
  String text,
) {
  bool isSpace(int i) => text[i].trim().isEmpty;
  return [
    for (var i = 0; i < pictures.length; i++)
      () {
        var start = i == 0 ? 0 : pictures[i].start.clamp(0, text.length);
        var end = i == pictures.length - 1
            ? text.length
            : pictures[i + 1].start.clamp(start, text.length);
        while (start < end && isSpace(start)) {
          start++;
        }
        while (end > start && isSpace(end - 1)) {
          end--;
        }
        return (start: start, end: end);
      }(),
  ];
}

/// Vị trí bắt đầu của từng segment (đã sort theo segmentOrder) trong chữ cảnh;
/// Backend cũ không trả startOffset thì dò indexOf theo thứ tự.
List<int> segmentStarts(String text, List<ReadingSegment> sorted) {
  var cursor = 0;
  return [
    for (final s in sorted)
      () {
        final known = s.startOffset;
        if (known != null) {
          cursor = known + s.text.length;
          return known;
        }
        final at = text.indexOf(s.text, cursor.clamp(0, text.length));
        final start = at >= 0 ? at : cursor;
        cursor = start + s.text.length;
        return start;
      }(),
  ];
}

/// Tách các cảnh thành trang theo tranh. Segment thuộc tranh chứa startOffset
/// của nó; tương tác của cảnh chỉ nằm ở trang cuối của cảnh.
List<KidReaderPageItem> buildKidReaderPages(List<ReadingScene> scenes) {
  final pages = <KidReaderPageItem>[];
  for (var si = 0; si < scenes.length; si++) {
    final scene = scenes[si];
    final text = scene.text;
    final pictures = scenePictures(scene);
    final parts = pictureParts(pictures, text);
    final sorted = [...scene.segments]
      ..sort((a, b) => a.segmentOrder.compareTo(b.segmentOrder));
    final starts = segmentStarts(text, sorted);

    // Tranh chứa vị trí: tranh cuối có mốc bắt đầu (chưa bỏ khoảng trắng) <= vị trí.
    int pictureOf(int offset) {
      var hit = 0;
      for (var i = 1; i < pictures.length; i++) {
        if (pictures[i].start.clamp(0, text.length) <= offset) hit = i;
      }
      return hit;
    }

    final segsOf = List.generate(pictures.length, (_) => <ReadingSegment>[]);
    for (var k = 0; k < sorted.length; k++) {
      final s = sorted[k];
      final p = pictureOf(starts[k]);
      final base = parts[p].start;
      final len = parts[p].end - base;
      final end = s.endOffset ?? starts[k] + s.text.length;
      segsOf[p].add(
        s.copyWith(
          startOffset: (starts[k] - base).clamp(0, len),
          endOffset: (end - base).clamp(0, len),
        ),
      );
    }

    for (var i = 0; i < pictures.length; i++) {
      final last = i == pictures.length - 1;
      pages.add((
        sceneIndex: si,
        scene: scene.copyWith(
          text: text.substring(parts[i].start, parts[i].end),
          illustrationUrl: pictures[i].url,
          illustrations: null,
          segments: segsOf[i],
          interaction: last ? scene.interaction : null,
        ),
      ));
    }
  }
  return pages;
}

/// Trang đầu của cảnh thứ [sceneIndex]; không có thì trang 0.
int firstPageOfScene(List<KidReaderPageItem> pages, int sceneIndex) {
  final i = pages.indexWhere((p) => p.sceneIndex == sceneIndex);
  return i < 0 ? 0 : i;
}
