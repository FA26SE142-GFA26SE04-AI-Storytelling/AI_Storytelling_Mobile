import 'package:flutter/material.dart';
import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';

// Màn đăng nhập và router sẽ làm ở lượt sau.
class TaleTaleApp extends StatelessWidget {
  const TaleTaleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Đầm Sen Kể Chuyện',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const _PlaceholderHome(),
    );
  }
}

class _PlaceholderHome extends StatelessWidget {
  const _PlaceholderHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Đầm Sen Kể Chuyện',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
