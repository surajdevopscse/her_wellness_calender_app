import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/core/errors/exceptions.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/authentication_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/verify_otp_usecase.dart';

class VerifyOtpController extends GetxController {
  VerifyOtpController(this.verifyOtpUseCase, this.forgotPasswordUseCase);

  final VerifyOtpUseCase verifyOtpUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  final emailOrMobile = ''.obs;
  final otpControllers = List.generate(6, (_) => TextEditingController());
  final otpFocusNodes = List.generate(6, (_) => FocusNode());
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final canResend = true.obs;

  @override
  void onInit() {
    super.onInit();
    emailOrMobile.value = (Get.arguments as String?) ?? '';
  }

  String get otp => otpControllers.map((c) => c.text).join();

  void handleOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < otpFocusNodes.length - 1) {
      otpFocusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  Future<void> verify() async {
    errorMessage.value = '';
    if (emailOrMobile.value.isEmpty) {
      errorMessage.value = 'Email or mobile is required.';
      return;
    }
    if (otp.length != 6) {
      errorMessage.value = 'Enter the 6-digit code.';
      return;
    }
    isLoading.value = true;
    try {
      await verifyOtpUseCase(emailOrMobile: emailOrMobile.value, otp: otp);
      Get.offNamed(
        AuthenticationRoutes.resetPassword,
        arguments: {'emailOrMobile': emailOrMobile.value, 'otp': otp},
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Verification failed.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resend() async {
    if (emailOrMobile.value.isEmpty) {
      errorMessage.value = 'Email or mobile is required.';
      return;
    }
    canResend.value = false;
    errorMessage.value = '';
    try {
      await forgotPasswordUseCase(emailOrMobile: emailOrMobile.value);
      Get.snackbar('OTP', 'A new reset code has been sent.');
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Unable to resend reset code.';
    } finally {
      await Future<void>.delayed(const Duration(seconds: 2));
      canResend.value = true;
    }
  }

  @override
  void onClose() {
    for (final controller in otpControllers) {
      controller.dispose();
    }
    for (final node in otpFocusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
