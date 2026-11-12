import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/core/router/app_router.dart';

class TaleTaleApp extends ConsumerWidget {
  const TaleTaleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Đầm Sen Kể Chuyện',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
