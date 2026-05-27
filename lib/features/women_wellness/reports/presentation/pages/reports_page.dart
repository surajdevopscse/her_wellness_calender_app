import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_insight_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_empty_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_error_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_loading_view.dart';
import 'package:her_wellness_calender/features/women_wellness/core/routes/wellness_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/presentation/controllers/reports_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/presentation/widgets/report_summary_card.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/presentation/widgets/wellness_chart_card.dart';

/// Reports and analytics screen with charts and summaries.
class ReportsPage extends GetView<ReportsController> {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const WellnessLoadingView();
      }
      if (controller.errorMessage.value.isNotEmpty) {
        return WellnessErrorState(
          message: controller.errorMessage.value,
          onRetry: controller.load,
        );
      }
      final report = controller.report.value;
      if (report == null) {
        return const WellnessEmptyState(
          message: WellnessConstants.reportsEmpty,
        );
      }
      return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          WellnessResponsive.pagePadding(context).left,
          WellnessResponsive.pagePadding(context).top,
          WellnessResponsive.pagePadding(context).right,
          WellnessResponsive.bottomContentInset(context),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: WellnessResponsive.contentMaxWidth(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WellnessCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your patterns, beautifully translated',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: WellnessSpacing.sm),
                      Text(
                        WellnessConstants.disclaimer,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
                ReportSummaryCard(report: report),
                const SizedBox(height: WellnessSpacing.lg),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final cards = [
                      WellnessInsightCard(
                        title: 'Regularity',
                        message:
                            'Your cycle average is ${report.averageCycleLength.toStringAsFixed(1)} days with ${report.cycleRegularity.toLowerCase()} timing across recent entries.',
                        icon: Icons.track_changes_rounded,
                        tint: WellnessColors.secondary,
                      ),
                      WellnessInsightCard(
                        title: 'Most common pattern',
                        message: report.commonSymptoms.isEmpty
                            ? 'Keep logging a few more days to reveal your most consistent symptom patterns.'
                            : 'The symptoms showing up most often are ${report.commonSymptoms.take(3).join(', ').toLowerCase()}.',
                        icon: Icons.favorite_outline_rounded,
                        tint: WellnessColors.primaryHot,
                      ),
                    ];
                    if (!WellnessResponsive.useComfortableColumns(
                      context,
                      constraints.maxWidth,
                    )) {
                      return Column(
                        children: [
                          cards[0],
                          const SizedBox(height: WellnessSpacing.md),
                          cards[1],
                        ],
                      );
                    }
                    return Row(
                      children: [
                        Expanded(child: cards[0]),
                        const SizedBox(width: WellnessSpacing.md),
                        Expanded(child: cards[1]),
                      ],
                    );
                  },
                ),
                const SizedBox(height: WellnessSpacing.lg),
                WellnessCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cycle Length Trend',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 180,
                        child: LineChart(
                          LineChartData(
                            gridData: const FlGridData(show: false),
                            titlesData: const FlTitlesData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                color: WellnessColors.primaryDeep,
                                spots: [
                                  for (
                                    var i = 0;
                                    i < report.cycleLengthTrend.length;
                                    i++
                                  )
                                    FlSpot(
                                      i.toDouble(),
                                      report.cycleLengthTrend[i].toDouble(),
                                    ),
                                ],
                                isCurved: true,
                                barWidth: 3,
                                dotData: const FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: WellnessColors.secondary.withValues(
                                    alpha: 0.18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
                WellnessChartCard(
                  title: 'Symptoms Frequency',
                  values: report.symptomFrequency,
                ),
                const SizedBox(height: WellnessSpacing.lg),
                WellnessChartCard(
                  title: 'Pain Trend',
                  values: report.painTrend,
                ),
                const SizedBox(height: WellnessSpacing.lg),
                WellnessChartCard(
                  title: 'Flow Trend',
                  values: report.flowTrend,
                ),
                const SizedBox(height: WellnessSpacing.lg),
                WellnessChartCard(
                  title: 'Mood Distribution',
                  values: report.moodDistribution,
                ),
                const SizedBox(height: WellnessSpacing.lg),
                OutlinedButton.icon(
                  onPressed: () => Get.toNamed(WellnessRoutes.insights),
                  icon: const Icon(Icons.insights_outlined),
                  label: const Text('Explore deeper insights'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
