import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

/// Flow level segmented selector.
class FlowSelector extends StatelessWidget {
  const FlowSelector({super.key, required this.value, required this.onChanged});

  final FlowLevel value;
  final ValueChanged<FlowLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: WellnessSpacing.sm,
      runSpacing: WellnessSpacing.sm,
      children: FlowLevel.values.map((item) {
        final selected = item == value;
        return ChoiceChip(
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(item.label),
          ),
          selected: selected,
          onSelected: (_) => onChanged(item),
          selectedColor: WellnessColors.primaryHot.withValues(alpha: 0.62),
          backgroundColor: WellnessColors.blush.withValues(alpha: 0.55),
          side: BorderSide(
            color: selected
                ? WellnessColors.primaryDeep
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
