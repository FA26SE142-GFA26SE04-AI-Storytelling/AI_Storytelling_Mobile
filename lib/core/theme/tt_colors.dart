import 'package:flutter/material.dart';

/// Design tokens for colors defined in DESIGN.md.
class TtColors extends ThemeExtension<TtColors> {
  const TtColors({
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

  final Color bg;
  final Color chrome;
  final Color panel;
  final Color surface;
  final Color surface2;
  final Color paper;
  final Color line;
  final Color line2;
  final Color text;
  final Color muted;
  final Color faint;
  final Color inkWarm;
  final Color link;
  final Color primary;
  final Color primaryStrong;
  final Color gold;
  final Color goldDeep;
  final Color rose;
  final Color mint;
  final Color sky;
  final Color danger;
  final Color okInk;
  final Color warnInk;
  final Color lotus;
  final Color lotusDeep;
  final Color lotusLight;
  final Color shadow;

  static const TtColors light = TtColors(
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

  static const TtColors dark = TtColors(
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
    sky: Color(0xFF38B2F5), // Dark theme không có sky: dùng cùng giá trị light 38b2f5
    danger: Color(0xFFFF8A80),
    okInk: Color(0xFF5EEAD4),
    warnInk: Color(0xFFFFC857),
    lotus: Color(0xFFE98AAF),
    lotusDeep: Color(0xFFC96A92),
    lotusLight: Color(0xFFF5B7CF),
    shadow: Color(0xFF000000),
  );

  @override
  TtColors copyWith({
    Color? bg,
    Color? chrome,
    Color? panel,
    Color? surface,
    Color? surface2,
    Color? paper,
    Color? line,
    Color? line2,
    Color? text,
    Color? muted,
    Color? faint,
    Color? inkWarm,
    Color? link,
    Color? primary,
    Color? primaryStrong,
    Color? gold,
    Color? goldDeep,
    Color? rose,
    Color? mint,
    Color? sky,
    Color? danger,
    Color? okInk,
    Color? warnInk,
    Color? lotus,
    Color? lotusDeep,
    Color? lotusLight,
    Color? shadow,
  }) {
    return TtColors(
      bg: bg ?? this.bg,
      chrome: chrome ?? this.chrome,
      panel: panel ?? this.panel,
      surface: surface ?? this.surface,
      surface2: surface2 ?? this.surface2,
      paper: paper ?? this.paper,
      line: line ?? this.line,
      line2: line2 ?? this.line2,
      text: text ?? this.text,
      muted: muted ?? this.muted,
      faint: faint ?? this.faint,
      inkWarm: inkWarm ?? this.inkWarm,
      link: link ?? this.link,
      primary: primary ?? this.primary,
      primaryStrong: primaryStrong ?? this.primaryStrong,
      gold: gold ?? this.gold,
      goldDeep: goldDeep ?? this.goldDeep,
      rose: rose ?? this.rose,
      mint: mint ?? this.mint,
      sky: sky ?? this.sky,
      danger: danger ?? this.danger,
      okInk: okInk ?? this.okInk,
      warnInk: warnInk ?? this.warnInk,
      lotus: lotus ?? this.lotus,
      lotusDeep: lotusDeep ?? this.lotusDeep,
      lotusLight: lotusLight ?? this.lotusLight,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  TtColors lerp(ThemeExtension<TtColors>? other, double t) {
    if (other is! TtColors) {
      return this;
    }
    return TtColors(
      bg: Color.lerp(bg, other.bg, t)!,
      chrome: Color.lerp(chrome, other.chrome, t)!,
      panel: Color.lerp(panel, other.panel, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surface2: Color.lerp(surface2, other.surface2, t)!,
      paper: Color.lerp(paper, other.paper, t)!,
      line: Color.lerp(line, other.line, t)!,
      line2: Color.lerp(line2, other.line2, t)!,
      text: Color.lerp(text, other.text, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      faint: Color.lerp(faint, other.faint, t)!,
      inkWarm: Color.lerp(inkWarm, other.inkWarm, t)!,
      link: Color.lerp(link, other.link, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryStrong: Color.lerp(primaryStrong, other.primaryStrong, t)!,
      gold: Color.lerp(gold, other.gold, t)!,
      goldDeep: Color.lerp(goldDeep, other.goldDeep, t)!,
      rose: Color.lerp(rose, other.rose, t)!,
      mint: Color.lerp(mint, other.mint, t)!,
      sky: Color.lerp(sky, other.sky, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      okInk: Color.lerp(okInk, other.okInk, t)!,
      warnInk: Color.lerp(warnInk, other.warnInk, t)!,
      lotus: Color.lerp(lotus, other.lotus, t)!,
      lotusDeep: Color.lerp(lotusDeep, other.lotusDeep, t)!,
      lotusLight: Color.lerp(lotusLight, other.lotusLight, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}

extension TtThemeContext on BuildContext {
  TtColors get tt => Theme.of(this).extension<TtColors>()!;
}
