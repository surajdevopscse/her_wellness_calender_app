import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/core/errors/exceptions.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/authentication_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/reset_password_usecase.dart';

class ResetPasswordController extends GetxController {
  ResetPasswordController(this.resetPasswordUseCase);

  final ResetPasswordUseCase resetPasswordUseCase;

  late final String emailOrMobile;
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final obscurePassword = true.obs;
  final obscureConfirm = true.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    emailOrMobile = (Get.arguments as String?) ?? '';
  }

  Future<void> resetPassword() async {
    errorMessage.value = '';
    if (otpController.text.trim().isEmpty) {
      errorMessage.value = 'Reset code is required.';
      return;
    }
    if (passwordController.text.length < 8) {
      errorMessage.value = 'Password must be at least 8 characters.';
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      errorMessage.value = 'Passwords do not match.';
      return;
    }
    isLoading.value = true;
    try {
      await resetPasswordUseCase(
        emailOrMobile: emailOrMobile,
        otp: otpController.text.trim(),
        newPassword: passwordController.text,
      );
      Get.offAllNamed(AuthenticationRoutes.login);
      Get.snackbar('Success', 'Password updated. Please sign in.');
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Unable to reset password.';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
