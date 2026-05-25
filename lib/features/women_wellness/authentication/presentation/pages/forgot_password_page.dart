import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/controllers/forgot_password_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/widgets/auth_shell_layout.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthShellLayout(
      title: 'Forgot password?',
      subtitle: 'We will send a secure reset code to your email or mobile.',
      heroIcon: Icons.lock_reset_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: controller.emailController,
            decoration: const InputDecoration(
              labelText: 'Email or mobile',
              prefixIcon: Icon(Icons.alternate_email_outlined),
            ),
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
            () => controller.successMessage.value.isEmpty
                ? const SizedBox.shrink()
                : Text(controller.successMessage.value),
          ),
          const SizedBox(height: WellnessSpacing.sm),
          Obx(
            () => FilledButton(
              onPressed: controller.isLoading.value ? null : controller.sendReset,
              child: Text(controller.isLoading.value ? 'Sending...' : 'Send reset code'),
            ),
          ),
        ],
      ),
    );
  }
}
