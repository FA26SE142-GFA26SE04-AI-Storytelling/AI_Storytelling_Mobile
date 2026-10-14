import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../../app/theme/tt_theme.dart';

enum TtButtonVariant { primary, secondary, ghost, ok, danger, kid }

/// Nút Taletale: nút chính hình lá có vân lá chìm, thu nhỏ nhẹ khi nhấn.
class TtButton extends StatefulWidget {
  const TtButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = TtButtonVariant.primary,
    this.busy = false,
    this.expand = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final TtButtonVariant variant;

  /// Đang xử lý: hiện vòng xoay và không bấm được.
  final bool busy;

  /// Giãn hết chiều ngang.
  final bool expand;

  @override
  State<TtButton> createState() => _TtButtonState();
}

class _TtButtonState extends State<TtButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    final enabled = widget.onPressed != null && !widget.busy;
    final (bg, fg, border) = switch (widget.variant) {
      TtButtonVariant.primary => (c.primaryStrong, Colors.white, null),
      TtButtonVariant.secondary => (c.surface2, c.text, c.line2),
      TtButtonVariant.ghost => (Colors.transparent, c.muted, null),
      TtButtonVariant.ok => (c.mint.withValues(alpha: 0.14), c.okInk, c.mint.withValues(alpha: 0.35)),
      TtButtonVariant.danger => (c.danger.withValues(alpha: 0.10), c.danger, c.danger.withValues(alpha: 0.30)),
      TtButtonVariant.kid => (Color.alphaBlend(c.gold.withValues(alpha: 0.22), c.panel), c.warnInk, c.gold.withValues(alpha: 0.45)),
    };
    final primary = widget.variant == TtButtonVariant.primary;
    final radius = primary ? TtRadius.leaf : BorderRadius.circular(TtRadius.md);
    final veinOpacity = switch (widget.variant) {
      TtButtonVariant.primary => 0.15,
      TtButtonVariant.ghost => 0.0,
      TtButtonVariant.secondary || TtButtonVariant.kid => 0.07,
      _ => 0.10,
    };

    final content = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.busy)
          SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2.2, color: fg))
        else if (widget.icon != null)
          Icon(widget.icon, size: 19, color: fg),
        if (widget.busy || widget.icon != null) const SizedBox(width: 8),
        Flexible(
          child: Text(
            widget.label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontFamily: TtFonts.ui, fontWeight: FontWeight.w700, fontSize: 14.5, color: fg),
          ),
        ),
      ],
    );

    return Semantics(
      button: true,
      enabled: enabled,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 120),
        child: AnimatedOpacity(
          opacity: enabled || widget.busy ? 1 : 0.45,
          duration: const Duration(milliseconds: 150),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radius,
              boxShadow: primary && enabled
                  ? [BoxShadow(color: c.primary.withValues(alpha: 0.45), blurRadius: 14, offset: const Offset(0, 4), spreadRadius: -6)]
                  : null,
            ),
            child: Material(
              color: bg,
              shape: RoundedRectangleBorder(
                borderRadius: radius,
                side: border == null ? BorderSide.none : BorderSide(color: border),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: enabled ? widget.onPressed : null,
                onHighlightChanged: (v) => setState(() => _pressed = v),
                child: CustomPaint(
                  painter: veinOpacity > 0 ? LeafVeinPainter(fg.withValues(alpha: veinOpacity)) : null,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: TtTouch.parent),
                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10), child: content),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Vân lá: gân giữa và các gân nhánh, co giãn theo kích thước nút (giống `--vein` bên web).
class LeafVeinPainter extends CustomPainter {
  const LeafVeinPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 200, sy = size.height / 40;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, 20 * sy), Offset(size.width, 20 * sy), paint..strokeWidth = 1.6);
    paint.strokeWidth = 1;
    final path = Path();
    for (var x = 18.0; x <= 148; x += 26) {
      path
        ..moveTo(x * sx, 20 * sy)
        ..quadraticBezierTo((x + 12) * sx, 14 * sy, (x + 24) * sx, 3 * sy)
        ..moveTo(x * sx, 20 * sy)
        ..quadraticBezierTo((x + 12) * sx, 26 * sy, (x + 24) * sx, 37 * sy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LeafVeinPainter old) => old.color != color;
}
