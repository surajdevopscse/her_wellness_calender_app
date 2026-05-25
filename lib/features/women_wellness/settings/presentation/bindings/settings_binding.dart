import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/authentication/domain/repositories/auth_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/logout_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/core/bindings/binding_utils.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/domain/repositories/settings_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/presentation/controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    ensureLazyPut(() => LogoutUseCase(Get.find<AuthRepository>()));
    ensureLazyPut(
      () => SettingsController(
        Get.find<SettingsRepository>(),
        Get.find<LogoutUseCase>(),
      ),
    );
  }
}
