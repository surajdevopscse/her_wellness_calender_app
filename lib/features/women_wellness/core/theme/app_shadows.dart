import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';

/// Shared shadow presets for cards, dialogs, and hover states.
class AppShadows {
  AppShadows._();

  static List<BoxShadow> soft(Brightness brightness) => [
    BoxShadow(
      color: brightness == Brightness.dark
          ? Colors.black.withValues(alpha: 0.18)
          : WellnessColors.textPrimary.withValues(alpha: 0.06),
      blurRadius: 14,
      offset: const Offset(0, 6),
    ),
  ];

  static List<BoxShadow> hover(Brightness brightness) => [
    BoxShadow(
      color: brightness == Brightness.dark
          ? Colors.black.withValues(alpha: 0.24)
          : WellnessColors.textPrimary.withValues(alpha: 0.10),
      blurRadius: 22,
      offset: const Offset(0, 10),
    ),
  ];
}
