import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/bindings/binding_utils.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/repositories/daily_log_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/usecases/add_daily_log_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/usecases/delete_daily_log_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/usecases/get_daily_logs_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/usecases/update_daily_log_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/presentation/controllers/daily_log_controller.dart';

class DailyLogBinding extends Bindings {
  @override
  void dependencies() {
    ensureLazyPut(() => GetDailyLogsUseCase(Get.find<DailyLogRepository>()));
    ensureLazyPut(() => AddDailyLogUseCase(Get.find<DailyLogRepository>()));
    ensureLazyPut(() => UpdateDailyLogUseCase(Get.find<DailyLogRepository>()));
    ensureLazyPut(() => DeleteDailyLogUseCase(Get.find<DailyLogRepository>()));
    ensureLazyPut(
      () => DailyLogController(
        Get.find<GetDailyLogsUseCase>(),
        Get.find<AddDailyLogUseCase>(),
        Get.find<UpdateDailyLogUseCase>(),
        Get.find<DeleteDailyLogUseCase>(),
      ),
    );
  }
}
