import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Khung vẽ gốc của ếch (giống viewBox 405×460 của Frog.tsx trên web).
const double kFrogViewW = 405;
const double kFrogViewH = 460;

/// Tâm hai mắt trong khung 405×460, dùng để tính hướng nhìn của con ngươi.
const List<Offset> kFrogEyes = [Offset(130, 64), Offset(276, 64)];

/// Con ngươi dịch tối đa chừng này đơn vị khi nhìn theo ngón tay.
const double kFrogPupilMax = 6;

/// Trạng thái từng bộ phận của ếch tại một khung hình (đơn vị theo khung 405×460).
class FrogPose {
  /// Cười mỉm (miệng ngậm) khi nghỉ; false là cười tươi (miệng há).
  bool smile = false;
  double breathe = 0;
  double lid = 0;
  double winkLid = 0;
  Offset pupil = Offset.zero;
  double laugh = 0;
  double wow = 0;
  double blush = 0;
  double tongue = 0;
  double mouthOpen = 0;
  double armDeg = 0;
}

const _green = Color(0xFF7CC455);
const _greenDark = Color(0xFF4B7B37);
const _belly = Color(0xFFD7D088);
const _ring = Color(0xFFE9E9E6);
const _ink = Color(0xFF363636);
const _mouth = Color(0xFF3A3A3A);
const _pink = Color(0xFFE0707F);
const _blush = Color(0xFFF4A3B4);

Paint _fill(Color c, [double opacity = 1]) =>
    Paint()..color = c.withValues(alpha: c.a * opacity);

void _ellipse(
  Canvas c,
  double cx,
  double cy,
  double rx,
  double ry,
  Paint p, [
  double rotDeg = 0,
]) {
  if (rotDeg == 0) {
    c.drawOval(
      Rect.fromCenter(center: Offset(cx, cy), width: rx * 2, height: ry * 2),
      p,
    );
    return;
  }
  c.save();
  c.translate(cx, cy);
  c.rotate(rotDeg * math.pi / 180);
  c.drawOval(
    Rect.fromCenter(center: Offset.zero, width: rx * 2, height: ry * 2),
    p,
  );
  c.restore();
}

void _toes(Canvas c, List<List<double>> list, double rx, double ry, Paint p) {
  for (final t in list) {
    _ellipse(c, t[0], t[1], rx, ry, p, t[2]);
  }
}

Path _openMouth() => Path()
  ..moveTo(156, 124)
  ..quadraticBezierTo(203, 134, 250, 124)
  ..quadraticBezierTo(246, 168, 203, 170)
  ..quadraticBezierTo(160, 168, 156, 124)
  ..close();

Path _mouthTongue() => Path()
  ..moveTo(178, 156)
  ..quadraticBezierTo(203, 146, 228, 156)
  ..quadraticBezierTo(222, 168, 203, 169)
  ..quadraticBezierTo(184, 168, 178, 156)
  ..close();

void _drawOpenMouth(Canvas c, double opacity) {
  if (opacity <= 0) return;
  c.drawPath(_openMouth(), _fill(_mouth, opacity));
  c.drawPath(_mouthTongue(), _fill(_pink, opacity));
}

