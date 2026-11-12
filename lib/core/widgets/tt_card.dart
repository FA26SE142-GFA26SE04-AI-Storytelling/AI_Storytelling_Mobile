import 'package:flutter/material.dart';

import '../theme/tt_colors.dart';
import '../theme/tt_radius.dart';

/// Thẻ Card chuẩn giao diện của dự án, hỗ trợ hiệu ứng bóng, viền và chạm nhấn.
class TtCard extends StatelessWidget {
  const TtCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  /// Widget con bên trong thẻ.
  final Widget child;

  /// Khoảng đệm bên trong thẻ.
  final EdgeInsetsGeometry padding;

  /// Callback khi nhấn vào thẻ.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final borderRadius = BorderRadius.circular(TtRadius.lg);

    Widget content = Padding(
      padding: padding,
      child: child,
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: content,
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: tt.panel.withValues(alpha: 0.92),
        borderRadius: borderRadius,
        border: Border.all(
          color: tt.line2,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: tt.shadow.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: content,
      ),
    );
  }
}
