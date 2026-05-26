import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_error_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_insight_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_loading_view.dart';
import 'package:her_wellness_calender/features/women_wellness/notifications/presentation/controllers/notifications_controller.dart';

class NotificationsPage extends GetView<NotificationsController> {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const WellnessLoadingView();
      if (controller.errorMessage.value.isNotEmpty &&
          controller.templates.isEmpty) {
        return WellnessErrorState(
          message: controller.errorMessage.value,
          onRetry: controller.load,
        );
      }
      return ListView(
        padding: const EdgeInsets.all(WellnessSpacing.xl),
        children: [
          const WellnessInsightCard(
            title: 'Notification previews',
            message:
                'See exactly how reminders appear before they reach your lock screen, and decide whether you want discreet or detailed copy.',
            icon: Icons.notifications_active_outlined,
          ),
          const SizedBox(height: WellnessSpacing.lg),
          WellnessCard(
            child: Obx(
              () => SwitchListTile(
                title: const Text('Use discreet notification text'),
                subtitle: const Text(
                  'When enabled, lock-screen previews stay generic instead of mentioning periods, ovulation, or symptoms.',
                ),
                value: controller.hideSensitive.value,
                onChanged: controller.toggleSensitiveText,
              ),
            ),
          ),
          if (controller.errorMessage.value.isNotEmpty) ...[
            const SizedBox(height: WellnessSpacing.md),
            WellnessCard(
              child: Text(
                controller.errorMessage.value,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
          const SizedBox(height: WellnessSpacing.lg),
          for (final template in controller.templates) ...[
            WellnessCard(
              child: Builder(
                builder: (_) {
                  final preview = controller.previewFor(template);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: WellnessColors.secondary.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.mark_chat_unread_outlined,
                              color: WellnessColors.primaryDeep,
                            ),
                          ),
                          const SizedBox(width: WellnessSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _labelForType(template.type),
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  controller.hideSensitive.value
                                      ? 'Private lock-screen preview'
                                      : 'Visible lock-screen preview',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: WellnessSpacing.sm),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(WellnessSpacing.md),
                        decoration: BoxDecoration(
                          color: WellnessColors.primaryHot.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              preview.title,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(preview.body),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: WellnessSpacing.md),
          ],
        ],
      );
    });
  }

  String _labelForType(String type) {
    switch (type) {
      case 'upcomingPeriod':
        return 'Upcoming period reminder';
      case 'dailyLog':
        return 'Daily check-in reminder';
      case 'ovulation':
        return 'Ovulation window reminder';
      case 'hydration':
        return 'Hydration reminder';
      case 'appointment':
        return 'Appointment reminder';
      default:
        return type;
    }
  }
}
