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
    final style = Theme.of(context).textTheme.titleMedium
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
          Expanded(
            child: Text(
              title,
              style: style,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// Đường cong nảy về khi thả nút (cubic-bezier(.3, 1.5, .5, 1) của web).
const Curve kKidBounceCurve = Cubic(0.3, 1.5, 0.5, 1);

/// Nút nổi 3D kiểu trẻ em với hiệu ứng nhấn xuống.
class KidBtn3D extends StatefulWidget {
  const KidBtn3D({
    super.key,
    required this.label,
    required this.color,
    this.onPressed,
    this.icon,
    this.expand = false,
    this.foregroundColor = Colors.white,
    this.big = false,
  });

  final String label;
  final Color color;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;

  /// Màu chữ và icon; nền sáng (vàng, hồng) nên dùng chữ sẫm.
  final Color foregroundColor;

  /// Nút chính cỡ lớn: cao 76, chữ Baloo2 in hoa.
  final bool big;

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
    final big = widget.big;
    final shadowH = _pressed ? 2.0 : 6.0;
    final translateY = _pressed ? 4.0 : 0.0;
    final fg = disabled
        ? widget.foregroundColor.withValues(alpha: 0.6)
        : widget.foregroundColor;
    final labelStyle = big
        ? TextStyle(
            fontFamily: 'Baloo2',
            fontSize: 24,
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: 0.5,
            color: fg,
          )
        : Theme.of(context).textTheme.labelLarge
              ?.copyWith(fontWeight: FontWeight.w800, color: fg);

    Widget content = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, size: big ? 30 : 20, color: fg),
          SizedBox(width: big ? 8 : 6),
        ],
        Flexible(
          // Nút to: thu nhỏ chữ cho vừa nút hẹp thay vì cắt "…".
          child: big
              ? FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.label.toUpperCase(),
                    style: labelStyle,
                    maxLines: 1,
                  ),
                )
              : Text(
                  widget.label,
                  style: labelStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ],
    );

    final radius = BorderRadius.circular(big ? 24 : 16);
    final reduce = MediaQuery.disableAnimationsOf(context);
    Widget btn = GestureDetector(
      onTapDown: disabled ? null : _onTapDown,
      onTapUp: disabled ? null : _onTapUp,
      onTapCancel: disabled ? null : _onTapCancel,
      onTap: widget.onPressed,
      // Giống .kid-btn3d web: nhấn lún nhanh 0.12s, thả nảy về bằng đường cong vượt nhẹ.
      child: AnimatedContainer(
        duration: reduce
            ? Duration.zero
            : Duration(milliseconds: _pressed ? 120 : 350),
        curve: _pressed ? Curves.linear : kKidBounceCurve,
        transform: Matrix4.translationValues(0, translateY, 0),
        constraints: BoxConstraints(minHeight: big ? 76 : 0),
        alignment: big ? Alignment.center : null,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: big ? 14 : 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.lerp(bg, Colors.white, 0.4)!, bg],
          ),
          borderRadius: radius,
          boxShadow: [
            BoxShadow(color: shadow, offset: Offset(0, shadowH), blurRadius: 0),
          ],
        ),
        // Viền vẽ đè (foregroundDecoration) để không đổi kích thước nút ở các màn đang dùng.
        foregroundDecoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: shadow, width: 3),
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
