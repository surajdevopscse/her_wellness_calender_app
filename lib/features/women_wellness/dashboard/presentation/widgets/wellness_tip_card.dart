import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_animations.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';

/// Today's wellness tip with readable neutral surfaces.
class WellnessTipCard extends StatelessWidget {
  const WellnessTipCard({super.key, required this.tip});

  final String tip;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final chipColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : WellnessColors.secondary.withValues(alpha: 0.38);
    final titleColor = isDark
        ? WellnessColors.darkTextPrimary
        : WellnessColors.textPrimary;
    final bodyColor = isDark
        ? WellnessColors.darkTextSecondary
        : WellnessColors.textSecondary;

    return FadeInContainer(
      delay: const Duration(milliseconds: 120),
      child: WellnessCard(
        padding: const EdgeInsets.all(WellnessSpacing.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: chipColor,
                borderRadius: BorderRadius.circular(
                  WellnessSpacing.controlRadius,
                ),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.white.withValues(alpha: 0.5),
                ),
              ),
              child: const Icon(
                Icons.spa_outlined,
                color: WellnessColors.primaryDeep,
                size: 26,
              ),
            ),
            const SizedBox(width: WellnessSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s tip',
                    style: WellnessTextStyles.sectionHeader(
                      brightness,
                    ).copyWith(color: titleColor),
                  ),
                  const SizedBox(height: WellnessSpacing.sm),
                  Text(
                    tip,
                    style: WellnessTextStyles.body.copyWith(color: bodyColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
