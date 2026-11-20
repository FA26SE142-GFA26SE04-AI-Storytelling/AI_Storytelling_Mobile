import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/kid_panel.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_toast.dart';
import '../data/kid_reading_repository.dart';
import 'kid_scene_grid.dart';
import 'kid_voice_recorder.dart';

/// Trang 3 "Điều gì em thích ở tranh này?" của màn hình sau khi đọc xong truyện.
class KidFavoriteStep extends ConsumerStatefulWidget {
  const KidFavoriteStep({
    super.key,
    required this.sessionId,
    this.pickedTile,
    this.canRecord = true,
    required this.onBackToPick,
    required this.onSent,
  });

  /// Mã phiên đọc truyện.
  final int sessionId;

  /// Ô tranh bé đã chọn ở trang 2 (null nếu chưa chọn tranh nào).
  final KidSceneTile? pickedTile;

  /// Cờ cho phép ghi âm lấy từ thông tin suy ngẫm truyện.
  final bool canRecord;

  /// Quay lại trang 2 để chọn lại tranh.
  final VoidCallback onBackToPick;

  /// Sang trang tiếp theo sau khi gửi thành công.
  final VoidCallback onSent;

  @override
  ConsumerState<KidFavoriteStep> createState() => _KidFavoriteStepState();
}

class _KidFavoriteStepState extends ConsumerState<KidFavoriteStep> {
  late bool _canRecord;
  late final TextEditingController _textController;
  String? _audioPath;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _canRecord = widget.canRecord;
    _textController = TextEditingController();
    _textController.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant KidFavoriteStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.canRecord != widget.canRecord) {
      _canRecord = widget.canRecord;
    }
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    if (_sending) return;

    final trimmed = _textController.text.trim();
    final hasText = trimmed.isNotEmpty;
    final hasAudio = _audioPath != null;

    if (!hasText && !hasAudio) return;

    setState(() {
      _sending = true;
    });

    try {
      final repo = ref.read(kidReadingRepositoryProvider);
      await repo.reflectionNote(
        widget.sessionId,
        text: hasText ? trimmed : null,
        audioPath: _audioPath,
      );

      if (!mounted) return;
      showTtToast(context, 'Đã gửi cho bố mẹ', type: TtToastType.success);
      widget.onSent();
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 409) {
        showTtToast(context, e.message, type: TtToastType.error);
        widget.onBackToPick();
      } else if (e.statusCode == 403) {
        setState(() {
          _canRecord = false;
          _audioPath = null;
        });
        showTtToast(context, e.message, type: TtToastType.error);
      } else {
        showTtToast(context, e.message, type: TtToastType.error);
      }
    } catch (e) {
      if (!mounted) return;
      final message = e is ApiException
          ? e.message
          : 'Có lỗi xảy ra. Vui lòng thử lại.';
      showTtToast(context, message, type: TtToastType.error);
    } finally {
      if (mounted) {
        setState(() {
          _sending = false;
        });
      }
    }
  }

  Widget _buildEmptyState(TtColors tt) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Icon(Icons.photo_library_rounded, size: 72, color: tt.goldDeep),
              const SizedBox(height: 16),
              Text(
                'Em chọn tranh em thích nhất trước nhé',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: tt.text,
                ),
              ),
              const SizedBox(height: 24),
              KidBtn3D(
                label: 'Chọn tranh',
                icon: Icons.photo_library_rounded,
                color: tt.primary,
                expand: true,
                big: true,
                onPressed: widget.onBackToPick,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(TtColors tt, KidSceneTile tile) {
    final trimmed = _textController.text.trim();
    final canSubmit = (trimmed.isNotEmpty || _audioPath != null) && !_sending;
    final size = MediaQuery.sizeOf(context);
    // Màn ngang: tranh trái, ô viết + nút gửi phải để không phải cuộn.
    final wide = size.width >= 600 && size.width > size.height;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: wide ? 820 : 440),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Điều gì em thích ở tranh này?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: tt.text,
                ),
              ),
              const SizedBox(height: 14),
              _sideBySide(
                wide,
                // Tranh với viền vàng dày và nhãn tranh
                Container(
                  decoration: BoxDecoration(
                    color: tt.panel,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: tt.gold, width: 3.5),
                    boxShadow: [
                      BoxShadow(
                        color: tt.goldDeep.withValues(alpha: 0.22),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Hiện trọn tranh như màn đọc (không cắt), phần thừa là tranh làm mờ.
                        // Màn ngang thấp: giới hạn cao để nút Gửi không bị đẩy xuống.
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: wide ? 130 : double.infinity,
                          ),
                          child: AspectRatio(
                            aspectRatio: 16 / 10,
                            child: TtWholeImage(url: tile.imageUrl),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          color: tt.panel,
                          child: Text(
                            tile.label,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: tt.warnInk,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                [
                  // Ô viết chia sẻ
                  TextField(
                    controller: _textController,
                    maxLength: 200,
                    maxLines: 3,
                    minLines: 2,
                    enabled: !_sending,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: tt.text,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Em viết điều em thích nhé...',
                      hintStyle: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: tt.muted,
                      ),
                      filled: true,
                      fillColor: tt.panel,
                      contentPadding: const EdgeInsets.all(14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: tt.line2, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: tt.line2, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: tt.primary, width: 2),
                      ),
                      counterStyle: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: tt.muted,
                      ),
                    ),
                  ),
                  // Thu âm giọng nói (chỉ hiện khi được phép)
                  if (_canRecord) ...[
                    const SizedBox(height: 8),
                    KidVoiceRecorder(
                      audioPath: _audioPath,
                      onChanged: _sending
                          ? (_) {}
                          : (path) => setState(() => _audioPath = path),
                      enabled: _canRecord && !_sending,
                      sending: _sending,
                    ),
                  ],
                  const SizedBox(height: 18),
                  // Nút gửi bố mẹ
                  KidBtn3D(
                    label: 'Gửi bố mẹ',
                    icon: Icons.favorite_rounded,
                    color: tt.primary,
                    expand: true,
                    big: true,
                    onPressed: canSubmit ? _handleSend : null,
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  /// Màn ngang: tranh trái, phần viết phải; màn dọc: xếp dọc.
  Widget _sideBySide(bool wide, Widget picture, List<Widget> form) {
    if (!wide) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [picture, const SizedBox(height: 14), ...form],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: picture),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: form,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final tile = widget.pickedTile;

    if (tile == null) {
      return _buildEmptyState(tt);
    }

    return _buildContent(tt, tile);
  }
}
