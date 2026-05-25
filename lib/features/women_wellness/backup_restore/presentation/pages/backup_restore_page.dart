import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_primary_button.dart';

class BackupRestorePage extends StatelessWidget {
  const BackupRestorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(WellnessSpacing.xl),
      child: Column(
        children: [
          WellnessCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Cloud backup', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: WellnessSpacing.sm),
                const Text(
                  'Encrypted cloud backup placeholder. Enable only in Privacy settings.',
                ),
                const SizedBox(height: WellnessSpacing.lg),
                WellnessPrimaryButton(
                  label: 'Backup now',
                  icon: Icons.cloud_upload_outlined,
                  onPressed: () =>
                      Get.snackbar('Backup', 'Cloud backup queued (mock).'),
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
                const Text('Restore from your latest encrypted backup file.'),
                const SizedBox(height: WellnessSpacing.lg),
                OutlinedButton.icon(
                  onPressed: () =>
                      Get.snackbar('Restore', 'Restore flow ready (mock).'),
                  icon: const Icon(Icons.restore_outlined),
                  label: const Text('Restore backup'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
