import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/core/errors/exceptions.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/authentication_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/login_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/core/routes/wellness_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/domain/repositories/onboarding_repository.dart';

class LoginController extends GetxController {
  LoginController(this.loginUseCase, this.onboardingRepository);

  final LoginUseCase loginUseCase;
  final OnboardingRepository onboardingRepository;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rememberMe = true.obs;
  final obscurePassword = true.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> login() async {
    errorMessage.value = '';
    final identifier = emailController.text.trim();
    if (identifier.isEmpty) {
      errorMessage.value = 'Email or mobile is required.';
      return;
    }
    if (passwordController.text.isEmpty) {
      errorMessage.value = 'Password is required.';
      return;
    }
    isLoading.value = true;
    try {
      await loginUseCase(
        emailOrMobile: identifier,
        password: passwordController.text,
      );
      final setupDone = await onboardingRepository.isSetupCompleted();
      Get.offAllNamed(
        setupDone
            ? WellnessRoutes.dashboard
            : AuthenticationRoutes.setupOnboarding,
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Unable to sign in. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
