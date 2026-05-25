import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/bindings/binding_utils.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/repositories/symptoms_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/usecases/get_symptoms_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/usecases/save_selected_symptoms_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/presentation/controllers/symptoms_controller.dart';

class SymptomsBinding extends Bindings {
  @override
  void dependencies() {
    ensureLazyPut(() => GetSymptomsUseCase(Get.find<SymptomsRepository>()));
    ensureLazyPut(
      () => SaveSelectedSymptomsUseCase(Get.find<SymptomsRepository>()),
    );
    ensureLazyPut(
      () => SymptomsController(
        Get.find<GetSymptomsUseCase>(),
        Get.find<SaveSelectedSymptomsUseCase>(),
      ),
    );
  }
}
