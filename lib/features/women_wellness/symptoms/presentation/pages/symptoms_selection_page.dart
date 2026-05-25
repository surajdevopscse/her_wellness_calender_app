import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_empty_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_error_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_insight_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_loading_view.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_primary_button.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/entities/symptom_item.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/presentation/controllers/symptoms_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/presentation/widgets/symptom_chip.dart';

/// Symptoms multi-select screen with search and recent symptoms.
class SymptomsSelectionPage extends GetView<SymptomsController> {
  const SymptomsSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const WellnessLoadingView();
      }
      if (controller.errorMessage.value.isNotEmpty &&
          controller.symptoms.isEmpty) {
        return WellnessErrorState(
          message: controller.errorMessage.value,
          onRetry: controller.load,
        );
      }
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
                const WellnessInsightCard(
                  title: 'Name what your body is telling you',
                  message:
                      'Track the signals that matter most so your reports feel more honest, specific, and supportive.',
                  icon: Icons.eco_outlined,
                ),
                const SizedBox(height: WellnessSpacing.lg),
                WellnessCard(
                  padding: const EdgeInsets.all(WellnessSpacing.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        WellnessConstants.symptomsSelectionTitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: WellnessSpacing.lg),
                      TextField(
                        controller: controller.searchController,
                        onChanged: controller.updateSearch,
                        decoration: const InputDecoration(
                          hintText: WellnessConstants.symptomsSearchHint,
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(height: WellnessSpacing.lg),
                      if (controller.recentlyUsedSymptoms.isNotEmpty &&
                          controller.searchQuery.value.isEmpty) ...[
                        _buildSymptomSection(
                          context,
                          title: WellnessConstants.recentlyUsedSymptoms,
                          symptoms: controller.recentlyUsedSymptoms,
                        ),
                        const SizedBox(height: WellnessSpacing.lg),
                      ],
                      if (controller.filteredSymptoms.isEmpty)
                        const WellnessEmptyState(
                          message: WellnessConstants.symptomsEmpty,
                          icon: Icons.search_off,
                        )
                      else
                        _buildSymptomSection(
                          context,
                          title: WellnessConstants.allSymptoms,
                          symptoms: controller.filteredSymptoms,
                        ),
                      const SizedBox(height: WellnessSpacing.lg),
                      _buildCustomSymptomInput(context),
                      if (controller.errorMessage.value.isNotEmpty) ...[
                        const SizedBox(height: WellnessSpacing.md),
                        Text(
                          controller.errorMessage.value,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                      const SizedBox(height: WellnessSpacing.xl),
                      Align(
                        alignment: Alignment.centerRight,
                        child: WellnessPrimaryButton(
                          label: controller.isSaving.value
                              ? WellnessConstants.saving
                              : WellnessConstants.done,
                          icon: Icons.check,
                          onPressed: controller.isSaving.value
                              ? null
                              : controller.completeSelection,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSymptomSection(
    BuildContext context, {
    required String title,
    required List<SymptomItem> symptoms,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: WellnessSpacing.md),
        Wrap(
          spacing: WellnessSpacing.sm,
          runSpacing: WellnessSpacing.sm,
          children: symptoms
              .map(
                (symptom) => SymptomChip.fromItem(
                  item: symptom,
                  selected: controller.selectedSymptoms.contains(symptom),
                  onSelected: (_) => controller.toggle(symptom),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildCustomSymptomInput(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.customSymptomController,
            decoration: const InputDecoration(
              labelText: WellnessConstants.customSymptom,
              hintText: WellnessConstants.customSymptomHint,
            ),
            onSubmitted: (_) => controller.addCustomSymptom(),
          ),
        ),
        const SizedBox(width: WellnessSpacing.md),
        IconButton.filledTonal(
          tooltip: WellnessConstants.addCustomSymptom,
          onPressed: controller.addCustomSymptom,
          icon: const Icon(Icons.add),
          style: IconButton.styleFrom(
            backgroundColor: WellnessColors.primaryHot.withValues(alpha: 0.45),
            foregroundColor: WellnessColors.primaryDeep,
          ),
        ),
      ],
    );
  }
}
