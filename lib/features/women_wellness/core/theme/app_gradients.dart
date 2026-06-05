import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';

/// Shared gradients for hero areas, highlights, and premium surfaces.
class AppGradients {
  AppGradients._();

  static const heroSoft = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6F98), Color(0xFFFF9FBC), Color(0xFFFFE2EC)],
  );

  static const accentGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [WellnessColors.primaryHot, WellnessColors.accent],
  );

  static const aquaGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [WellnessColors.secondary, Color(0xFFF0FFFE)],
  );

  static const peachGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [WellnessColors.peach, Color(0xFFFFF5EF)],
  );
}
