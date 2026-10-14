import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../motion/motion.dart';

/// Nền đầm sen chỉ để trang trí: lá sen nhấp nhô, hoa sen, gợn nước, đom đóm ở theme tối.
/// Bản nhẹ của components/brand/PondBackdrop.tsx (không có lau sậy và chuồn chuồn).
class PondBackdrop extends StatefulWidget {
  const PondBackdrop({super.key, this.flowers = true, this.fireflies = true});

  final bool flowers;
  final bool fireflies;

  @override
  State<PondBackdrop> createState() => _PondBackdropState();
}

class _PondBackdropState extends State<PondBackdrop> with SingleTickerProviderStateMixin {
  late final _clock = AnimationController(vsync: this, duration: const Duration(seconds: 12));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (reduceMotion(context)) {
      _clock.stop();
    } else if (!_clock.isAnimating) {
      _clock.repeat();
    }
  }

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    return ExcludeSemantics(
      child: IgnorePointer(
        child: RepaintBoundary(
          child: CustomPaint(
            size: Size.infinite,
            painter: _PondPainter(_clock, c, flowers: widget.flowers, fireflies: widget.fireflies && c.isDark),
          ),
        ),
      ),
    );
  }
}

class _Pad {
  const _Pad(this.x, this.y, this.size, this.deg, this.opacity, this.flower);
  final double x, y, size, deg, opacity;
  final bool flower;
}

const _pads = [
  _Pad(0.06, 0.78, 120, -12, 0.55, true),
  _Pad(0.84, 0.12, 90, 18, 0.40, false),
  _Pad(0.88, 0.74, 150, 6, 0.50, true),
  _Pad(0.10, 0.10, 70, -30, 0.35, false),
];

class _PondPainter extends CustomPainter {
  _PondPainter(this.clock, this.c, {required this.flowers, required this.fireflies}) : super(repaint: clock);

  final Animation<double> clock;
  final TtColors c;
  final bool flowers;
  final bool fireflies;

  @override
  void paint(Canvas canvas, Size size) {
    final t = clock.value * 12000; // ms trong chu kỳ 12s

    // Gợn nước: 3 vòng loang lần lượt, mỗi vòng 4.2s.
    for (var i = 0; i < 3; i++) {
      final phase = ((t - i * 1400) % 4200) / 4200;
      if (phase < 0) continue;
      final e = Curves.easeOutSine.transform(phase);
      final center = Offset(size.width * (0.30 + i * 0.22), size.height * (0.58 + (i % 2) * 0.14));
      canvas.drawCircle(
        center,
        45 * (0.4 + 2.0 * e),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = c.primary.withValues(alpha: 0.5 * (1 - e)),
      );
    }

    // Lá sen nhấp nhô 6px, chu kỳ 6s, lệch pha nhau 0.5s.
    for (var i = 0; i < _pads.length; i++) {
      final pad = _pads[i];
      final bob = (math.sin((t - i * 500) / 6000 * 2 * math.pi) + 1) / 2 * -6;
      final origin = Offset(size.width * pad.x, size.height * pad.y + bob);
      canvas.save();
      canvas.translate(origin.dx, origin.dy);
      _paintPad(canvas, pad.size, pad.deg, pad.opacity);
      if (flowers && pad.flower) {
        canvas.save();
        canvas.translate(pad.size * 0.29, -pad.size * 0.24);
        paintLotus(canvas, pad.size * 0.42, c, opacity: pad.opacity + 0.3);
        canvas.restore();
      }
      canvas.restore();
    }

    // Đom đóm ở theme tối.
    if (fireflies) {
      for (var i = 0; i < 12; i++) {
        final period = 2 * (2200 + i * 260.0);
        final k = (math.sin(((t - i * 240) / period) * 2 * math.pi) + 1) / 2;
        final dx = (i.isOdd ? 1 : -1) * (30 + i * 6) * k;
        final dy = (-20 - (i % 4) * 10) * k;
        final pos = Offset(size.width * (0.08 + ((i * 37) % 84) / 100) + dx, size.height * (0.10 + ((i * 53) % 78) / 100) + dy);
        final glow = 0.15 + 0.85 * k;
        canvas.drawCircle(
          pos,
          9,
          Paint()
            ..color = c.gold.withValues(alpha: 0.25 * glow)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
        );
        canvas.drawCircle(pos, 3, Paint()..color = c.gold.withValues(alpha: glow));
      }
    }
  }

  /// Lá sen có khe hình nêm (viewBox 100×70).
  void _paintPad(Canvas canvas, double s, double deg, double opacity) {
    final k = s / 100;
    canvas.save();
    canvas.scale(k);
    // Xoay quanh tâm lá như bên web.
    canvas.translate(50, 35);
    canvas.rotate(deg * math.pi / 180);
    canvas.translate(-50, -35);
    final oval = Rect.fromCenter(center: const Offset(50, 35), width: 80, height: 56);
    canvas.drawOval(oval, Paint()..color = c.primary.withValues(alpha: 0.16 * opacity));
    // Phần lá trừ khe: cung từ điểm (88,22) vòng qua đến (50,7).
    final leaf = Path()
      ..moveTo(50, 35)
      ..lineTo(88, 22)
      ..arcToPoint(const Offset(50, 7), radius: const Radius.elliptical(40, 28), largeArc: true)
      ..close();
    canvas.drawPath(leaf, Paint()..color = c.primary.withValues(alpha: 0.28 * opacity));
    canvas.drawLine(
      const Offset(50, 35),
      const Offset(88, 22),
      Paint()
        ..color = c.primary.withValues(alpha: 0.3 * opacity)
        ..strokeWidth = 1.5,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_PondPainter old) => old.c != c || old.flowers != flowers || old.fireflies != fireflies;
}

/// Hoa sen năm cánh quanh nhụy vàng (viewBox 100×78), vẽ tại gốc toạ độ hiện tại.
void paintLotus(Canvas canvas, double size, TtColors c, {double opacity = 1}) {
  final k = size / 100;
  final a = opacity.clamp(0.0, 1.0) * 0.95;
  canvas.save();
  canvas.scale(k);
  final petal = Path()
    ..moveTo(50, 56)
    ..cubicTo(34, 44, 34, 22, 50, 8)
    ..cubicTo(66, 22, 66, 44, 50, 56)
    ..close();
  void draw(double deg, double scale, Color color) {
    canvas.save();
    canvas.translate(50, 56);
    canvas.rotate(deg * math.pi / 180);
    canvas.scale(scale);
    canvas.translate(-50, -56);
    canvas.drawPath(petal, Paint()..color = color.withValues(alpha: a));
    canvas.restore();
  }

  draw(-62, 0.88, c.lotusDeep);
  draw(62, 0.88, c.lotusDeep);
  draw(-32, 0.96, c.lotus);
  draw(32, 0.96, c.lotus);
  draw(0, 1, c.lotusLight);
  canvas.drawOval(Rect.fromCenter(center: const Offset(50, 58), width: 18, height: 8), Paint()..color = c.gold.withValues(alpha: a));
  canvas.restore();
}
