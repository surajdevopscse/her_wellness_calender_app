import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_insight_card.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/presentation/controllers/reminder_settings_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/reminders/presentation/widgets/reminder_tile.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_error_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_loading_view.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';

/// Reminder settings screen.
class ReminderSettingsPage extends GetView<ReminderSettingsController> {
  const ReminderSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const WellnessLoadingView();
      }
      if (controller.errorMessage.value.isNotEmpty) {
        return WellnessErrorState(
          message: controller.errorMessage.value,
          onRetry: controller.load,
        );
      }
      return ListView(
        padding: const EdgeInsets.all(WellnessSpacing.xl),
        children: [
          const WellnessInsightCard(
            title: 'Timely support',
            message: 'Set gentle nudges for cycle care, medication, and body awareness without overwhelming your day.',
            icon: Icons.schedule_rounded,
          ),
          const SizedBox(height: WellnessSpacing.lg),
          for (final reminder in controller.reminders) ...[
            WellnessCard(
              child: Column(
                children: [
                  ReminderTile(
                    reminder: reminder,
                    onToggle: (value) => controller.toggle(reminder, value),
                  ),
                  ListTile(
                    leading: const Icon(Icons.schedule_outlined),
                    title: Text('Time: ${reminder.reminderTime}'),
                    subtitle: Text('Days before: ${reminder.daysBefore}'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: WellnessSpacing.md),
          ],
        ],
      );
    });
  }
}
