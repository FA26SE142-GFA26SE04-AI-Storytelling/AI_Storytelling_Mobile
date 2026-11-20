import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/kid_metrics.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/kid_panel.dart';
import 'kid_lobby_motion.dart';

/// Chữ sẫm trên nền sáng (vàng, hồng): giữ nguyên ở cả hai theme vì nền không đổi.
const Color kKidInkOnBright = Color(0xFF1F2F27);

/// Nút tròn 3D trên sảnh của bé (giống .kid-btn3d web): nền chuyển sáng → màu chính,
/// viền và bóng cứng màu đậm, icon to, nhãn ngắn bên dưới, badge số ở góc khi [badge] > 0.
/// Nhấn: lún xuống, nghiêng về phía ngón tay; thả: nảy về.
class KidStageButton extends StatefulWidget {
  const KidStageButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    this.onDown,
    this.iconColor = Colors.white,
    this.badge,
    this.badgeLabel,
    this.diameter = kKidMinTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  /// Gọi ngay khi ngón tay chạm xuống (vd cho ếch làm động tác).
  final VoidCallback? onDown;

  /// Số hiện ở góc; null hoặc 0 thì không hiện.
  final int? badge;

  /// Nghĩa của badge cho trình đọc màn hình (vd "3 huy hiệu").
  final String? badgeLabel;
  final double diameter;

  @override
  State<KidStageButton> createState() => _KidStageButtonState();
}

class _KidStageButtonState extends State<KidStageButton> {
  bool _pressed = false;

  void _setPressed(bool v) {
    if (_pressed != v) setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final reduce = MediaQuery.disableAnimationsOf(context);
    final d = widget.diameter;
    final edge = Color.alphaBlend(
      Colors.black.withValues(alpha: 0.28),
      widget.color,
    );
    final light = Color.lerp(widget.color, Colors.white, 0.45)!;
    final badge = widget.badge ?? 0;

    final circle = AnimatedContainer(
      duration: reduce
          ? Duration.zero
          : Duration(milliseconds: _pressed ? 120 : 350),
      curve: _pressed ? Curves.linear : kKidBounceCurve,
      width: d,
      height: d,
      transform: Matrix4.translationValues(0, _pressed ? 4 : 0, 0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [light, widget.color],
        ),
        border: Border.all(color: edge, width: 3),
        boxShadow: [
          BoxShadow(
            color: edge,
            offset: Offset(0, _pressed ? 2 : 6),
            blurRadius: 0,
          ),
        ],
      ),
      child: Icon(widget.icon, size: d * 0.46, color: widget.iconColor),
    );

    return Semantics(
      button: true,
      label: badge > 0 && widget.badgeLabel != null
          ? '${widget.label}: ${widget.badgeLabel}'
          : widget.label,
      excludeSemantics: true,
      // excludeSemantics bỏ cả hành động bấm của con, nên gắn lại để TalkBack/VoiceOver bấm được.
      onTap: () {
        widget.onDown?.call();
        widget.onTap();
      },
      child: KidMagnet(
        onDown: widget.onDown,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) => _setPressed(true),
          onTapUp: (_) => _setPressed(false),
          onTapCancel: () => _setPressed(false),
          onTap: widget.onTap,
          child: SizedBox(
            width: d + 28,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    circle,
                    if (badge > 0)
                      Positioned(
                        top: -4,
                        right: -8,
                        child: _Badge(count: badge),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.label,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Baloo2',
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                      color: tt.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final badge = Container(
      constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tt.danger,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: tt.panel, width: 2),
      ),
      child: Text(
        count > 99 ? '99+' : '$count',
        style: TextStyle(
          fontFamily: 'Baloo2',
          fontSize: 14,
          fontWeight: FontWeight.w800,
          height: 1.1,
          color: tt.bg,
        ),
      ),
    );
    if (MediaQuery.disableAnimationsOf(context)) return badge;
    // Key theo số: số đổi thì badge nảy lại.
    return badge
        .animate(key: ValueKey(count))
        .scaleXY(begin: 0.4, end: 1, duration: 450.ms, curve: kKidBounceCurve);
  }
}

/// Cúp huy hiệu chỉ để xem (không bấm): huy chương vàng có cúp, bên dưới là số huy hiệu đã đạt.
/// Cùng khổ với [KidStageButton] để đặt vào một góc sảnh. [count] null (chưa tải được) thì hiện "–".
class KidTrophyMedal extends StatelessWidget {
  const KidTrophyMedal({
    super.key,
    required this.count,
    this.diameter = kKidMinTap,
  });

  final int? count;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final d = diameter;
    final n = count;
    return Semantics(
      label: n == null ? 'Huy hiệu' : 'Huy hiệu: em có $n huy hiệu',
      excludeSemantics: true,
      child: SizedBox(
        width: d + 28,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: d,
              height: d,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color.lerp(tt.gold, Colors.white, 0.55)!, tt.gold],
                ),
                border: Border.all(color: tt.goldDeep, width: 3),
              ),
              child: Icon(
                Icons.emoji_events_rounded,
                size: d * 0.56,
                color: tt.goldDeep,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              constraints: const BoxConstraints(minWidth: 36),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: tt.gold.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: tt.goldDeep, width: 2),
              ),
              child: Text(
                n == null ? '–' : (n > 99 ? '99+' : '$n'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  color: tt.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
