import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/entities/symptom_item.dart';

/// Selectable premium symptom chip owned by the symptoms feature.
class SymptomChip extends StatelessWidget {
  const SymptomChip({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onSelected,
    this.color,
  });

  factory SymptomChip.fromItem({
    Key? key,
    required SymptomItem item,
    required bool selected,
    required ValueChanged<bool> onSelected,
  }) {
    final type = item.type;
    return SymptomChip(
      key: key,
      label: item.label,
      icon: type?.icon ?? Icons.add_circle_outline,
      color: type?.color,
      selected: selected,
      onSelected: onSelected,
    );
  }

  factory SymptomChip.fromSymptomType({
    Key? key,
    required SymptomType symptom,
    required bool selected,
    required ValueChanged<bool> onSelected,
  }) {
    return SymptomChip(
      key: key,
      label: symptom.label,
      icon: symptom.icon,
      color: symptom.color,
      selected: selected,
      onSelected: onSelected,
    );
  }

  final String label;
  final IconData icon;
  final Color? color;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    final accent = color ?? WellnessColors.primaryDeep;
    return FilterChip(
      avatar: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected
              ? WellnessColors.textOnPrimary.withValues(alpha: 0.16)
              : accent.withValues(alpha: 0.14),
        ),
        child: Icon(
          icon,
          size: 14,
          color: selected ? WellnessColors.textOnPrimary : accent,
        ),
      ),
      label: Text(label, style: WellnessTextStyles.label),
      padding: const EdgeInsets.symmetric(
        horizontal: WellnessSpacing.sm,
        vertical: WellnessSpacing.xs,
      ),
      selected: selected,
      selectedColor: accent.withValues(alpha: 0.82),
      backgroundColor: WellnessColors.blush.withValues(alpha: 0.55),
      checkmarkColor: WellnessColors.textOnPrimary,
      side: BorderSide(
        color: selected
            ? accent
            : WellnessColors.border.withValues(alpha: 0.65),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      onSelected: onSelected,
      labelStyle: TextStyle(
        color: selected
            ? WellnessColors.textOnPrimary
            : WellnessColors.textPrimary,
      ),
    );
  }
}
