import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/core/errors/exceptions.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/register_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/core/routes/wellness_routes.dart';

class RegisterController extends GetxController {
  RegisterController(this.registerUseCase);

  final RegisterUseCase registerUseCase;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final acceptedPolicy = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirm = true.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> register() async {
    errorMessage.value = '';
    if (fullNameController.text.trim().isEmpty) {
      errorMessage.value = 'Full name is required.';
      return;
    }
    if (emailController.text.trim().isEmpty) {
      errorMessage.value = 'Email or mobile is required.';
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
    if (!acceptedPolicy.value) {
      errorMessage.value = 'Please accept the privacy policy.';
      return;
    }
    isLoading.value = true;
    try {
      await registerUseCase(
        fullName: fullNameController.text.trim(),
        emailOrMobile: emailController.text.trim(),
        password: passwordController.text,
      );
      Get.offAllNamed(WellnessRoutes.dashboard);
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Unable to create account.';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
