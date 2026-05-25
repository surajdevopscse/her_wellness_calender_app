import 'package:flutter/material.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_primary_button.dart';

/// Responsive card that renders editable wellness profile fields.
class ProfileFormCard extends StatelessWidget {
  const ProfileFormCard({
    super.key,
    required this.formKey,
    required this.ageGroup,
    required this.averageCycleLengthController,
    required this.averagePeriodLengthController,
    required this.healthNotesController,
    required this.lastPeriodStartDate,
    required this.isSaving,
    required this.onAgeGroupChanged,
    required this.onPickLastPeriodDate,
    required this.onSave,
    required this.validateCycleLength,
    required this.validatePeriodLength,
  });

  final GlobalKey<FormState> formKey;
  final String? ageGroup;
  final TextEditingController averageCycleLengthController;
  final TextEditingController averagePeriodLengthController;
  final TextEditingController healthNotesController;
  final DateTime? lastPeriodStartDate;
  final bool isSaving;
  final ValueChanged<String?> onAgeGroupChanged;
  final VoidCallback onPickLastPeriodDate;
  final VoidCallback onSave;
  final FormFieldValidator<String> validateCycleLength;
  final FormFieldValidator<String> validatePeriodLength;

  @override
  Widget build(BuildContext context) {
    final isWide = !WellnessResponsive.isMobile(context);
    final fields = [
      DropdownButtonFormField<String>(
        initialValue: ageGroup,
        decoration: const InputDecoration(
          labelText: WellnessConstants.ageGroup,
          hintText: WellnessConstants.ageGroupHint,
        ),
        items: WellnessConstants.ageGroups
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: isSaving ? null : onAgeGroupChanged,
      ),
      TextFormField(
        controller: averageCycleLengthController,
        enabled: !isSaving,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: WellnessConstants.averageCycleLength,
          suffixText: WellnessConstants.days,
        ),
        validator: validateCycleLength,
      ),
      TextFormField(
        controller: averagePeriodLengthController,
        enabled: !isSaving,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: WellnessConstants.averagePeriodLength,
          suffixText: WellnessConstants.days,
        ),
        validator: validatePeriodLength,
      ),
      InkWell(
        onTap: isSaving ? null : onPickLastPeriodDate,
        borderRadius: BorderRadius.circular(WellnessSpacing.controlRadius),
        child: InputDecorator(
          decoration: const InputDecoration(
            labelText: WellnessConstants.lastPeriodStartDate,
            suffixIcon: Icon(Icons.calendar_month_outlined),
          ),
          child: Text(
            lastPeriodStartDate == null
                ? WellnessConstants.selectDate
                : WellnessDateHelper.formatShort(lastPeriodStartDate!),
          ),
        ),
      ),
    ];

    return WellnessCard(
      padding: const EdgeInsets.all(WellnessSpacing.xl),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              WellnessConstants.profileFormTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: WellnessSpacing.xs),
            Text(
              WellnessConstants.profileFormSubtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: WellnessSpacing.xl),
            if (isWide)
              LayoutBuilder(
                builder: (context, constraints) {
                  final fieldWidth = WellnessResponsive.adaptiveFieldWidth(
                    context,
                    constraints.maxWidth,
                  );
                  return Wrap(
                    spacing: WellnessSpacing.lg,
                    runSpacing: WellnessSpacing.lg,
                    children: [
                      for (final field in fields)
                        SizedBox(width: fieldWidth, child: field),
                    ],
                  );
                },
              )
            else
              Column(
                children: [
                  for (final field in fields) ...[
                    field,
                    const SizedBox(height: WellnessSpacing.lg),
                  ],
                ],
              ),
            const SizedBox(height: WellnessSpacing.lg),
            TextFormField(
              controller: healthNotesController,
              enabled: !isSaving,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: WellnessConstants.healthNotes,
                hintText: WellnessConstants.healthNotesHint,
              ),
            ),
            const SizedBox(height: WellnessSpacing.xl),
            Align(
              alignment: Alignment.centerRight,
              child: WellnessPrimaryButton(
                label: isSaving
                    ? WellnessConstants.saving
                    : WellnessConstants.save,
                icon: Icons.save_outlined,
                onPressed: isSaving ? null : onSave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
