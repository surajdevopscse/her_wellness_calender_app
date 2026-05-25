import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/calendar/domain/entities/calendar_day_detail.dart';
import 'package:her_wellness_calender/features/women_wellness/calendar/domain/usecases/get_calendar_data_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/calendar/presentation/widgets/calendar_day_detail_sheet.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/entities/daily_log.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/presentation/controllers/daily_log_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/dashboard/presentation/controllers/wellness_dashboard_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/presentation/controllers/period_entry_controller.dart';

/// Calendar state, day selection, and detail sheet actions.
class WellnessCalendarController extends GetxController {
  WellnessCalendarController(this.getCalendarDataUseCase);

  final GetCalendarDataUseCase getCalendarDataUseCase;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final selectedDate = DateTime.now().obs;
  final calendarData = Rxn<CalendarData>();

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      calendarData.value = await getCalendarDataUseCase();
    } catch (_) {
      errorMessage.value = WellnessConstants.error;
    } finally {
      isLoading.value = false;
    }
  }

  void selectDate(DateTime date) {
    selectedDate.value = WellnessDateHelper.dateOnly(date);
  }

  CalendarDayDetail? dayDetailFor(DateTime date) {
    final data = calendarData.value;
    if (data == null) return null;
    return CalendarDayDetail.fromData(
      date: WellnessDateHelper.dateOnly(date),
      periods: data.periods,
      logs: data.logs,
      prediction: data.prediction,
    );
  }

  void openDayDetail(BuildContext context, DateTime date) {
    final detail = dayDetailFor(date);
    if (detail == null) return;
    selectDate(date);
    CalendarDayDetailSheet.show(
      context,
      detail: detail,
      onAddLog: _openDailyLog,
      onEditLog: _openDailyLog,
      onAddPeriod: _openPeriodTracking,
    );
  }

  void _openDailyLog(DateTime date) {
    if (Get.isRegistered<WellnessDashboardController>()) {
      Get.find<WellnessDashboardController>().selectTab(3);
    }
    if (Get.isRegistered<DailyLogController>()) {
      final controller = Get.find<DailyLogController>();
      final data = calendarData.value;
      DailyLog? existing;
      if (data != null) {
        for (final log in data.logs) {
          if (WellnessDateHelper.isSameDay(log.logDate, date)) {
            existing = log;
            break;
          }
        }
      }
      controller.bindLog(existing);
      controller.updateLogDate(date);
    }
  }

  void _openPeriodTracking(DateTime date) {
    if (Get.isRegistered<WellnessDashboardController>()) {
      Get.find<WellnessDashboardController>().selectTab(2);
    }
    if (Get.isRegistered<PeriodEntryController>()) {
      Get.find<PeriodEntryController>().prefillStartDate(date);
    }
  }
}
