import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../models/child_read_aloud_dto.dart';

/// Khoảng vị trí của từ trong đoạn văn bản kèm trạng thái đọc to.
class ReadAloudWordRange {
  const ReadAloudWordRange({
    required this.start,
    required this.end,
    required this.status,
    this.hint,
  });

  final int start;
  final int end;
  final String status;

  /// Gợi ý khi chữ đọc chưa đúng (tone/unclear/different), null nếu không có
  final String? hint;
}

/// Ghép token chữ trong [segmentText] với danh sách [words] theo thứ tự.
List<ReadAloudWordRange> readAloudWordRanges(
  String segmentText,
  List<ReadAloudWord> words,
) {
  if (segmentText.isEmpty || words.isEmpty) {
    return const [];
  }

  final tokens = RegExp(
    r'[\p{L}\p{N}]+',
    unicode: true,
  ).allMatches(segmentText).toList();
  if (tokens.isEmpty) {
    return const [];
  }

  final sortedWords = List<ReadAloudWord>.from(words)
    ..sort((a, b) => a.index.compareTo(b.index));

  // shortcut: Tách chữ giống backend nên khớp theo thứ tự, chỉ lệch khi text không ở dạng Unicode NFC; nâng cấp khi chuẩn hoá NFC hoặc backend trả thẳng start/end index.
  final count = tokens.length < sortedWords.length
      ? tokens.length
      : sortedWords.length;

  return List<ReadAloudWordRange>.generate(count, (i) {
    final token = tokens[i];
    return ReadAloudWordRange(
      start: token.start,
      end: token.end,
      status: sortedWords[i].status,
      hint: sortedWords[i].hint,
    );
  });
}

/// Trả về kiểu chữ theo trạng thái đọc to đồng bộ với web.
TextStyle readAloudStyle(String status, TtColors tt) {
  switch (status) {
    case 'good':
      return TextStyle(color: tt.primary, fontWeight: FontWeight.w700);
    case 'retry':
      return TextStyle(
        backgroundColor: tt.gold.withValues(alpha: 0.4),
        fontWeight: FontWeight.w700,
      );
    case 'skipped':
      return TextStyle(color: tt.muted.withValues(alpha: 0.6));
    default:
      return const TextStyle();
  }
}
