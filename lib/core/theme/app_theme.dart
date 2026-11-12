import 'package:flutter/material.dart';

import 'tt_colors.dart';

/// Quản lý cấu hình ThemeData cho toàn bộ ứng dụng (Light và Dark).
abstract final class AppTheme {
  /// Cấu hình ThemeData chế độ sáng (Light mode).
  static ThemeData light() {
    return _buildTheme(
      colorScheme: ColorScheme.light(
        primary: TtColors.light.primaryStrong,
        onPrimary: Colors.white,
        surface: TtColors.light.panel,
        onSurface: TtColors.light.text,
        error: TtColors.light.danger,
        onError: Colors.white,
        secondary: TtColors.light.primary,
        tertiary: TtColors.light.gold,
        outline: TtColors.light.line2,
        outlineVariant: TtColors.light.line,
      ),
      tt: TtColors.light,
    );
  }

  /// Cấu hình ThemeData chế độ tối (Dark mode).
  static ThemeData dark() {
    return _buildTheme(
      colorScheme: ColorScheme.dark(
        primary: TtColors.dark.primaryStrong,
        onPrimary: Colors.white,
        surface: TtColors.dark.panel,
        onSurface: TtColors.dark.text,
        error: TtColors.dark.danger,
        onError: Colors.white,
        secondary: TtColors.dark.primary,
        tertiary: TtColors.dark.gold,
        outline: TtColors.dark.line2,
        outlineVariant: TtColors.dark.line,
      ),
      tt: TtColors.dark,
    );
  }

  /// Hàm dựng ThemeData chung cho cả Light và Dark.
  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required TtColors tt,
  }) {
    final textTheme = _buildTextTheme(tt);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      fontFamily: 'Nunito',
      scaffoldBackgroundColor: tt.bg,
      extensions: <ThemeExtension<dynamic>>[tt],
      appBarTheme: AppBarTheme(
        backgroundColor: tt.chrome,
        foregroundColor: tt.text,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleMedium,
      ),
    );
  }

  /// Tạo TextTheme với phông Baloo2 cho tiêu đề, Nunito cho nội dung và nhãn.
  static TextTheme _buildTextTheme(TtColors tt) {
    final base = ThemeData(useMaterial3: true).textTheme.apply(
      fontFamily: 'Nunito',
      displayColor: tt.text,
      bodyColor: tt.text,
    );

    return base.copyWith(
      displaySmall: TextStyle(
        fontFamily: 'Baloo2',
        fontSize: 28,
        fontWeight: FontWeight.w800,
        height: 1.15,
        color: tt.text,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Baloo2',
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: tt.text,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Baloo2',
        fontSize: 17,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: tt.text,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: tt.text,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: tt.text,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 15,
        fontWeight: FontWeight.w700,
        height: 1.5,
        color: tt.text,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: tt.text,
      ),
    );
  }
}
