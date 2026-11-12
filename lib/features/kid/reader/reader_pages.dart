import '../../../models/reading_content_dto.dart';
import '../../../models/reading_segment_dto.dart';

/// Đại diện cho một trang đọc của bé tương ứng với một tranh và phần chữ đi kèm.
class ReaderPage {
  const ReaderPage({
    required this.scene,
    required this.pictureIndex,
    required this.pictureCount,
    required this.imageUrl,
    required this.text,
    required this.textStart,
    required this.textEnd,
    required this.segments,
  });

  /// Dữ liệu cảnh gốc.
  final ReadingSceneDto scene;

  /// Chỉ số tranh trong cảnh (bắt đầu từ 0).
  final int pictureIndex;

  /// Tổng số tranh trong cảnh.
  final int pictureCount;

  /// Đường dẫn URL hình ảnh của tranh minh họa.
  final String? imageUrl;

  /// Toàn bộ văn bản của cảnh (không phải chỉ riêng đoạn của trang).
  final String text;

  /// Vị trí bắt đầu đoạn chữ trên trang trong văn bản cảnh.
  final int textStart;

  /// Vị trí kết thúc đoạn chữ trên trang trong văn bản cảnh.
  final int textEnd;

  /// Danh sách các segment nằm trong phạm vi `[textStart, textEnd)`.
  final List<ReadingSegmentDto> segments;

  /// Chỉ số cảnh.
  int get sceneIndex => scene.sceneIndex;

  /// Trang lưu tiến độ (bắt đầu từ 1, tương ứng với `sceneIndex + 1`).
  int get savePage => scene.sceneIndex + 1;

  /// Đoạn văn bản hiển thị trên trang này.
  String get pageText => text.substring(textStart, textEnd);
}

/// Tranh minh họa đã chuẩn hóa cho một cảnh.
class ScenePicture {
  const ScenePicture({
    this.url,
    required this.start,
    required this.end,
  });

  final String? url;
  final int start;
  final int end;
}

/// Vị trí giới hạn `[start, end]` của văn bản tương ứng với một tranh.
class PicturePart {
  const PicturePart({
    required this.start,
    required this.end,
  });

  final int start;
  final int end;
}

/// Lấy danh sách tranh minh họa hợp lệ của cảnh.
///
/// Lọc các illustration có URL khác rỗng, sắp xếp theo [beatOrder].
/// Nếu cảnh không có tranh minh họa hợp lệ nào, tạo một tranh mặc định từ [illustrationUrl].
List<ScenePicture> scenePictures(ReadingSceneDto scene) {
  final valid = scene.illustrations
      .where((i) => i.url != null && i.url!.trim().isNotEmpty)
      .toList()
    ..sort((a, b) => a.beatOrder.compareTo(b.beatOrder));

  if (valid.isNotEmpty) {
    return valid
        .map(
          (i) => ScenePicture(
            url: i.url,
            start: i.startOffset,
            end: i.endOffset,
          ),
        )
        .toList();
  }

  return [
    ScenePicture(
      url: scene.illustrationUrl,
      start: 0,
      end: scene.text.length,
    ),
  ];
}

/// Tính toán phạm vi chữ `[start, end]` tương ứng với từng tranh trong [pictures].
List<PicturePart> pictureParts(List<ScenePicture> pictures, String text) {
  final len = text.length;
  final parts = <PicturePart>[];

  for (var i = 0; i < pictures.length; i++) {
    final p = pictures[i];
    var start = (i == 0) ? 0 : p.start.clamp(0, len);
    var end = (i == pictures.length - 1)
        ? len
        : pictures[i + 1].start.clamp(start, len);

    while (start < end && RegExp(r'\s').hasMatch(text[start])) {
      start++;
    }
    while (end > start && RegExp(r'\s').hasMatch(text[end - 1])) {
      end--;
    }

    parts.add(PicturePart(start: start, end: end));
  }

  return parts;
}

/// Xác định vị trí bắt đầu `startOffset` cho từng segment trong cảnh.
Map<int, int> segmentStarts(ReadingSceneDto scene) {
  final sorted = [...scene.segments]
    ..sort((a, b) => a.segmentOrder.compareTo(b.segmentOrder));

  final result = <int, int>{};
  var cursor = 0;

  for (final seg in sorted) {
    int start;
    if (seg.startOffset != null) {
      start = seg.startOffset!;
    } else {
      final idx = scene.text.indexOf(seg.text, cursor);
      if (idx != -1) {
        start = idx;
      } else {
        start = cursor;
      }
    }
    result[seg.segmentId] = start;
    cursor = start + seg.text.length;
  }

  return result;
}

