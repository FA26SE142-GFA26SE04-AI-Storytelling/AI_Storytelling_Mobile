import 'package:flutter/material.dart';

import 'package:ai_storytelling_mobile/core/widgets/tt_adaptive.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../library/data/library_logic.dart';

// Mảnh giao diện dùng chung cho các màn Sự kiện của phụ huynh.

/// 1500000 → '1.500.000 đ'; không có ngân sách thì [empty].
String eventBudgetText(int budget, [String empty = 'Quà / Lượt AI']) =>
    budget > 0 ? '${groupThousands(budget)} đ' : empty;

const eventGroupLabel = <String, String>{
  'open': 'Đang mở',
  'upcoming': 'Sắp diễn ra',
  'ended': 'Đã kết thúc',
};

/// Nhãn nhỏ bo tròn (trạng thái, MỚI…).
class EventTag extends StatelessWidget {
  const EventTag(this.label, {super.key, this.bg, this.fg});

  final String label;
  final Color? bg;
  final Color? fg;

  /// Nhãn nhóm: Đang mở (xanh), Sắp diễn ra (vàng), Đã kết thúc (xám).
  factory EventTag.group(BuildContext context, String group) {
    final tt = context.tt;
    final label = eventGroupLabel[group] ?? '';
    return switch (group) {
      'open' => EventTag(
        label,
        bg: tt.primary.withValues(alpha: 0.15),
        fg: tt.primaryStrong,
      ),
      'upcoming' => EventTag(
        label,
        bg: tt.gold.withValues(alpha: 0.3),
        fg: TtColors.light.inkWarm,
      ),
      _ => EventTag(label, bg: tt.surface2, fg: tt.muted),
    };
  }

  factory EventTag.isNew(BuildContext context) =>
      EventTag('MỚI', bg: context.tt.primary, fg: Colors.white);

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: bg ?? tt.surface2,
        borderRadius: BorderRadius.circular(TtRadius.full),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelLarge
            ?.copyWith(color: fg ?? tt.text),
      ),
    );
  }
}

/// Một mục thông tin: icon vàng + chữ nhỏ.
class EventMeta extends StatelessWidget {
  const EventMeta(this.icon, this.text, {super.key});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: tt.goldDeep),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: tt.text),
          ),
        ),
      ],
    );
  }
}

/// Khung chung: viền rõ, nền hơi trong suốt, tiêu đề có icon vàng.
/// [highlight] = khung vàng (mời tham gia).
class EventPanel extends StatelessWidget {
  const EventPanel({
    super.key,
    required this.child,
    this.title,
    this.icon,
    this.trailing,
    this.highlight = false,
  });

  final Widget child;
  final String? title;
  final IconData? icon;
  final Widget? trailing;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: highlight
            ? tt.gold.withValues(alpha: 0.12)
            : tt.panel.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(TtRadius.lg),
        border: Border.all(
          color: highlight ? tt.gold : tt.line2,
          width: highlight ? 1.5 : 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null) ...[
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20, color: tt.goldDeep),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    title!,
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontSize: 18),
                  ),
                ),
                ?trailing,
              ],
            ),
            const SizedBox(height: 10),
          ],
          child,
        ],
      ),
    );
  }
}

/// Nút vàng (đăng ký, nhận thưởng): chữ tối trên nền vàng ở cả hai theme.
class EventGoldButton extends StatelessWidget {
  const EventGoldButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.compact = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final ink = TtColors.light.inkWarm;
    final text = Text(label, maxLines: 1, overflow: TextOverflow.ellipsis);
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: tt.gold,
        foregroundColor: ink,
        disabledBackgroundColor: tt.gold.withValues(alpha: 0.45),
        disabledForegroundColor: ink.withValues(alpha: 0.6),
        side: BorderSide(color: tt.goldDeep, width: 1.2),
        minimumSize: Size(0, compact ? 38 : 48),
        padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 18),
        textStyle: TextStyle(
          fontFamily: 'Nunito',
          fontSize: compact ? 14 : 15,
          fontWeight: FontWeight.w800,
        ),
        shape: const RoundedRectangleBorder(borderRadius: TtRadius.leaf),
      ),
      child: icon == null
          ? text
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: compact ? 18 : 20),
                const SizedBox(width: 6),
                Flexible(child: text),
              ],
            ),
    );
  }
}

/// Popup chung của Sự kiện: tiêu đề, thân cuộn được, Huỷ + nút xác nhận.
/// [onConfirm] chạy khi bấm xác nhận (nút khoá và không đóng được popup lúc
/// đang gửi); trả true thì đóng popup. [body] nhận setState của popup để
/// cập nhật lựa chọn / ô nhập; [ready] quyết định nút xác nhận có bật không.
Future<bool> showEventDialog(
  BuildContext context, {
  required String title,
  required Widget Function(StateSetter setState) body,
  required String confirmLabel,
  required Future<bool> Function() onConfirm,
  IconData? confirmIcon,
  bool Function()? ready,
}) async =>
    await showDialog<bool>(
      context: context,
      builder: (_) => _EventDialog(
        title: title,
        body: body,
        confirmLabel: confirmLabel,
        confirmIcon: confirmIcon,
        onConfirm: onConfirm,
        ready: ready,
      ),
    ) ??
    false;

class _EventDialog extends StatefulWidget {
  const _EventDialog({
    required this.title,
    required this.body,
    required this.confirmLabel,
    required this.onConfirm,
    this.confirmIcon,
    this.ready,
  });

  final String title;
  final Widget Function(StateSetter setState) body;
  final String confirmLabel;
  final IconData? confirmIcon;
  final Future<bool> Function() onConfirm;
  final bool Function()? ready;

  @override
  State<_EventDialog> createState() => _EventDialogState();
}

class _EventDialogState extends State<_EventDialog> {
  bool _busy = false;

  Future<void> _confirm() async {
    if (_busy) return;
    setState(() => _busy = true);
    var ok = false;
    try {
      ok = await widget.onConfirm();
    } finally {
      if (mounted) {
        if (ok) {
          Navigator.of(context).pop(true);
        } else {
          setState(() => _busy = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final ready = widget.ready?.call() ?? true;
    final isWide = MediaQuery.sizeOf(context).width >= kTwoColumnMinWidth;
    return PopScope(
      canPop: !_busy,
      child: Dialog(
        backgroundColor: tt.panel,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TtRadius.xl),
          side: BorderSide(color: tt.line2, width: 1.5),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isWide ? 560 : 460,
            maxHeight: 580,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: SingleChildScrollView(child: widget.body(setState)),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TtButton(
                        label: 'Huỷ',
                        variant: TtButtonVariant.secondary,
                        onPressed: _busy
                            ? null
                            : () => Navigator.of(context).pop(false),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TtButton(
                        label: widget.confirmLabel,
                        icon: widget.confirmIcon,
                        isLoading: _busy,
                        onPressed: ready ? _confirm : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
