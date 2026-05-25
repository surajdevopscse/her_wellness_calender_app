import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_animations.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';

/// Today's wellness tip with soft gradient and fade-in.
class WellnessTipCard extends StatelessWidget {
  const WellnessTipCard({super.key, required this.tip});

  final String tip;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return FadeInContainer(
      delay: const Duration(milliseconds: 120),
      child: WellnessCard(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [WellnessColors.peach, WellnessColors.blush, WellnessColors.lavender],
        ),
        padding: const EdgeInsets.all(WellnessSpacing.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(WellnessSpacing.controlRadius),
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
                    style: WellnessTextStyles.sectionHeader(brightness),
                  ),
                  const SizedBox(height: WellnessSpacing.sm),
                  Text(
                    tip,
                    style: WellnessTextStyles.bodyForBrightness(brightness),
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
