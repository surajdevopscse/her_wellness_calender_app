import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';

/// Reusable chart card owned by the reports feature.
class WellnessChartCard extends StatelessWidget {
  const WellnessChartCard({
    super.key,
    required this.title,
    required this.values,
  });

  final String title;
  final Map<String, int> values;

  @override
  Widget build(BuildContext context) {
    final entries = values.entries.toList();
    final brightness = Theme.of(context).brightness;
    return WellnessCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: WellnessSpacing.xs),
          Text(
            'A simple view of how often each pattern appeared in your recent data.',
            style: WellnessTextStyles.body.copyWith(
              color: WellnessColors.textSecondaryFor(brightness),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: WellnessSpacing.md),
          if (entries.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(WellnessSpacing.lg),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.32),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Add a few more logs to make this chart more meaningful.',
                style: WellnessTextStyles.body.copyWith(
                  color: WellnessColors.textSecondaryFor(brightness),
                ),
              ),
            )
          else
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1,
                    getDrawingHorizontalLine: (_) => FlLine(
                      color: WellnessColors.border.withValues(alpha: 0.22),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: const FlTitlesData(show: false),
                  barGroups: [
                    for (var i = 0; i < entries.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: entries[i].value.toDouble(),
                            width: 18,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(14),
                            ),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                WellnessColors.primaryDeep,
                                WellnessColors.secondary,
                                WellnessColors.accent,
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          if (entries.isNotEmpty) ...[
            const SizedBox(height: WellnessSpacing.md),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: entries
                  .map(
                    (entry) => Chip(label: Text('${entry.key}: ${entry.value}')),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
