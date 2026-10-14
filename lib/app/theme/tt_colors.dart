import 'package:material_ui/material_ui.dart';

/// Token màu Taletale (chủ đề đầm sen). Chép đúng từ
/// AI_Storytelling_Frontend/src/app/styles/tokens.css — đổi màu thì sửa cả hai nơi (xem DESIGN.md).
///
/// Dùng qua `context.tt.primary`, không viết mã màu trực tiếp trong widget.
@immutable
class TtColors extends ThemeExtension<TtColors> {
  const TtColors({
    required this.brightness,
    required this.bg,
    required this.chrome,
    required this.panel,
    required this.surface,
    required this.surface2,
    required this.paper,
    required this.line,
    required this.line2,
    required this.text,
    required this.muted,
    required this.faint,
    required this.inkWarm,
    required this.link,
    required this.primary,
    required this.primaryStrong,
    required this.gold,
    required this.goldDeep,
    required this.rose,
    required this.mint,
    required this.sky,
    required this.danger,
    required this.okInk,
    required this.warnInk,
    required this.lotus,
    required this.lotusDeep,
    required this.lotusLight,
    required this.shadow,
  });

  final Brightness brightness;

  // Nền và bề mặt
  final Color bg, chrome, panel, surface, surface2, paper, line, line2;

  // Chữ
  final Color text, muted, faint, inkWarm, link;

  // Thương hiệu và trạng thái
  final Color primary, primaryStrong, gold, goldDeep, rose, mint, sky, danger, okInk, warnInk, lotus, lotusDeep, lotusLight;

  final Color shadow;

  static const light = TtColors(
    brightness: Brightness.light,
    bg: Color(0xFFF4FBF6),
    chrome: Color(0xFFFFFFFF),
    panel: Color(0xFFFFFFFF),
    surface: Color(0xFFEBF7F0),
    surface2: Color(0xFFDCF0E5),
    paper: Color(0xFFFCFFFC),
    line: Color(0xFFDCEBE1),
    line2: Color(0xFFC3DCCC),
    text: Color(0xFF1F2F27),
    muted: Color(0xFF547062),
    faint: Color(0xFF8FA89B),
    inkWarm: Color(0xFF1F3A2D),
    link: Color(0xFF17754A),
    primary: Color(0xFF2FA866),
    primaryStrong: Color(0xFF1F8A55),
    gold: Color(0xFFFFD166),
    goldDeep: Color(0xFFD97706),
    rose: Color(0xFFFF8FA3),
    mint: Color(0xFF14B8A6),
    sky: Color(0xFF38B2F5),
    danger: Color(0xFFB42318),
    okInk: Color(0xFF0F766E),
    warnInk: Color(0xFF8F5200),
    lotus: Color(0xFFF6A9C4),
    lotusDeep: Color(0xFFEE86AB),
    lotusLight: Color(0xFFFCD3E1),
    shadow: Color(0xFF1F3A2D),
  );

  static const dark = TtColors(
    brightness: Brightness.dark,
    bg: Color(0xFF0F1713),
    chrome: Color(0xFF141E19),
    panel: Color(0xFF17231D),
    surface: Color(0xFF1D2B24),
    surface2: Color(0xFF263830),
    paper: Color(0xFF1A271F),
    line: Color(0xFF26372E),
    line2: Color(0xFF365044),
    text: Color(0xFFE8F4EC),
    muted: Color(0xFFA3BDB0),
    faint: Color(0xFF6F8A7C),
    inkWarm: Color(0xFFE3F2E9),
    link: Color(0xFF6EE7A8),
    primary: Color(0xFF3DD68C),
    primaryStrong: Color(0xFF1F8A55),
    gold: Color(0xFFFFD166),
    goldDeep: Color(0xFFF59E0B),
    rose: Color(0xFFFF8FA3),
    mint: Color(0xFF2DD4BF),
    sky: Color(0xFF38B2F5),
    danger: Color(0xFFFF8A80),
    okInk: Color(0xFF5EEAD4),
    warnInk: Color(0xFFFFC857),
    lotus: Color(0xFFE98AAF),
    lotusDeep: Color(0xFFC96A92),
    lotusLight: Color(0xFFF5B7CF),
    shadow: Color(0xFF000000),
  );

  bool get isDark => brightness == Brightness.dark;

  /// Mặt nước làm nền màn hình (`--water`).
  Gradient get water => isDark
      ? const RadialGradient(center: Alignment(-0.76, -1), radius: 1.1, colors: [Color(0xFF12301F), Color(0xFF0B1410)])
      : const RadialGradient(center: Alignment(-0.76, -1), radius: 1.1, colors: [Color(0xFFD8F4E4), Color(0xFFEAF7EF)]);

  /// Nền màn đăng nhập (`--login-bg`).
  Gradient get loginBg => isDark
      ? const RadialGradient(center: Alignment(-0.6, -0.8), radius: 0.9, colors: [Color(0xFF123325), Color(0xFF0F1713)])
      : const RadialGradient(center: Alignment(-0.6, -0.8), radius: 0.9, colors: [Color(0xFFD4F3E0), Color(0xFFF4FBF6)]);

  /// Nền Chế độ của bé (`--kid-bg`).
  Gradient get kidBg => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [0, 0.6, 1],
    colors: isDark ? const [Color(0xFF14283A), Color(0xFF1F2A1F), Color(0xFF123024)] : const [Color(0xFFC9ECFF), Color(0xFFF3FBD9), Color(0xFFBDEBCF)],
  );

  @override
  TtColors copyWith() => this;

  @override
  TtColors lerp(TtColors? other, double t) {
    if (other == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return TtColors(
      brightness: t < 0.5 ? brightness : other.brightness,
      bg: l(bg, other.bg),
      chrome: l(chrome, other.chrome),
      panel: l(panel, other.panel),
      surface: l(surface, other.surface),
      surface2: l(surface2, other.surface2),
      paper: l(paper, other.paper),
      line: l(line, other.line),
      line2: l(line2, other.line2),
      text: l(text, other.text),
      muted: l(muted, other.muted),
      faint: l(faint, other.faint),
      inkWarm: l(inkWarm, other.inkWarm),
      link: l(link, other.link),
      primary: l(primary, other.primary),
      primaryStrong: l(primaryStrong, other.primaryStrong),
      gold: l(gold, other.gold),
      goldDeep: l(goldDeep, other.goldDeep),
      rose: l(rose, other.rose),
      mint: l(mint, other.mint),
      sky: l(sky, other.sky),
      danger: l(danger, other.danger),
      okInk: l(okInk, other.okInk),
      warnInk: l(warnInk, other.warnInk),
      lotus: l(lotus, other.lotus),
      lotusDeep: l(lotusDeep, other.lotusDeep),
      lotusLight: l(lotusLight, other.lotusLight),
      shadow: l(shadow, other.shadow),
    );
  }
}

extension TtColorsX on BuildContext {
  TtColors get tt => Theme.of(this).extension<TtColors>()!;
}
