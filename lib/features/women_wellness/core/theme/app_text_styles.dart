import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';

/// Alias typography tokens for app-wide design system naming.
class AppTextStyles {
  AppTextStyles._();

  static TextTheme textTheme(Brightness brightness) =>
      WellnessTextStyles.textTheme(brightness);

  static TextStyle sectionHeader(Brightness brightness) =>
      WellnessTextStyles.sectionHeader(brightness);
}
