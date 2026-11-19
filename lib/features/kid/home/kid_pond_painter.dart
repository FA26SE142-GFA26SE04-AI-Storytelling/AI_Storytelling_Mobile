import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import 'kid_frog_painter.dart';

/// Biến đổi 2D quanh một điểm gốc (dịch, xoay độ, co giãn).
class StageXf {
  double tx = 0, ty = 0, rot = 0, sx = 1, sy = 1;

  void reset() {
    tx = ty = rot = 0;
    sx = sy = 1;
  }

  void applyAround(Canvas c, Offset origin) {
    c.translate(origin.dx + tx, origin.dy + ty);
    if (rot != 0) c.rotate(rot * math.pi / 180);
    c.scale(sx, sy);
    c.translate(-origin.dx, -origin.dy);
  }
}

/// Mọi thông số của một khung hình sân khấu ếch; state cập nhật rồi báo vẽ lại.
class PondFrame extends ChangeNotifier {
  final FrogPose pose = FrogPose();

  /// Hoạt cảnh chờ 7 giây (thở, nghiêng, nhảy nhỏ) quanh chân ếch.
  final StageXf idle = StageXf();

  /// Động tác khi bé chạm ếch (nhảy, xoay, nén, nhảy múa).
  final StageXf poke = StageXf();
  bool pokeAroundCenter = false;

  /// Bục lá sen lún xuống khi ếch đáp.
  final StageXf pad = StageXf();
  double ripple = 0, rippleSx = 1, rippleSy = 1;
  double glow = 0.75, glowScale = 1;
  double bobL = 0, bobR = 0;

  /// Lệch theo ngón tay, mỗi trục trong [-1, 1].
  Offset parallax = Offset.zero;

  void changed() => notifyListeners();
}

/// Vẽ sân khấu: quầng sáng, lá sen hai bên (có hoa sen), bục lá sen và ếch.
/// Khung [size] rộng bằng ếch, cao 1.08 lần; lá và quầng có thể vẽ tràn ra ngoài.
class PondPainter extends CustomPainter {
  PondPainter(this.f, this.tt) : super(repaint: f);

  final PondFrame f;
  final TtColors tt;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final par = Offset(f.parallax.dx * 8, f.parallax.dy * 5);
    final feet = Offset(s / 2, s * 0.914);

    // Lớp sau dịch ít hơn, lớp trước dịch nhiều hơn: tạo chiều sâu.
    canvas.save();
    canvas.translate(par.dx * 0.6, par.dy * 0.6);
    canvas.drawCircle(
      Offset(s / 2, s * 0.55),
      s * 0.66,
      Paint()
        ..shader =
            RadialGradient(
              colors: [
                tt.gold.withValues(alpha: 0.32),
                tt.gold.withValues(alpha: 0),
              ],
            ).createShader(
              Rect.fromCircle(
                center: Offset(s / 2, s * 0.55),
                radius: s * 0.66,
              ),
            ),
    );
    _leaf(
      canvas,
      Rect.fromCenter(
        center: Offset(s * 0.06, s * 0.86 + f.bobL),
        width: s * 0.28,
        height: s * 0.075,
      ),
      flip: true,
    );
    canvas.restore();

    canvas.save();
    canvas.translate(par.dx, par.dy);
    final padRect = Rect.fromCenter(
      center: Offset(s / 2, s * 0.95),
      width: s * 1.05,
      height: s * 0.2,
    );
    // Quầng vàng nhịp quanh bục.
    final glowRect = Rect.fromCenter(
      center: padRect.center,
      width: (padRect.width + 44) * f.glowScale,
      height: (padRect.height + 28) * f.glowScale,
    );
    canvas.drawOval(
      glowRect,
      Paint()
        ..shader = RadialGradient(
          colors: [
            tt.gold.withValues(alpha: 0.7 * f.glow),
            tt.gold.withValues(alpha: 0),
          ],
          stops: const [0.3, 1],
        ).createShader(glowRect),
    );
    canvas.save();
    f.pad.applyAround(canvas, padRect.bottomCenter);
    _leaf(canvas, padRect, border: 4, inset: 8);
    canvas.restore();
    if (f.ripple > 0) {
      final r = padRect.inflate(6);
      canvas.drawOval(
        Rect.fromCenter(
          center: r.center,
          width: r.width * f.rippleSx,
          height: r.height * f.rippleSy,
        ),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = Color.lerp(
            tt.sky,
            Colors.white,
            0.3,
          )!.withValues(alpha: f.ripple),
      );
    }

