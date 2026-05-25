import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/authentication/domain/repositories/auth_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/login_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/logout_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/register_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/controllers/forgot_password_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/controllers/login_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/controllers/register_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/controllers/reset_password_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/controllers/verify_otp_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    final repo = Get.find<AuthRepository>();
    Get.lazyPut(() => LoginUseCase(repo), fenix: true);
    Get.lazyPut(() => RegisterUseCase(repo), fenix: true);
    Get.lazyPut(() => ForgotPasswordUseCase(repo), fenix: true);
    Get.lazyPut(() => ResetPasswordUseCase(repo), fenix: true);
    Get.lazyPut(() => VerifyOtpUseCase(repo), fenix: true);
    Get.lazyPut(() => LogoutUseCase(repo), fenix: true);
    Get.lazyPut(() => LoginController(Get.find<LoginUseCase>()), fenix: true);
    Get.lazyPut(() => RegisterController(Get.find<RegisterUseCase>()), fenix: true);
    Get.lazyPut(
      () => ForgotPasswordController(Get.find<ForgotPasswordUseCase>()),
      fenix: true,
    );
    Get.lazyPut(
      () => ResetPasswordController(Get.find<ResetPasswordUseCase>()),
      fenix: true,
    );
    Get.lazyPut(() => VerifyOtpController(Get.find<VerifyOtpUseCase>()), fenix: true);
  }
}
