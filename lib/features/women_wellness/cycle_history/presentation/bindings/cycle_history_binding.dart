import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/bindings/binding_utils.dart';
import 'package:her_wellness_calender/features/women_wellness/cycle_history/presentation/controllers/cycle_history_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/usecases/get_period_history_usecase.dart';

class CycleHistoryBinding extends Bindings {
  @override
  void dependencies() {
    ensureLazyPut(
      () => GetPeriodHistoryUseCase(Get.find<PeriodTrackingRepository>()),
    );
    ensureLazyPut(
      () => CycleHistoryController(Get.find<GetPeriodHistoryUseCase>()),
    );
  }
}
