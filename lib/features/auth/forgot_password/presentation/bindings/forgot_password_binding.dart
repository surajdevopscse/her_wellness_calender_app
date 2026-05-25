import 'package:get/get.dart';

import 'package:her_wellness_calender/features/auth/forgot_password/presentation/controllers/forgot_password_controller.dart';

/// Registers forgot-password dependencies.
class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}
