import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
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
      return ListView(
        padding: const EdgeInsets.all(WellnessSpacing.xl),
        children: [
          const WellnessInsightCard(
            title: 'Notification previews',
            message: 'Balance gentle reminders with discretion so your cycle support feels safe in any environment.',
            icon: Icons.notifications_active_outlined,
          ),
          const SizedBox(height: WellnessSpacing.lg),
          WellnessCard(
            child: Obx(
              () => SwitchListTile(
                title: const Text('Hide sensitive notification text'),
                subtitle: const Text(
                  'Shows generic "Wellness Reminder" on lock screen when enabled.',
                ),
                value: controller.hideSensitive.value,
                onChanged: (v) => controller.hideSensitive.value = v,
              ),
            ),
          ),
          const SizedBox(height: WellnessSpacing.lg),
          for (final template in controller.templates) ...[
            WellnessCard(
              child: Builder(
                builder: (_) {
                  final preview = controller.previewFor(template);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(template.type, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: WellnessSpacing.sm),
                      Text('Title: ${preview.title}'),
                      const SizedBox(height: 4),
                      Text('Body: ${preview.body}'),
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
}
