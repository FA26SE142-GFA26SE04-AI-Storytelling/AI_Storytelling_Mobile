import 'package:flutter/material.dart';

import '../theme/tt_colors.dart';
import '../theme/tt_radius.dart';

/// Biến thể giao diện cho nút trong dự án.
enum TtButtonVariant { primary, secondary, danger }

/// Nút bấm chuẩn trong hệ thống thiết kế của dự án.
class TtButton extends StatelessWidget {
  const TtButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = TtButtonVariant.primary,
    this.isLoading = false,
    this.expanded = false,
  });

  /// Nhãn hiển thị của nút.
  final String label;

  /// Callback khi nhấn, null thì nút ở trạng thái vô hiệu hóa.
  final VoidCallback? onPressed;

  /// Icon tùy chọn đứng trước nhãn.
  final IconData? icon;

  /// Kiểu nút: primary, secondary hoặc danger.
  final TtButtonVariant variant;

  /// Trạng thái đang tải, hiển thị spinner và khóa nút.
  final bool isLoading;

  /// Chiếm toàn bộ chiều ngang khả dụng nếu là true.
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final effectiveOnPressed = (isLoading || onPressed == null) ? null : onPressed;
    final minSize = Size(expanded ? double.infinity : 0, 52);
    const padding = EdgeInsets.symmetric(horizontal: 20);

    Widget content;
    if (isLoading) {
      final spinnerColor =
          variant == TtButtonVariant.secondary ? tt.text : Colors.white;
      content = SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
        ),
      );
    } else {
      final labelWidget = FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );

      if (icon != null) {
        content = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Flexible(child: labelWidget),
          ],
        );
      } else {
        content = labelWidget;
      }
    }

    Widget button;
    if (variant == TtButtonVariant.secondary) {
      button = OutlinedButton(
        onPressed: effectiveOnPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: tt.panel,
          foregroundColor: tt.text,
          disabledBackgroundColor: tt.panel.withValues(alpha: 0.6),
          disabledForegroundColor: tt.text.withValues(alpha: 0.4),
          side: BorderSide(color: tt.line2, width: 1.5),
          minimumSize: minSize,
          padding: padding,
          textStyle: const TextStyle(fontFamily: 'Nunito', fontSize: 15, fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TtRadius.lg),
          ),
        ),
        child: content,
      );
    } else {
      final bg =
          variant == TtButtonVariant.danger ? tt.danger : tt.primaryStrong;
      button = FilledButton(
        onPressed: effectiveOnPressed,
        style: FilledButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: Colors.white,
          disabledBackgroundColor: bg.withValues(alpha: 0.6),
          disabledForegroundColor: Colors.white.withValues(alpha: 0.7),
          minimumSize: minSize,
          padding: padding,
          textStyle: const TextStyle(fontFamily: 'Nunito', fontSize: 15, fontWeight: FontWeight.w700),
          shape: const RoundedRectangleBorder(borderRadius: TtRadius.leaf),
        ),
        child: content,
      );
    }

    if (expanded) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }
}

/// Nút tròn chỉ chứa icon với viền nhẹ và tooltip.
class TtIconButton extends StatelessWidget {
  const TtIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
    this.size = 48,
  });

  /// Icon hiển thị.
  final IconData icon;

  /// Chú thích khi hover hoặc nhấn giữ.
  final String tooltip;

  /// Callback khi nhấn.
  final VoidCallback? onPressed;

  /// Kích thước đường kính của nút.
  final double size;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return Tooltip(
      message: tooltip,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        style: IconButton.styleFrom(
          backgroundColor: tt.panel,
          foregroundColor: tt.text,
          disabledBackgroundColor: tt.panel.withValues(alpha: 0.6),
          disabledForegroundColor: tt.text.withValues(alpha: 0.4),
          side: BorderSide(color: tt.line2, width: 1.5),
          shape: const CircleBorder(),
          minimumSize: Size(size, size),
          fixedSize: Size(size, size),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
