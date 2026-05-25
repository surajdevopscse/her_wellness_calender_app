import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/auth/auth_routes.dart';

/// Handles register form state and validation.
class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxString errorMessage = ''.obs;
  final RxBool isLoading = false.obs;

  Future<void> register() async {
    errorMessage.value = '';
    if (nameController.text.trim().isEmpty) {
      errorMessage.value = 'Please enter your name.';
      return;
    }
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
    Get.offNamed(AuthRoutes.login);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
