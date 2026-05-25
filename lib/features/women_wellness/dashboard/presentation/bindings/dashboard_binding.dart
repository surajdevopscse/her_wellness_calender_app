import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/calendar/presentation/bindings/calendar_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/core/bindings/binding_utils.dart';
import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/usecases/calculate_cycle_prediction_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/cycle_history/presentation/bindings/cycle_history_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/repositories/daily_log_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/presentation/bindings/daily_log_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/domain/usecases/get_wellness_dashboard_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/controllers/wellness_dashboard_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/insights/presentation/bindings/insights_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/pdf_report/presentation/bindings/pdf_report_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/presentation/bindings/period_tracking_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/presentation/bindings/privacy_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/repositories/wellness_profile_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/presentation/bindings/reminders_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/repositories/reports_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/presentation/bindings/reports_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/presentation/bindings/settings_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/presentation/bindings/symptoms_binding.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    CalendarBinding().dependencies();
    PeriodTrackingBinding().dependencies();
    DailyLogBinding().dependencies();
    SymptomsBinding().dependencies();
    ReportsBinding().dependencies();
    InsightsBinding().dependencies();
    CycleHistoryBinding().dependencies();
    RemindersBinding().dependencies();
    PrivacyBinding().dependencies();
    SettingsBinding().dependencies();
    PdfReportBinding().dependencies();

    ensureLazyPut(
      () => CalculateCyclePredictionUseCase(
        Get.find<WellnessProfileRepository>(),
        Get.find<PeriodTrackingRepository>(),
      ),
    );
    ensureLazyPut(
      () => GetWellnessDashboardUseCase(
        Get.find<WellnessProfileRepository>(),
        Get.find<PeriodTrackingRepository>(),
        Get.find<DailyLogRepository>(),
        Get.find<ReportsRepository>(),
        Get.find<CalculateCyclePredictionUseCase>(),
      ),
    );
    ensureLazyPut(
      () => WellnessDashboardController(Get.find<GetWellnessDashboardUseCase>()),
    );
  }
}
