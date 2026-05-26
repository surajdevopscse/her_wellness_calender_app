import 'package:flutter/material.dart';

/// Premium women wellness color system with layered glow tokens.
class WellnessColors {
  WellnessColors._();

  static const primary = Color(0xFFF3B5BE);
  static const primaryDeep = Color(0xFFD97F91);
  static const primaryHot = Color(0xFFFFE3E6);
  static const secondary = Color(0xFFC7E4D5);
  static const accent = Color(0xFFE8B17C);
  static const glowRose = Color(0xFFFFCDD5);
  static const glowLavender = Color(0xFFE7E0F3);
  static const glowPeach = Color(0xFFF7D3AE);

  static const background = Color(0xFFFCF7F4);
  static const backgroundAlt = Color(0xFFF5EFE9);
  static const surface = Color(0xFFFFFBF8);
  static const card = Color(0xFFFFFFFF);
  static const border = Color(0xFFE8DDD7);
  static const blush = Color(0xFFFFF0F1);
  static const lavender = Color(0xFFF4F0F7);
  static const peach = Color(0xFFFBF0E4);

  static const textPrimary = Color(0xFF34262B);
  static const textSecondary = Color(0xFF6C5B62);
  static const textMuted = Color(0xFF9B8991);
  static const textOnPrimary = Color(0xFF2B1D23);
  static const textOnSecondary = Color(0xFFFFFFFF);

  static const period = Color(0xFFF29AA7);
  static const periodDeep = Color(0xFFD86F8A);
  static const fertile = Color(0xFFB9E1C8);
  static const fertileDeep = Color(0xFF5D9B79);
  static const ovulation = Color(0xFFF9C67D);
  static const ovulationDeep = Color(0xFFCC8E38);
  static const pms = Color(0xFFD8C6E8);
  static const pmsDeep = Color(0xFF8F73AA);
  static const predicted = Color(0xFFFAD6B1);
  static const predictedDeep = Color(0xFFC9975D);
  static const success = Color(0xFF73C69B);
  static const warning = Color(0xFFF0B768);
  static const error = Color(0xFFDB728E);

  static const darkPrimary = Color(0xFFF3B5BE);
  static const darkPrimaryDeep = Color(0xFFC9DBC9);
  static const darkAccent = Color(0xFFE8B17C);
  static const darkBackground = Color(0xFF1C1418);
  static const darkBackgroundAlt = Color(0xFF261C21);
  static const darkBackgroundRaised = Color(0xFF31242A);
  static const darkSurface = Color(0xFF281D22);
  static const darkCard = Color(0xFF34262D);
  static const darkBorder = Color(0xFF5D4A50);
  static const darkTextPrimary = Color(0xFFF9F1F3);
  static const darkTextSecondary = Color(0xFFE0CDD1);
  static const darkTextMuted = Color(0xFFAA979D);
  static const darkTextOnPrimary = Color(0xFF22181C);
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
          : const [background, backgroundAlt, surface];

  static List<Color> heroGradientFor(Brightness brightness) =>
      brightness == Brightness.dark
          ? const [Color(0xFF4A3136), Color(0xFF322227), Color(0xFF25191D)]
          : const [Color(0xFFFFF1F0), Color(0xFFF4EEE8), Color(0xFFFFF4EA)];
}
