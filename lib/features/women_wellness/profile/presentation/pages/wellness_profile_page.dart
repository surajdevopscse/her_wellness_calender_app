import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_app_bar.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_background.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_empty_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_error_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_loading_view.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/presentation/controllers/wellness_profile_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/presentation/widgets/profile_form_card.dart';

/// Responsive profile page for editing cycle baseline details.
class WellnessProfilePage extends GetView<WellnessProfileController> {
  const WellnessProfilePage({super.key, this.showScaffold = true});

  final bool showScaffold;

  @override
  Widget build(BuildContext context) {
    final content = WellnessBackground(child: _buildBody(context));
    if (!showScaffold) return content;
    return Scaffold(
      appBar: const WellnessAppBar(title: WellnessConstants.profileTitle),
      body: content,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const WellnessLoadingView();
      }
      if (controller.errorMessage.value.isNotEmpty &&
          controller.profile.value == null) {
        return WellnessErrorState(
          message: controller.errorMessage.value,
          onRetry: controller.load,
        );
      }
      if (controller.profile.value == null) {
        return const WellnessEmptyState(
          message: WellnessConstants.profileEmpty,
          icon: Icons.person_outline,
        );
      }
      return _buildFormContent(context);
    });
  }

  Widget _buildFormContent(BuildContext context) {
    return SingleChildScrollView(
      padding: WellnessResponsive.pagePadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: WellnessSpacing.pageMaxWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (controller.errorMessage.value.isNotEmpty) ...[
                WellnessCard(
                  child: Text(
                    controller.errorMessage.value,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
              ],
              ProfileFormCard(
                formKey: controller.formKey,
                ageGroup: controller.ageGroup.value,
                averageCycleLengthController:
                    controller.averageCycleLengthController,
                averagePeriodLengthController:
                    controller.averagePeriodLengthController,
                healthNotesController: controller.healthNotesController,
                lastPeriodStartDate:
                    controller.selectedLastPeriodStartDate.value,
                isSaving: controller.isSaving.value,
                onAgeGroupChanged: (value) => controller.ageGroup.value = value,
                onPickLastPeriodDate: () => _pickLastPeriodDate(context),
                onSave: controller.save,
                validateCycleLength: controller.validateCycleLength,
                validatePeriodLength: controller.validatePeriodLength,
              ),
              const SizedBox(height: WellnessSpacing.lg),
              const WellnessCard(
                child: Text(WellnessConstants.medicalDisclaimer),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickLastPeriodDate(BuildContext context) async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: controller.selectedLastPeriodStartDate.value ?? now,
      firstDate: DateTime(now.year - 10),
      lastDate: now,
    );
    if (selected != null) {
      controller.updateLastPeriodStartDate(selected);
    }
  }
}
