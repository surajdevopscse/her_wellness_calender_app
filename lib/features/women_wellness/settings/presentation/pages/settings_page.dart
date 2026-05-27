import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_insight_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_loading_view.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_section_header.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/domain/entities/app_settings.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/presentation/controllers/settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.settings.value == null) {
        return const WellnessLoadingView();
      }
      final settings = controller.settings.value;
      return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          WellnessSpacing.lg,
          WellnessSpacing.lg,
          WellnessSpacing.lg,
          WellnessResponsive.bottomContentInset(context),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: WellnessSpacing.compactMaxWidth,
            ),
            child: Column(
              children: [
                const WellnessInsightCard(
                  title: 'Make the app feel like your space',
                  message:
                      'Adjust appearance, privacy, backups, and notifications to match your comfort and rhythm.',
                  icon: Icons.tune_rounded,
                  tint: WellnessColors.secondary,
                ),
                const SizedBox(height: WellnessSpacing.lg),
                const WellnessSectionHeader(
                  title: 'Appearance',
                  subtitle:
                      'Choose a theme that feels right on both bright and low-light screens.',
                ),
                const SizedBox(height: WellnessSpacing.md),
                WellnessCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Appearance',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: WellnessSpacing.md),
                      SizedBox(
                        width: double.infinity,
                        child: SegmentedButton<AppThemeMode>(
                          showSelectedIcon: false,
                          style: ButtonStyle(
                            visualDensity: VisualDensity.standard,
                            backgroundColor: WidgetStateProperty.resolveWith((
                              states,
                            ) {
                              if (states.contains(WidgetState.selected)) {
                                return Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? WellnessColors.darkPrimary.withValues(
                                        alpha: 0.22,
                                      )
                                    : WellnessColors.secondary.withValues(
                                        alpha: 0.55,
                                      );
                              }
                              return Colors.transparent;
                            }),
                            foregroundColor: WidgetStateProperty.resolveWith((
                              states,
                            ) {
                              if (states.contains(WidgetState.selected)) {
                                return WellnessColors.textPrimaryFor(
                                  Theme.of(context).brightness,
                                );
                              }
                              return WellnessColors.textSecondaryFor(
                                Theme.of(context).brightness,
                              );
                            }),
                            side: WidgetStatePropertyAll(
                              BorderSide(
                                color: WellnessColors.textPrimaryFor(
                                  Theme.of(context).brightness,
                                ),
                              ),
                            ),
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 12),
                            ),
                            textStyle: WidgetStatePropertyAll(
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          segments: const [
                            ButtonSegment(
                              value: AppThemeMode.system,
                              label: Text('Auto'),
                            ),
                            ButtonSegment(
                              value: AppThemeMode.light,
                              label: Text('Light'),
                            ),
                            ButtonSegment(
                              value: AppThemeMode.dark,
                              label: Text('Dark'),
                            ),
                          ],
                          selected: {
                            settings?.themeMode ?? AppThemeMode.system,
                          },
                          onSelectionChanged: (value) =>
                              controller.updateTheme(value.first),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
                const WellnessSectionHeader(
                  title: 'Personal controls',
                  subtitle:
                      'Manage your profile, reminders, and privacy from one place.',
                ),
                const SizedBox(height: WellnessSpacing.md),
                WellnessCard(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person_outline_rounded),
                        title: const Text('Profile & cycle baseline'),
                        subtitle: const Text(
                          'Review your average cycle length, age group, and last period date.',
                        ),
                        onTap: controller.openProfile,
                      ),
                      SwitchListTile(
                        title: const Text('Notifications'),
                        value: settings?.notificationsEnabled ?? true,
                        onChanged: controller.toggleNotifications,
                      ),
                      ListTile(
                        leading: const Icon(Icons.notifications_outlined),
                        title: const Text('Notification preferences'),
                        onTap: controller.openNotifications,
                      ),
                      ListTile(
                        leading: const Icon(Icons.lock_outline),
                        title: const Text('Privacy & security'),
                        onTap: controller.openPrivacy,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
                const WellnessSectionHeader(
                  title: 'Data & portability',
                  subtitle:
                      'Export, restore, and review how your information moves with you.',
                ),
                const SizedBox(height: WellnessSpacing.md),
                WellnessCard(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.upload_outlined),
                        title: const Text('Export data'),
                        onTap: controller.openExport,
                      ),
                      ListTile(
                        leading: const Icon(Icons.cloud_sync_outlined),
                        title: const Text('Backup & restore'),
                        onTap: controller.openBackup,
                      ),
                      ListTile(
                        leading: const Icon(Icons.language_outlined),
                        title: const Text('Language'),
                        subtitle: const Text('English (placeholder)'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
                const WellnessSectionHeader(
                  title: 'About the app',
                  subtitle:
                      'Keep policy, version, and trust information easy to find.',
                ),
                const SizedBox(height: WellnessSpacing.md),
                WellnessCard(
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text('App info'),
                        subtitle: Text('Her Wellness Calendar v1.0.0'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.policy_outlined),
                        title: const Text('Privacy policy'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.article_outlined),
                        title: const Text('Terms and conditions'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: controller.logout,
                    style: FilledButton.styleFrom(
                      backgroundColor: WellnessColors.periodDeep,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: WellnessSpacing.md,
                      ),
                      textStyle: Theme.of(context).textTheme.titleSmall
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          WellnessSpacing.controlRadius + 2,
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.logout_rounded, size: 18),
                    label: const Text('Sign out'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
