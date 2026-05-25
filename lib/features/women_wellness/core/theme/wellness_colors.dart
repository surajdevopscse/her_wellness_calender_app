import 'package:flutter/material.dart';

/// Premium women wellness color system with layered glow tokens.
class WellnessColors {
  WellnessColors._();

  static const primary = Color(0xFFF5B7C5);
  static const primaryDeep = Color(0xFFE68EA6);
  static const primaryHot = Color(0xFFFFD4DE);
  static const secondary = Color(0xFFD8B4FE);
  static const accent = Color(0xFFFDBA74);
  static const glowRose = Color(0xFFFFC6D2);
  static const glowLavender = Color(0xFFE8CCFF);
  static const glowPeach = Color(0xFFFCCB9A);

  static const background = Color(0xFFFCF8F6);
  static const backgroundAlt = Color(0xFFF7F0F8);
  static const surface = Color(0xFFFFFCFB);
  static const card = Color(0xFFFFFFFF);
  static const border = Color(0xFFEADCE8);
  static const blush = Color(0xFFFFEEF3);
  static const lavender = Color(0xFFF4EEFF);
  static const peach = Color(0xFFFFF0E3);

  static const textPrimary = Color(0xFF2F2435);
  static const textSecondary = Color(0xFF6C5D73);
  static const textMuted = Color(0xFF988A9E);
  static const textOnPrimary = Color(0xFF241B2A);
  static const textOnSecondary = Color(0xFFFFFFFF);

  static const period = Color(0xFFF29AA7);
  static const periodDeep = Color(0xFFD86F8A);
  static const fertile = Color(0xFFA7E7C5);
  static const fertileDeep = Color(0xFF5DAA86);
  static const ovulation = Color(0xFFF9C67D);
  static const ovulationDeep = Color(0xFFCC8E38);
  static const pms = Color(0xFFC6A4F8);
  static const pmsDeep = Color(0xFF8E69D4);
  static const predicted = Color(0xFFFAD6B1);
  static const predictedDeep = Color(0xFFC9975D);
  static const success = Color(0xFF73C69B);
  static const warning = Color(0xFFF0B768);
  static const error = Color(0xFFDB728E);

  static const darkPrimary = Color(0xFFF5B7C5);
  static const darkPrimaryDeep = Color(0xFFD8B4FE);
  static const darkAccent = Color(0xFFFDBA74);
  static const darkBackground = Color(0xFF1A1023);
  static const darkBackgroundAlt = Color(0xFF22152D);
  static const darkBackgroundRaised = Color(0xFF2B1838);
  static const darkSurface = Color(0xFF25182F);
  static const darkCard = Color(0xFF2F1F3A);
  static const darkBorder = Color(0xFF5B4267);
  static const darkTextPrimary = Color(0xFFF9F2FB);
  static const darkTextSecondary = Color(0xFFD9C7E3);
  static const darkTextMuted = Color(0xFFA997B6);
  static const darkTextOnPrimary = Color(0xFF1B1321);
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
          : const [background, backgroundAlt, blush];

  static List<Color> heroGradientFor(Brightness brightness) =>
      brightness == Brightness.dark
          ? const [Color(0xFF3B224D), Color(0xFF281733), Color(0xFF201028)]
          : const [Color(0xFFFFEEF3), Color(0xFFF6E8FF), Color(0xFFFFF2E7)];
}
