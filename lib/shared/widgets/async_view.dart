import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../motion/motion.dart';
import 'feedback.dart';
import 'frog.dart';
import 'tt_button.dart';

/// Khối xám nhấp nháy nhẹ thay cho nội dung đang tải (DESIGN.md › trạng thái đang tải).
class Skeleton extends StatelessWidget {
  const Skeleton({super.key, this.width, this.height = 16, this.radius = 12});

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final box = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: context.tt.surface2, borderRadius: BorderRadius.circular(radius)),
    );
    if (reduceMotion(context)) return box;
    return box.animate(onPlay: (c) => c.repeat(reverse: true)).fade(begin: 1, end: 0.45, duration: 900.ms, curve: Curves.easeInOut);
  }
}

/// Lỗi tải dữ liệu: ếch ngẫm nghĩ, thông báo và nút thử lại.
class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => EmptyState(
    title: 'Chưa tải được dữ liệu',
    message: '$error',
    mood: FrogMood.think,
    actions: [TtButton(label: 'Thử lại', icon: Icons.refresh_rounded, variant: TtButtonVariant.secondary, onPressed: onRetry)],
  );
}

/// Hiện [data] khi có dữ liệu, [loading] khi đang tải lần đầu, [ErrorState] khi lỗi.
/// Khi tải lại (kéo để làm mới) vẫn giữ dữ liệu cũ trên màn hình.
class AsyncView<T> extends StatelessWidget {
  const AsyncView({super.key, required this.value, required this.data, required this.loading, required this.onRetry});

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget loading;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => switch (value) {
    AsyncValue(:final value?, hasValue: true) => data(value),
    AsyncError(:final error) => ErrorState(error: error, onRetry: onRetry),
    _ => loading,
  };
}
