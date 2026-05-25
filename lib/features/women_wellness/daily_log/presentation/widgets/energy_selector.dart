import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

/// Energy level selector.
class EnergySelector extends StatelessWidget {
  const EnergySelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final EnergyLevel value;
  final ValueChanged<EnergyLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: WellnessSpacing.sm,
      runSpacing: WellnessSpacing.sm,
      children: EnergyLevel.values.map((item) {
        final selected = item == value;
        return ChoiceChip(
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(item.label),
          ),
          selected: selected,
          onSelected: (_) => onChanged(item),
          selectedColor: WellnessColors.secondary.withValues(alpha: 0.5),
          backgroundColor: WellnessColors.lavender.withValues(alpha: 0.42),
          side: BorderSide(
            color: selected
                ? WellnessColors.secondary
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
