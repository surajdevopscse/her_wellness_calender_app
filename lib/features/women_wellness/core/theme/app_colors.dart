import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';

/// Alias design tokens to keep naming consistent with app-wide UI guidance.
class AppColors {
  AppColors._();

  static const primary = WellnessColors.primaryDeep;
  static const secondary = WellnessColors.secondary;
  static const background = WellnessColors.background;
  static const surface = WellnessColors.surface;
  static const success = WellnessColors.success;
  static const warning = WellnessColors.warning;
  static const error = WellnessColors.error;

  static Color textPrimary(Brightness brightness) =>
      WellnessColors.textPrimaryFor(brightness);

  static Color textSecondary(Brightness brightness) =>
      WellnessColors.textSecondaryFor(brightness);
}
