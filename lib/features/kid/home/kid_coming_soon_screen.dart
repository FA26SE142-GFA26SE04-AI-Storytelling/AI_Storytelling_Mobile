import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_state_views.dart';

class KidComingSoonScreen extends StatelessWidget {
  const KidComingSoonScreen({
    super.key,
    required this.title,
  });

  final String title;

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
            Expanded(
              child: Center(
                child: TtEmptyState(
                  icon: Icons.hourglass_empty_rounded,
                  title: '$title sắp có',
                  message: 'Mục này sẽ mở ở bản sau nhé em.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
