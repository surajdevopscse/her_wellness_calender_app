import 'package:flutter/material.dart';

/// Serene women wellness color system with sage, cream, rose, and clay tones.
class WellnessColors {
  WellnessColors._();

  static const primary = Color(0xFFDCE9D4);
  static const primaryDeep = Color(0xFF3F5F3E);
  static const primaryHot = Color(0xFFF2C9D1);
  static const secondary = Color(0xFFE5EDDC);
  static const accent = Color(0xFFC9935A);
  static const glowRose = Color(0xFFF6C5CF);
  static const glowLavender = Color(0xFFEDE5EF);
  static const glowPeach = Color(0xFFF5D6B6);

  static const background = Color(0xFFFAF6EF);
  static const backgroundAlt = Color(0xFFF3EDE4);
  static const surface = Color(0xFFFFFCF8);
  static const card = Color(0xFFFFFFFF);
  static const border = Color(0xFFE3D8CB);
  static const blush = Color(0xFFFFEEF1);
  static const lavender = Color(0xFFF4EFF4);
  static const peach = Color(0xFFF7E8D5);

  static const textPrimary = Color(0xFF2F2A23);
  static const textSecondary = Color(0xFF6F665B);
  static const textMuted = Color(0xFF9B9184);
  static const textOnPrimary = Color(0xFFFFFFFF);
  static const textOnSecondary = Color(0xFFFFFFFF);

  static const period = Color(0xFFE9909F);
  static const periodDeep = Color(0xFFBC6272);
  static const fertile = Color(0xFFC8DDBB);
  static const fertileDeep = Color(0xFF65885D);
  static const ovulation = Color(0xFFE9BC7B);
  static const ovulationDeep = Color(0xFFB37C39);
  static const pms = Color(0xFFD8CEE0);
  static const pmsDeep = Color(0xFF89789A);
  static const predicted = Color(0xFFF2D7BD);
  static const predictedDeep = Color(0xFFA9784E);
  static const success = Color(0xFF79A978);
  static const warning = Color(0xFFE3AE65);
  static const error = Color(0xFFC66A82);

  static const darkPrimary = Color(0xFFC8DDBB);
  static const darkPrimaryDeep = Color(0xFFE3D4C1);
  static const darkAccent = Color(0xFFD9A46E);
  static const darkBackground = Color(0xFF191B16);
  static const darkBackgroundAlt = Color(0xFF20251E);
  static const darkBackgroundRaised = Color(0xFF2A3026);
  static const darkSurface = Color(0xFF23281F);
  static const darkCard = Color(0xFF2D3429);
  static const darkBorder = Color(0xFF56604D);
  static const darkTextPrimary = Color(0xFFF8F2EA);
  static const darkTextSecondary = Color(0xFFE2D7CA);
  static const darkTextMuted = Color(0xFFB1A598);
  static const darkTextOnPrimary = Color(0xFF20271D);
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
      ? const [Color(0xFF2D3529), Color(0xFF262E23), Color(0xFF20271D)]
      : const [surface, Color(0xFFFCF8F1), Color(0xFFF1EBDD)];
}
