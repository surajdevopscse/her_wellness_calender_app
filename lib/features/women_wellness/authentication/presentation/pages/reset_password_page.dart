import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/controllers/reset_password_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/widgets/auth_shell_layout.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthShellLayout(
      title: 'Reset password',
      subtitle: 'Enter the code we sent and choose a new password.',
      heroIcon: Icons.password_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: controller.otpController,
            decoration: const InputDecoration(
              labelText: 'Reset code / OTP',
              prefixIcon: Icon(Icons.pin_outlined),
            ),
          ),
          const SizedBox(height: WellnessSpacing.md),
          Obx(
            () => TextField(
              controller: controller.passwordController,
              obscureText: controller.obscurePassword.value,
              decoration: InputDecoration(
                labelText: 'New password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () => controller.obscurePassword.toggle(),
                  icon: Icon(
                    controller.obscurePassword.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: WellnessSpacing.md),
          Obx(
            () => TextField(
              controller: controller.confirmPasswordController,
              obscureText: controller.obscureConfirm.value,
              decoration: InputDecoration(
                labelText: 'Confirm password',
                prefixIcon: const Icon(Icons.lock_reset_outlined),
                suffixIcon: IconButton(
                  onPressed: () => controller.obscureConfirm.toggle(),
                  icon: Icon(
                    controller.obscureConfirm.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: WellnessSpacing.sm),
          Obx(
            () => controller.errorMessage.value.isEmpty
                ? const SizedBox.shrink()
                : Text(
                    controller.errorMessage.value,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
          ),
          const SizedBox(height: WellnessSpacing.sm),
          Obx(
            () => FilledButton(
              onPressed: controller.isLoading.value ? null : controller.resetPassword,
              child: Text(controller.isLoading.value ? 'Saving...' : 'Update password'),
            ),
          ),
        ],
      ),
    );
  }
}
