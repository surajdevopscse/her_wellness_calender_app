import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

/// Sleep quality selector.
class SleepQualitySelector extends StatelessWidget {
  const SleepQualitySelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final SleepQuality value;
  final ValueChanged<SleepQuality> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: WellnessSpacing.sm,
      runSpacing: WellnessSpacing.sm,
      children: SleepQuality.values.map((item) {
        final selected = item == value;
        return ChoiceChip(
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(item.label),
          ),
          selected: selected,
          onSelected: (_) => onChanged(item),
          selectedColor: WellnessColors.accent.withValues(alpha: 0.45),
          backgroundColor: WellnessColors.peach.withValues(alpha: 0.45),
          side: BorderSide(
            color: selected
                ? WellnessColors.accent
                : WellnessColors.border.withValues(alpha: 0.65),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        );
      }).toList(),
    );
  }
}
