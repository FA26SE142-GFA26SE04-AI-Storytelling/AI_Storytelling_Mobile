import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../models/child_reading_dto.dart';
import 'kid_caption_logic.dart';

/// Widget "Chế độ phụ đề" của màn đọc truyện bé khi xoay ngang:
/// tranh phủ toàn màn hình, chữ phụ đề ở đáy chạy theo giọng đọc,
/// thanh điều khiển nổi tự ẩn.
class KidCaptionView extends StatefulWidget {
  const KidCaptionView({
    super.key,
    this.imageUrl,
    required this.segments,
    this.vocabulary = const [],
    required this.onVocabTap,
    this.activeSegmentId,
    required this.isPlaying,
    required this.positionStream,
    required this.durationStream,
    required this.hasAudio,
    required this.topBar,
    required this.bottomBarBuilder,
    required this.onAdvancePage,
  });

  /// Đường dẫn hình ảnh minh họa cho cảnh/trang hiện tại.
  final String? imageUrl;

  /// Các đoạn nội dung của trang hiện tại.
  final List<ReadingSegment> segments;

  /// Danh sách từ vựng.
  final List<ReadingVocabulary> vocabulary;

  /// Callback khi bé chạm vào từ vựng trên phụ đề.
  final void Function(ReadingVocabulary item) onVocabTap;

  /// SegmentId đang phát âm thanh, null nếu chưa phát.
  final int? activeSegmentId;

  /// Trạng thái đang phát âm thanh.
  final bool isPlaying;

  /// Luồng cập nhật vị trí phát âm thanh.
  final Stream<Duration> positionStream;

  /// Luồng cập nhật tổng thời lượng âm thanh.
  final Stream<Duration?> durationStream;

  /// Trang hiện tại có file âm thanh giọng đọc hay không.
  final bool hasAudio;

  /// Thanh điều khiển trên cùng (do màn hình truyền vào).
  final Widget topBar;

  /// Hàm dựng thanh điều khiển đáy; nhận vào callback `onAdvance` cho nút ▶.
  final Widget Function(VoidCallback onAdvance) bottomBarBuilder;

  /// Callback chuyển sang trang kế tiếp.
  final VoidCallback onAdvancePage;

  @override
  State<KidCaptionView> createState() => _KidCaptionViewState();
}

class _KidCaptionViewState extends State<KidCaptionView> {
  Timer? _hideTimer;
  bool _controlsVisible = true;
  int _manualChunk = 0;
  final List<TapGestureRecognizer> _vocabRecognizers = [];

  @override
  void initState() {
    super.initState();
    _controlsVisible = true;
    if (widget.isPlaying) {
      _startHideTimer();
    }
  }

