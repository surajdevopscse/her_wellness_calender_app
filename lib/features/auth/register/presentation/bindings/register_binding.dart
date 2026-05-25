import 'package:get/get.dart';

import 'package:her_wellness_calender/features/auth/register/presentation/controllers/register_controller.dart';

/// Registers account creation dependencies.
class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
