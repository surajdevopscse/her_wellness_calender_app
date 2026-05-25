import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_animations.dart';

/// Emoji-style mood selector with 48px touch targets.
class MoodSelector extends StatelessWidget {
  const MoodSelector({super.key, required this.value, required this.onChanged});

  final MoodType value;
  final ValueChanged<MoodType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: WellnessSpacing.sm,
      runSpacing: WellnessSpacing.sm,
      children: MoodType.values.map((item) {
        final selected = item == value;
        return ScaleTap(
          onTap: () => onChanged(item),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            constraints: const BoxConstraints(
              minWidth: WellnessSpacing.minTouchTarget,
              minHeight: WellnessSpacing.minTouchTarget,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: selected
                  ? WellnessColors.primaryHot.withValues(alpha: 0.45)
                  : WellnessColors.blush.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(WellnessSpacing.pillRadius),
              border: Border.all(
                color: selected ? WellnessColors.primary : WellnessColors.border,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  size: 24,
                  color: selected ? WellnessColors.primaryDeep : WellnessColors.textSecondary,
                ),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  style: WellnessTextStyles.label.copyWith(
                    fontSize: 11,
                    color: selected ? WellnessColors.primaryDeep : WellnessColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
