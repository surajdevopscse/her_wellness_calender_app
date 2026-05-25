import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/controllers/verify_otp_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/widgets/auth_shell_layout.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

class VerifyOtpPage extends GetView<VerifyOtpController> {
  const VerifyOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthShellLayout(
      title: 'Verify OTP',
      subtitle: 'Enter the 6-digit code. Mock code: 123456',
      heroIcon: Icons.verified_user_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: WellnessSpacing.sm,
            runSpacing: WellnessSpacing.sm,
            children: List.generate(6, (index) {
              return SizedBox(
                width: 44,
                child: TextField(
                  controller: controller.otpControllers[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(counterText: ''),
                ),
              );
            }),
          ),
          const SizedBox(height: WellnessSpacing.md),
          Obx(
            () => controller.errorMessage.value.isEmpty
                ? const SizedBox.shrink()
                : Text(
                    controller.errorMessage.value,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
          ),
          Obx(
            () => FilledButton(
              onPressed: controller.isLoading.value ? null : controller.verify,
              child: Text(controller.isLoading.value ? 'Verifying...' : 'Verify'),
            ),
          ),
          Obx(
            () => TextButton(
              onPressed: controller.canResend.value ? controller.resend : null,
              child: const Text('Resend OTP'),
            ),
          ),
        ],
      ),
    );
  }
}
