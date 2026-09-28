import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palette pulled from Youssef's portrait: near-black studio backdrop,
/// charcoal/slate suit tones, and a warm champagne → bronze highlight.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.bg,
    required this.bg2,
    required this.surface,
    required this.surfaceHi,
    required this.border,
    required this.text,
    required this.muted,
    required this.accent,
    required this.accentDeep,
    required this.steel,
    required this.success,
    required this.spotlight,
  });

  final Color bg;
  final Color bg2;
  final Color surface;
  final Color surfaceHi;
  final Color border;
  final Color text;
  final Color muted;
  final Color accent;
  final Color accentDeep;
  final Color steel;
  final Color success;
  final Color spotlight;

  LinearGradient get accentGradient =>
      LinearGradient(colors: [const Color(0xFFF1D9BC), accent, accentDeep], begin: Alignment.topLeft, end: Alignment.bottomRight);

  static const dark = AppColors(
    bg: Color(0xFF0B0B0E),
    bg2: Color(0xFF0F1215),
    surface: Color(0xFF14171B),
    surfaceHi: Color(0xFF1C2025),
    border: Color(0x1AFFFFFF),
    text: Color(0xFFF3EEE8),
    muted: Color(0xFF9A9894),
    accent: Color(0xFFD9B48F),
    accentDeep: Color(0xFF866757),
    steel: Color(0xFF8E979F),
    success: Color(0xFF7FD1A4),
    spotlight: Color(0xFF2C3135),
  );

  static const light = AppColors(
    bg: Color(0xFFF5F2EE),
    bg2: Color(0xFFEDE8E2),
    surface: Color(0xFFFFFFFF),
    surfaceHi: Color(0xFFF8F5F1),
    border: Color(0x1A1A1D21),
    text: Color(0xFF14171B),
    muted: Color(0xFF6A665F),
    accent: Color(0xFF9C7556),
    accentDeep: Color(0xFF6E5041),
    steel: Color(0xFF5E666E),
    success: Color(0xFF2E8B57),
    spotlight: Color(0xFFE2DAD0),
  );

  @override
  AppColors copyWith() => this;

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      bg: l(bg, other.bg),
      bg2: l(bg2, other.bg2),
      surface: l(surface, other.surface),
      surfaceHi: l(surfaceHi, other.surfaceHi),
      border: l(border, other.border),
      text: l(text, other.text),
      muted: l(muted, other.muted),
      accent: l(accent, other.accent),
      accentDeep: l(accentDeep, other.accentDeep),
      steel: l(steel, other.steel),
      success: l(success, other.success),
      spotlight: l(spotlight, other.spotlight),
    );
  }
}

extension ColorsX on BuildContext {
  AppColors get c => Theme.of(this).extension<AppColors>()!;
}

class AppFonts {
  static TextStyle heading(bool ar) => ar ? GoogleFonts.cairo(fontWeight: FontWeight.w800) : GoogleFonts.sora(fontWeight: FontWeight.w700);
  static TextStyle body(bool ar) => ar ? GoogleFonts.cairo() : GoogleFonts.inter();
  static TextStyle mono() => GoogleFonts.jetBrainsMono();
}

ThemeData buildTheme({required bool dark, required bool ar}) {
  final c = dark ? AppColors.dark : AppColors.light;
  final base = dark ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true);
  final body = AppFonts.body(ar);
  return base.copyWith(
    scaffoldBackgroundColor: c.bg,
    colorScheme: base.colorScheme.copyWith(primary: c.accent, secondary: c.steel, surface: c.surface, onSurface: c.text),
    textTheme: base.textTheme.apply(fontFamily: body.fontFamily, bodyColor: c.text, displayColor: c.text),
    textSelectionTheme: TextSelectionThemeData(cursorColor: c.accent, selectionColor: c.accent.withValues(alpha: 0.3)),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: c.surfaceHi,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.border),
      ),
      textStyle: body.copyWith(color: c.text, fontSize: 12),
    ),
    extensions: [c],
  );
}
