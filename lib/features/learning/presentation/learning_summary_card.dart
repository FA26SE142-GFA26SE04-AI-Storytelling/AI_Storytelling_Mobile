import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_confirm_dialog.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_profile_dto.dart';
import '../../../models/parent_story_summary_dto.dart';
import '../data/learning_repository.dart';
import 'learning_providers.dart';
import 'learning_widgets.dart';
import 'summary_audio.dart';

/// Phần bé kể lại: nghe bản ghi âm ngay trong dòng, xem cảnh bé còn thắc mắc, xoá.
class LearningSummaryCard extends ConsumerStatefulWidget {
  const LearningSummaryCard({
    super.key,
    required this.child,
    required this.summary,
    required this.audio,
    this.onDeleted,
  });

  final ChildProfileDto child;
  final ParentStorySummaryItemDto summary;
  final SummaryAudio audio;

  /// Gọi sau khi xoá thành công để chỗ chứa thẻ ẩn nó đi.
  final VoidCallback? onDeleted;

  @override
  ConsumerState<LearningSummaryCard> createState() =>
      _LearningSummaryCardState();
}

class _LearningSummaryCardState extends ConsumerState<LearningSummaryCard> {
  bool _busy = false;

  /// Link nghe hết hạn sau 15 phút: lấy lại link mới rồi bấm nghe lần nữa.
  void _playFailed() {
    if (!mounted) return;
    ref.invalidate(
      storySummaryByIdProvider((
        childId: widget.child.id,
        summaryId: widget.summary.summaryId,
      )),
    );
    showTtToast(
      context,
      'Chưa phát được bản ghi âm. Đã tải lại, hãy bấm nghe lần nữa.',
      type: TtToastType.error,
    );
  }

  Future<void> _delete() async {
    final s = widget.summary;
    final confirmed = await showConfirmDialog(
      context,
      title: 'Xoá phần kể lại?',
      message:
          'Phần ${widget.child.nickname} kể lại về “${s.title}” và bản ghi âm sẽ bị xoá, không khôi phục được.',
      confirmLabel: 'Xoá',
      destructive: true,
    );
    if (!confirmed || !mounted) return;
    setState(() => _busy = true);
    try {
      if (widget.audio.currentId == s.summaryId) await widget.audio.stop();
      await ref
          .read(learningRepositoryProvider)
          .deleteSummary(widget.child.id, s.summaryId);
      if (!mounted) return;
      showTtToast(context, 'Đã xoá phần kể lại.', type: TtToastType.success);
      ref.invalidate(storySummariesProvider(widget.child.id));
      // Lần đọc không còn phần kể lại nữa.
      ref.invalidate(readingFeedbackProvider(widget.child.id));
      widget.onDeleted?.call();
    } catch (e) {
      if (!mounted) return;
      setState(() => _busy = false);
      showTtToast(
        context,
        e is ApiException ? e.message : 'Chưa xoá được phần kể lại.',
        type: TtToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final s = widget.summary;
    final url = s.recordingUrl?.trim();

    return TtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  s.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall,
                ),
              ),
              const SizedBox(width: 8),
              TtIconButton(
                icon: Icons.delete_outline_rounded,
                tooltip: 'Xoá phần kể lại',
                size: 40,
                onPressed: _busy ? null : _delete,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              if (url != null && url.isNotEmpty)
                LearningPlayButton(
                  audio: widget.audio,
                  id: s.summaryId,
                  url: url,
                  tooltip: 'Nghe bé kể lại',
                  onFailed: _playFailed,
                )
              else
                Icon(Icons.mic_off_rounded, color: tt.muted),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  url != null && url.isNotEmpty
                      ? 'Bản ghi âm'
                      : '${widget.child.nickname} chưa ghi âm',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: url != null && url.isNotEmpty ? tt.text : tt.muted,
                  ),
                ),
              ),
              LearningChip(
                label: learningDate(s.createdAt),
                color: tt.muted,
                icon: Icons.event_rounded,
              ),
            ],
          ),
          if (s.flags.isNotEmpty) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(Icons.help_outline_rounded, size: 18, color: tt.goldDeep),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Chỗ ${widget.child.nickname} còn thắc mắc',
                    style: textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            for (final f in s.flags) _FlagRow(flag: f),
          ],
        ],
      ),
    );
  }
}

/// Một cảnh bé còn thắc mắc: ảnh nhỏ + chữ rút gọn, bấm để xem hết.
class _FlagRow extends StatefulWidget {
  const _FlagRow({required this.flag});

  final ParentStorySummaryFlagDto flag;

  @override
  State<_FlagRow> createState() => _FlagRowState();
}

class _FlagRowState extends State<_FlagRow> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final f = widget.flag;
    return InkWell(
      borderRadius: BorderRadius.circular(TtRadius.md),
      onTap: () => setState(() => _open = !_open),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TtNetworkImage(
              url: f.illustrationUrl,
              width: 64,
              height: 64,
              radius: const BorderRadius.all(Radius.circular(TtRadius.sm)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LearningChip(
                    label: 'Cảnh ${f.sceneIndex + 1}',
                    color: tt.goldDeep,
                    fill: tt.gold,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    f.sceneText,
                    maxLines: _open ? null : 2,
                    overflow: _open
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Nút nghe / tạm dừng một bản ghi âm (vàng); [id] khác nhau cho mỗi bản ghi.
class LearningPlayButton extends StatelessWidget {
  const LearningPlayButton({
    super.key,
    required this.audio,
    required this.id,
    required this.url,
    required this.tooltip,
    required this.onFailed,
  });

  final SummaryAudio audio;
  final int id;
  final String url;
  final String tooltip;

  /// Gọi khi không mở được bản ghi (thường do link hết hạn).
  final VoidCallback onFailed;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return ListenableBuilder(
      listenable: audio,
      builder: (context, _) {
        final playing = audio.isPlaying(id);
        return IconButton.filled(
          tooltip: playing ? 'Tạm dừng' : tooltip,
          onPressed: () async {
            final ok = await audio.toggle(id, url);
            if (!ok && context.mounted) onFailed();
          },
          style: IconButton.styleFrom(
            backgroundColor: tt.gold,
            foregroundColor: tt.text,
            side: BorderSide(color: tt.goldDeep, width: 1.5),
          ),
          icon: Icon(playing ? Icons.pause_rounded : Icons.play_arrow_rounded),
        );
      },
    );
  }
}
