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
      title: 'Private wellness,\nyour way',
      subtitle: 'Track your cycle with confidence and discretion.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Welcome back',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: WellnessSpacing.xs),
          Text(
            'A calm space to understand your cycle, symptoms, and energy.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: WellnessSpacing.lg),
          TextField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email or mobile',
              prefixIcon: Icon(Icons.alternate_email_outlined),
            ),
          ),
          const SizedBox(height: WellnessSpacing.md),
          Obx(
            () => TextField(
              controller: controller.passwordController,
              obscureText: controller.obscurePassword.value,
              decoration: InputDecoration(
                labelText: 'Password',
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
              title: const Text('Remember me'),
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
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
          ),
          Obx(
            () => FilledButton(
              onPressed: controller.isLoading.value ? null : controller.login,
              child: Text(
                controller.isLoading.value ? 'Entering your space...' : 'Continue',
              ),
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed(AuthenticationRoutes.forgotPassword),
            child: const Text('Forgot password?'),
          ),
          OutlinedButton(
            onPressed: () {},
            child: const Text('Continue with Google'),
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
