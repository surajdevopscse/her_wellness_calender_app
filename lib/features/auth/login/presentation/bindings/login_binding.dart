import 'package:get/get.dart';

import 'package:her_wellness_calender/features/auth/login/presentation/controllers/login_controller.dart';

/// Registers login dependencies.
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
