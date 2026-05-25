import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/bindings/binding_utils.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/repositories/wellness_profile_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/usecases/get_wellness_profile_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/usecases/update_wellness_profile_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/presentation/controllers/wellness_profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    ensureLazyPut(
      () => GetWellnessProfileUseCase(Get.find<WellnessProfileRepository>()),
    );
    ensureLazyPut(
      () => UpdateWellnessProfileUseCase(Get.find<WellnessProfileRepository>()),
    );
    ensureLazyPut(
      () => WellnessProfileController(
        Get.find<GetWellnessProfileUseCase>(),
        Get.find<UpdateWellnessProfileUseCase>(),
      ),
    );
  }
}
