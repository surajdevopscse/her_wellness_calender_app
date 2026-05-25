import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/core/errors/exceptions.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/core/routes/wellness_routes.dart';

class VerifyOtpController extends GetxController {
  VerifyOtpController(this.verifyOtpUseCase);

  final VerifyOtpUseCase verifyOtpUseCase;

  final emailOrMobile = ''.obs;
  final otpControllers = List.generate(6, (_) => TextEditingController());
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final canResend = true.obs;

  @override
  void onInit() {
    super.onInit();
    emailOrMobile.value = (Get.arguments as String?) ?? 'demo@wellness.local';
  }

  String get otp => otpControllers.map((c) => c.text).join();

  Future<void> verify() async {
    errorMessage.value = '';
    if (otp.length != 6) {
      errorMessage.value = 'Enter the 6-digit code.';
      return;
    }
    isLoading.value = true;
    try {
      await verifyOtpUseCase(
        emailOrMobile: emailOrMobile.value,
        otp: otp,
      );
      Get.offAllNamed(WellnessRoutes.dashboard);
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Verification failed.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resend() async {
    canResend.value = false;
    await Future<void>.delayed(const Duration(seconds: 2));
    canResend.value = true;
    Get.snackbar('OTP', 'Mock OTP resent: 123456');
  }

  @override
  void onClose() {
    for (final controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
