import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/entities/cycle_prediction.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_animations.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_glass_card.dart';

/// Fertility window and phase estimates with visual phase bar.
class PredictionCard extends StatelessWidget {
  const PredictionCard({super.key, required this.prediction});

  final CyclePrediction prediction;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final cycleDay = prediction.currentCycleDay;
    final phaseProgress = (cycleDay / 28).clamp(0.0, 1.0);

    return FadeInContainer(
      delay: const Duration(milliseconds: 80),
      child: WellnessGlassCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fertility & phases',
              style: WellnessTextStyles.sectionHeader(brightness),
            ),
            const SizedBox(height: WellnessSpacing.md),
            ClipRRect(
              borderRadius: BorderRadius.circular(WellnessSpacing.pillRadius),
              child: SizedBox(
                height: 10,
                child: Row(
                  children: [
                    Expanded(
                      flex: (phaseProgress * 100).round().clamp(1, 100),
                      child: Container(color: WellnessColors.period),
                    ),
                    Expanded(
                      flex: 100 - (phaseProgress * 100).round().clamp(0, 99),
                      child: Container(
                        color: WellnessColors.fertile.withValues(alpha: 0.65),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: WellnessSpacing.md),
            _PhaseRow(
              icon: Icons.wb_sunny_outlined,
              color: WellnessColors.ovulation,
              label: 'Ovulation',
              value: WellnessDateHelper.shortDate.format(prediction.ovulationDate),
            ),
            const SizedBox(height: WellnessSpacing.sm),
            _PhaseRow(
              icon: Icons.eco_outlined,
              color: WellnessColors.fertileDeep,
              label: 'Fertile window',
              value:
                  '${WellnessDateHelper.shortDate.format(prediction.fertileWindowStart)} – ${WellnessDateHelper.shortDate.format(prediction.fertileWindowEnd)}',
            ),
            const SizedBox(height: WellnessSpacing.sm),
            _PhaseRow(
              icon: Icons.spa_outlined,
              color: WellnessColors.pms,
              label: 'PMS',
              value:
                  '${WellnessDateHelper.shortDate.format(prediction.pmsStartDate)} – ${WellnessDateHelper.shortDate.format(prediction.pmsEndDate)}',
            ),
            if (prediction.warningMessage != null) ...[
              const SizedBox(height: WellnessSpacing.md),
              Text(
                prediction.warningMessage!,
                style: WellnessTextStyles.body.copyWith(color: WellnessColors.error),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PhaseRow extends StatelessWidget {
  const _PhaseRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: WellnessSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: WellnessTextStyles.label),
              Text(
                value,
                style: WellnessTextStyles.bodyFor(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
