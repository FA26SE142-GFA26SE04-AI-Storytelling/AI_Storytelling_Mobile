import 'dart:convert';
import 'dart:math' as math;

/// Đại diện cho mốc thời gian phát âm của một từ trong audio.
class Timing {
  final String word;
  final double start;
  final double? end;

  const Timing({
    required this.word,
    required this.start,
    this.end,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Timing &&
          runtimeType == other.runtimeType &&
          word == other.word &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => Object.hash(word, start, end);

  @override
  String toString() => 'Timing(word: $word, start: $start, end: $end)';
}

/// Parse chuỗi JSON word timings sang danh sách [Timing].
/// Trả về danh sách rỗng nếu null, rỗng hoặc có lỗi decode (không ném lỗi).
List<Timing> parseWordTimings(String? jsonStr) {
  if (jsonStr == null || jsonStr.trim().isEmpty) {
    return const [];
  }
  try {
    final decoded = jsonDecode(jsonStr);
    if (decoded is! List) {
      return const [];
    }
    final result = <Timing>[];
    for (final item in decoded) {
      if (item is Map) {
        final word = item['word'];
        final start = item['start'];
        if (word is String && start is num) {
          final endRaw = item['end'];
          final double? end = endRaw is num ? endRaw.toDouble() : null;
          result.add(Timing(
            word: word,
            start: start.toDouble(),
            end: end,
          ));
        }
      }
    }
    return result;
  } catch (_) {
    return const [];
  }
}

/// Truyện có mốc thời gian từng chữ hay không (để bật chế độ phụ đề).
bool storyHasWordTimings(Iterable<String?> wordTimingsJsons) {
  for (final jsonStr in wordTimingsJsons) {
    if (parseWordTimings(jsonStr).isNotEmpty) {
      return true;
    }
  }
  return false;
}

/// Tính nhịp độ (pace) ước tính của văn bản dựa trên các cụm từ và dấu câu.
({List<({int at, double start})> words, double total}) paceOf(String text) {
  final words = <({int at, double start})>[];
  double total = 0.0;

  final sentenceEndRegex = RegExp(r'[.!?…][\"”\x27’\)\]]*$');
  final clauseEndRegex = RegExp(r'[,;:][\"”\x27’\)\]]*$');

  final matches = RegExp(r'\S+').allMatches(text);
  for (final m in matches) {
    final token = m.group(0)!;
    words.add((at: m.start, start: total));

    double pause = 0.0;
    if (sentenceEndRegex.hasMatch(token)) {
      pause = 1.2;
    } else if (clauseEndRegex.hasMatch(token)) {
      pause = 0.6;
    }

    total += 1.0 + pause;
  }

  return (words: words, total: total);
}

/// Tìm vị trí ký tự tương ứng với thời điểm [seconds] trong [text].
int charInSegment(
  String text,
  List<Timing> timings,
  double seconds,
  double duration,
) {
  if (timings.isNotEmpty) {
    int cursor = 0;
    int hit = 0;
    for (final t in timings) {
      final at = text.indexOf(t.word, cursor);
      if (at < 0) continue;
      if (t.start <= seconds) {
        hit = at;
      }
      cursor = at + t.word.length;
    }
    return hit;
  }

  if (duration <= 0 || !duration.isFinite) {
    return 0;
  }

  final pace = paceOf(text);
  final safeSeconds = math.max(0.0, seconds);
  final target = (safeSeconds / duration) * pace.total;
  int hit = 0;
  for (final w in pace.words) {
    if (w.start <= target) {
      hit = w.at;
    } else {
      break;
    }
  }
  return hit;
}

/// Xác định phạm vi từ tại vị trí [offset] trong [text].
({int start, int end})? wordAt(String text, int offset) {
  if (text.isEmpty || offset < 0 || offset >= text.length) {
    return null;
  }

  final whitespaceRegex = RegExp(r'\s');

  int start = offset;
  while (start < text.length && whitespaceRegex.hasMatch(text[start])) {
    start++;
  }
  if (start >= text.length) {
    return null;
  }

  while (start > 0 && !whitespaceRegex.hasMatch(text[start - 1])) {
    start--;
  }

  int end = start;
  while (end < text.length && !whitespaceRegex.hasMatch(text[end])) {
    end++;
  }

  return (start: start, end: end);
}

/// Tách văn bản thành các khúc phụ đề (mỗi khúc <= 90 ký tự, không mất chữ).
List<String> splitCaptionChunks(String text) {
  if (text.trim().isEmpty) {
    return const [];
  }

  // Bước 1: tách theo câu: kết thúc khi gặp . ! ? … (kèm các dấu đóng ngay sau nếu có) hoặc xuống dòng \n.
  final rawSentences = <String>[];
  final terminators = {'.', '!', '?', '…'};
  final closingChars = {'"', '”', "'", '’', ')', ']'};

  int start = 0;
  int i = 0;
  while (i < text.length) {
    if (text[i] == '\r' && i + 1 < text.length && text[i + 1] == '\n') {
      rawSentences.add(text.substring(start, i));
      i += 2;
      start = i;
    } else if (text[i] == '\n') {
      rawSentences.add(text.substring(start, i));
      i++;
      start = i;
    } else if (terminators.contains(text[i])) {
      while (i < text.length && terminators.contains(text[i])) {
        i++;
      }
      while (i < text.length && closingChars.contains(text[i])) {
        i++;
      }
      rawSentences.add(text.substring(start, i));
      start = i;
    } else {
      i++;
    }
  }
  if (start < text.length) {
    rawSentences.add(text.substring(start));
  }

  // Bước 2: khúc nào dài > 90 ký tự thì cắt tiếp.
  final splitChunks = <String>[];
  for (final sentence in rawSentences) {
    if (sentence.length <= 90) {
      splitChunks.add(sentence);
    } else {
      splitChunks.addAll(_subdivideChunk(sentence, maxLength: 90));
    }
  }

  // Bước 3: trim mỗi khúc, bỏ khúc rỗng.
  return splitChunks
      .map((c) => c.trim())
      .where((c) => c.isNotEmpty)
      .toList();
}

List<String> _subdivideChunk(String chunk, {int maxLength = 90}) {
  final result = <String>[];
  String remaining = chunk;
  final closingChars = {'"', '”', "'", '’', ')', ']'};
  final punctuation = {',', ';', ':'};

  while (remaining.length > maxLength) {
    int cut = -1;

    // 1. Ưu tiên dấu phẩy , ; : gần nhất để phần đầu <= maxLength
    for (int i = math.min(remaining.length - 1, maxLength - 1); i >= 0; i--) {
      if (punctuation.contains(remaining[i])) {
        int candidate = i + 1;
        while (candidate < maxLength &&
            candidate < remaining.length &&
            closingChars.contains(remaining[candidate])) {
          candidate++;
        }
        if (candidate <= maxLength && candidate > 0) {
          cut = candidate;
          break;
        }
      }
    }

    // 2. Nếu không có dấu thì cắt tại khoảng trắng gần nhất <= maxLength
    if (cut <= 0) {
      for (int i = math.min(remaining.length, maxLength); i > 0; i--) {
        if (i == maxLength) {
          if (i < remaining.length && RegExp(r'\s').hasMatch(remaining[i])) {
            cut = maxLength;
            break;
          }
        }
        if (i < maxLength && RegExp(r'\s').hasMatch(remaining[i])) {
          cut = i;
          break;
        }
      }
    }

    // 3. Nếu không có khoảng trắng thì cắt cứng ở maxLength
    if (cut <= 0) {
      cut = maxLength;
    }

    result.add(remaining.substring(0, cut));
    remaining = remaining.substring(cut);
  }

  if (remaining.isNotEmpty) {
    result.add(remaining);
  }

  return result;
}

/// Chọn chỉ số khúc phụ đề tương ứng với thời điểm [positionSec].
int pickChunkIndex(
  List<String> chunks, {
  required List<Timing> timings,
  required String text,
  double? positionSec,
  double? durationSec,
}) {
  final n = chunks.length;
  if (n == 0) return 0;
  if (positionSec == null) return 0;

  final double pos;
  if (timings.isNotEmpty) {
    pos = charInSegment(text, timings, positionSec, durationSec ?? 0.0)
        .toDouble();
  } else {
    final double ratio = (durationSec != null && durationSec > 0.0)
        ? (positionSec / durationSec)
        : 0.0;
    pos = ratio * text.length;
  }

  final chunkStarts = <int>[];
  int cursor = 0;
  for (final chunk in chunks) {
    final idx = text.indexOf(chunk, cursor);
    if (idx >= 0) {
      chunkStarts.add(idx);
      cursor = idx + chunk.length;
    } else {
      chunkStarts.add(cursor);
    }
  }

  int selectedIndex = 0;
  for (int i = 0; i < n; i++) {
    if (chunkStarts[i] <= pos) {
      selectedIndex = i;
    }
  }

  return selectedIndex.clamp(0, n - 1);
}
