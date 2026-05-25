import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_confirm_dialog.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_error_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_loading_view.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_primary_button.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_secondary_button.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/presentation/controllers/period_entry_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/presentation/widgets/period_date_selector.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/presentation/widgets/period_length_card.dart';

/// Responsive add/edit screen for period entries.
class AddEditPeriodPage extends GetView<PeriodEntryController> {
  const AddEditPeriodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.history.isEmpty) {
        return const WellnessLoadingView();
      }
      if (controller.errorMessage.value.isNotEmpty &&
          controller.history.isEmpty) {
        return WellnessErrorState(
          message: controller.errorMessage.value,
          onRetry: controller.loadHistory,
        );
      }
      return SingleChildScrollView(
        padding: WellnessResponsive.pagePadding(context),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: WellnessSpacing.pageMaxWidth,
            ),
            child: WellnessCard(
                padding: const EdgeInsets.all(WellnessSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(WellnessSpacing.lg),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0x33F5B7C5),
                            Color(0x33D8B4FE),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.isEditMode
                                ? 'Refine your cycle record'
                                : 'Capture this cycle gently',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: WellnessSpacing.sm),
                          Text(
                            'Track start and end dates with notes that help you recognize patterns over time.',
                            style: WellnessTextStyles.bodyFor(context).copyWith(
                              color: WellnessColors.textSecondaryFor(
                                Theme.of(context).brightness,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: WellnessSpacing.xl),
                    Text(
                      controller.isEditMode
                          ? WellnessConstants.editPeriodTitle
                        : WellnessConstants.addPeriodTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: WellnessSpacing.xl),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final useColumns = WellnessResponsive.useComfortableColumns(
                        context,
                        constraints.maxWidth,
                      );
                      if (!useColumns) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildDateFields(context),
                            const SizedBox(height: WellnessSpacing.lg),
                            _buildNotesFields(),
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildDateFields(context)),
                          const SizedBox(width: WellnessSpacing.lg),
                          Expanded(child: _buildNotesFields()),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: WellnessSpacing.lg),
                  PeriodLengthCard(
                    periodLength: controller.calculatedPeriodLength,
                    showWarning: controller.hasLongPeriodWarning,
                  ),
                  if (controller.message.value.isNotEmpty) ...[
                    const SizedBox(height: WellnessSpacing.lg),
                    Text(
                      controller.message.value,
                      style: TextStyle(
                        color: controller.hasLongPeriodWarning
                            ? WellnessColors.warning
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                  const SizedBox(height: WellnessSpacing.xl),
                  _buildActions(context),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildDateFields(BuildContext context) {
    return Column(
      children: [
        PeriodDateSelector(
          label: WellnessConstants.startDate,
          value: controller.startDate.value,
          onChanged: (value) {
            if (value != null) controller.updateStartDate(value);
          },
        ),
        const SizedBox(height: WellnessSpacing.lg),
        PeriodDateSelector(
          label: WellnessConstants.endDate,
          value: controller.endDate.value,
          optional: true,
          firstDate: controller.startDate.value,
          onChanged: controller.updateEndDate,
        ),
      ],
    );
  }

  Widget _buildNotesFields() {
    return Column(
      children: [
        TextField(
          controller: controller.irregularNoteController,
          minLines: 2,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: WellnessConstants.irregularCycleNote,
            hintText: WellnessConstants.irregularCycleNoteHint,
          ),
        ),
        const SizedBox(height: WellnessSpacing.lg),
        TextField(
          controller: controller.notesController,
          minLines: 3,
          maxLines: 5,
          decoration: const InputDecoration(
            labelText: WellnessConstants.notes,
            hintText: WellnessConstants.periodNotesHint,
          ),
        ),
        const SizedBox(height: WellnessSpacing.lg),
        WellnessCard(
          padding: const EdgeInsets.all(WellnessSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.auto_awesome_rounded, color: WellnessColors.primaryDeep),
              const SizedBox(width: WellnessSpacing.md),
              Expanded(
                child: Text(
                  'Gentle note: logging consistently helps surface more meaningful cycle predictions and wellness insights.',
                  style: WellnessTextStyles.bodyFor(Get.context!).copyWith(
                    color: WellnessColors.textSecondaryFor(
                      Theme.of(Get.context!).brightness,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: WellnessSpacing.md,
      runSpacing: WellnessSpacing.md,
      children: [
        if (controller.isEditMode)
          WellnessSecondaryButton(
            label: WellnessConstants.deletePeriod,
            icon: Icons.delete_outline,
            onPressed: controller.isDeleting.value
                ? null
                : () => _confirmDelete(context),
          ),
        WellnessPrimaryButton(
          label: controller.isSaving.value
              ? WellnessConstants.saving
              : WellnessConstants.savePeriod,
          icon: Icons.save_outlined,
          onPressed: controller.isSaving.value ? null : controller.save,
        ),
      ],
    );
  }

  Future<void> _confirmDelete(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => WellnessConfirmDialog(
        title: WellnessConstants.deletePeriodTitle,
        message: WellnessConstants.deletePeriodConfirmation,
        onConfirm: () {
          Navigator.pop(context);
          controller.deleteCurrentEntry();
        },
      ),
    );
  }
}
