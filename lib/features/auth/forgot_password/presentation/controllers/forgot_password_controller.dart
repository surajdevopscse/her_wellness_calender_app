import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Handles password reset request state.
class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final RxString message = ''.obs;
  final RxBool isLoading = false.obs;

  Future<void> submit() async {
    if (!emailController.text.contains('@')) {
      message.value = 'Please enter a valid email address.';
      return;
    }
    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 300));
    isLoading.value = false;
    message.value =
        'Password reset instructions have been sent if this account exists.';
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
