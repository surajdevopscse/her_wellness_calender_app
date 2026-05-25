import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';

/// Water intake stepper for daily logs.
class WaterIntakeStepper extends StatelessWidget {
  const WaterIntakeStepper({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: WellnessSpacing.md,
        vertical: WellnessSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: WellnessColors.lavender.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: WellnessColors.border.withValues(alpha: 0.55),
        ),
      ),
      child: Row(
        children: [
          _RoundIconButton(
            icon: Icons.remove_rounded,
            onTap: value <= 0 ? null : () => onChanged(value - 1),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '$value',
                  style: WellnessTextStyles.statNumber(
                    color: WellnessColors.primaryDeep,
                  ).copyWith(fontSize: 30),
                ),
                Text(
                  WellnessConstants.glasses,
                  style: WellnessTextStyles.caption(context),
                ),
              ],
            ),
          ),
          _RoundIconButton(
            icon: Icons.add_rounded,
            onTap: value >= 30 ? null : () => onChanged(value + 1),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: onTap,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: WellnessColors.primaryHot.withValues(alpha: 0.42),
        foregroundColor: WellnessColors.primaryDeep,
        disabledBackgroundColor: WellnessColors.blush.withValues(alpha: 0.28),
      ),
    );
  }
}
