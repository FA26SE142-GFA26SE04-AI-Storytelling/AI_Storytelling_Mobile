import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'router.dart';
import 'theme/theme_mode_controller.dart';
import 'theme/tt_theme.dart';

class TaletaleApp extends ConsumerWidget {
  const TaletaleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Taletale',
      debugShowCheckedModeBanner: false,
      theme: TtTheme.light,
      darkTheme: TtTheme.dark,
      themeMode: ref.watch(themeModeProvider),
      routerConfig: ref.watch(routerProvider),
      locale: const Locale('vi'),
      supportedLocales: const [Locale('vi'), Locale('en')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      // Tôn trọng cỡ chữ hệ thống nhưng giới hạn để bố cục khu người lớn không vỡ (DESIGN.md › Kiểu chữ).
      builder: (context, child) => MediaQuery.withClampedTextScaling(maxScaleFactor: 1.3, child: child!),
    );
  }
}
