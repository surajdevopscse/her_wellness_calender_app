import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/bindings/binding_utils.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/repositories/privacy_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/usecases/delete_wellness_data_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/usecases/get_privacy_settings_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/usecases/update_privacy_settings_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/presentation/controllers/privacy_settings_controller.dart';

class PrivacyBinding extends Bindings {
  @override
  void dependencies() {
    ensureLazyPut(
      () => GetPrivacySettingsUseCase(Get.find<PrivacyRepository>()),
    );
    ensureLazyPut(
      () => UpdatePrivacySettingsUseCase(Get.find<PrivacyRepository>()),
    );
    ensureLazyPut(
      () => DeleteWellnessDataUseCase(Get.find<PrivacyRepository>()),
    );
    ensureLazyPut(
      () => PrivacySettingsController(
        Get.find<GetPrivacySettingsUseCase>(),
        Get.find<UpdatePrivacySettingsUseCase>(),
        Get.find<DeleteWellnessDataUseCase>(),
      ),
    );
  }
}
