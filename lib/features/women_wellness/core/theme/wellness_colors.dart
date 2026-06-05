import 'package:flutter/material.dart';

/// Serene women wellness color system with soft pink, aqua, peach, and plum tones.
class WellnessColors {
  WellnessColors._();

  static const primary = Color(0xFFFF6F98);
  static const primaryDeep = Color(0xFFC21758);
  static const primaryHot = Color(0xFFFF4F7B);
  static const secondary = Color(0xFFBCEEF0);
  static const accent = Color(0xFF8D5ED6);
  static const glowRose = Color(0xFFFFC9D9);
  static const glowAqua = Color(0xFFCFF6F3);
  static const glowLavender = Color(0xFFE8D9FF);
  static const glowPeach = Color(0xFFFFD8BF);

  static const background = Color(0xFFFFF5F8);
  static const backgroundAlt = Color(0xFFF3FBFA);
  static const surface = Color(0xFFFFFFFF);
  static const card = Color(0xFFFFFFFF);
  static const border = Color(0xFFF0D6E1);
  static const blush = Color(0xFFFFE8F0);
  static const aqua = Color(0xFFE1F7F6);
  static const lavender = Color(0xFFF0E7FF);
  static const peach = Color(0xFFFFE4D2);

  static const textPrimary = Color(0xFF2D2130);
  static const textSecondary = Color(0xFF74616D);
  static const textMuted = Color(0xFFA18D96);
  static const textOnPrimary = Color(0xFFFFFFFF);
  static const textOnSecondary = Color(0xFFFFFFFF);

  static const period = Color(0xFFFF6F98);
  static const periodDeep = Color(0xFFC21758);
  static const fertile = Color(0xFFBCEEF0);
  static const fertileDeep = Color(0xFF118B8F);
  static const ovulation = Color(0xFFFFC59E);
  static const ovulationDeep = Color(0xFFD36A2B);
  static const pms = Color(0xFFE0D1FF);
  static const pmsDeep = Color(0xFF7253B5);
  static const predicted = Color(0xFFFFD1DF);
  static const predictedDeep = Color(0xFFD83B70);
  static const success = Color(0xFF39A58A);
  static const warning = Color(0xFFE49A43);
  static const error = Color(0xFFD54E71);

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
    primary: primaryHot,
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
      : const [background, Color(0xFFFFFBFD), backgroundAlt];

  static List<Color> heroGradientFor(Brightness brightness) =>
      brightness == Brightness.dark
      ? const [Color(0xFF34233D), Color(0xFF2A1D31), Color(0xFF211728)]
      : const [Color(0xFFFF739A), Color(0xFFFF9FBC), Color(0xFFFFE2EC)];
}
