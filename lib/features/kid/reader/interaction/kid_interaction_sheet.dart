import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/theme/tt_colors.dart';
import '../../../../core/theme/tt_radius.dart';
import '../../../../core/widgets/tt_button.dart';
import '../../../../core/widgets/tt_frog.dart';
import '../../../../core/widgets/tt_toast.dart';
import '../../../../models/listening_dto.dart';
import '../../../../models/reading_interaction_dto.dart';
import '../media/authed_media.dart';
import '../reader_controller.dart';
import 'interaction_body.dart';

/// Hiển thị hộp thoại câu hỏi tương tác khi nghe truyện của bé.
Future<void> showKidInteractionDialog(
  BuildContext context, {
  required int storyId,
  required ReadingInteractionDto q,
}) =>
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => KidInteractionDialog(storyId: storyId, q: q),
    );

/// Widget hộp thoại tương tác đọc truyện cho bé.
class KidInteractionDialog extends ConsumerStatefulWidget {
  const KidInteractionDialog({
    super.key,
    required this.storyId,
    required this.q,
  });

  /// Mã câu chuyện đang đọc.
  final int storyId;

  /// Dữ liệu câu hỏi tương tác.
  final ReadingInteractionDto q;

  @override
  ConsumerState<KidInteractionDialog> createState() => _KidInteractionDialogState();
}

class _KidInteractionDialogState extends ConsumerState<KidInteractionDialog> {
  late final AudioPlayer _audioPlayer;
  late final TextEditingController _textController;

  /// Danh sách id các đáp án đã chọn theo thứ tự (cho EventOrdering).
  final List<int> _selectedOptionIds = [];

  /// Đang gửi câu trả lời lên máy chủ.
  bool _isSubmitting = false;

