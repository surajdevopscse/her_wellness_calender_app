import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/bindings/binding_utils.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/repositories/period_tracking_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/usecases/add_period_entry_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/usecases/delete_period_entry_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/usecases/get_period_history_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/usecases/update_period_entry_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/presentation/controllers/period_entry_controller.dart';

class PeriodTrackingBinding extends Bindings {
  @override
  void dependencies() {
    ensureLazyPut(
      () => GetPeriodHistoryUseCase(Get.find<PeriodTrackingRepository>()),
    );
    ensureLazyPut(
      () => AddPeriodEntryUseCase(Get.find<PeriodTrackingRepository>()),
    );
    ensureLazyPut(
      () => UpdatePeriodEntryUseCase(Get.find<PeriodTrackingRepository>()),
    );
    ensureLazyPut(
      () => DeletePeriodEntryUseCase(Get.find<PeriodTrackingRepository>()),
    );
    ensureLazyPut(
      () => PeriodEntryController(
        Get.find<GetPeriodHistoryUseCase>(),
        Get.find<AddPeriodEntryUseCase>(),
        Get.find<UpdatePeriodEntryUseCase>(),
        Get.find<DeletePeriodEntryUseCase>(),
      ),
    );
  }
}
