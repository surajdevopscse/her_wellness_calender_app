import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_empty_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_error_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_loading_view.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/presentation/controllers/reports_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/presentation/widgets/wellness_chart_card.dart';

/// Insights hub with charts and trend cards (extends reports data).
class InsightsPage extends GetView<ReportsController> {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const WellnessLoadingView();
      if (controller.errorMessage.value.isNotEmpty) {
        return WellnessErrorState(
          message: controller.errorMessage.value,
          onRetry: controller.load,
        );
      }
      final report = controller.report.value;
      if (report == null) {
        return const WellnessEmptyState(message: WellnessConstants.reportsEmpty);
      }
      return SingleChildScrollView(
        padding: const EdgeInsets.all(WellnessSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WellnessCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cycle story',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: WellnessSpacing.sm),
                  Text(
                    'Average cycle: ${report.averageCycleLength.toStringAsFixed(1)} days',
                  ),
                  Text('Regularity: ${report.cycleRegularity}'),
                  if (report.commonSymptoms.isNotEmpty)
                    Text(
                      'Most frequent symptoms: ${report.commonSymptoms.take(3).join(', ')}',
                    ),
                ],
              ),
            ),
            const SizedBox(height: WellnessSpacing.lg),
            WellnessCard(
              child: SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: report.averageCycleLength,
                        title: 'Cycle',
                        color: WellnessColors.primaryDeep,
                        radius: 60,
                      ),
                      PieChartSectionData(
                        value: report.averagePeriodLength,
                        title: 'Period',
                        color: WellnessColors.secondary,
                        radius: 54,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: WellnessSpacing.lg),
            WellnessChartCard(title: 'Mood trend', values: report.moodDistribution),
            const SizedBox(height: WellnessSpacing.lg),
            WellnessChartCard(title: 'Pain trend', values: report.painTrend),
            const SizedBox(height: WellnessSpacing.lg),
            WellnessChartCard(title: 'Symptom heatmap', values: report.symptomFrequency),
          ],
        ),
      );
    });
  }
}