  @override
  void didUpdateWidget(covariant KidCaptionView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _startHideTimer();
      } else {
        _cancelHideTimer();
        _controlsVisible = true;
      }
    }

    final bool segmentsChanged =
        widget.segments.length != oldWidget.segments.length ||
        (widget.segments.isNotEmpty &&
            oldWidget.segments.isNotEmpty &&
            widget.segments.first.segmentId !=
                oldWidget.segments.first.segmentId);
    final bool segmentSwitched =
        widget.activeSegmentId != oldWidget.activeSegmentId;

    if (segmentsChanged || segmentSwitched) {
      _manualChunk = 0;
    }
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _clearVocabRecognizers();
    super.dispose();
  }

  void _clearVocabRecognizers() {
    for (final recognizer in _vocabRecognizers) {
      recognizer.dispose();
    }
    _vocabRecognizers.clear();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && widget.isPlaying) {
        setState(() {
          _controlsVisible = false;
        });
      }
    });
  }

  void _cancelHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = null;
  }

  void _revealControls() {
    if (!_controlsVisible) {
      setState(() {
        _controlsVisible = true;
      });
    }
    if (widget.isPlaying) {
      _startHideTimer();
    } else {
      _cancelHideTimer();
    }
  }

  void _onTapBackground() {
    _revealControls();
  }

  ReadingSegment? _resolveCurrentSegment() {
    if (widget.segments.isEmpty) return null;
    if (widget.activeSegmentId != null) {
      for (final s in widget.segments) {
        if (s.segmentId == widget.activeSegmentId) {
          return s;
        }
      }
    }
    return widget.segments.first;
  }

  void _handleAdvance() {
    _revealControls();
    if (widget.hasAudio) {
      widget.onAdvancePage();
      return;
    }
    final segment = _resolveCurrentSegment();
    if (segment == null) {
      widget.onAdvancePage();
      return;
    }
    final chunks = splitCaptionChunks(segment.text);
    if (chunks.isEmpty || _manualChunk >= chunks.length - 1) {
      widget.onAdvancePage();
    } else {
      setState(() {
        _manualChunk++;
      });
    }
  }

  void _handleCaptionTap() {
    _revealControls();
    if (!widget.hasAudio) {
      _handleAdvance();
    }
  }

  bool _isWordChar(String char) {
    return RegExp(r'[\p{L}\p{N}]', unicode: true).hasMatch(char);
  }

  List<({int start, int end, ReadingVocabulary vocab, TapGestureRecognizer recognizer})>
      _findVocabMatches(String chunk) {
    if (widget.vocabulary.isEmpty || chunk.isEmpty) {
      return const [];
    }

    final candidateMatches =
        <({int start, int end, ReadingVocabulary vocab, bool isWholeWord})>[];

    for (final v in widget.vocabulary) {
      final term = v.term.trim();
      if (term.isEmpty) continue;

      final regex = RegExp(RegExp.escape(term), caseSensitive: false);
      final itemMatches =
          <({int start, int end, ReadingVocabulary vocab, bool isWholeWord})>[];
      for (final m in regex.allMatches(chunk)) {
        final bool beforeOk = m.start == 0 || !_isWordChar(chunk[m.start - 1]);
        final bool afterOk =
            m.end == chunk.length || !_isWordChar(chunk[m.end]);
        itemMatches.add((
          start: m.start,
          end: m.end,
          vocab: v,
          isWholeWord: beforeOk && afterOk,
        ));
      }
      final whole = itemMatches.where((m) => m.isWholeWord).toList();
      candidateMatches.addAll(whole.isNotEmpty ? whole : itemMatches);
    }

    if (candidateMatches.isEmpty) {
      return const [];
    }

    candidateMatches.sort((a, b) {
      final cmp = a.start.compareTo(b.start);
      if (cmp != 0) return cmp;
      if (a.isWholeWord != b.isWholeWord) {
        return a.isWholeWord ? -1 : 1;
      }
      return (b.end - b.start).compareTo(a.end - a.start);
    });

    final result =
        <({int start, int end, ReadingVocabulary vocab, TapGestureRecognizer recognizer})>[];
    int lastEnd = 0;
    for (final m in candidateMatches) {
      if (m.start >= lastEnd) {
        final recognizer = TapGestureRecognizer()
          ..onTap = () {
            if (mounted) {
              widget.onVocabTap(m.vocab);
            }
          };
        _vocabRecognizers.add(recognizer);
        result.add((
          start: m.start,
          end: m.end,
          vocab: m.vocab,
          recognizer: recognizer,
        ));
        lastEnd = m.end;
      }
    }

    return result;
  }

  Widget _buildChunkText(
    String chunk, {
    int? highlightStart,
    int? highlightEnd,
  }) {
    final tt = context.tt;
    _clearVocabRecognizers();

    final vocabMatches = _findVocabMatches(chunk);

    final splitPoints = <int>{0, chunk.length};
    final bool hasHighlight = highlightStart != null &&
        highlightEnd != null &&
        highlightStart < highlightEnd;

    if (hasHighlight) {
      splitPoints.add(highlightStart.clamp(0, chunk.length));
      splitPoints.add(highlightEnd.clamp(0, chunk.length));
    }
    for (final vm in vocabMatches) {
      splitPoints.add(vm.start);
      splitPoints.add(vm.end);
    }

    final sortedPoints = splitPoints.toList()..sort();
    final spans = <InlineSpan>[];

    for (int i = 0; i < sortedPoints.length - 1; i++) {
      final start = sortedPoints[i];
      final end = sortedPoints[i + 1];
      if (start >= end) continue;

      final text = chunk.substring(start, end);

      Color color = Colors.white;
      FontWeight fontWeight = FontWeight.w700;

      if (hasHighlight) {
        if (end <= highlightStart) {
          color = Colors.white;
          fontWeight = FontWeight.w700;
        } else if (start >= highlightEnd) {
          color = Colors.white.withValues(alpha: 0.75);
          fontWeight = FontWeight.w700;
        } else {
          color = tt.gold;
          fontWeight = FontWeight.w900;
        }
      }

      TapGestureRecognizer? recognizer;
      TextDecoration? decoration;
      Color? decorationColor;
      double? decorationThickness;

      for (final vm in vocabMatches) {
        if (start >= vm.start && end <= vm.end) {
          decoration = TextDecoration.underline;
          decorationColor = tt.gold;
          decorationThickness = 2;
          recognizer = vm.recognizer;
          break;
        }
      }

      spans.add(
        TextSpan(
          text: text,
          recognizer: recognizer,
          style: TextStyle(
            color: color,
            fontWeight: fontWeight,
            decoration: decoration,
            decorationColor: decorationColor,
            decorationThickness: decorationThickness,
          ),
        ),
      );
    }

    return Text.rich(
      TextSpan(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          fontFamily: 'Nunito',
        ),
        children: spans,
      ),
      key: ValueKey<String>(chunk),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCaptionBox(
    BuildContext context,
    String chunk, {
    int? highlightStart,
    int? highlightEnd,
  }) {
    final disableAnimations =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final duration =
        disableAnimations ? Duration.zero : const Duration(milliseconds: 200);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _handleCaptionTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              child: AnimatedSwitcher(
                duration: duration,
                transitionBuilder: (child, animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(0.0, 0.15),
                    end: Offset.zero,
                  ).animate(animation);

                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    ),
                  );
                },
                child: _buildChunkText(
                  chunk,
                  highlightStart: highlightStart,
                  highlightEnd: highlightEnd,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCaptionArea(BuildContext context, ReadingSegment? segment) {
    if (segment == null) {
      return const SizedBox.shrink();
    }

    final chunks = splitCaptionChunks(segment.text);
    if (chunks.isEmpty) {
      return const SizedBox.shrink();
    }

    final bool isActivelyPlaying = widget.isPlaying &&
        widget.hasAudio &&
        widget.activeSegmentId != null &&
        widget.activeSegmentId == segment.segmentId;

    if (isActivelyPlaying) {
      return StreamBuilder<Duration>(
        stream: widget.positionStream,
        builder: (context, posSnapshot) {
          return StreamBuilder<Duration?>(
            stream: widget.durationStream,
            builder: (context, durSnapshot) {
              final positionSec = posSnapshot.hasData
                  ? posSnapshot.data!.inMilliseconds / 1000.0
                  : 0.0;
              final durationSec = durSnapshot.data != null
                  ? durSnapshot.data!.inMilliseconds / 1000.0
                  : null;
              final timings = parseWordTimings(segment.wordTimingsJson);
              final chunkIndex = pickChunkIndex(
                chunks,
                timings: timings,
                text: segment.text,
                positionSec: positionSec,
                durationSec: durationSec,
              );
              final safeIndex = chunkIndex.clamp(0, chunks.length - 1);
              final chunk = chunks[safeIndex];

              int? highlightStart;
              int? highlightEnd;

              if (timings.isNotEmpty) {
                final charIdx = charInSegment(
                  segment.text,
                  timings,
                  positionSec,
                  durationSec ?? 0.0,
                );
                final chunkStart = segment.text.indexOf(chunk);
                if (chunkStart >= 0) {
                  final wordRange = wordAt(segment.text, charIdx);
                  if (wordRange != null) {
                    final hStart =
                        (wordRange.start - chunkStart).clamp(0, chunk.length);
                    final hEnd =
                        (wordRange.end - chunkStart).clamp(0, chunk.length);
                    if (hStart < hEnd) {
                      highlightStart = hStart;
                      highlightEnd = hEnd;
                    }
                  }
                }
              }

              return _buildCaptionBox(
                context,
                chunk,
                highlightStart: highlightStart,
                highlightEnd: highlightEnd,
              );
            },
          );
        },
      );
    }

    final safeIndex = _manualChunk.clamp(0, chunks.length - 1);
    return _buildCaptionBox(context, chunks[safeIndex]);
  }

  Widget _buildControlsOverlay(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: !_controlsVisible,
        child: AnimatedOpacity(
          opacity: _controlsVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Thanh trên (topBar) với gradient đen mờ
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: widget.topBar,
                ),
              ),
              const Spacer(),
              // Thanh đáy (bottomBar) với gradient đen mờ
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: widget.bottomBarBuilder(_handleAdvance),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentSegment = _resolveCurrentSegment();

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Nền tranh phủ toàn màn hình
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _onTapBackground,
            child: TtWholeImage(url: widget.imageUrl),
          ),
        ),

        // 2. Phụ đề nổi trên tranh, căn giữa ngay trên thanh đáy
        _buildCaptionArea(context, currentSegment),

        // 3. Thanh điều khiển nổi trên tranh tự ẩn
        _buildControlsOverlay(context),
      ],
    );
  }
}
