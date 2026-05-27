import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/entities/cycle_prediction.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_animations.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_glass_card.dart';

/// Glass stat card: cycle day and next period countdown.
class CycleStatusCard extends StatelessWidget {
  const CycleStatusCard({super.key, required this.prediction});

  final CyclePrediction prediction;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final daysUntil = prediction.daysUntilNextPeriod;

    return FadeInContainer(
      child: WellnessGlassCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cyclone_outlined,
                  size: WellnessSpacing.iconSize,
                  color: WellnessColors.primaryDeep,
                ),
                const SizedBox(width: WellnessSpacing.sm),
                Text(
                  'Cycle day',
                  style: WellnessTextStyles.section.copyWith(
                    color: WellnessColors.textSecondaryFor(brightness),
                  ),
                ),
              ],
            ),
            const SizedBox(height: WellnessSpacing.md),
            Text(
              '${prediction.currentCycleDay}',
              style: WellnessTextStyles.statNumber(
                color: WellnessColors.textPrimaryFor(brightness),
              ),
            ),
            const SizedBox(height: WellnessSpacing.sm),
            Row(
              children: [
                const Icon(
                  Icons.event_outlined,
                  size: 18,
                  color: WellnessColors.primaryDeep,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    daysUntil >= 0
                        ? 'Next period in $daysUntil days'
                        : 'Period later than expected',
                    style: WellnessTextStyles.bodyForBrightness(brightness),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              WellnessDateHelper.shortDate.format(prediction.nextPeriodDate),
              style: WellnessTextStyles.caption(context),
            ),
          ],
        ),
      ),
    );
  }
}
