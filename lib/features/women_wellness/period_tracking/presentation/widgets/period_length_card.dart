import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';

/// Displays the auto-calculated period length and long-period warning.
class PeriodLengthCard extends StatelessWidget {
  const PeriodLengthCard({
    super.key,
    required this.periodLength,
    required this.showWarning,
  });

  final int periodLength;
  final bool showWarning;

  @override
  Widget build(BuildContext context) {
    return WellnessCard(
      child: Row(
        children: [
          Icon(
            showWarning ? Icons.warning_amber_outlined : Icons.timeline,
            color: showWarning
                ? WellnessColors.warning
                : WellnessColors.primary,
          ),
          const SizedBox(width: WellnessSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  WellnessConstants.periodLength,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: WellnessSpacing.xs),
                Text(
                  periodLength <= 0
                      ? WellnessConstants.startDateRequired
                      : '$periodLength ${periodLength == 1 ? WellnessConstants.day : WellnessConstants.days}',
                ),
                if (showWarning) ...[
                  const SizedBox(height: WellnessSpacing.xs),
                  const Text(WellnessConstants.unusuallyLongPeriod),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
