import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/authentication/authentication_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/controllers/register_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/widgets/auth_shell_layout.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthShellLayout(
      title: 'Start your\nwellness journey',
      subtitle: 'Create a private account to track cycles and symptoms.',
      heroIcon: Icons.spa_outlined,
      eyebrow: 'Create a private account',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: WellnessSpacing.lg),
          Text('Full name', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: WellnessSpacing.xs),
          TextField(
            controller: controller.fullNameController,
            decoration: const InputDecoration(
              hintText: 'Enter your full name',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: WellnessSpacing.md),
          Text(
            'Email or mobile',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: WellnessSpacing.xs),
          TextField(
            controller: controller.emailController,
            decoration: const InputDecoration(
              hintText: 'Enter your email or mobile',
              prefixIcon: Icon(Icons.alternate_email_outlined),
            ),
          ),
          const SizedBox(height: WellnessSpacing.md),
          Text('Password', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: WellnessSpacing.xs),
          Obx(
            () => TextField(
              controller: controller.passwordController,
              obscureText: controller.obscurePassword.value,
              decoration: InputDecoration(
                hintText: 'Create a password',
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
          Text(
            'Confirm password',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: WellnessSpacing.xs),
          Obx(
            () => TextField(
              controller: controller.confirmPasswordController,
              obscureText: controller.obscureConfirm.value,
              decoration: InputDecoration(
                hintText: 'Re-enter your password',
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
          Obx(
            () => CheckboxListTile(
              value: controller.acceptedPolicy.value,
              onChanged: (v) => controller.acceptedPolicy.value = v ?? false,
              title: const Text(
                'I accept the privacy policy and secure data handling',
              ),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          Obx(
            () => controller.errorMessage.value.isEmpty
                ? const SizedBox.shrink()
                : Text(
                    controller.errorMessage.value,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
          ),
          const SizedBox(height: WellnessSpacing.sm),
          Obx(
            () => FilledButton(
              onPressed: controller.isLoading.value
                  ? null
                  : controller.register,
              child: Text(
                controller.isLoading.value
                    ? 'Creating your private space...'
                    : 'Create account',
              ),
            ),
          ),
          const SizedBox(height: WellnessSpacing.sm),
          Container(
            padding: const EdgeInsets.all(WellnessSpacing.md),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.42),
              borderRadius: BorderRadius.circular(
                WellnessSpacing.controlRadius,
              ),
            ),
            child: Text(
              'You can update period history, reminders, and privacy controls after registration.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          TextButton(
            onPressed: () => Get.offNamed(AuthenticationRoutes.login),
            child: const Text('Already have an account? Sign in'),
          ),
        ],
      ),
    );
  }
}
