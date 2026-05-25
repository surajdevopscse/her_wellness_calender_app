import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

/// Pain level selector.
class PainLevelSelector extends StatelessWidget {
  const PainLevelSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final PainLevel value;
  final ValueChanged<PainLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: WellnessSpacing.sm,
      runSpacing: WellnessSpacing.sm,
      children: PainLevel.values.map((item) {
        final selected = item == value;
        return ChoiceChip(
          avatar: Icon(
            item.icon,
            size: 16,
            color: selected ? WellnessColors.textOnPrimary : item.color,
          ),
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(item.label),
          ),
          selected: selected,
          onSelected: (_) => onChanged(item),
          selectedColor: item.color.withValues(alpha: 0.85),
          backgroundColor: item.color.withValues(alpha: 0.12),
          labelStyle: TextStyle(
            color: selected
                ? WellnessColors.textOnPrimary
                : WellnessColors.textPrimary,
          ),
          side: BorderSide(
            color: selected
                ? item.color
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
