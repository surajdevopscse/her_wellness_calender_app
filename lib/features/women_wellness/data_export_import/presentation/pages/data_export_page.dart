import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_insight_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_primary_button.dart';
import 'package:her_wellness_calender/features/women_wellness/data_export_import/presentation/controllers/data_export_controller.dart';

class DataExportPage extends GetView<DataExportController> {
  const DataExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(WellnessSpacing.xl),
      child: WellnessCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const WellnessInsightCard(
              title: 'Own your health history',
              message: 'Download your data securely or bring a saved backup back into the app whenever you need it.',
              icon: Icons.folder_zip_outlined,
            ),
            const SizedBox(height: WellnessSpacing.lg),
            Text('Export wellness data', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: WellnessSpacing.md),
            const Text(
              'Files are saved to your app documents folder and opened in the '
              'system share sheet. No sensitive data is logged to console.',
            ),
            const SizedBox(height: WellnessSpacing.lg),
            Obx(
              () => WellnessPrimaryButton(
                label: controller.isBusy.value ? 'Exporting...' : 'Export JSON',
                icon: Icons.data_object_outlined,
                onPressed: controller.isBusy.value ? null : controller.exportJson,
              ),
            ),
            const SizedBox(height: WellnessSpacing.sm),
            Obx(
              () => WellnessPrimaryButton(
                label: controller.isBusy.value ? 'Exporting...' : 'Export CSV',
                icon: Icons.table_rows_outlined,
                onPressed: controller.isBusy.value ? null : controller.exportCsv,
              ),
            ),
            const SizedBox(height: WellnessSpacing.lg),
            OutlinedButton.icon(
              onPressed: controller.isBusy.value ? null : controller.importBackup,
              icon: const Icon(Icons.file_upload_outlined),
              label: const Text('Import JSON backup'),
            ),
            const SizedBox(height: WellnessSpacing.md),
            Obx(() {
              if (controller.statusMessage.value.isEmpty) {
                return const SizedBox.shrink();
              }
              return Text(controller.statusMessage.value);
            }),
            Obx(() {
              final last = controller.lastExport.value;
              if (last == null) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(top: WellnessSpacing.sm),
                child: Text(
                  'Last file: ${last.path}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
