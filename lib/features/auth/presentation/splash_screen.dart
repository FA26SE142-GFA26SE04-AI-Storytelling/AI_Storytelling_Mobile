import 'package:flutter/material.dart';

import 'package:ai_storytelling_mobile/core/theme/tt_colors.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_frog.dart';

/// Màn hình Splash hiển thị khi khởi động và kiểm tra phiên đăng nhập.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TtFrog(
              mood: TtFrogMood.idle,
              size: 140,
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Đang mở Đầm Sen Kể Chuyện...',
              style: textTheme.bodyMedium?.copyWith(
                color: tt.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
