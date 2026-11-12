import 'package:flutter/material.dart';

import '../theme/tt_colors.dart';
import '../theme/tt_radius.dart';
import 'tt_button.dart';

/// Hiển thị hộp thoại xác nhận hành động của người dùng.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Xác nhận',
  String cancelLabel = 'Huỷ',
  bool destructive = false,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      final tt = dialogContext.tt;

      return Dialog(
        backgroundColor: tt.panel,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TtRadius.xl),
          side: BorderSide(color: tt.line2, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(dialogContext).textTheme.titleMedium?.copyWith(
                      color: tt.text,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: Theme.of(dialogContext).textTheme.bodyMedium?.copyWith(
                      color: tt.muted,
                    ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: TtButton(
                      label: cancelLabel,
                      variant: TtButtonVariant.secondary,
                      onPressed: () => Navigator.of(dialogContext).pop(false),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TtButton(
                      label: confirmLabel,
                      variant: destructive
                          ? TtButtonVariant.danger
                          : TtButtonVariant.primary,
                      onPressed: () => Navigator.of(dialogContext).pop(true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  return result ?? false;
}
