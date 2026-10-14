import 'package:material_ui/material_ui.dart';

import 'tt_colors.dart';

/// Bo góc (DESIGN.md › rounded).
abstract final class TtRadius {
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 14.0;
  static const lg = 18.0;
  static const xl = 24.0;
  static const xxl = 34.0;
  static const book = 44.0;

  /// Hình lá của nút chính: hai góc chéo bo lớn, hai góc còn lại bo nhỏ.
  static const leaf = BorderRadius.only(
    topLeft: Radius.circular(18),
    topRight: Radius.circular(7),
    bottomRight: Radius.circular(18),
    bottomLeft: Radius.circular(7),
  );
}

/// Vùng chạm tối thiểu.
abstract final class TtTouch {
  static const parent = 48.0;
  static const kid = 64.0;
}

abstract final class TtFonts {
  static const ui = 'Nunito';
  static const display = 'Baloo2';
}

abstract final class TtTheme {
  static ThemeData get light => _build(TtColors.light);
  static ThemeData get dark => _build(TtColors.dark);

  static ThemeData _build(TtColors c) {
    final scheme = ColorScheme(
      brightness: c.brightness,
      primary: c.primaryStrong,
      onPrimary: Colors.white,
      primaryContainer: Color.alphaBlend(c.primary.withValues(alpha: 0.16), c.panel),
      onPrimaryContainer: c.text,
      secondary: c.gold,
      onSecondary: const Color(0xFF5C3000),
      tertiary: c.mint,
      onTertiary: Colors.white,
      error: c.danger,
      onError: Colors.white,
      surface: c.panel,
      onSurface: c.text,
      onSurfaceVariant: c.muted,
      surfaceContainerLowest: c.panel,
      surfaceContainerLow: c.paper,
      surfaceContainer: c.chrome,
      surfaceContainerHigh: c.surface,
      surfaceContainerHighest: c.surface2,
      outline: c.line2,
      outlineVariant: c.line,
      shadow: c.shadow,
      inverseSurface: c.text,
      onInverseSurface: c.bg,
    );

    final text = _textTheme(c);

    return ThemeData(
      useMaterial3: true,
      brightness: c.brightness,
      colorScheme: scheme,
      extensions: [c],
      fontFamily: TtFonts.ui,
      textTheme: text,
      scaffoldBackgroundColor: c.bg,
      canvasColor: c.bg,
      dividerTheme: DividerThemeData(color: c.line, thickness: 1, space: 1),
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: c.bg,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        foregroundColor: c.text,
        centerTitle: false,
        titleTextStyle: text.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: c.panel,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TtRadius.lg),
          side: BorderSide(color: c.line),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surface,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        hintStyle: TextStyle(color: c.faint),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TtRadius.sm),
          borderSide: BorderSide(color: c.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TtRadius.sm),
          borderSide: BorderSide(color: c.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TtRadius.sm),
          borderSide: BorderSide(color: c.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TtRadius.sm),
          borderSide: BorderSide(color: c.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TtRadius.sm),
          borderSide: BorderSide(color: c.danger, width: 1.5),
        ),
        errorStyle: TextStyle(color: c.danger, fontSize: 12.5),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: c.primary, selectionColor: c.primary.withValues(alpha: 0.3), selectionHandleColor: c.primary),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: c.chrome,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 68,
        indicatorColor: c.primary.withValues(alpha: 0.16),
        indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TtRadius.md)),
        iconTheme: WidgetStateProperty.resolveWith((s) => IconThemeData(color: s.contains(WidgetState.selected) ? c.primaryStrong : c.muted, size: 24)),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (s) => TextStyle(
            fontFamily: TtFonts.ui,
            fontSize: 12,
            fontWeight: s.contains(WidgetState.selected) ? FontWeight.w800 : FontWeight.w600,
            color: s.contains(WidgetState.selected) ? c.text : c.muted,
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: c.chrome,
        indicatorColor: c.primary.withValues(alpha: 0.16),
        indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TtRadius.md)),
        selectedIconTheme: IconThemeData(color: c.primaryStrong),
        unselectedIconTheme: IconThemeData(color: c.muted),
        selectedLabelTextStyle: TextStyle(fontFamily: TtFonts.ui, fontSize: 13, fontWeight: FontWeight.w800, color: c.text),
        unselectedLabelTextStyle: TextStyle(fontFamily: TtFonts.ui, fontSize: 13, fontWeight: FontWeight.w600, color: c.muted),
      ),
      badgeTheme: BadgeThemeData(backgroundColor: c.gold, textColor: const Color(0xFF5C3000)),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(TtRadius.md))),
          side: WidgetStatePropertyAll(BorderSide(color: c.line)),
          backgroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? c.surface2 : c.surface),
          foregroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? c.text : c.muted),
          textStyle: const WidgetStatePropertyAll(TextStyle(fontFamily: TtFonts.ui, fontWeight: FontWeight.w700, fontSize: 13.5)),
          minimumSize: const WidgetStatePropertyAll(Size(0, TtTouch.parent)),
        ),
      ),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? c.primaryStrong : c.line2),
        thumbColor: const WidgetStatePropertyAll(Colors.white),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.surface,
        selectedColor: c.primary.withValues(alpha: 0.16),
        side: BorderSide(color: c.line2),
        shape: const StadiumBorder(),
        labelStyle: TextStyle(fontFamily: TtFonts.ui, fontWeight: FontWeight.w600, fontSize: 13, color: c.muted),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: c.text,
        contentTextStyle: TextStyle(fontFamily: TtFonts.ui, color: c.bg, fontWeight: FontWeight.w700, fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TtRadius.sm)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.panel,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: c.line2,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(TtRadius.xl))),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.panel,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TtRadius.xl)),
        titleTextStyle: text.headlineSmall,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.link,
          minimumSize: const Size(0, TtTouch.parent),
          textStyle: const TextStyle(fontFamily: TtFonts.ui, fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.primaryStrong,
        foregroundColor: Colors.white,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: TtRadius.leaf),
      ),
    );
  }

  /// Thang chữ mobile (DESIGN.md › typography.mobile-scale).
  static TextTheme _textTheme(TtColors c) {
    TextStyle display(double size, FontWeight w, double h) => TextStyle(fontFamily: TtFonts.display, fontSize: size, fontWeight: w, height: h, color: c.text);
    TextStyle ui(double size, FontWeight w, double h, [Color? color]) =>
        TextStyle(fontFamily: TtFonts.ui, fontSize: size, fontWeight: w, height: h, color: color ?? c.text);
    return TextTheme(
      displaySmall: display(28, FontWeight.w800, 1.15),
      headlineMedium: display(24, FontWeight.w800, 1.2),
      headlineSmall: display(22, FontWeight.w700, 1.25),
      titleLarge: display(19, FontWeight.w700, 1.3),
      titleMedium: ui(15, FontWeight.w700, 1.35),
      titleSmall: ui(14, FontWeight.w700, 1.35),
      bodyLarge: ui(15, FontWeight.w400, 1.5),
      bodyMedium: ui(14, FontWeight.w400, 1.45),
      bodySmall: ui(12.5, FontWeight.w400, 1.4, c.muted),
      labelLarge: ui(14, FontWeight.w700, 1.2),
      labelMedium: ui(12, FontWeight.w700, 1.2, c.muted),
      labelSmall: ui(11, FontWeight.w600, 1.2, c.muted),
    );
  }
}
