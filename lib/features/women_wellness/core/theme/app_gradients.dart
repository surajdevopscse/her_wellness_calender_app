import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';

/// Shared gradients for hero areas, highlights, and premium surfaces.
class AppGradients {
  AppGradients._();

  static const heroSoft = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [WellnessColors.surface, Color(0xFFFFF1F8), Color(0xFFF3E8FB)],
  );

  static const accentGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [WellnessColors.primaryDeep, Color(0xFFB76FA6)],
  );
}
