import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_wellness_calender/features/auth/splash/presentation/bindings/splash_binding.dart';
import 'package:her_wellness_calender/features/auth/splash/presentation/pages/splash_page.dart';

import 'package:her_wellness_calender/features/women_wellness/authentication/authentication_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/bindings/authentication_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/pages/forgot_password_page.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/pages/login_page.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/pages/register_page.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/pages/reset_password_page.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/pages/verify_otp_page.dart';
import 'package:her_wellness_calender/features/women_wellness/backup_restore/presentation/pages/backup_restore_page.dart';
import 'package:her_wellness_calender/features/women_wellness/calendar/presentation/bindings/calendar_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/calendar/presentation/pages/wellness_calendar_page.dart';
import 'package:her_wellness_calender/features/women_wellness/core/routes/wellness_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/core/services/theme_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_theme.dart';
import 'package:her_wellness_calender/features/women_wellness/cycle_history/presentation/bindings/cycle_history_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/cycle_history/presentation/pages/cycle_history_page.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/bindings/dashboard_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/presentation/bindings/daily_log_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/presentation/pages/daily_log_page.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/pages/wellness_dashboard_page.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/presentation/bindings/data_export_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/presentation/pages/data_export_page.dart';
import 'package:her_wellness_calender/features/women_wellness/insights/presentation/bindings/insights_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/insights/presentation/pages/insights_page.dart';
import 'package:her_wellness_calender/features/women_wellness/notifications/presentation/bindings/notifications_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/notifications/presentation/pages/notifications_page.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/presentation/bindings/onboarding_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/presentation/pages/onboarding_page.dart';
import 'package:her_wellness_calender/features/women_wellness/pdf_report/presentation/bindings/pdf_report_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/pdf_report/presentation/pages/pdf_report_preview_page.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/presentation/bindings/period_tracking_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/presentation/pages/add_edit_period_page.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/presentation/bindings/privacy_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/presentation/pages/privacy_settings_page.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/presentation/bindings/profile_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/presentation/pages/wellness_profile_page.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/presentation/bindings/reminders_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/presentation/pages/reminder_settings_page.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/presentation/bindings/reports_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/presentation/pages/reports_page.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/presentation/bindings/settings_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/presentation/pages/settings_page.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/presentation/bindings/symptoms_binding.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/presentation/pages/symptoms_selection_page.dart';

/// Root application with feature-wise GetX routing.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(
      () => GetMaterialApp(
        title: 'Her Wellness Calendar',
        theme: WellnessTheme.light,
        darkTheme: WellnessTheme.dark,
        themeMode: themeController.materialThemeMode,
        debugShowCheckedModeBanner: false,
        initialRoute: AuthenticationRoutes.splash,
        getPages: [
          GetPage(
            name: AuthenticationRoutes.splash,
            page: () => const SplashPage(),
            binding: SplashBinding(),
          ),
          GetPage(
            name: AuthenticationRoutes.onboarding,
            page: () => const OnboardingPage(),
            binding: OnboardingBinding(),
          ),
          GetPage(
            name: AuthenticationRoutes.login,
            page: () => const LoginPage(),
            binding: AuthenticationBinding(),
          ),
          GetPage(
            name: AuthenticationRoutes.register,
            page: () => const RegisterPage(),
            binding: AuthenticationBinding(),
          ),
          GetPage(
            name: AuthenticationRoutes.forgotPassword,
            page: () => const ForgotPasswordPage(),
            binding: AuthenticationBinding(),
          ),
          GetPage(
            name: AuthenticationRoutes.resetPassword,
            page: () => const ResetPasswordPage(),
            binding: AuthenticationBinding(),
          ),
          GetPage(
            name: AuthenticationRoutes.verifyOtp,
            page: () => const VerifyOtpPage(),
            binding: AuthenticationBinding(),
          ),
          GetPage(
            name: WellnessRoutes.dashboard,
            page: () => const WellnessDashboardPage(),
            binding: DashboardBinding(),
          ),
          GetPage(
            name: WellnessRoutes.profile,
            page: () => const WellnessProfilePage(),
            binding: ProfileBinding(),
          ),
          GetPage(
            name: WellnessRoutes.calendar,
            page: () => const WellnessCalendarPage(),
            binding: CalendarBinding(),
          ),
          GetPage(
            name: WellnessRoutes.addEditPeriod,
            page: () => const AddEditPeriodPage(),
            binding: PeriodTrackingBinding(),
          ),
          GetPage(
            name: WellnessRoutes.dailyLog,
            page: () => const DailyLogPage(),
            binding: DailyLogBinding(),
          ),
          GetPage(
            name: WellnessRoutes.symptoms,
            page: () => const SymptomsSelectionPage(),
            binding: SymptomsBinding(),
          ),
          GetPage(
            name: WellnessRoutes.reports,
            page: () => const ReportsPage(),
            binding: ReportsBinding(),
          ),
          GetPage(
            name: WellnessRoutes.insights,
            page: () => const InsightsPage(),
            binding: InsightsBinding(),
          ),
          GetPage(
            name: WellnessRoutes.cycleHistory,
            page: () => const CycleHistoryPage(),
            binding: CycleHistoryBinding(),
          ),
          GetPage(
            name: WellnessRoutes.reminders,
            page: () => const ReminderSettingsPage(),
            binding: RemindersBinding(),
          ),
          GetPage(
            name: WellnessRoutes.privacy,
            page: () => const PrivacySettingsPage(),
            binding: PrivacyBinding(),
          ),
          GetPage(
            name: WellnessRoutes.settings,
            page: () => const SettingsPage(),
            binding: SettingsBinding(),
          ),
          GetPage(
            name: WellnessRoutes.notifications,
            page: () => const NotificationsPage(),
            binding: NotificationsBinding(),
          ),
          GetPage(
            name: WellnessRoutes.dataExport,
            page: () => const DataExportPage(),
            binding: DataExportBinding(),
          ),
          GetPage(
            name: WellnessRoutes.backupRestore,
            page: () => const BackupRestorePage(),
          ),
          GetPage(
            name: WellnessRoutes.pdfPreview,
            page: () => const PdfReportPreviewPage(),
            binding: PdfReportBinding(),
          ),
        ],
      ),
    );
  }
}
