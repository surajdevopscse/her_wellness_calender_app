import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_insight_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_primary_button.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/presentation/controllers/data_export_controller.dart';

class BackupRestorePage extends GetView<DataExportController> {
  const BackupRestorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(WellnessSpacing.xl),
      child: Column(
        children: [
          const WellnessInsightCard(
            title: 'Backup with clarity',
            message:
                'Create a portable copy of your cycle history, daily logs, reminders, and privacy preferences, then restore it when you need it.',
            icon: Icons.cloud_done_outlined,
          ),
          const SizedBox(height: WellnessSpacing.lg),
          WellnessCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Backup file', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: WellnessSpacing.sm),
                const Text(
                  'Create a local encrypted-style backup file you can store in your preferred drive or share destination.',
                ),
                const SizedBox(height: WellnessSpacing.lg),
                Obx(
                  () => WellnessPrimaryButton(
                    label:
                        controller.isBusy.value ? 'Saving...' : 'Backup as JSON',
                    icon: Icons.cloud_upload_outlined,
                    onPressed:
                        controller.isBusy.value ? null : controller.exportJson,
                  ),
                ),
                const SizedBox(height: WellnessSpacing.sm),
                Obx(
                  () => OutlinedButton.icon(
                    onPressed:
                        controller.isBusy.value ? null : controller.exportCsv,
                    icon: const Icon(Icons.table_rows_outlined),
                    label: Text(
                      controller.isBusy.value ? 'Saving...' : 'Backup as CSV',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: WellnessSpacing.lg),
          WellnessCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Restore', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: WellnessSpacing.sm),
                const Text(
                  'Choose a previously exported JSON backup to restore profile, cycle history, daily logs, symptoms, reminders, and privacy settings.',
                ),
                const SizedBox(height: WellnessSpacing.lg),
                Obx(
                  () => OutlinedButton.icon(
                    onPressed:
                        controller.isBusy.value ? null : controller.importBackup,
                    icon: const Icon(Icons.restore_outlined),
                    label: Text(
                      controller.isBusy.value
                          ? 'Restoring...'
                          : 'Restore backup',
                    ),
                  ),
                ),
                Obx(() {
                  if (controller.statusMessage.value.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: WellnessSpacing.md),
                    child: Text(controller.statusMessage.value),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
