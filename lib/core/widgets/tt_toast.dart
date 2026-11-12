import 'package:flutter/material.dart';

import '../theme/tt_colors.dart';
import '../theme/tt_radius.dart';

/// Các loại thông báo toast trong ứng dụng.
enum TtToastType { success, error, info }

/// Hiển thị thông báo dạng toast ở cạnh dưới màn hình.
void showTtToast(
  BuildContext context,
  String message, {
  TtToastType type = TtToastType.info,
}) {
  final tt = context.tt;

  Color accentColor;
  IconData iconData;

  switch (type) {
    case TtToastType.success:
      accentColor = tt.primary;
      iconData = Icons.check_circle_rounded;
      break;
    case TtToastType.error:
      accentColor = tt.danger;
      iconData = Icons.error_rounded;
      break;
    case TtToastType.info:
      accentColor = tt.okInk;
      iconData = Icons.info_rounded;
      break;
  }

  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      duration: Duration(seconds: type == TtToastType.error ? 4 : 3),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: tt.panel,
          borderRadius: BorderRadius.circular(TtRadius.lg),
          border: Border.all(color: accentColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: tt.shadow.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 22,
              color: accentColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: tt.text,
                    ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
