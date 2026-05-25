import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';

/// Compact, theme-aware medical disclaimer (not a full-width gray bar).
class DashboardDisclaimerStrip extends StatelessWidget {
  const DashboardDisclaimerStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return WellnessCard(
      padding: const EdgeInsets.symmetric(
        horizontal: WellnessSpacing.lg,
        vertical: WellnessSpacing.md,
      ),
      color: isDark
          ? WellnessColors.darkSurface.withValues(alpha: 0.65)
          : WellnessColors.surface.withValues(alpha: 0.9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 20,
            color: isDark ? WellnessColors.darkAccent : WellnessColors.accent,
          ),
          const SizedBox(width: WellnessSpacing.md),
          Expanded(
            child: Text(
              WellnessConstants.disclaimer,
              style: WellnessTextStyles.caption(context),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
