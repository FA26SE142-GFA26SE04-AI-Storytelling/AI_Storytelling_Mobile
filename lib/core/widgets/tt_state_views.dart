import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/tt_colors.dart';
import '../theme/tt_radius.dart';
import 'tt_button.dart';

/// Khung xương tải trang (Skeleton) với hiệu ứng shimmer mượt mà.
class TtSkeleton extends StatelessWidget {
  const TtSkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.radius = const BorderRadius.all(Radius.circular(TtRadius.sm)),
  });

  /// Chiều rộng khung xương, null nếu co dãn theo cha.
  final double? width;

  /// Chiều cao khung xương.
  final double height;

  /// Bán kính bo góc (mặc định TtRadius.sm).
  final BorderRadiusGeometry? radius;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final effectiveRadius =
        radius ?? const BorderRadius.all(Radius.circular(TtRadius.sm));

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: tt.surface,
        borderRadius: effectiveRadius,
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1200.ms, color: tt.surface2);
  }
}

/// Giao diện trạng thái trống (Empty State).
class TtEmptyState extends StatelessWidget {
  const TtEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  /// Icon minh họa.
  final IconData icon;

  /// Tiêu đề trạng thái.
  final String title;

  /// Mô tả chi tiết (tùy chọn).
  final String? message;

  /// Nhãn nút hành động (tùy chọn).
  final String? actionLabel;

  /// Callback khi bấm nút hành động.
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: tt.surface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 36,
                color: tt.muted,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium,
            ),
            if (message != null && message!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: tt.muted,
                ),
              ),
            ],
            if (actionLabel != null && actionLabel!.isNotEmpty) ...[
              const SizedBox(height: 16),
              TtButton(
                label: actionLabel!,
                onPressed: onAction,
                variant: TtButtonVariant.secondary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Giao diện trạng thái lỗi kèm nút thử lại.
class TtErrorState extends StatelessWidget {
  const TtErrorState({
    super.key,
    required this.message,
    required this.onRetry,
    this.title = 'Có lỗi xảy ra',
    this.retryLabel = 'Thử lại',
  });

  /// Thông điệp lỗi chi tiết.
  final String message;

  /// Callback khi bấm nút thử lại.
  final VoidCallback onRetry;

  /// Tiêu đề thông báo lỗi.
  final String title;

  /// Nhãn trên nút thử lại.
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: tt.surface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                size: 36,
                color: tt.danger,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: tt.muted,
              ),
            ),
            const SizedBox(height: 16),
            TtButton(
              label: retryLabel,
              icon: Icons.refresh_rounded,
              variant: TtButtonVariant.primary,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
