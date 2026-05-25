import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/bindings/binding_utils.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/repositories/reports_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/domain/usecases/get_reports_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/reports/presentation/controllers/reports_controller.dart';

class ReportsBinding extends Bindings {
  @override
  void dependencies() {
    ensureLazyPut(() => GetReportsUseCase(Get.find<ReportsRepository>()));
    ensureLazyPut(() => ReportsController(Get.find<GetReportsUseCase>()));
  }
}
