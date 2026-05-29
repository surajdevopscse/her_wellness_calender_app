import 'package:flutter/material.dart';

/// Serene women wellness color system with soft pink, lavender, and plum tones.
class WellnessColors {
  WellnessColors._();

  static const primary = Color(0xFFF5D6E6);
  static const primaryDeep = Color(0xFF6E3F73);
  static const primaryHot = Color(0xFFF3B4CF);
  static const secondary = Color(0xFFE9DDF8);
  static const accent = Color(0xFFB76FA6);
  static const glowRose = Color(0xFFF8C9DC);
  static const glowLavender = Color(0xFFE8D8F7);
  static const glowPeach = Color(0xFFF8D8C8);

  static const background = Color(0xFFFFF7FB);
  static const backgroundAlt = Color(0xFFF7EFFB);
  static const surface = Color(0xFFFFFBFD);
  static const card = Color(0xFFFFFFFF);
  static const border = Color(0xFFE8D6E8);
  static const blush = Color(0xFFFFEAF3);
  static const lavender = Color(0xFFF1E8FB);
  static const peach = Color(0xFFFBE4DA);

  static const textPrimary = Color(0xFF2F2433);
  static const textSecondary = Color(0xFF6D5B70);
  static const textMuted = Color(0xFF9A8A9D);
  static const textOnPrimary = Color(0xFFFFFFFF);
  static const textOnSecondary = Color(0xFFFFFFFF);

  static const period = Color(0xFFEA86AE);
  static const periodDeep = Color(0xFFB84D7B);
  static const fertile = Color(0xFFD8C7F1);
  static const fertileDeep = Color(0xFF795AA8);
  static const ovulation = Color(0xFFF2B8D5);
  static const ovulationDeep = Color(0xFFC65A91);
  static const pms = Color(0xFFD5C1E4);
  static const pmsDeep = Color(0xFF7C5B8D);
  static const predicted = Color(0xFFF4D3E5);
  static const predictedDeep = Color(0xFFA95784);
  static const success = Color(0xFF9D78B6);
  static const warning = Color(0xFFE5A76F);
  static const error = Color(0xFFC95F86);

  static const darkPrimary = Color(0xFFF0C7DF);
  static const darkPrimaryDeep = Color(0xFFE2D0F2);
  static const darkAccent = Color(0xFFE4A2D0);
  static const darkBackground = Color(0xFF171019);
  static const darkBackgroundAlt = Color(0xFF211728);
  static const darkBackgroundRaised = Color(0xFF2C2133);
  static const darkSurface = Color(0xFF251A2B);
  static const darkCard = Color(0xFF302238);
  static const darkBorder = Color(0xFF66536D);
  static const darkTextPrimary = Color(0xFFFFF5FB);
  static const darkTextSecondary = Color(0xFFEAD7E8);
  static const darkTextMuted = Color(0xFFBDAABC);
  static const darkTextOnPrimary = Color(0xFF2A1830);
  static const darkTextOnSecondary = Color(0xFFFFFFFF);

  static ColorScheme get lightScheme => const ColorScheme.light(
    primary: primary,
    secondary: secondary,
    tertiary: accent,
    surface: surface,
    surfaceContainerHighest: blush,
    error: error,
    onPrimary: textOnPrimary,
    onSecondary: textOnSecondary,
    onSurface: textPrimary,
    onError: Colors.white,
  );

  static ColorScheme get darkScheme => const ColorScheme.dark(
    primary: darkPrimary,
    secondary: darkPrimaryDeep,
    tertiary: darkAccent,
    surface: darkSurface,
    surfaceContainerHighest: darkCard,
    error: error,
    onPrimary: darkTextOnPrimary,
    onSecondary: darkTextOnSecondary,
    onSurface: darkTextPrimary,
    onError: Colors.white,
  );

  static Color cardFor(Brightness brightness) =>
      brightness == Brightness.dark ? darkCard : card;

  static Color backgroundFor(Brightness brightness) =>
      brightness == Brightness.dark ? darkBackground : background;

  static Color textPrimaryFor(Brightness brightness) =>
      brightness == Brightness.dark ? darkTextPrimary : textPrimary;

  static Color textSecondaryFor(Brightness brightness) =>
      brightness == Brightness.dark ? darkTextSecondary : textSecondary;

  static Color borderFor(Brightness brightness) =>
      brightness == Brightness.dark ? darkBorder : border;

  static List<Color> backgroundGradientFor(Brightness brightness) =>
      brightness == Brightness.dark
      ? const [darkBackground, darkBackgroundAlt, darkBackgroundRaised]
      : const [background, background, backgroundAlt];

  static List<Color> heroGradientFor(Brightness brightness) =>
      brightness == Brightness.dark
      ? const [Color(0xFF34233D), Color(0xFF2A1D31), Color(0xFF211728)]
      : const [surface, Color(0xFFFFF1F8), Color(0xFFF3E8FB)];
}
