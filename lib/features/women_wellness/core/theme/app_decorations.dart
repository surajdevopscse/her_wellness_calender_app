import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/app_radius.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/app_shadows.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';

/// Shared decoration helpers for cards, highlights, and subtle panels.
class AppDecorations {
  AppDecorations._();

  static BoxDecoration softPanel(Brightness brightness) => BoxDecoration(
        color: brightness == Brightness.dark
            ? WellnessColors.darkSurface.withValues(alpha: 0.55)
            : WellnessColors.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: WellnessColors.borderFor(brightness).withValues(alpha: 0.55),
        ),
        boxShadow: AppShadows.soft(brightness),
      );

  static BoxDecoration subtleHighlight(Brightness brightness) => BoxDecoration(
        color: brightness == Brightness.dark
            ? Colors.white.withValues(alpha: 0.06)
            : WellnessColors.primaryHot.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(AppRadius.md),
      );
}
