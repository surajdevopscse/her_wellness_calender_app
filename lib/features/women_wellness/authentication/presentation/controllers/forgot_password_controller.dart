import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/core/errors/exceptions.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/authentication_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/forgot_password_usecase.dart';

class ForgotPasswordController extends GetxController {
  ForgotPasswordController(this.forgotPasswordUseCase);

  final ForgotPasswordUseCase forgotPasswordUseCase;

  final emailController = TextEditingController();
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final successMessage = ''.obs;

  Future<void> sendReset() async {
    errorMessage.value = '';
    successMessage.value = '';
    if (emailController.text.trim().isEmpty) {
      errorMessage.value = 'Email or mobile is required.';
      return;
    }
    isLoading.value = true;
    try {
      await forgotPasswordUseCase(emailOrMobile: emailController.text.trim());
      successMessage.value = 'Reset instructions sent (mock).';
      Get.toNamed(
        AuthenticationRoutes.resetPassword,
        arguments: emailController.text.trim(),
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Unable to send reset link.';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
