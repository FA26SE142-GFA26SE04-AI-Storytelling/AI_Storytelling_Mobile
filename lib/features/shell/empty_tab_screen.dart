import 'package:flutter/material.dart';

import 'package:ai_storytelling_mobile/core/widgets/tt_state_views.dart';

/// Màn hình giữ chỗ dạng tab rỗng chưa có nội dung.
class EmptyTabScreen extends StatelessWidget {
  const EmptyTabScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.message,
    this.footer,
  });

  /// Tiêu đề tab.
  final String title;

  /// Biểu tượng minh họa.
  final IconData icon;

  /// Nội dung thông báo hiển thị.
  final String message;

  /// Widget tùy chọn hiển thị ở đáy màn hình (ví dụ: nút bấm).
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Semantics(
                  header: true,
                  label: title,
                  child: TtEmptyState(
                    icon: icon,
                    title: 'Sắp có nội dung',
                    message: message,
                  ),
                ),
              ),
            ),
            if (footer != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: footer!,
              ),
          ],
        ),
      ),
    );
  }
}
