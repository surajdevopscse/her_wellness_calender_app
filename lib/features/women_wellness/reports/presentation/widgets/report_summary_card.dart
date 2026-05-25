import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_animations.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_glass_card.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/entities/wellness_report.dart';

/// Report summary card for dashboard and report insights.
class ReportSummaryCard extends StatelessWidget {
  const ReportSummaryCard({super.key, required this.report});

  final WellnessReport report;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return FadeInContainer(
      delay: const Duration(milliseconds: 140),
      child: WellnessGlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cycle snapshot',
              style: WellnessTextStyles.sectionHeader(brightness),
            ),
            const SizedBox(height: WellnessSpacing.md),
            Row(
              children: [
                Expanded(
                  child: _MetricTile(
                    label: 'Avg cycle',
                    value: report.averageCycleLength.toStringAsFixed(1),
                    suffix: 'days',
                  ),
                ),
                const SizedBox(width: WellnessSpacing.md),
                Expanded(
                  child: _MetricTile(
                    label: 'Avg period',
                    value: report.averagePeriodLength.toStringAsFixed(1),
                    suffix: 'days',
                  ),
                ),
              ],
            ),
            const SizedBox(height: WellnessSpacing.md),
            WellnessGlassCard(
              padding: const EdgeInsets.all(WellnessSpacing.lg),
              tint: WellnessColors.primaryHot.withValues(alpha: 0.18),
              child: Row(
                children: [
                  const Icon(
                    Icons.insights_outlined,
                    color: WellnessColors.primaryDeep,
                  ),
                  const SizedBox(width: WellnessSpacing.md),
                  Expanded(
                    child: Text(
                      'Regularity: ${report.cycleRegularity}. Common symptoms include ${report.commonSymptoms.take(3).join(', ')}.',
                      style: WellnessTextStyles.bodyFor(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.suffix,
  });

  final String label;
  final String value;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      padding: const EdgeInsets.all(WellnessSpacing.lg),
      decoration: BoxDecoration(
        color: WellnessColors.blush.withValues(alpha: 0.36),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: WellnessColors.borderFor(brightness).withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: WellnessTextStyles.caption(context)),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: WellnessTextStyles.statNumber(
                    color: WellnessColors.textPrimaryFor(brightness),
                  ).copyWith(fontSize: 28),
                ),
                TextSpan(
                  text: ' $suffix',
                  style: WellnessTextStyles.caption(context).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
