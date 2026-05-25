import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/calendar/domain/usecases/get_calendar_data_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/calendar/presentation/controllers/wellness_calendar_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/core/bindings/binding_utils.dart';
import 'package:her_wellness_calender/features/women_wellness/cycle_history/domain/usecases/calculate_cycle_prediction_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/repositories/daily_log_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/repositories/wellness_profile_repository.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    ensureLazyPut(
      () => CalculateCyclePredictionUseCase(
        Get.find<WellnessProfileRepository>(),
        Get.find<PeriodTrackingRepository>(),
      ),
    );
    ensureLazyPut(
      () => GetCalendarDataUseCase(
        Get.find<PeriodTrackingRepository>(),
        Get.find<DailyLogRepository>(),
        Get.find<CalculateCyclePredictionUseCase>(),
      ),
    );
    ensureLazyPut(
      () => WellnessCalendarController(Get.find<GetCalendarDataUseCase>()),
    );
  }
}
