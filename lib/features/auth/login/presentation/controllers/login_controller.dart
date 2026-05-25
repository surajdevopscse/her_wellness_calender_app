import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/routes/wellness_routes.dart';

/// Handles login form state.
class LoginController extends GetxController {
  final emailController = TextEditingController(text: 'demo@wellness.local');
  final passwordController = TextEditingController(text: 'password');
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> login() async {
    errorMessage.value = '';
    if (!emailController.text.contains('@')) {
      errorMessage.value = 'Please enter a valid email address.';
      return;
    }
    if (passwordController.text.length < 6) {
      errorMessage.value = 'Password must be at least 6 characters.';
      return;
    }
    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 300));
    isLoading.value = false;
    Get.offAllNamed(WellnessRoutes.dashboard);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
