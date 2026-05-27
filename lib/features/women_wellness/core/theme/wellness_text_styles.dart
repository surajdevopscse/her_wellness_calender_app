import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'wellness_colors.dart';

/// Typography: restrained display type and clear product UI text.
class WellnessTextStyles {
  WellnessTextStyles._();

  static const double _bodyHeight = 1.6;

  static TextTheme textTheme(Brightness brightness) {
    final primary = WellnessColors.textPrimaryFor(brightness);
    final secondary = WellnessColors.textSecondaryFor(brightness);
    final bodyTheme = GoogleFonts.plusJakartaSansTextTheme();
    final displayTheme = GoogleFonts.plusJakartaSansTextTheme();

    return bodyTheme.copyWith(
      displayLarge: displayTheme.displayLarge?.copyWith(
        fontSize: 42,
        fontWeight: FontWeight.w700,
        height: 1.02,
        letterSpacing: 0,
        color: primary,
      ),
      displayMedium: displayTheme.displayMedium?.copyWith(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        height: 1.08,
        letterSpacing: 0,
        color: primary,
      ),
      headlineLarge: displayTheme.headlineLarge?.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.12,
        color: primary,
      ),
      headlineMedium: displayTheme.headlineMedium?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.16,
        color: primary,
      ),
      headlineSmall: displayTheme.headlineSmall?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: primary,
      ),
      titleLarge: bodyTheme.titleLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.28,
        color: primary,
      ),
      titleMedium: bodyTheme.titleMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.28,
        color: primary,
      ),
      titleSmall: bodyTheme.titleSmall?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: primary,
      ),
      bodyLarge: bodyTheme.bodyLarge?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: _bodyHeight,
        color: primary,
      ),
      bodyMedium: bodyTheme.bodyMedium?.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.58,
        color: primary,
      ),
      bodySmall: bodyTheme.bodySmall?.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: secondary,
      ),
      labelLarge: bodyTheme.labelLarge?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: primary,
      ),
      labelMedium: bodyTheme.labelMedium?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: secondary,
      ),
      labelSmall: bodyTheme.labelSmall?.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.25,
        color: secondary,
      ),
    );
  }

  static TextStyle appTitle(Brightness brightness) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        height: 1.0,
        letterSpacing: 0,
        color: WellnessColors.textPrimaryFor(brightness),
      );

  static TextStyle sectionHeader(Brightness brightness) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.15,
        color: WellnessColors.textPrimaryFor(brightness),
      );

  static TextStyle display({Color? color}) => GoogleFonts.plusJakartaSans(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    height: 1.08,
    letterSpacing: 0,
    color: color,
  );

  static TextStyle statNumber({Color? color}) => GoogleFonts.plusJakartaSans(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 0.95,
    letterSpacing: 0,
    color: color,
  );

  static TextStyle heroNumber({Color? color}) => GoogleFonts.plusJakartaSans(
    fontSize: 56,
    fontWeight: FontWeight.w700,
    height: 0.92,
    letterSpacing: 0,
    color: color,
  );

  static TextStyle get title => GoogleFonts.plusJakartaSans(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.1,
  );

  static TextStyle titleFor(BuildContext context) => title.copyWith(
    color: WellnessColors.textPrimaryFor(Theme.of(context).brightness),
  );

  static TextStyle get section => GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  static TextStyle get label => GoogleFonts.plusJakartaSans(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  static TextStyle button(Brightness brightness) => GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: WellnessColors.textPrimaryFor(brightness),
  );

  static TextStyle get body => GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: _bodyHeight,
  );

  static TextStyle bodyFor(BuildContext context) => body.copyWith(
    color: WellnessColors.textPrimaryFor(Theme.of(context).brightness),
  );

  static TextStyle bodyForBrightness(Brightness brightness) =>
      body.copyWith(color: WellnessColors.textPrimaryFor(brightness));

  static TextStyle get captionStatic => GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: WellnessColors.textSecondary,
  );

  static TextStyle caption(BuildContext context) => captionStatic.copyWith(
    color: WellnessColors.textSecondaryFor(Theme.of(context).brightness),
  );
}
