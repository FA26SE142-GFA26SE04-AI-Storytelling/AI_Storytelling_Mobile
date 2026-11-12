import 'package:flutter/material.dart';

/// Design tokens for corner radius defined in DESIGN.md.
abstract final class TtRadius {
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 14;
  static const double lg = 18;
  static const double xl = 24;
  static const double x2l = 34;
  static const double book = 44;
  static const double full = 9999;

  /// Leaf shape radius "18 7 18 7", dùng cho nút chính.
  static const BorderRadius leaf = BorderRadius.only(
    topLeft: Radius.circular(18),
    topRight: Radius.circular(7),
    bottomRight: Radius.circular(18),
    bottomLeft: Radius.circular(7),
  );
}
