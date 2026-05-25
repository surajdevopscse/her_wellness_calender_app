import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_validators.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/entities/wellness_profile.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/usecases/get_wellness_profile_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/usecases/update_wellness_profile_usecase.dart';

/// View model for profile form state, validation, loading, and persistence.
class WellnessProfileController extends GetxController {
  WellnessProfileController(
    this._getProfileUseCase,
    this._updateProfileUseCase,
  );

  final GetWellnessProfileUseCase _getProfileUseCase;
  final UpdateWellnessProfileUseCase _updateProfileUseCase;

  final formKey = GlobalKey<FormState>();
  final ageGroup = RxnString();
  final selectedLastPeriodStartDate = Rxn<DateTime>();
  final averageCycleLengthController = TextEditingController();
  final averagePeriodLengthController = TextEditingController();
  final healthNotesController = TextEditingController();
  final profile = Rxn<WellnessProfile>();
  final isLoading = false.obs;
  final isSaving = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  /// Loads the saved profile and hydrates form fields.
  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final loadedProfile = await _getProfileUseCase();
      profile.value = loadedProfile;
      if (loadedProfile != null) {
        _bindProfileToForm(loadedProfile);
      }
    } catch (_) {
      errorMessage.value = WellnessConstants.profileLoadError;
    } finally {
      isLoading.value = false;
    }
  }

  /// Updates the selected last-period date from the date picker.
  void updateLastPeriodStartDate(DateTime value) {
    selectedLastPeriodStartDate.value = WellnessDateHelper.dateOnly(value);
  }

  /// Validates and saves edited profile fields.
  Future<void> save() async {
    final current = profile.value;
    if (current == null) return;
    if (!(formKey.currentState?.validate() ?? false)) return;

    final lastPeriodStart = selectedLastPeriodStartDate.value;
    final dateError = WellnessValidators.validateDateNotInFuture(
      lastPeriodStart,
    );
    if (dateError != null) {
      errorMessage.value = dateError;
      return;
    }

    isSaving.value = true;
    errorMessage.value = '';
    try {
      final updated = current.copyWith(
        ageGroup: ageGroup.value,
        averageCycleLength: int.parse(averageCycleLengthController.text),
        averagePeriodLength: int.parse(averagePeriodLengthController.text),
        lastPeriodStartDate: lastPeriodStart,
        healthNotes: healthNotesController.text.trim().isEmpty
            ? null
            : healthNotesController.text.trim(),
      );
      profile.value = await _updateProfileUseCase(updated);
      Get.snackbar(
        WellnessConstants.profileTitle,
        WellnessConstants.profileSaveSuccess,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      errorMessage.value = error is ArgumentError
          ? error.message.toString()
          : WellnessConstants.profileSaveError;
    } finally {
      isSaving.value = false;
    }
  }

  String? validateCycleLength(String? value) {
    final parsed = int.tryParse(value ?? '');
    if (parsed == null) return WellnessConstants.requiredField;
    return WellnessValidators.validateCycleLength(parsed);
  }

  String? validatePeriodLength(String? value) {
    final parsed = int.tryParse(value ?? '');
    if (parsed == null) return WellnessConstants.requiredField;
    return WellnessValidators.validatePeriodLength(parsed);
  }

  void _bindProfileToForm(WellnessProfile value) {
    ageGroup.value = value.ageGroup;
    selectedLastPeriodStartDate.value = value.lastPeriodStartDate;
    averageCycleLengthController.text = '${value.averageCycleLength}';
    averagePeriodLengthController.text = '${value.averagePeriodLength}';
    healthNotesController.text = value.healthNotes ?? '';
  }

  @override
  void onClose() {
    averageCycleLengthController.dispose();
    averagePeriodLengthController.dispose();
    healthNotesController.dispose();
    super.onClose();
  }
}
