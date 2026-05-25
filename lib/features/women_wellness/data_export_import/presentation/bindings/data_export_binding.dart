import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/bindings/binding_utils.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/repositories/data_export_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/usecases/export_wellness_data_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/domain/usecases/import_wellness_data_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/presentation/controllers/data_export_controller.dart';

class DataExportBinding extends Bindings {
  @override
  void dependencies() {
    ensureLazyPut(
      () => ExportWellnessDataUseCase(Get.find<DataExportRepository>()),
    );
    ensureLazyPut(
      () => ImportWellnessDataUseCase(Get.find<DataExportRepository>()),
    );
    ensureLazyPut(
      () => DataExportController(
        Get.find<ExportWellnessDataUseCase>(),
        Get.find<ImportWellnessDataUseCase>(),
      ),
    );
  }
}
