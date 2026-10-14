import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../motion/motion.dart';

enum FrogMood { idle, happy, think }

enum FrogVariant {
  /// Cả con ếch ngồi.
  full,

  /// Chỉ phần đầu, dùng làm logo.
  face,
}

// Bảng màu linh vật (DESIGN.md › colors.mascot)
const _green = Color(0xFF7CC455);
const _greenDark = Color(0xFF4B7B37);
const _belly = Color(0xFFD7D088);
const _ring = Color(0xFFE9E9E6);
const _ink = Color(0xFF363636);

/// Linh vật ếch Taletale, vẽ lại từ components/brand/Frog.tsx.
/// Khi [animated]: chớp mắt và thở nhẹ (tắt khi máy bật giảm chuyển động).
class Frog extends StatefulWidget {
  const Frog({super.key, this.size = 120, this.mood = FrogMood.idle, this.variant = FrogVariant.full, this.animated = true});

  final double size;
  final FrogMood mood;
  final FrogVariant variant;
  final bool animated;

  @override
  State<Frog> createState() => _FrogState();
}

class _FrogState extends State<Frog> with TickerProviderStateMixin {
  // Chớp mắt 220ms rồi nghỉ 3200ms; thở lên xuống 1500ms.
  late final _blink = AnimationController(vsync: this, duration: const Duration(milliseconds: 3420));
  late final _breathe = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(Frog old) {
    super.didUpdateWidget(old);
    _sync();
  }

  void _sync() {
    final run = widget.animated && !reduceMotion(context);
    if (run && !_blink.isAnimating) {
      _blink.repeat();
      _breathe.repeat(reverse: true);
    } else if (!run && _blink.isAnimating) {
      _blink.stop();
      _breathe.stop();
      _blink.value = 0;
      _breathe.value = 0;
    }
  }

  @override
  void dispose() {
    _blink.dispose();
    _breathe.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final face = widget.variant == FrogVariant.face;
    final faint = context.tt.faint;
    return Semantics(
      label: 'Linh vật ếch Taletale',
      image: true,
      child: SizedBox(
        width: widget.size,
        height: widget.size * (face ? 0.6 : 1.135),
        child: RepaintBoundary(
          child: CustomPaint(
            painter: _FrogPainter(mood: widget.mood, face: face, blink: _blink, breathe: _breathe, bubble: faint),
          ),
        ),
      ),
    );
  }
}

class _FrogPainter extends CustomPainter {
  _FrogPainter({required this.mood, required this.face, required this.blink, required this.breathe, required this.bubble})
    : super(repaint: Listenable.merge([blink, breathe]));

  final FrogMood mood;
  final bool face;
  final Animation<double> blink;
  final Animation<double> breathe;
  final Color bubble;

  /// Mí mắt phủ xuống rồi mở ra trong 220ms đầu chu kỳ.
  double get _lid {
    const share = 220 / 3420;
    final t = blink.value;
    return t >= share ? 0 : math.sin(math.pi * t / share);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Hệ toạ độ gốc: viewBox 405×460 (full) hoặc cắt "68 20 270 162" (face).
    if (face) {
      final s = size.width / 270;
      canvas.scale(s);
      canvas.translate(-68, -20);
    } else {
      canvas.scale(size.width / 405);
    }
    final p = Paint()..isAntiAlias = true;

    if (!face) {
      p.color = _greenDark;
      _oval(canvas, p, 62, 238, 50, 72, -18);
      _oval(canvas, p, 346, 246, 52, 80, 14);
      _oval(canvas, p, 94, 326, 38, 19, -8);
      _oval(canvas, p, 312, 328, 38, 19, 8);
      _toes(canvas, p, const [(68, 350, 16), (94, 358, 0), (120, 350, -16)], 9, 17);
      _toes(canvas, p, const [(286, 352, 16), (312, 360, 0), (338, 352, -16)], 9, 17);
    }

    canvas.save();
    canvas.translate(0, Curves.easeInOutSine.transform(breathe.value) * 4);

    p.color = _green;
    _oval(canvas, p, 203, 212, 126, 140);
    p.color = _belly;
    _oval(canvas, p, 203, 226, 106, 122);

    if (!face) {
      final arm = Paint()
        ..color = _green
        ..strokeWidth = 24
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(const Offset(123, 204), const Offset(168, 330), arm);
      canvas.drawLine(const Offset(269, 204), const Offset(232, 330), arm);
      p.color = _green;
      _oval(canvas, p, 168, 338, 21, 11);
      _oval(canvas, p, 233, 338, 21, 11);
      _toes(canvas, p, const [(152, 358, 14), (168, 364, 0), (184, 358, -14)], 8.5, 14);
      _toes(canvas, p, const [(217, 358, 14), (233, 364, 0), (249, 358, -14)], 8.5, 14);
    }

    // Mắt: núm xanh, viền trắng, đồng tử. Khi nghĩ, mắt liếc lên góc phải.
    final look = mood == FrogMood.think ? const Offset(5, -6) : Offset.zero;
    final lid = _lid;
    for (final cx in const [130.0, 276.0]) {
      const cy = 64.0;
      canvas.drawCircle(Offset(cx, cy), 38, p..color = _green);
      canvas.drawCircle(Offset(cx, cy), 27, p..color = _ring);
      canvas.drawCircle(Offset(cx, cy) + look, 21, p..color = _ink);
      if (lid > 0) canvas.drawOval(Rect.fromLTWH(cx - 28, cy - 55, 56, 56 * lid), p..color = _green);
    }

    p.color = _greenDark;
    _oval(canvas, p, 190, 82, 7, 6);
    _oval(canvas, p, 216, 82, 7, 6);

    if (mood == FrogMood.happy) {
      canvas.drawPath(
        Path()
          ..moveTo(156, 124)
          ..quadraticBezierTo(203, 134, 250, 124)
          ..quadraticBezierTo(246, 168, 203, 170)
          ..quadraticBezierTo(160, 168, 156, 124)
          ..close(),
        p..color = const Color(0xFF3A3A3A),
      );
      canvas.drawPath(
        Path()
          ..moveTo(178, 156)
          ..quadraticBezierTo(203, 146, 228, 156)
          ..quadraticBezierTo(222, 168, 203, 169)
          ..quadraticBezierTo(184, 168, 178, 156)
          ..close(),
        p..color = const Color(0xFFE0707F),
      );
    } else {
      canvas.drawPath(
        Path()
          ..moveTo(158, 126)
          ..quadraticBezierTo(203, 134, 248, 126)
          ..quadraticBezierTo(203, 154, 158, 126)
          ..close(),
        p..color = _ink,
      );
    }

    if (mood == FrogMood.think) {
      p.color = bubble;
      canvas.drawCircle(const Offset(344, 26), 4, p);
      canvas.drawCircle(const Offset(358, 12), 7, p);
    }
    canvas.restore();
  }

  static void _oval(Canvas canvas, Paint p, double cx, double cy, double rx, double ry, [double deg = 0]) {
    if (deg == 0) {
      canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: rx * 2, height: ry * 2), p);
      return;
    }
    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(deg * math.pi / 180);
    canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: rx * 2, height: ry * 2), p);
    canvas.restore();
  }

  /// Một bàn chân có 3 ngón xoè: (x, y, góc nghiêng).
  static void _toes(Canvas canvas, Paint p, List<(double, double, double)> toes, double rx, double ry) {
    for (final (x, y, deg) in toes) {
      _oval(canvas, p, x, y, rx, ry, deg);
    }
  }

  @override
  bool shouldRepaint(_FrogPainter old) => old.mood != mood || old.face != face || old.bubble != bubble;
}