/// Xây dựng danh sách các [ReaderPage] từ nội dung truyện [content].
List<ReaderPage> buildReaderPages(ReadingContentDto content) {
  final sortedScenes = [...content.scenes]
    ..sort((a, b) => a.sceneIndex.compareTo(b.sceneIndex));

  final pages = <ReaderPage>[];

  for (final scene in sortedScenes) {
    final hasText = scene.text.trim().isNotEmpty;
    final hasIllustrationUrl =
        scene.illustrationUrl != null && scene.illustrationUrl!.trim().isNotEmpty;
    final hasIllustrations = scene.illustrations
        .any((i) => i.url != null && i.url!.trim().isNotEmpty);

    // Bỏ qua cảnh không có chữ và không có tranh
    if (!hasText && !hasIllustrationUrl && !hasIllustrations) {
      continue;
    }

    final pictures = scenePictures(scene);
    final parts = pictureParts(pictures, scene.text);
    final segStarts = segmentStarts(scene);
    final sortedSegments = [...scene.segments]
      ..sort((a, b) => a.segmentOrder.compareTo(b.segmentOrder));

    for (var i = 0; i < pictures.length; i++) {
      final part = parts[i];
      final List<ReadingSegmentDto> pageSegments;

      if (pictures.length == 1) {
        pageSegments = sortedSegments;
      } else {
        pageSegments = sortedSegments.where((seg) {
          final start = segStarts[seg.segmentId] ?? (seg.startOffset ?? 0);
          return start >= part.start && start < part.end;
        }).toList();
      }

      pages.add(
        ReaderPage(
          scene: scene,
          pictureIndex: i,
          pictureCount: pictures.length,
          imageUrl: pictures[i].url,
          text: scene.text,
          textStart: part.start,
          textEnd: part.end,
          segments: pageSegments,
        ),
      );
    }
  }

  return pages;
}

/// Trả về chỉ số trang đầu tiên có `savePage == lastPage`, không thấy trả về 0.
int indexForLastPage(List<ReaderPage> pages, int lastPage) {
  for (var i = 0; i < pages.length; i++) {
    if (pages[i].savePage == lastPage) {
      return i;
    }
  }
  return 0;
}

/// Trả segment chứa vị trí đầu trang ([ReaderPage.textStart]) trong văn bản cảnh.
ReadingSegmentDto? segmentAtPageStart(ReaderPage page) {
  if (page.segments.isEmpty) {
    return null;
  }

  final sortedSegments = [...page.segments]
    ..sort((a, b) => a.segmentOrder.compareTo(b.segmentOrder));

  final positioned = <({ReadingSegmentDto segment, int start, int end})>[];
  var cursor = 0;

  for (final seg in sortedSegments) {
    int start;
    if (seg.startOffset != null) {
      start = seg.startOffset!;
    } else {
      final idx = page.text.indexOf(seg.text, cursor);
      if (idx != -1) {
        start = idx;
      } else {
        start = cursor;
      }
    }
    final end = start + seg.text.length;
    cursor = end;
    positioned.add((segment: seg, start: start, end: end));
  }

  for (final item in positioned) {
    if (item.start <= page.textStart && page.textStart < item.end) {
      return item.segment;
    }
  }

  ReadingSegmentDto? fallback;
  int? maxStart;
  for (final item in positioned) {
    if (item.start <= page.textStart) {
      if (maxStart == null || item.start > maxStart) {
        maxStart = item.start;
        fallback = item.segment;
      }
    }
  }

  if (fallback != null) {
    return fallback;
  }

  return sortedSegments.first;
}

/// Đại diện cho một đoạn văn bản thường hoặc từ vựng nổi bật.
class VocabSpan {
  const VocabSpan({
    required this.text,
    this.vocabularyId,
  });

  /// Nội dung đoạn văn bản.
  final String text;

  /// Khóa ID từ vựng nếu đoạn này khớp với từ vựng, `null` nếu là văn bản thường.
  final int? vocabularyId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabSpan &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          vocabularyId == other.vocabularyId;

  @override
  int get hashCode => Object.hash(text, vocabularyId);

  @override
  String toString() => 'VocabSpan(text: $text, vocabularyId: $vocabularyId)';
}

class _VocabMatch {
  const _VocabMatch({
    required this.start,
    required this.end,
    required this.vocabularyId,
  });

  final int start;
  final int end;
  final int vocabularyId;

  int get length => end - start;
}

/// Tách văn bản [text] thành các [VocabSpan] theo danh sách [vocabulary].
List<VocabSpan> splitByVocabulary(
  String text,
  List<ReadingVocabularyDto> vocabulary,
) {
  if (text.isEmpty) {
    return const [];
  }

  final lowerText = text.toLowerCase();
  final matches = <_VocabMatch>[];

  for (final v in vocabulary) {
    final term = v.term.trim();
    if (term.isEmpty) {
      continue;
    }
    final termLower = term.toLowerCase();
    var startIndex = 0;
    while (true) {
      final found = lowerText.indexOf(termLower, startIndex);
      if (found == -1) {
        break;
      }
      matches.add(
        _VocabMatch(
          start: found,
          end: found + termLower.length,
          vocabularyId: v.id,
        ),
      );
      startIndex = found + 1;
    }
  }

  if (matches.isEmpty) {
    return [VocabSpan(text: text)];
  }

  // Sắp xếp theo vị trí bắt đầu tăng dần; nếu trùng start thì ưu tiên độ dài lớn hơn
  matches.sort((a, b) {
    final startCmp = a.start.compareTo(b.start);
    if (startCmp != 0) {
      return startCmp;
    }
    return b.length.compareTo(a.length);
  });

  final selected = <_VocabMatch>[];
  var cursor = 0;
  for (final m in matches) {
    if (m.start >= cursor) {
      selected.add(m);
      cursor = m.end;
    }
  }

  final spans = <VocabSpan>[];
  var current = 0;

  for (final m in selected) {
    if (m.start > current) {
      spans.add(VocabSpan(text: text.substring(current, m.start)));
    }
    spans.add(
      VocabSpan(
        text: text.substring(m.start, m.end),
        vocabularyId: m.vocabularyId,
      ),
    );
    current = m.end;
  }

  if (current < text.length) {
    spans.add(VocabSpan(text: text.substring(current)));
  }

  return spans;
}
