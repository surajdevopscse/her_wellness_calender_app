import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_insight_card.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/domain/usecases/get_wellness_dashboard_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/controllers/wellness_dashboard_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/widgets/cycle_status_card.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/widgets/fertility_status_card.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/widgets/prediction_card.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/widgets/quick_log_card.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/widgets/dashboard_disclaimer_strip.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/widgets/dashboard_metrics_grid.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/widgets/wellness_tip_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_app_bar.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_background.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_desktop_rail.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_mobile_nav.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_empty_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_error_state.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/widgets/wellness_hero_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_loading_view.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/presentation/pages/add_edit_period_page.dart';
import 'package:her_wellness_calender/features/women_wellness/cycle_history/presentation/pages/cycle_history_page.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/presentation/pages/daily_log_page.dart';
import 'package:her_wellness_calender/features/women_wellness/pdf_report/presentation/pages/pdf_report_preview_page.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/presentation/pages/settings_page.dart';
import 'package:her_wellness_calender/features/women_wellness/insights/presentation/pages/insights_page.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/presentation/pages/privacy_settings_page.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/presentation/pages/reminder_settings_page.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/presentation/pages/reports_page.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/presentation/widgets/report_summary_card.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/presentation/pages/symptoms_selection_page.dart';
import 'package:her_wellness_calender/features/women_wellness/calendar/presentation/pages/wellness_calendar_page.dart';

/// Main women wellness dashboard and responsive navigation shell.
class WellnessDashboardPage extends GetView<WellnessDashboardController> {
  const WellnessDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      _DashboardHome(controller: controller),
      const WellnessCalendarPage(),
      const AddEditPeriodPage(),
      const DailyLogPage(),
      const SymptomsSelectionPage(),
      const ReportsPage(),
      const CycleHistoryPage(),
      const ReminderSettingsPage(),
      const PrivacySettingsPage(),
      const SettingsPage(),
      const InsightsPage(),
      const PdfReportPreviewPage(),
    ];
    return Obx(
      () => Scaffold(
        extendBody: true,
        appBar: const WellnessAppBar(title: WellnessConstants.appTitle),
        body: WellnessBackground(
          child: Row(
            children: [
              if (WellnessResponsive.isDesktop(context))
                Padding(
                  padding: const EdgeInsets.all(WellnessSpacing.lg),
                  child: WellnessDesktopRail(
                    selectedIndex: controller.selectedTabIndex.value,
                    onSelected: controller.selectTab,
                  ),
                ),
              Expanded(
                child: IndexedStack(
                  index: controller.selectedTabIndex.value,
                  children: pages,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: WellnessResponsive.isDesktop(context)
            ? null
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    WellnessSpacing.mobileNavHorizontalInset,
                    0,
                    WellnessSpacing.mobileNavHorizontalInset,
                    WellnessSpacing.mobileNavBottomInset,
                  ),
                  child: WellnessMobileNav(
                    selectedPageIndex: controller.selectedTabIndex.value,
                    onSelected: controller.selectTab,
                  ),
                ),
              ),
      ),
    );
  }
}

class _DashboardHome extends StatelessWidget {
  const _DashboardHome({required this.controller});

  final WellnessDashboardController controller;

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
      final data = controller.dashboard.value;
      if (data == null) {
        return const WellnessEmptyState(
          message: WellnessConstants.dashboardEmpty,
        );
      }
      return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          WellnessResponsive.isMobile(context)
              ? WellnessSpacing.lg + WellnessSpacing.xs
              : WellnessSpacing.xl,
          WellnessSpacing.lg,
          WellnessResponsive.isMobile(context)
              ? WellnessSpacing.lg + WellnessSpacing.xs
              : WellnessSpacing.xl,
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
                WellnessHeroCard(data: data, tip: controller.dailyTip),
                const SizedBox(height: WellnessSpacing.lg),
                _InsightStrip(data: data),
                const SizedBox(height: WellnessSpacing.lg),
                const DashboardDisclaimerStrip(),
                const SizedBox(height: WellnessSpacing.lg),
                DashboardMetricsGrid(
                  children: _dashboardCards(data, controller),
                ),
                const SizedBox(height: WellnessSpacing.lg),
                QuickLogCard(
                  onAddPeriod: () => controller.selectTab(2),
                  onAddLog: () => controller.selectTab(3),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  List<Widget> _dashboardCards(
    WellnessDashboardData data,
    WellnessDashboardController controller,
  ) {
    return [
      CycleStatusCard(prediction: data.prediction),
      FertilityStatusCard(prediction: data.prediction),
      PredictionCard(prediction: data.prediction),
      WellnessTipCard(tip: controller.dailyTip),
      ReportSummaryCard(report: data.report),
    ];
  }
}

class _InsightStrip extends StatelessWidget {
  const _InsightStrip({required this.data});

  final WellnessDashboardData data;

  @override
  Widget build(BuildContext context) {
    final latestLog = data.logs.isEmpty ? null : data.logs.first;
    final hydrationMessage = latestLog == null
        ? 'Add a quick daily check-in to unlock more personal hydration and recovery nudges.'
        : latestLog.waterIntakeGlass >= 7
        ? 'You logged ${latestLog.waterIntakeGlass} glasses of water on your latest check-in. Hydration is supporting a steadier recovery rhythm.'
        : 'Your latest check-in logged ${latestLog.waterIntakeGlass} glasses of water. A small hydration push may help energy and cramp recovery.';
    final symptomSummary = data.report.commonSymptoms.isEmpty
        ? 'You are still building a symptom pattern. A few more logs will make insights more specific.'
        : 'Recent patterns point to ${data.report.commonSymptoms.take(2).join(' and ').toLowerCase()} showing up most often around this cycle.';
    final outlookMessage = data.prediction.daysUntilNextPeriod >= 0
        ? 'Your next period is estimated in ${data.prediction.daysUntilNextPeriod} days, with ovulation around ${WellnessDateHelper.shortDate.format(data.prediction.ovulationDate)}.'
        : 'Your next period looks later than expected. If this feels unusual for you, keep logging and consider checking in with a clinician.';

    final cards = [
      WellnessInsightCard(
        title: 'Energy',
        message: hydrationMessage,
        icon: Icons.bolt_rounded,
        tint: WellnessColors.secondary,
      ),
      WellnessInsightCard(
        title: 'Pattern',
        message: symptomSummary,
        icon: Icons.favorite_outline_rounded,
        tint: WellnessColors.accent,
      ),
      WellnessInsightCard(
        title: 'Looking ahead',
        message: outlookMessage,
        icon: Icons.auto_graph_rounded,
        tint: WellnessColors.primaryHot,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (!WellnessResponsive.useComfortableColumns(
          context,
          constraints.maxWidth,
        )) {
          return Column(
            children: [
              for (var i = 0; i < cards.length; i++) ...[
                if (i > 0) const SizedBox(height: WellnessSpacing.md),
                cards[i],
              ],
            ],
          );
        }
        return Row(
          children: [
            for (var i = 0; i < cards.length; i++) ...[
              Expanded(child: cards[i]),
              if (i < cards.length - 1)
                const SizedBox(width: WellnessSpacing.md),
            ],
          ],
        );
      },
    );
  }
}
