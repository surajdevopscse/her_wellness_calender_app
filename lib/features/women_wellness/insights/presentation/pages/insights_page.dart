import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/app_gradients.dart';
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
      if (report == null || !report.hasData) {
        return const WellnessEmptyState(message: WellnessConstants.reportsEmpty);
      }
      return RefreshIndicator(
        onRefresh: controller.load,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            WellnessSpacing.xl,
            WellnessSpacing.xl,
            WellnessSpacing.xl,
            WellnessResponsive.bottomContentInset(context),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: WellnessSpacing.pageMaxWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WellnessCard(
                    gradient: Theme.of(context).brightness == Brightness.dark
                        ? null
                        : AppGradients.peachGlow,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: WellnessColors.period.withValues(
                                  alpha: 0.14,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.insights_rounded,
                                color: WellnessColors.primaryHot,
                              ),
                            ),
                            const SizedBox(width: WellnessSpacing.md),
                            Expanded(
                              child: Text(
                                'Insights for you',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: WellnessSpacing.lg),
                        Wrap(
                          spacing: WellnessSpacing.sm,
                          runSpacing: WellnessSpacing.sm,
                          children: [
                            _InsightBadge(
                              label:
                                  '${report.averageCycleLength.toStringAsFixed(1)} day cycle',
                            ),
                            _InsightBadge(label: report.cycleRegularity),
                            _InsightBadge(
                              label:
                                  '${report.averagePeriodLength.toStringAsFixed(1)} day period',
                            ),
                          ],
                        ),
                        if (report.commonSymptoms.isNotEmpty) ...[
                          const SizedBox(height: WellnessSpacing.lg),
                          Text(
                            'Common symptoms',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: WellnessSpacing.xs),
                          Text(
                            report.commonSymptoms.take(3).join(', '),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: WellnessSpacing.lg),
                  WellnessCard(
                    child: SizedBox(
                      height: 220,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: report.averageCycleLength,
                              title: 'Cycle',
                              color: WellnessColors.primaryHot,
                              radius: 64,
                            ),
                            PieChartSectionData(
                              value: report.averagePeriodLength,
                              title: 'Period',
                              color: WellnessColors.secondary,
                              radius: 56,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: WellnessSpacing.lg),
                  WellnessChartCard(
                    title: 'Mood trend',
                    values: report.moodDistribution,
                  ),
                  const SizedBox(height: WellnessSpacing.lg),
                  WellnessChartCard(title: 'Pain trend', values: report.painTrend),
                  const SizedBox(height: WellnessSpacing.lg),
                  WellnessChartCard(
                    title: 'Symptom heatmap',
                    values: report.symptomFrequency,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _InsightBadge extends StatelessWidget {
  const _InsightBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.68),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: WellnessColors.border.withValues(alpha: 0.7)),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelMedium),
    );
  }
}
