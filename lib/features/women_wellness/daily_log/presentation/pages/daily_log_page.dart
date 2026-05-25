import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_confirm_dialog.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_error_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_insight_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_loading_view.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_primary_button.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_secondary_button.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_section_card.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/presentation/controllers/daily_log_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/presentation/widgets/energy_selector.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/presentation/widgets/flow_selector.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/presentation/widgets/mood_selector.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/presentation/widgets/pain_level_selector.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/presentation/widgets/sleep_quality_selector.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/presentation/widgets/water_intake_stepper.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/presentation/widgets/symptom_chip.dart';

/// Daily log screen for flow, pain, mood, symptoms, habits, and notes.
class DailyLogPage extends GetView<DailyLogController> {
  const DailyLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.logs.isEmpty) {
        return const WellnessLoadingView();
      }
      if (controller.errorMessage.value.isNotEmpty && controller.logs.isEmpty) {
        return WellnessErrorState(
          message: controller.errorMessage.value,
          onRetry: controller.loadLogs,
        );
      }

      final isMobile = WellnessResponsive.isMobile(context);
      return Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: isMobile ? _buildMobileActions(context) : null,
        body: SingleChildScrollView(
          padding: WellnessResponsive.pagePadding(context),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: WellnessSpacing.pageMaxWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WellnessCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.isEditMode
                              ? 'Reflect on how your body felt'
                              : 'Capture today with more care',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: WellnessSpacing.sm),
                        Text(
                          'Mood, pain, sleep, hydration, and notes come together here so your trends feel more human than clinical.',
                          style: WellnessTextStyles.bodyFor(context).copyWith(
                            color: WellnessColors.textSecondaryFor(
                              Theme.of(context).brightness,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: WellnessSpacing.lg),
                  const WellnessInsightCard(
                    title: 'A gentler habit',
                    message:
                        'Even quick entries create stronger patterns for mood, pain, and symptom insights over time.',
                    icon: Icons.auto_awesome_rounded,
                    tint: WellnessColors.secondary,
                  ),
                  const SizedBox(height: WellnessSpacing.lg),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final useColumns = WellnessResponsive.useComfortableColumns(
                        context,
                        constraints.maxWidth,
                      );
                      if (!useColumns) {
                        return _buildSingleColumn(context);
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildPrimaryColumn(context)),
                          const SizedBox(width: WellnessSpacing.xl),
                          Expanded(child: _buildSecondaryColumn(context)),
                        ],
                      );
                    },
                  ),
                  if (controller.message.value.isNotEmpty) ...[
                    const SizedBox(height: WellnessSpacing.lg),
                    WellnessCard(
                      child: Text(
                        controller.message.value,
                        style: TextStyle(
                          color: controller.message.value ==
                                  WellnessConstants.dailyLogSaved
                              ? WellnessColors.success
                              : Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                  if (!isMobile) ...[
                    const SizedBox(height: WellnessSpacing.xl),
                    _buildDesktopActions(context),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSingleColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildPrimaryColumn(context),
        const SizedBox(height: WellnessSpacing.lg),
        _buildSecondaryColumn(context),
      ],
    );
  }

  Widget _buildPrimaryColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        WellnessSectionCard(
          title: 'Cycle signals',
          subtitle: 'Flow, pain, mood, and symptoms',
          icon: Icons.favorite_outline_rounded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDateSelector(context),
              const SizedBox(height: WellnessSpacing.lg),
              _buildSectionLabel(context, WellnessConstants.flow),
              FlowSelector(
                value: controller.flow.value,
                onChanged: (value) => controller.flow.value = value,
              ),
              const SizedBox(height: WellnessSpacing.lg),
              _buildSectionLabel(context, WellnessConstants.pain),
              PainLevelSelector(
                value: controller.pain.value,
                onChanged: (value) => controller.pain.value = value,
              ),
              const SizedBox(height: WellnessSpacing.lg),
              _buildSectionLabel(context, WellnessConstants.mood),
              MoodSelector(
                value: controller.mood.value,
                onChanged: (value) => controller.mood.value = value,
              ),
              const SizedBox(height: WellnessSpacing.lg),
              _buildSectionLabel(context, WellnessConstants.symptoms),
              Wrap(
                spacing: WellnessSpacing.sm,
                runSpacing: WellnessSpacing.sm,
                children: SymptomType.values
                    .map(
                      (symptom) => SymptomChip.fromSymptomType(
                        symptom: symptom,
                        selected: controller.symptoms.contains(symptom),
                        onSelected: (_) => controller.toggleSymptom(symptom),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: WellnessSpacing.md),
              Align(
                alignment: Alignment.centerLeft,
                child: WellnessSecondaryButton(
                  label: WellnessConstants.symptomsSelectionTitle,
                  icon: Icons.tune_outlined,
                  onPressed: controller.selectSymptoms,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        WellnessSectionCard(
          title: 'Daily wellbeing',
          subtitle: 'Energy, rest, hydration, and care notes',
          icon: Icons.spa_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionLabel(context, WellnessConstants.energy),
              EnergySelector(
                value: controller.energy.value,
                onChanged: (value) => controller.energy.value = value,
              ),
              const SizedBox(height: WellnessSpacing.lg),
              _buildSectionLabel(context, WellnessConstants.sleep),
              SleepQualitySelector(
                value: controller.sleep.value,
                onChanged: (value) => controller.sleep.value = value,
              ),
              const SizedBox(height: WellnessSpacing.lg),
              _buildSectionLabel(context, WellnessConstants.waterIntake),
              WaterIntakeStepper(
                value: controller.water.value,
                onChanged: (value) => controller.water.value = value,
              ),
              const SizedBox(height: WellnessSpacing.md),
              SwitchListTile(
                value: controller.medicineTaken.value,
                onChanged: (value) => controller.medicineTaken.value = value,
                title: const Text(WellnessConstants.medicineTaken),
                subtitle: const Text('Add a note when medication is part of your day.'),
                contentPadding: EdgeInsets.zero,
              ),
              TextField(
                controller: controller.medicineNameController,
                enabled: controller.medicineTaken.value,
                decoration: const InputDecoration(
                  labelText: WellnessConstants.medicineName,
                ),
              ),
              const SizedBox(height: WellnessSpacing.lg),
              TextField(
                controller: controller.notesController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: WellnessConstants.customNotes,
                  hintText: WellnessConstants.customNotesHint,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: WellnessSpacing.sm),
      child: Text(label, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return InkWell(
      onTap: () => _pickDate(context),
      borderRadius: BorderRadius.circular(WellnessSpacing.controlRadius),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: WellnessConstants.logDate,
          suffixIcon: Icon(Icons.calendar_month_outlined),
        ),
        child: Text(
          WellnessDateHelper.formatShort(controller.selectedDate.value),
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final value = controller.selectedDate.value;
    final selected = await showDatePicker(
      context: context,
      initialDate: value,
      firstDate: DateTime(value.year - 10),
      lastDate: DateTime(value.year + 1),
    );
    if (selected != null) controller.updateLogDate(selected);
  }

  Widget _buildDesktopActions(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: WellnessSpacing.md,
      runSpacing: WellnessSpacing.md,
      children: [
        if (controller.isEditMode)
          WellnessSecondaryButton(
            label: WellnessConstants.deleteDailyLog,
            icon: Icons.delete_outline,
            onPressed: controller.isDeleting.value
                ? null
                : () => _confirmDelete(context),
          ),
        WellnessPrimaryButton(
          label: controller.isSaving.value
              ? WellnessConstants.saving
              : WellnessConstants.saveDailyLog,
          icon: Icons.save_outlined,
          onPressed: controller.isSaving.value ? null : controller.save,
        ),
      ],
    );
  }

  Widget _buildMobileActions(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(WellnessSpacing.lg),
        child: Row(
          children: [
            if (controller.isEditMode) ...[
              Expanded(
                child: WellnessSecondaryButton(
                  label: WellnessConstants.delete,
                  icon: Icons.delete_outline,
                  onPressed: controller.isDeleting.value
                      ? null
                      : () => _confirmDelete(context),
                ),
              ),
              const SizedBox(width: WellnessSpacing.md),
            ],
            Expanded(
              child: WellnessPrimaryButton(
                label: controller.isSaving.value
                    ? WellnessConstants.saving
                    : WellnessConstants.saveDailyLog,
                icon: Icons.save_outlined,
                onPressed: controller.isSaving.value ? null : controller.save,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => WellnessConfirmDialog(
        title: WellnessConstants.deleteDailyLogTitle,
        message: WellnessConstants.deleteDailyLogConfirmation,
        onConfirm: () {
          Navigator.pop(context);
          controller.deleteCurrentLog();
        },
      ),
    );
  }
}