/// Vẽ ếch vào [canvas] với bề rộng [width] (gốc toạ độ ở góc trên trái khung ếch).
void paintFrog(Canvas canvas, double width, FrogPose p) {
  final c = canvas;
  c.save();
  c.scale(width / kFrogViewW);

  // Chân sau: đùi, bàn chân, 3 ngón.
  final dark = _fill(_greenDark);
  _ellipse(c, 70, 262, 50, 66, dark, -20);
  _ellipse(c, 336, 262, 50, 66, dark, 20);
  _ellipse(c, 98, 330, 42, 18, dark, -6);
  _ellipse(c, 308, 330, 42, 18, dark, 6);
  _toes(
    c,
    [
      [74, 348, 16],
      [98, 354, 0],
      [122, 348, -16],
    ],
    9,
    15,
    dark,
  );
  _toes(
    c,
    [
      [284, 348, 16],
      [308, 354, 0],
      [332, 348, -16],
    ],
    9,
    15,
    dark,
  );

  // Thân nhấp nhô theo nhịp thở.
  c.translate(0, p.breathe);
  final green = _fill(_green);
  _ellipse(c, 203, 212, 126, 140, green);
  _ellipse(c, 203, 226, 106, 122, _fill(_belly));

  final arm = Paint()
    ..color = _green
    ..strokeWidth = 24
    ..strokeCap = StrokeCap.round;
  c.drawLine(const Offset(120, 250), const Offset(150, 330), arm);
  _ellipse(c, 150, 338, 20, 11, green);
  _toes(
    c,
    [
      [136, 356, 14],
      [150, 362, 0],
      [164, 356, -14],
    ],
    8.5,
    14,
    green,
  );
  // Tay phải xoay quanh vai (286, 250) khi vẫy.
  c.save();
  c.translate(286, 250);
  c.rotate(p.armDeg * math.pi / 180);
  c.translate(-286, -250);
  c.drawLine(const Offset(286, 250), const Offset(256, 330), arm);
  _ellipse(c, 256, 338, 20, 11, green);
  _toes(
    c,
    [
      [242, 356, 14],
      [256, 362, 0],
      [270, 356, -14],
    ],
    8.5,
    14,
    green,
  );
  c.restore();

  // Mắt: núm xanh, viền trắng, con ngươi, mí mắt phủ từ trên xuống.
  for (var i = 0; i < kFrogEyes.length; i++) {
    final e = kFrogEyes[i];
    c.drawCircle(e, 38, green);
    c.drawCircle(e, 27, _fill(_ring));
    c.drawCircle(e + p.pupil, 21, _fill(_ink));
    final lid = i == 1 ? math.max(p.lid, p.winkLid) : p.lid;
    if (lid > 0) {
      c.drawOval(Rect.fromLTWH(e.dx - 28, e.dy - 28, 56, 56 * lid), green);
    }
  }

  // Mắt cười tít "^ ^".
  if (p.laugh > 0) {
    final stroke = Paint()
      ..color = _ink.withValues(alpha: p.laugh)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    for (final e in kFrogEyes) {
      c.drawCircle(e, 30, _fill(_green, p.laugh));
      c.drawPath(
        Path()
          ..moveTo(e.dx - 20, e.dy + 8)
          ..quadraticBezierTo(e.dx, e.dy - 16, e.dx + 20, e.dy + 8),
        stroke,
      );
    }
  }
  // Ngạc nhiên: con ngươi nhỏ, miệng chữ O.
  if (p.wow > 0) {
    for (final e in kFrogEyes) {
      c.drawCircle(e, 29, _fill(_ring, p.wow));
      c.drawCircle(e, 11, _fill(_ink, p.wow));
    }
    _ellipse(c, 203, 148, 20, 24, _fill(_mouth, p.wow));
    _ellipse(c, 203, 160, 11, 7, _fill(_pink, p.wow));
  }
  if (p.blush > 0) {
    _ellipse(c, 128, 142, 20, 11, _fill(_blush, p.blush));
    _ellipse(c, 278, 142, 20, 11, _fill(_blush, p.blush));
  }

  // Lỗ mũi và miệng.
  _ellipse(c, 190, 82, 7, 6, dark);
  _ellipse(c, 216, 82, 7, 6, dark);
  final mouthVisible = 1 - p.wow;
  if (!p.smile) {
    _drawOpenMouth(c, mouthVisible);
  } else {
    final closed = mouthVisible * (1 - p.mouthOpen);
    if (closed > 0) {
      c.drawPath(
        Path()
          ..moveTo(168, 130)
          ..quadraticBezierTo(203, 156, 238, 130),
        Paint()
          ..color = _ink.withValues(alpha: closed)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 9
          ..strokeCap = StrokeCap.round,
      );
    }
    _drawOpenMouth(c, p.mouthOpen);
  }
  // Lưỡi thè ra từ miệng (203, 152) về phía trên phải.
  if (p.tongue > 0) {
    const o = Offset(203, 152);
    final tip = o + (const Offset(300, 104) - o) * p.tongue;
    c.drawLine(
      o,
      tip,
      Paint()
        ..color = _pink
        ..strokeWidth = 14 * p.tongue.clamp(0.4, 1)
        ..strokeCap = StrokeCap.round,
    );
  }
  c.restore();
}

/// Giá trị theo các mốc chia đều, mỗi đoạn nội suy êm (inOutSine); [u] ngoài [0,1] lấy mốc đầu/cuối.
double kf(List<num> values, double u) {
  final stops = [
    for (var i = 0; i < values.length; i++) i / (values.length - 1),
  ];
  return kfp(stops, values, u);
}

/// Như [kf] nhưng với các mốc [stops] tuỳ ý (0..1), giống keyframes phần trăm của CSS.
double kfp(List<num> stops, List<num> values, double u) {
  if (u <= 0 || u.isNaN) return values.first.toDouble();
  if (u >= 1) return values.last.toDouble();
  var i = 1;
  while (i < stops.length - 1 && u > stops[i]) {
    i++;
  }
  final a = stops[i - 1], b = stops[i];
  final t = b == a ? 1.0 : (u - a) / (b - a);
  final e = -(math.cos(math.pi * t) - 1) / 2;
  return (values[i - 1] + (values[i] - values[i - 1]) * e).toDouble();
}
