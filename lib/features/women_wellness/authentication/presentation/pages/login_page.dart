import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/authentication/authentication_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/controllers/login_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/presentation/widgets/auth_shell_layout.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthShellLayout(
      title: 'Serene care,\nyour way',
      subtitle: 'Track your cycle with calm, confidence, and discretion.',
      eyebrow: 'Sign in securely',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: WellnessSpacing.lg),
          Text(
            'Email or mobile',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: WellnessSpacing.xs),
          TextField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
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
                hintText: 'Enter your password',
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
          Obx(
            () => CheckboxListTile(
              value: controller.rememberMe.value,
              onChanged: (v) => controller.rememberMe.value = v ?? false,
              title: const Text('Keep me signed in on this device'),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          Obx(
            () => controller.errorMessage.value.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(bottom: WellnessSpacing.sm),
                    child: Text(
                      controller.errorMessage.value,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
          ),
          Obx(
            () => FilledButton(
              onPressed: controller.isLoading.value ? null : controller.login,
              child: Text(
                controller.isLoading.value
                    ? 'Entering your space...'
                    : 'Continue',
              ),
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed(AuthenticationRoutes.forgotPassword),
            child: const Text('Forgot password?'),
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
              'Your wellness data stays private and editable after sign-in.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed(AuthenticationRoutes.register),
            child: const Text('Create account'),
          ),
        ],
      ),
    );
  }
}
