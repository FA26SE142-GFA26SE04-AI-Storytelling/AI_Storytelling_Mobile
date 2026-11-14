import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../models/child_reading_dto.dart';

/// Candidate match của một từ vựng trong văn bản
class _VocabCandidate {
  const _VocabCandidate({
    required this.start,
    required this.end,
    required this.vocab,
    required this.isWholeWord,
  });

  final int start;
  final int end;
  final ReadingVocabulary vocab;
  final bool isWholeWord;
}

/// Widget hiển thị MỘT trang (= một cảnh/scene) của truyện dành cho chế độ đọc của bé.
class KidReaderPage extends StatefulWidget {
  const KidReaderPage({
    super.key,
    required this.scene,
    required this.vocabulary,
    this.activeSegmentId,
    required this.isWide,
    required this.onVocabTap,
  });

  /// Thông tin cảnh truyện đang hiển thị
  final ReadingScene scene;

  /// Danh sách từ vựng của truyện cần tra cứu
  final List<ReadingVocabulary> vocabulary;

  /// Id đoạn đang đọc (được highlight màu vàng nhạt)
  final int? activeSegmentId;

  /// Có đang hiển thị trên màn hình rộng (tablet/desktop) hay không
  final bool isWide;

  /// Callback khi bé chạm vào một từ vựng
  final void Function(ReadingVocabulary item) onVocabTap;

  @override
  State<KidReaderPage> createState() => _KidReaderPageState();
}