    canvas.save();
    f.idle.applyAround(canvas, feet);
    f.poke.applyAround(
      canvas,
      f.pokeAroundCenter ? Offset(s / 2, s * 0.57) : feet,
    );
    paintFrog(canvas, s, f.pose);
    canvas.restore();
    canvas.restore();

    // Lá trước có bông sen, nhô ra trước bục.
    canvas.save();
    canvas.translate(par.dx * 1.5, par.dy * 1.5 + f.bobR);
    final front = Rect.fromCenter(
      center: Offset(s * 0.95, s * 1.0),
      width: s * 0.34,
      height: s * 0.095,
    );
    _leaf(canvas, front, border: 3, inset: 5);
    _lotus(
      canvas,
      Offset(front.center.dx, front.bottom - front.height * 0.35),
      s * 0.22,
    );
    canvas.restore();
  }

  /// Mặt lá sen: nền xanh, mép dưới đậm, gân lá toả từ tâm, một khía hình nêm.
  void _leaf(
    Canvas c,
    Rect r, {
    double border = 3,
    double inset = 5,
    bool flip = false,
  }) {
    final oval = Path()..addOval(r);
    // Khía lá: nêm 22° gần hướng 6 giờ (lật ngang với lá bên trái).
    final a0 = (flip ? 248.0 : 70.0) * math.pi / 180;
    const sweep = 22 * math.pi / 180;
    final wedge = Path()
      ..moveTo(r.center.dx, r.center.dy)
      ..arcTo(r.inflate(4), a0, sweep, false)
      ..close();
    final shape = Path.combine(PathOperation.difference, oval, wedge);
    final strong = tt.primaryStrong;
    c.save();
    c.clipPath(shape);
    c.drawRect(
      r,
      Paint()
        ..color = Color.alphaBlend(strong.withValues(alpha: 0.55), tt.primary),
    );
    c.drawOval(
      r.shift(Offset(0, -inset)).inflate(1),
      Paint()..color = tt.primary,
    );
    final vein = Paint()
      ..color = strong.withValues(alpha: 0.45)
      ..strokeWidth = 1.5;
    for (var i = 0; i < 12; i++) {
      final a = i * math.pi / 6;
      c.drawLine(
        r.center,
        r.center +
            Offset(math.cos(a) * r.width / 2, math.sin(a) * r.height / 2),
        vein,
      );
    }
    c.restore();
    c.drawPath(
      shape,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = border
        ..color = strong,
    );
  }

  /// Hoa sen năm cánh (giống Lotus.tsx), [base] là chân hoa, [w] bề rộng.
  void _lotus(Canvas c, Offset base, double w) {
    final k = w / 100;
    c.save();
    c.translate(base.dx - 50 * k, base.dy - 58 * k);
    c.scale(k);
    final petal = Path()
      ..moveTo(50, 56)
      ..cubicTo(34, 44, 34, 22, 50, 8)
      ..cubicTo(66, 22, 66, 44, 50, 56)
      ..close();
    for (final (rot, scale, color) in [
      (-62.0, 0.88, tt.lotusDeep),
      (62.0, 0.88, tt.lotusDeep),
      (-32.0, 0.96, tt.lotus),
      (32.0, 0.96, tt.lotus),
      (0.0, 1.0, tt.lotusLight),
    ]) {
      c.save();
      c.translate(50, 56);
      c.rotate(rot * math.pi / 180);
      c.scale(scale);
      c.translate(-50, -56);
      c.drawPath(petal, Paint()..color = color.withValues(alpha: 0.95));
      c.restore();
    }
    c.drawOval(
      Rect.fromCenter(center: const Offset(50, 58), width: 18, height: 8),
      Paint()..color = tt.gold,
    );
    c.restore();
  }

  @override
  bool shouldRepaint(PondPainter old) => old.f != f || old.tt != tt;
}
