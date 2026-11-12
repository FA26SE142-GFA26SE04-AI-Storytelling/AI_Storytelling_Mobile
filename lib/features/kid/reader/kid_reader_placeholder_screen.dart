import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_state_views.dart';

class KidReaderPlaceholderScreen extends StatelessWidget {
  const KidReaderPlaceholderScreen({
    super.key,
    required this.storyId,
  });

  final int storyId;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TtButton(
                  label: 'Quay lại',
                  icon: Icons.arrow_back_rounded,
                  variant: TtButtonVariant.secondary,
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/kid');
                    }
                  },
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: TtEmptyState(
                  icon: Icons.auto_stories_rounded,
                  title: 'Màn đọc sẽ mở ở bản sau',
                  message: 'Em chờ bản sau nhé, truyện này đã sẵn sàng rồi.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
