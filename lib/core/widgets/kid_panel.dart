import 'package:flutter/material.dart';

import '../theme/tt_colors.dart';

/// Panel nền mờ kiểu trẻ em với viền màu và blur nền.
class KidPanel extends StatelessWidget {
  const KidPanel({
    super.key,
    required this.child,
    this.borderColor,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Container(
      decoration: BoxDecoration(
        color: tt.panel.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor ?? tt.line2, width: 3),
        boxShadow: [
          BoxShadow(
            color: tt.text.withValues(alpha: 0.12),
            offset: const Offset(0, 6),
            blurRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Thanh tiêu đề dùng trong KidPanel với padding: EdgeInsets.zero, body tự Padding 16.
class KidPanelHeader extends StatelessWidget {
  const KidPanelHeader({
    super.key,
    required this.title,
    required this.color,
    this.icon,
    this.textColor,
  });

  final String title;
  final Color color;
  final IconData? icon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final fg = textColor ?? Colors.white;
    final style = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontWeight: FontWeight.w800, color: fg);
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(21)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 22, color: fg),
            const SizedBox(width: 8),
          ],
          Expanded(child: Text(title, style: style, maxLines: 1, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}

/// Nút nổi 3D kiểu trẻ em với hiệu ứng nhấn xuống.
class KidBtn3D extends StatefulWidget {
  const KidBtn3D({
    super.key,
    required this.label,
    required this.color,
    this.onPressed,
    this.icon,
    this.expand = false,
  });

  final String label;
  final Color color;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;

  @override
  State<KidBtn3D> createState() => _KidBtn3DState();
}

class _KidBtn3DState extends State<KidBtn3D> {
  bool _pressed = false;

  void _onTapDown(TapDownDetails _) => setState(() => _pressed = true);
  void _onTapUp(TapUpDetails _) => setState(() => _pressed = false);
  void _onTapCancel() => setState(() => _pressed = false);

  @override
  Widget build(BuildContext context) {
    final disabled = widget.onPressed == null;
    final bg = disabled ? widget.color.withValues(alpha: 0.5) : widget.color;
    final shadow = Color.alphaBlend(Colors.black.withValues(alpha: 0.35), bg);
    final shadowH = _pressed ? 2.0 : 5.0;
    final translateY = _pressed ? 3.0 : 0.0;
    final labelStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w800,
          color: disabled ? Colors.white.withValues(alpha: 0.6) : Colors.white,
        );

    Widget content = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, size: 20, color: labelStyle?.color),
          const SizedBox(width: 6),
        ],
        Flexible(
          child: Text(widget.label, style: labelStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ],
    );

    Widget btn = GestureDetector(
      onTapDown: disabled ? null : _onTapDown,
      onTapUp: disabled ? null : _onTapUp,
      onTapCancel: disabled ? null : _onTapCancel,
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        transform: Matrix4.translationValues(0, translateY, 0),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: shadow,
              offset: Offset(0, shadowH),
              blurRadius: 0,
            ),
          ],
        ),
        child: content,
      ),
    );

    if (widget.expand) {
      return SizedBox(width: double.infinity, child: btn);
    }
    return btn;
  }
}
