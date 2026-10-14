import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_ui/material_ui.dart';

/// Người dùng bật giảm chuyển động trong cài đặt máy.
bool reduceMotion(BuildContext context) => MediaQuery.maybeDisableAnimationsOf(context) ?? false;

/// Rise-in: các phần tử mờ dần vào và nhích lên, xuất hiện lần lượt (giống useRiseIn bên web).
List<Widget> riseIn(BuildContext context, List<Widget> children, {Duration interval = const Duration(milliseconds: 50), double distance = 12}) {
  if (reduceMotion(context)) return children;
  return children
      .animate(interval: interval)
      .fadeIn(duration: 320.ms, curve: Curves.easeOutCubic)
      .moveY(begin: distance, end: 0, duration: 380.ms, curve: Curves.easeOutCubic);
}
