import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../../shared/widgets/frog.dart';

/// Hiện trong lúc khôi phục phiên đăng nhập khi mở app.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: c.loginBg),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Frog(size: 110),
              const SizedBox(height: 12),
              Text('Đang kiểm tra phiên đăng nhập…', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: c.muted)),
            ],
          ),
        ),
      ),
    );
  }
}
