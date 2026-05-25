import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';

/// Non-interactive card explaining what data is stored.
class PrivacyDataInfoCard extends StatelessWidget {
  const PrivacyDataInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return WellnessCard(
      color: WellnessColors.secondary.withValues(
        alpha: brightness == Brightness.dark ? 0.12 : 0.18,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: brightness == Brightness.dark
                ? WellnessColors.darkAccent
                : WellnessColors.accent,
          ),
          const SizedBox(width: WellnessSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  WellnessConstants.privacyDataStoredTitle,
                  style: WellnessTextStyles.section.copyWith(
                    color: WellnessColors.textPrimaryFor(brightness),
                  ),
                ),
                const SizedBox(height: WellnessSpacing.sm),
                Text(
                  WellnessConstants.privacyDataStoredBody,
                  style: WellnessTextStyles.bodyForBrightness(brightness),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