  /// Đang trong quá trình xếp lại thứ tự (state local).
  bool _isRetrying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _textController.dispose();
    super.dispose();
  }

  /// Phát âm thanh qua AudioPlayer riêng của hộp thoại.
  Future<void> _playAudio(String url) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url)));
      await _audioPlayer.play();
    } catch (_) {
      // Bỏ qua lỗi phát âm thanh
    }
  }

  /// Gửi câu trả lời tương tác.
  Future<void> _submit(ListeningAttemptRequestDto? body) async {
    if (body == null || _isSubmitting) return;
    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(readerControllerProvider(widget.storyId).notifier)
          .submitAttempt(widget.q, body);
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _isRetrying = false;
        });
      }
    }
  }

  /// Đóng hộp thoại tương tác.
  void _close() {
    ref
        .read(readerControllerProvider(widget.storyId).notifier)
        .closeInteraction();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final readerState = ref.watch(readerControllerProvider(widget.storyId));

    // Lắng nghe thông báo toast nếu có
    ref.listen<String?>(
      readerControllerProvider(widget.storyId).select((s) => s.notice),
      (prev, next) {
        if (next != null && next.isNotEmpty) {
          showTtToast(context, next, type: TtToastType.info);
          ref
              .read(readerControllerProvider(widget.storyId).notifier)
              .clearNotice();
        }
      },
    );

    // Lắng nghe kết quả để phát âm thanh phản hồi
    ref.listen<ListeningAttemptResultDto?>(
      readerControllerProvider(widget.storyId).select((s) => s.attemptResult),
      (prev, next) {
        if (next != null && next.interactionId == widget.q.id) {
          final audioUrl = next.feedbackAudioUrl;
          if (audioUrl != null && audioUrl.trim().isNotEmpty) {
            _playAudio(audioUrl.trim());
          }
        }
      },
    );

    final rawResult = readerState.attemptResult;
    final attemptResult =
        (rawResult?.interactionId == widget.q.id) ? rawResult : null;
    final hasResult = attemptResult != null && !_isRetrying;

    final frogMood = attemptResult == null
        ? TtFrogMood.idle
        : (attemptResult.matched == false
            ? TtFrogMood.think
            : TtFrogMood.happy);

    final type = widget.q.type;
    final isChoiceType = kChoiceTypes.contains(type);
    final isOrdering = isEventOrdering(type);
    final isFillBlank = type == 'FillBlank';
    final isRolePlay = type == 'RolePlay';
    final isOtherType =
        !isChoiceType && !isOrdering && !isFillBlank && !isRolePlay;

    return Dialog(
      backgroundColor: tt.panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TtRadius.xl),
        side: BorderSide(color: tt.line2, width: 2),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Linh vật ếch
            Center(child: TtFrog(mood: frogMood, size: 80)),
            const SizedBox(height: 16),

            // Câu hỏi / Lời nhắc
            if (widget.q.prompt != null && widget.q.prompt!.trim().isNotEmpty) ...[
              Text(
                widget.q.prompt!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: tt.text,
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Thân câu hỏi theo từng loại. Sau khi trả lời thì ẩn phần đáp án để
            // phản hồi và nút "Đọc tiếp" hiện ngay, không bị đẩy xuống dưới mép hộp.
            if (hasResult) ...[
              // Kết quả hiển thị ở dưới.
            ] else if (isChoiceType) ...[
              _buildChoiceBody(context, hasResult),
              if (!hasResult) ...[
                const SizedBox(height: 16),
                SizedBox(
                  height: 64,
                  child: TtButton(
                    label: 'Để sau',
                    variant: TtButtonVariant.secondary,
                    expanded: true,
                    onPressed: _isSubmitting ? null : _close,
                  ),
                ),
              ],
            ] else if (isFillBlank) ...[
              _buildFillBlankBody(context, hasResult),
            ] else if (isOrdering) ...[
              _buildOrderingBody(context, hasResult),
            ] else if (isRolePlay) ...[
              _buildRolePlayBody(context, hasResult),
            ] else if (isOtherType) ...[
              const SizedBox(height: 24),
              SizedBox(
                height: 64,
                child: TtButton(
                  label: 'Đọc tiếp',
                  icon: Icons.arrow_forward_rounded,
                  expanded: true,
                  onPressed: _close,
                ),
              ),
            ],

            // Kết quả sau khi trả lời
            if (hasResult) ...[
              const SizedBox(height: 24),
              _buildResultBody(context, attemptResult),
            ],
          ],
        ),
      ),
    );
  }

  /// Xây dựng giao diện cho dạng Checkpoint và PicturePrediction.
  Widget _buildChoiceBody(BuildContext context, bool hasResult) {
    final tt = context.tt;
    final isPicture = widget.q.type == 'PicturePrediction';

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 12) / 2;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: widget.q.options.map((opt) {
            final showImage = isPicture || (opt.imageUrl != null && opt.imageUrl!.isNotEmpty);
            final isDisabled = _isSubmitting || hasResult;

            return SizedBox(
              width: itemWidth,
              child: Material(
                color: tt.surface,
                borderRadius: BorderRadius.circular(TtRadius.lg),
                child: InkWell(
                  onTap: isDisabled
                      ? null
                      : () => _submit(buildAttemptBody(widget.q, optionId: opt.id)),
                  borderRadius: BorderRadius.circular(TtRadius.lg),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(TtRadius.lg),
                      border: Border.all(color: tt.line2, width: 1.5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 64),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (showImage && opt.imageUrl != null) ...[
                            AuthedAwareImage(
                              url: opt.imageUrl,
                              height: 80,
                              fit: BoxFit.cover,
                              radius: BorderRadius.circular(TtRadius.md),
                            ),
                            const SizedBox(height: 8),
                          ],
                          Text(
                            opt.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: isDisabled ? tt.muted : tt.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  /// Xây dựng giao diện cho dạng FillBlank.
  Widget _buildFillBlankBody(BuildContext context, bool hasResult) {
    final tt = context.tt;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.q.maskedSentence != null && widget.q.maskedSentence!.trim().isNotEmpty) ...[
          Text(
            widget.q.maskedSentence!,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: tt.text,
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (widget.q.hint != null && widget.q.hint!.trim().isNotEmpty) ...[
          Text(
            'Gợi ý: ${widget.q.hint!}',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: tt.muted,
            ),
          ),
          const SizedBox(height: 16),
        ],
        TextField(
          controller: _textController,
          enabled: !hasResult && !_isSubmitting,
          maxLength: 100,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 22,
            color: tt.text,
          ),
          decoration: InputDecoration(
            labelText: 'Chữ em điền',
            labelStyle: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 20,
              color: tt.muted,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(TtRadius.lg),
              borderSide: BorderSide(color: tt.line2, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(TtRadius.lg),
              borderSide: BorderSide(color: tt.line2, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(TtRadius.lg),
              borderSide: BorderSide(color: tt.primary, width: 2),
            ),
          ),
          onChanged: (_) => setState(() {}),
        ),
        if (!hasResult) ...[
          const SizedBox(height: 16),
          SizedBox(
            height: 64,
            child: TtButton(
              label: 'Xong',
              icon: Icons.check_rounded,
              expanded: true,
              onPressed: (_textController.text.trim().isEmpty || _isSubmitting)
                  ? null
                  : () => _submit(buildAttemptBody(widget.q, answer: _textController.text)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 64,
            child: TtButton(
              label: 'Để sau',
              variant: TtButtonVariant.secondary,
              expanded: true,
              onPressed: _isSubmitting ? null : _close,
            ),
          ),
        ],
      ],
    );
  }

  /// Xây dựng giao diện cho dạng EventOrdering.
  Widget _buildOrderingBody(BuildContext context, bool hasResult) {
    final tt = context.tt;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...widget.q.options.map((opt) {
          final selectedIdx = _selectedOptionIds.indexOf(opt.id);
          final isSelected = selectedIdx != -1;
          final isDisabled = isSelected || _isSubmitting || hasResult;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Material(
              color: isSelected ? tt.surface2.withValues(alpha: 0.6) : tt.surface,
              borderRadius: BorderRadius.circular(TtRadius.lg),
              child: InkWell(
                onTap: isDisabled
                    ? null
                    : () => setState(() => _selectedOptionIds.add(opt.id)),
                borderRadius: BorderRadius.circular(TtRadius.lg),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(TtRadius.lg),
                    border: Border.all(
                      color: isSelected ? tt.primary : tt.line2,
                      width: 1.5,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 64),
                    child: Row(
                      children: [
                        if (isSelected) ...[
                          Container(
                            width: 36,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: tt.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${selectedIdx + 1}',
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: Text(
                            opt.text,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? tt.muted : tt.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
        if (!hasResult) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 64,
                  child: TtButton(
                    label: 'Xếp lại',
                    icon: Icons.refresh_rounded,
                    variant: TtButtonVariant.secondary,
                    onPressed: (_selectedOptionIds.isEmpty || _isSubmitting)
                        ? null
                        : () => setState(() => _selectedOptionIds.clear()),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 64,
                  child: TtButton(
                    label: 'Xong',
                    icon: Icons.check_rounded,
                    onPressed: (_selectedOptionIds.length == widget.q.options.length && !_isSubmitting)
                        ? () {
                            _submit(buildAttemptBody(widget.q, orderedOptionIds: _selectedOptionIds));
                          }
                        : null,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 64,
            child: TtButton(
              label: 'Để sau',
              variant: TtButtonVariant.secondary,
              expanded: true,
              onPressed: _isSubmitting ? null : _close,
            ),
          ),
        ],
      ],
    );
  }

  /// Xây dựng giao diện cho dạng RolePlay.
  Widget _buildRolePlayBody(BuildContext context, bool hasResult) {
    final tt = context.tt;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.q.characterName != null && widget.q.characterName!.trim().isNotEmpty) ...[
          Text(
            widget.q.characterName!,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: tt.primaryStrong,
            ),
          ),
          const SizedBox(height: 8),
        ],
        if (widget.q.modelSentence != null && widget.q.modelSentence!.trim().isNotEmpty) ...[
          Text(
            widget.q.modelSentence!,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 22,
              color: tt.text,
            ),
          ),
          const SizedBox(height: 20),
        ],
        if (!hasResult) ...[
          SizedBox(
            height: 64,
            child: TtButton(
              label: 'Nghe mẫu',
              icon: Icons.volume_up_rounded,
              variant: TtButtonVariant.secondary,
              expanded: true,
              onPressed: (widget.q.modelAudioUrl == null ||
                      widget.q.modelAudioUrl!.trim().isEmpty ||
                      _isSubmitting)
                  ? null
                  : () => _playAudio(widget.q.modelAudioUrl!.trim()),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 64,
            child: TtButton(
              label: 'Em nói xong rồi',
              icon: Icons.check_rounded,
              expanded: true,
              onPressed: _isSubmitting
                  ? null
                  : () => _submit(buildAttemptBody(widget.q)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 64,
            child: TtButton(
              label: 'Để sau',
              variant: TtButtonVariant.secondary,
              expanded: true,
              onPressed: _isSubmitting ? null : _close,
            ),
          ),
        ],
      ],
    );
  }

  /// Xây dựng khối hiển thị kết quả sau khi gửi câu trả lời.
  Widget _buildResultBody(BuildContext context, ListeningAttemptResultDto result) {
    final tt = context.tt;

    final String feedbackText;
    if (result.feedback != null && result.feedback!.trim().isNotEmpty) {
      feedbackText = result.feedback!.trim();
    } else if (result.matched == false) {
      feedbackText = 'Gần đúng rồi, em thử lại nhé!';
    } else {
      feedbackText = 'Em làm tốt lắm!';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Chữ phản hồi
        Text(
          feedbackText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: result.matched == false ? tt.warnInk : tt.primaryStrong,
          ),
        ),

        // Gợi ý đáp án điền từ
        if (result.suggestedAnswer != null && result.suggestedAnswer!.trim().isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'Chữ cần điền là: ${result.suggestedAnswer!.trim()}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: tt.text,
            ),
          ),
        ],

        // Thứ tự đúng cho EventOrdering khi revealed
        if (result.revealed &&
            result.correctOrderOptionIds != null &&
            result.correctOrderOptionIds!.isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: tt.surface,
              borderRadius: BorderRadius.circular(TtRadius.lg),
              border: Border.all(color: tt.line2, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thứ tự đúng là:',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: tt.text,
                  ),
                ),
                const SizedBox(height: 8),
                ...(() {
                  final optionMap = {
                    for (final o in widget.q.options) o.id: o.text
                  };
                  final correctIds = result.correctOrderOptionIds!;
                  return correctIds.asMap().entries.map((entry) {
                    final index = entry.key + 1;
                    final text = optionMap[entry.value] ?? '';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        '$index. $text',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 22,
                          color: tt.text,
                        ),
                      ),
                    );
                  });
                })(),
              ],
            ),
          ),
        ],

        // Xếp lại và nghe lại cảnh cho EventOrdering khi chưa đúng và chưa revealed
        if (widget.q.type == 'EventOrdering' &&
            result.matched == false &&
            !result.revealed) ...[
          const SizedBox(height: 12),
          SizedBox(
            height: 64,
            child: TtButton(
              label: 'Xếp lại',
              icon: Icons.refresh_rounded,
              variant: TtButtonVariant.secondary,
              expanded: true,
              onPressed: () {
                setState(() {
                  _selectedOptionIds.clear();
                  _isRetrying = true;
                });
              },
            ),
          ),
          for (final idx in result.replaySceneIndexes) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 64,
              child: TtButton(
                label: 'Nghe lại cảnh ${idx + 1}',
                icon: Icons.replay_rounded,
                variant: TtButtonVariant.secondary,
                expanded: true,
                onPressed: () {
                  ref
                      .read(readerControllerProvider(widget.storyId).notifier)
                      .replayScene(idx);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ],

        // Nút Đọc tiếp luôn xuất hiện sau khi có kết quả
        const SizedBox(height: 16),
        SizedBox(
          height: 64,
          child: TtButton(
            label: 'Đọc tiếp',
            icon: Icons.arrow_forward_rounded,
            expanded: true,
            onPressed: _close,
          ),
        ),
      ],
    );
  }
}
