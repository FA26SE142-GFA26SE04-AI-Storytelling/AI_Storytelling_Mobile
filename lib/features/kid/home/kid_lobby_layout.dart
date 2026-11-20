import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Đường kính nút tròn trên sảnh.
const double kKidLobbyButton = 64;

const double _maxWidth = 520;

/// Cao một nút tròn kèm nhãn (vòng tròn + bóng + nhãn).
const double _railHeight = kKidLobbyButton + 36;

/// Rộng một nút tròn kèm nhãn.
const double _railWidth = kKidLobbyButton + 28;

/// Màn ngang: cụm sảnh rộng tối đa chừng này, không dạt ra mép màn.
const double _maxWideWidth = 900;

/// Màn ngang thấp hơn mức này thì đưa hàng nút sang cột bên phải.
const double _tallLandscape = 520;

/// Bề rộng cột bên phải (hàng nút) ở màn ngang thấp.
const double _sideColumn = 340;

/// Các khối của sảnh, dựng một lần rồi xếp theo khổ màn (dọc / ngang cao / ngang thấp).
class KidLobbyParts {
  const KidLobbyParts({
    required this.frog,
    required this.journey,
    required this.notebook,
    required this.wish,
    required this.badges,
    required this.bottom,
  });

  final Widget Function(double size) frog;
  final Widget journey, notebook, wish, badges, bottom;
}

/// Xếp sảnh theo khung [c]: dọc, ngang đủ cao (tablet) hoặc ngang thấp (điện thoại xoay ngang).
Widget kidLobbyLayout(BoxConstraints c, KidLobbyParts p) {
  if (c.maxWidth <= c.maxHeight * 1.15) return _portrait(c, p);
  return c.maxHeight >= _tallLandscape
      ? _landscapeTall(c, p)
      : _landscapeShort(c, p);
}

/// Màn dọc: bốn góc quanh ếch, hàng nút dưới.
Widget _portrait(BoxConstraints c, KidLobbyParts p) {
  final width = math.min(c.maxWidth, _maxWidth) - 32;
  // ~170: hàng nút dưới + khoảng cách; sân khấu ếch cao ~1.22 lần bề rộng.
  final size = math
      .min(width * 0.64, (c.maxHeight - 170) / 1.22)
      .clamp(100.0, 260.0);
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: _maxWidth),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 2 * _railHeight + 16,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    p.frog(size),
                    Align(alignment: Alignment.topLeft, child: p.journey),
                    Align(alignment: Alignment.bottomLeft, child: p.notebook),
                    Align(alignment: Alignment.topRight, child: p.wish),
                    Align(alignment: Alignment.bottomRight, child: p.badges),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            p.bottom,
          ],
        ),
      ),
    ),
  );
}

/// Hai cột nút sát hai bên ếch (giống sân khấu web), cả cụm căn giữa.
Widget _stage(double size, KidLobbyParts p) {
  Widget rail(Widget a, Widget b) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [a, const SizedBox(height: 24), b],
  );
  // Chừa chỗ cho lá sen hai bên (vẽ tràn ~0.12 bề rộng ếch).
  final gap = math.max(16.0, size * 0.12);
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      rail(p.journey, p.notebook),
      SizedBox(width: gap),
      p.frog(size),
      SizedBox(width: gap),
      rail(p.wish, p.badges),
    ],
  );
}

/// Ngang, đủ cao (tablet): sân khấu giữa, hàng nút ngay dưới ếch.
Widget _landscapeTall(BoxConstraints c, KidLobbyParts p) {
  final width = math.min(c.maxWidth, _maxWideWidth) - 32;
  final size = math
      .min((width - 2 * _railWidth) / 1.25, (c.maxHeight - 180) / 1.25)
      .clamp(120.0, 420.0);
  return Center(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Chừa khoảng trên đầu ếch cho cú nhảy.
          SizedBox(height: size * 0.1 + 8),
          _stage(size, p),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: p.bottom,
          ),
        ],
      ),
    ),
  );
}

/// Ngang, thấp (điện thoại xoay ngang): sân khấu bên trái,
/// hàng nút thành cột bên phải.
Widget _landscapeShort(BoxConstraints c, KidLobbyParts p) {
  final width = math.min(c.maxWidth, _maxWideWidth) - 32;
  final stageWidth = width - _sideColumn - 24;
  final size = math
      .min((stageWidth - 2 * _railWidth) / 1.25, (c.maxHeight - 40) / 1.22)
      .clamp(100.0, 300.0);
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: _maxWideWidth),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
        child: Row(
          children: [
            // Màn ngang rất hẹp: thu cả cụm thay vì tràn.
            Expanded(
              child: Center(
                child: FittedBox(fit: BoxFit.scaleDown, child: _stage(size, p)),
              ),
            ),
            const SizedBox(width: 24),
            SizedBox(
              width: _sideColumn,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [p.bottom],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
