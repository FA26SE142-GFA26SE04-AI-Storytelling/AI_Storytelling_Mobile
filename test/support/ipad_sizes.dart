import 'package:flutter/widgets.dart';

/// Các khổ iPad dùng để kiểm bố cục không tràn (điểm logic, devicePixelRatio = 1 trong test).
const Map<String, Size> kIpadSizes = {
  'iPad mini dọc 768x1024': Size(768, 1024),
  'iPad 11 dọc 834x1194': Size(834, 1194),
  'iPad 11 ngang 1194x834': Size(1194, 834),
  'iPad Pro 12.9 ngang 1366x1024': Size(1366, 1024),
};
