import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/kid_panel.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_reading_dto.dart';
import '../data/kid_reading_repository.dart';
import 'kid_scene_grid.dart';
import 'kid_voice_recorder.dart';

/// Bước 5: "Chỗ nào em còn thắc mắc? (n/5)" của màn sau khi đọc truyện.
///
/// Cho phép bé chọn tối đa 5 hình cảnh truyện để gửi câu hỏi (chữ hoặc giọng nói)
/// về cho phụ huynh giải đáp.
class KidQuestionsStep extends ConsumerStatefulWidget {
  const KidQuestionsStep({
    super.key,
    required this.sessionId,
    required this.tiles,
    required this.askedKeys,
    required this.onAsked,
  });

  /// ID của phiên đọc truyện hiện tại.
  final int sessionId;

  /// Danh sách các ô tranh cảnh truyện bé có thể chọn.
  final List<KidSceneTile> tiles;

  /// Tập các key ô tranh đã gửi câu hỏi (do màn cha quản lý).
  final Set<String> askedKeys;

  /// Callback gọi khi câu hỏi gửi thành công hoặc khi cảnh đã được hỏi (409).
  final void Function(KidSceneTile tile) onAsked;

  @override
  ConsumerState<KidQuestionsStep> createState() => _KidQuestionsStepState();
}

class _KidQuestionsStepState extends ConsumerState<KidQuestionsStep> {
  late final TextEditingController _textController;
  String? _pickedKey;
  String? _audioPath;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _clearSelection() {
    setState(() {
      _pickedKey = null;
      _textController.clear();
      _audioPath = null;
    });
  }

  Future<void> _sendQuestion(KidSceneTile tile) async {
    if (_sending) return;

    final trimmedText = _textController.text.trim();
    final hasAudio = _audioPath != null && _audioPath!.trim().isNotEmpty;

    if (trimmedText.isEmpty && !hasAudio) return;

    setState(() {
      _sending = true;
    });

    try {
      final repo = ref.read(kidReadingRepositoryProvider);
      await repo.summaryQuestion(
        widget.sessionId,
        sceneId: tile.sceneId,
        beatOrder: tile.beatOrder,
        text: trimmedText.isNotEmpty ? trimmedText : null,
        audioPath: hasAudio ? _audioPath : null,
      );

      if (!mounted) return;

      _clearSelection();
      widget.onAsked(tile);
      showTtToast(context, 'Đã gửi cho bố mẹ', type: TtToastType.success);
    } on ApiException catch (e) {
      if (!mounted) return;

      if (e.statusCode == 409) {
        _clearSelection();
        widget.onAsked(tile);
        showTtToast(context, e.message, type: TtToastType.error);
      } else {
        setState(() {
          _sending = false;
        });
        showTtToast(context, e.message, type: TtToastType.error);
      }
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _sending = false;
      });
      showTtToast(
        context,
        'Có lỗi xảy ra, em thử lại nhé.',
        type: TtToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final isFull = widget.askedKeys.length >= kSummaryMaxFlags;

    KidSceneTile? pickedTile;
    if (!isFull &&
        _pickedKey != null &&
        !widget.askedKeys.contains(_pickedKey)) {
      for (final tile in widget.tiles) {
        if (tile.key == _pickedKey) {
          pickedTile = tile;
          break;
        }
      }
    }

    final hasText = _textController.text.trim().isNotEmpty;
    final hasAudio = _audioPath != null && _audioPath!.trim().isNotEmpty;
    final canSend = (hasText || hasAudio) && !_sending;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Tiêu đề
          Text(
            'Chỗ nào em còn thắc mắc? (${widget.askedKeys.length}/$kSummaryMaxFlags)',
            style: TextStyle(
              fontFamily: 'Baloo2',
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: tt.text,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Trạng thái đã đạt tối đa số câu hỏi
          if (isFull) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: tt.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: tt.primary.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_rounded, color: tt.primary, size: 26),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Em đã hỏi đủ $kSummaryMaxFlags câu rồi',
                      style: TextStyle(
                        fontFamily: 'Baloo2',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: tt.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            // Lưới chọn tranh
            KidSceneGrid(
              tiles: widget.tiles,
              pickedKey: _pickedKey,
              doneKeys: widget.askedKeys,
              disabled: _sending,
              onPick: (tile) {
                setState(() {
                  _pickedKey = tile.key;
                });
              },
            ),

            // Panel tương tác khi đã chọn ô tranh
            if (pickedTile != null) ...[
              const SizedBox(height: 16),
              KidPanel(
                borderColor: tt.gold,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Hàng ảnh to + nhãn tranh + icon đóng bỏ chọn
                    Row(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: tt.gold, width: 2.5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13.5),
                            child: TtNetworkImage(
                              url: pickedTile.imageUrl,
                              fit: BoxFit.cover,
                              radius: BorderRadius.zero,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            pickedTile.label,
                            style: TextStyle(
                              fontFamily: 'Baloo2',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: tt.text,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Bỏ chọn',
                          icon: Icon(
                            Icons.close_rounded,
                            color: tt.muted,
                            size: 24,
                          ),
                          onPressed: _sending ? null : _clearSelection,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Ghi âm câu hỏi
                    KidVoiceRecorder(
                      audioPath: _audioPath,
                      onChanged: (path) => setState(() => _audioPath = path),
                      enabled: !_sending,
                      sending: _sending,
                    ),
                    const SizedBox(height: 14),

                    // Ô nhập câu hỏi dạng chữ
                    TextField(
                      controller: _textController,
                      enabled: !_sending,
                      maxLength: 200,
                      maxLines: 2,
                      onChanged: (_) => setState(() {}),
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 15,
                        color: tt.text,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Em muốn hỏi bố mẹ điều gì?',
                        hintStyle: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: tt.muted,
                        ),
                        filled: true,
                        fillColor: tt.bg,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: tt.line2, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: tt.line2, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: tt.gold, width: 2),
                        ),
                        counterStyle: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          color: tt.muted,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Hàng nút hành động: Bỏ & Gửi bố mẹ
                    Row(
                      children: [
                        KidBtn3D(
                          label: 'Bỏ',
                          icon: Icons.close_rounded,
                          color: tt.line2,
                          foregroundColor: tt.text,
                          onPressed: _sending ? null : _clearSelection,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: KidBtn3D(
                            label: 'Gửi bố mẹ',
                            icon: Icons.send_rounded,
                            color: tt.primary,
                            expand: true,
                            big: true,
                            onPressed: canSend
                                ? () => _sendQuestion(pickedTile!)
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