class _KidReaderPageState extends State<KidReaderPage> {
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    _clearRecognizers();
    super.dispose();
  }

  void _clearRecognizers() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();
  }

  /// Xác định URL tranh vẽ phù hợp cho đoạn đang đọc
  String? _resolveImageUrl() {
    final illustrations = widget.scene.illustrations;
    if (illustrations != null && illustrations.isNotEmpty) {
      if (widget.activeSegmentId != null) {
        final seg = widget.scene.segments
            .where((s) => s.segmentId == widget.activeSegmentId)
            .firstOrNull;
        if (seg != null && seg.startOffset != null) {
          final offset = seg.startOffset!;
          final matched = illustrations.where((ill) {
            return ill.startOffset <= offset && offset < ill.endOffset;
          }).firstOrNull;
          if (matched != null && matched.url != null && matched.url!.isNotEmpty) {
            return matched.url;
          }
        }
      }
      // Nếu không khớp hoặc không có activeSegmentId thì dùng illustration đầu tiên
      final firstUrl = illustrations.first.url;
      if (firstUrl != null && firstUrl.isNotEmpty) {
        return firstUrl;
      }
    }
    return widget.scene.illustrationUrl;
  }

  /// Tìm khoảng offset [start, end) của đoạn đang đọc trong scene.text
  ({int start, int end})? _getActiveRange(String text) {
    if (widget.activeSegmentId == null || text.isEmpty) return null;

    final segments = widget.scene.segments;
    final seg = segments
        .where((s) => s.segmentId == widget.activeSegmentId)
        .firstOrNull;
    if (seg == null) return null;

    if (seg.startOffset != null && seg.endOffset != null) {
      final start = seg.startOffset!.clamp(0, text.length);
      final end = seg.endOffset!.clamp(0, text.length);
      if (start < end) {
        return (start: start, end: end);
      }
    }

    // Nếu không có offset: tìm theo nội dung text của segment
    final segText = seg.text.trim();
    if (segText.isEmpty) return null;

    // Duyệt tuần tự theo segmentOrder để khớp đúng vị trí xuất hiện
    final sorted = List<ReadingSegment>.from(segments)
      ..sort((a, b) => a.segmentOrder.compareTo(b.segmentOrder));

    int searchFrom = 0;
    for (final s in sorted) {
      final sText = s.text.trim();
      if (sText.isEmpty) continue;
      final idx = text.indexOf(sText, searchFrom);
      final actualStart = idx != -1 ? idx : text.indexOf(sText);
      if (actualStart != -1) {
        final actualEnd = (actualStart + sText.length).clamp(0, text.length);
        if (s.segmentId == widget.activeSegmentId) {
          return (start: actualStart, end: actualEnd);
        }
        searchFrom = actualEnd;
      }
    }

    final fallbackIdx = text.indexOf(segText);
    if (fallbackIdx != -1) {
      return (
        start: fallbackIdx,
        end: (fallbackIdx + segText.length).clamp(0, text.length),
      );
    }

    return null;
  }

  /// Kiểm tra ký tự có phải là chữ cái hoặc số (hỗ trợ Unicode tiếng Việt)
  bool _isWordChar(String char) {
    return RegExp(r'[\p{L}\p{N}]', unicode: true).hasMatch(char);
  }

  /// Kiểm tra vị trí khớp có phải là từ nguyên vẹn hay không
  bool _isWholeWord(String text, int start, int end) {
    if (start > 0) {
      final prev = text.substring(start - 1, start);
      if (_isWordChar(prev)) return false;
    }
    if (end < text.length) {
      final next = text.substring(end, end + 1);
      if (_isWordChar(next)) return false;
    }
    return true;
  }

  /// Xây dựng các TextSpan phân chia theo đoạn active và từ vựng
  List<InlineSpan> _buildTextSpans(BuildContext context, String text) {
    _clearRecognizers();
    if (text.isEmpty) return const [];

    final tt = context.tt;
    final lowerText = text.toLowerCase();
    final allCandidates = <_VocabCandidate>[];

    // Lọc và sắp xếp từ vựng: ưu tiên từ dài trước để tránh khớp chèn từ con
    final validVocab = widget.vocabulary
        .where((v) => v.term.trim().isNotEmpty)
        .toList()
      ..sort((a, b) => b.term.trim().length.compareTo(a.term.trim().length));

    for (final v in validVocab) {
      final term = v.term.trim();
      final lowerTerm = term.toLowerCase();

      int searchIndex = 0;
      while (searchIndex < lowerText.length) {
        final idx = lowerText.indexOf(lowerTerm, searchIndex);
        if (idx == -1) break;
        final end = idx + lowerTerm.length;
        allCandidates.add(_VocabCandidate(
          start: idx,
          end: end,
          vocab: v,
          isWholeWord: _isWholeWord(text, idx, end),
        ));
        searchIndex = end;
      }
    }

    // Chọn các khoảng từ vựng không trùng lặp, ưu tiên khớp từ nguyên vẹn
    final occupied = List<bool>.filled(text.length, false);
    final selectedMatches = <_VocabCandidate>[];

    // Lượt 1: Thêm các từ khớp nguyên vẹn
    for (final candidate in allCandidates.where((c) => c.isWholeWord)) {
      bool collides = false;
      for (int i = candidate.start; i < candidate.end; i++) {
        if (occupied[i]) {
          collides = true;
          break;
        }
      }
      if (!collides) {
        for (int i = candidate.start; i < candidate.end; i++) {
          occupied[i] = true;
        }
        selectedMatches.add(candidate);
      }
    }

    // Lượt 2: Với các từ vựng chưa có lần xuất hiện nguyên vẹn nào, chấp nhận match con nếu trống
    final matchedVocabIds = selectedMatches.map((m) => m.vocab.id).toSet();
    for (final candidate in allCandidates.where((c) => !c.isWholeWord)) {
      if (!matchedVocabIds.contains(candidate.vocab.id)) {
        bool collides = false;
        for (int i = candidate.start; i < candidate.end; i++) {
          if (occupied[i]) {
            collides = true;
            break;
          }
        }
        if (!collides) {
          for (int i = candidate.start; i < candidate.end; i++) {
            occupied[i] = true;
          }
          selectedMatches.add(candidate);
          matchedVocabIds.add(candidate.vocab.id);
        }
      }
    }

    // Bản đồ gán từ vựng cho từng ký tự
    final charVocab = List<ReadingVocabulary?>.filled(text.length, null);
    for (final match in selectedMatches) {
      for (int i = match.start; i < match.end; i++) {
        charVocab[i] = match.vocab;
      }
    }

    // Xác định đoạn active
    final activeRange = _getActiveRange(text);
    bool isCharActive(int i) {
      if (activeRange == null) return false;
      return i >= activeRange.start && i < activeRange.end;
    }

    // Ghép các ký tự liên tiếp có cùng trạng thái (active, vocab) thành từng TextSpan
    final spans = <InlineSpan>[];
    int start = 0;

    while (start < text.length) {
      final currentActive = isCharActive(start);
      final currentVocab = charVocab[start];

      int end = start + 1;
      while (end < text.length &&
          isCharActive(end) == currentActive &&
          charVocab[end] == currentVocab) {
        end++;
      }

      final slice = text.substring(start, end);
      TapGestureRecognizer? recognizer;
      if (currentVocab != null) {
        final item = currentVocab;
        recognizer = TapGestureRecognizer()
          ..onTap = () => widget.onVocabTap(item);
        _recognizers.add(recognizer);
      }

      final style = TextStyle(
        backgroundColor: currentActive
            ? tt.gold.withValues(alpha: 0.25)
            : null,
        decoration: currentVocab != null ? TextDecoration.underline : null,
        decorationColor: currentVocab != null ? tt.gold : null,
        decorationThickness: currentVocab != null ? 2 : null,
        fontWeight: currentVocab != null ? FontWeight.w700 : FontWeight.w400,
      );

      spans.add(TextSpan(
        text: slice,
        style: style,
        recognizer: recognizer,
      ));

      start = end;
    }

    return spans;
  }

  Widget _buildImage(BuildContext context, String? imageUrl) {
    final tt = context.tt;
    final borderRadius = BorderRadius.circular(TtRadius.xl);

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          color: tt.line,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: tt.shadow.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(TtRadius.xl - 2),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: TtNetworkImage(
              key: ValueKey(imageUrl ?? ''),
              url: imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              radius: BorderRadius.zero,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextCard(BuildContext context, List<InlineSpan> spans) {
    final tt = context.tt;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: tt.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(TtRadius.xl),
        border: Border.all(
          color: tt.line,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: tt.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: spans.isEmpty
          ? const SizedBox.shrink()
          : Text.rich(
              TextSpan(
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 24,
                  height: 1.6,
                  color: tt.text,
                  fontWeight: FontWeight.w400,
                ),
                children: spans,
              ),
              textAlign: TextAlign.start,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = _resolveImageUrl();
    final spans = _buildTextSpans(context, widget.scene.text);

    if (widget.isWide) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: _buildImage(context, imageUrl),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 6,
                  child: _buildTextCard(context, spans),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImage(context, imageUrl),
          const SizedBox(height: 16),
          _buildTextCard(context, spans),
        ],
      ),
    );
  }
}
