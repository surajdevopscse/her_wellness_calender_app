import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/cycle_history/presentation/controllers/cycle_history_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_error_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_loading_view.dart';

/// Cycle history list screen.
class CycleHistoryPage extends GetView<CycleHistoryController> {
  const CycleHistoryPage({super.key});

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
      return ListView.separated(
        padding: const EdgeInsets.all(WellnessSpacing.xl),
        itemCount: controller.periods.length,
        separatorBuilder: (_, _) => const SizedBox(height: WellnessSpacing.md),
        itemBuilder: (context, index) {
          final period = controller.periods[index];
          return Card(
            child: ListTile(
              title: Text(
                '${WellnessDateHelper.shortDate.format(period.startDate)} - ${period.endDate == null ? 'Active' : WellnessDateHelper.shortDate.format(period.endDate!)}',
              ),
              subtitle: Text(
                '${period.periodLength} days | ${period.notes ?? 'No notes'}',
              ),
              trailing: Chip(
                label: Text(
                  period.irregularCycleNote == null ? 'Regular' : 'Irregular',
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
