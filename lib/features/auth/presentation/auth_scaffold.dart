import 'package:flutter/material.dart';

import 'package:ai_storytelling_mobile/core/theme/tt_colors.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_card.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_frog.dart';

/// Khung giao diện chuẩn dùng chung cho các màn hình xác thực (đăng nhập, đăng ký, v.v.).
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.showFox = true,
  });

  /// Tiêu đề chính của màn hình xác thực.
  final String title;

  /// Phụ đề mô tả ngắn bên dưới tiêu đề (tùy chọn).
  final String? subtitle;

  /// Nội dung form hoặc các thành phần chính bên trong thẻ.
  final Widget child;

  /// Có hiển thị linh vật phía trên hay không.
  final bool showFox;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tt = context.tt;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            24 + MediaQuery.viewPaddingOf(context).bottom,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (showFox) ...[
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: tt.gold.withValues(
                              alpha: isDark ? 0.15 : 0.25,
                            ),
                          ),
                        ),
                        const TtFrog(
                          mood: TtFrogMood.happy,
                          size: 120,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: textTheme.headlineMedium,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      subtitle!,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: tt.muted,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  TtCard(
                    padding: const EdgeInsets.all(20),
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
