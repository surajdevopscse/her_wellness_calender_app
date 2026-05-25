import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';

/// Calendar marker legend with icons.
class CalendarLegend extends StatelessWidget {
  const CalendarLegend({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.water_drop_outlined, 'Period', WellnessColors.period),
      (Icons.schedule_outlined, 'Predicted', WellnessColors.predicted),
      (Icons.wb_sunny_outlined, 'Ovulation', WellnessColors.ovulation),
      (Icons.eco_outlined, 'Fertile', WellnessColors.fertile),
      (Icons.spa_outlined, 'PMS', WellnessColors.pms),
      (Icons.circle, 'Log', WellnessColors.secondary),
    ];

    return Wrap(
      spacing: WellnessSpacing.md,
      runSpacing: WellnessSpacing.sm,
      children: items.map((item) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: item.$3.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(item.$1, size: 16, color: item.$3),
            ),
            const SizedBox(width: 6),
            Text(item.$2, style: WellnessTextStyles.caption(context)),
          ],
        );
      }).toList(),
    );
  }
}
