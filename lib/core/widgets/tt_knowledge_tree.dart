import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/tt_colors.dart';

/// Widget vẽ Cây tri thức theo 5 giai đoạn phát triển (0..4):
/// 0: SEED (Hạt giống), 1: SPROUT (Nảy mầm), 2: SAPLING (Cây con),
/// 3: GROWN (Cây có quả), 4: FLOWERING (Cây nở hoa).
///
/// Chuyển thể trực tiếp từ KnowledgeTreeArt.tsx.
class TtKnowledgeTree extends StatelessWidget {
  const TtKnowledgeTree({super.key, required this.stage, this.size = 220});

  /// Giai đoạn phát triển của cây (0..4).
  final int stage;

  /// Kích thước cạnh vuông widget.
  final double size;

  @override
  Widget build(BuildContext context) {
    final int safeStage = stage.clamp(0, 4);

    return Semantics(
      label: 'Cây tri thức giai đoạn $safeStage',
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          size: Size(size, size),
          painter: _KnowledgeTreePainter(stage: safeStage, tt: context.tt),
        ),
      ),
    );
  }
}

class _KnowledgeTreePainter extends CustomPainter {
  const _KnowledgeTreePainter({required this.stage, required this.tt});

  final int stage;
  final TtColors tt;

  Color get soil => Color.lerp(tt.text, tt.goldDeep, 0.55)!;
  Color get trunk => Color.lerp(tt.text, tt.goldDeep, 0.70)!;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 160.0, size.height / 160.0);

    // Đất & gò đất
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(80, 140), width: 116, height: 24),
      Paint()..color = soil.withValues(alpha: 0.35),
    );
    final soilPath = Path()
      ..moveTo(32, 140)
      ..quadraticBezierTo(36, 122, 80, 122)
      ..quadraticBezierTo(124, 122, 128, 140)
      ..close();
    canvas.drawPath(soilPath, Paint()..color = soil);

    switch (stage) {
      case 0:
        canvas.drawOval(
          Rect.fromCenter(center: const Offset(80, 119), width: 22, height: 16),
          Paint()..color = tt.goldDeep,
        );
        final gleam = Path()
          ..moveTo(76, 116)
          ..quadraticBezierTo(80, 112, 84, 116);
        canvas.drawPath(
          gleam,
          Paint()
            ..color = tt.gold
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round,
        );
        break;

      case 1:
        final stem = Path()
          ..moveTo(80, 124)
          ..quadraticBezierTo(80, 108, 80, 96);
        canvas.drawPath(
          stem,
          Paint()
            ..color = tt.primaryStrong
            ..strokeWidth = 4
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round,
        );
        _leaf(canvas, 80, 98, -52, 0.62, tt.primary);
        _leaf(canvas, 80, 98, 52, 0.62, tt.primaryStrong);
        break;

      case 2:
        final sapling = Path()
          ..moveTo(80, 124)
          ..quadraticBezierTo(78, 100, 80, 72);
        canvas.drawPath(
          sapling,
          Paint()
            ..color = trunk
            ..strokeWidth = 6
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round,
        );
        _leaf(canvas, 79, 104, -62, 0.70, tt.primary);
        _leaf(canvas, 80, 92, 64, 0.70, tt.primaryStrong);
        _leaf(canvas, 80, 80, -40, 0.78, tt.primary);
        _leaf(canvas, 80, 74, 34, 0.82, tt.primaryStrong);
        _leaf(canvas, 80, 72, 0, 0.70, tt.primary);
        break;

      case 3:
      case 4:
        _drawMatureTree(canvas);
        if (stage == 3) {
          final fruit = Paint()..color = tt.gold;
          canvas.drawCircle(const Offset(66, 62), 4.5, fruit);
          canvas.drawCircle(const Offset(96, 58), 4.5, fruit);
          canvas.drawCircle(const Offset(82, 78), 4.5, fruit);
        } else {
          _blossom(canvas, 62, 52, 1.1);
          _blossom(canvas, 96, 50, 1.2);
          _blossom(canvas, 80, 74, 1.0);
          _blossom(canvas, 52, 78, 0.8);
          _blossom(canvas, 108, 76, 0.85);
          _blossom(canvas, 80, 34, 0.85);
        }
        break;
    }

    canvas.restore();
  }

  void _drawMatureTree(Canvas canvas) {
    final trunkPath = Path()
      ..moveTo(72, 124)
      ..quadraticBezierTo(76, 104, 78, 86)
      ..lineTo(82, 86)
      ..quadraticBezierTo(84, 104, 88, 124)
      ..close();
    canvas.drawPath(trunkPath, Paint()..color = trunk);

    final branch = Paint()
      ..color = trunk
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(
      Path()
        ..moveTo(80, 100)
        ..quadraticBezierTo(66, 92, 58, 80),
      branch,
    );
    canvas.drawPath(
      Path()
        ..moveTo(80, 94)
        ..quadraticBezierTo(94, 86, 102, 74),
      branch,
    );

    // Tán lá
    canvas.drawCircle(const Offset(80, 56), 32, Paint()..color = tt.primary);
    canvas.drawCircle(
      const Offset(54, 72),
      22,
      Paint()..color = tt.primaryStrong,
    );
    canvas.drawCircle(
      const Offset(106, 72),
      22,
      Paint()..color = tt.primaryStrong,
    );
    canvas.drawCircle(
      const Offset(80, 50),
      20,
      Paint()..color = tt.primary.withValues(alpha: 0.85),
    );
  }

  void _leaf(
    Canvas canvas,
    double x,
    double y,
    double rotDeg,
    double s,
    Color fill,
  ) {
    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(rotDeg * math.pi / 180.0);
    canvas.scale(s, s);

    final leaf = Path()
      ..moveTo(0, 0)
      ..cubicTo(-12, -10, -12, -28, 0, -38)
      ..cubicTo(12, -28, 12, -10, 0, 0)
      ..close();
    canvas.drawPath(leaf, Paint()..color = fill);
    canvas.restore();
  }

  void _blossom(Canvas canvas, double x, double y, double s) {
    canvas.save();
    canvas.translate(x, y);
    canvas.scale(s, s);

    final petal = Paint()..color = tt.lotus;
    for (final double deg in [0.0, 72.0, 144.0, 216.0, 288.0]) {
      canvas.save();
      canvas.rotate(deg * math.pi / 180.0);
      canvas.drawOval(
        Rect.fromCenter(center: const Offset(0, -8), width: 11, height: 18),
        petal,
      );
      canvas.restore();
    }
    canvas.drawCircle(Offset.zero, 4.5, Paint()..color = tt.gold);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _KnowledgeTreePainter oldDelegate) =>
      oldDelegate.stage != stage || oldDelegate.tt != tt;
}
