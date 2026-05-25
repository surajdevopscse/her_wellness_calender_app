import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_validators.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/entities/period_entry.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/usecases/add_period_entry_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/usecases/delete_period_entry_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/usecases/get_period_history_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/period_tracking/domain/usecases/update_period_entry_usecase.dart';

/// View model for period history and add/edit/delete form state.
class PeriodEntryController extends GetxController {
  PeriodEntryController(
    this.getHistoryUseCase,
    this.addUseCase,
    this.updateUseCase,
    this.deleteUseCase,
  );

  final GetPeriodHistoryUseCase getHistoryUseCase;
  final AddPeriodEntryUseCase addUseCase;
  final UpdatePeriodEntryUseCase updateUseCase;
  final DeletePeriodEntryUseCase deleteUseCase;

  final history = <PeriodEntry>[].obs;
  final editingEntry = Rxn<PeriodEntry>();
  final startDate = Rxn<DateTime>();
  final endDate = Rxn<DateTime>();
  final irregularNoteController = TextEditingController();
  final notesController = TextEditingController();
  final isLoading = false.obs;
  final isSaving = false.obs;
  final isDeleting = false.obs;
  final message = ''.obs;
  final errorMessage = ''.obs;

  bool get isEditMode => editingEntry.value != null;

  int get calculatedPeriodLength {
    final start = startDate.value;
    final end = endDate.value;
    if (start == null) return 0;
    if (end == null) return 1;
    return WellnessDateHelper.daysBetween(start, end) + 1;
  }

  bool get hasLongPeriodWarning => calculatedPeriodLength > 10;

  @override
  void onReady() {
    super.onReady();
    loadHistory();
    bindEntry(
      Get.arguments is PeriodEntry ? Get.arguments as PeriodEntry : null,
    );
  }

  /// Loads period history from the repository for edit lookups and future lists.
  Future<void> loadHistory() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      history.assignAll(await getHistoryUseCase());
    } catch (_) {
      errorMessage.value = WellnessConstants.periodTrackingLoadError;
    } finally {
      isLoading.value = false;
    }
  }

  /// Sets start date when navigating from calendar day detail.
  void prefillStartDate(DateTime date) {
    bindEntry(null);
    startDate.value = WellnessDateHelper.dateOnly(date);
    endDate.value = null;
  }

  /// Binds an existing entry for edit mode, or resets the form for add mode.
  void bindEntry(PeriodEntry? entry) {
    editingEntry.value = entry;
    startDate.value = entry?.startDate;
    endDate.value = entry?.endDate;
    irregularNoteController.text = entry?.irregularCycleNote ?? '';
    notesController.text = entry?.notes ?? '';
    message.value = '';
  }

  void updateStartDate(DateTime value) {
    startDate.value = WellnessDateHelper.dateOnly(value);
  }

  void updateEndDate(DateTime? value) {
    endDate.value = value == null ? null : WellnessDateHelper.dateOnly(value);
  }

  /// Validates and saves a new or existing period entry.
  Future<void> save() async {
    final validationError = WellnessValidators.validatePeriodDates(
      startDate.value,
      endDate.value,
    );
    if (validationError != null) {
      message.value = validationError;
      return;
    }

    final current = editingEntry.value;
    final entry = PeriodEntry(
      id: current?.id ?? 'period_${DateTime.now().millisecondsSinceEpoch}',
      startDate: startDate.value!,
      endDate: endDate.value,
      isPredicted: current?.isPredicted ?? false,
      isConfirmed: true,
      irregularCycleNote: irregularNoteController.text.trim().isEmpty
          ? null
          : irregularNoteController.text.trim(),
      notes: notesController.text.trim().isEmpty
          ? null
          : notesController.text.trim(),
    );

    isSaving.value = true;
    message.value = '';
    try {
      final saved = current == null
          ? await addUseCase(entry)
          : await updateUseCase(entry);
      _upsertHistory(saved);
      bindEntry(saved);
      message.value = saved.periodLength > 10
          ? WellnessConstants.unusuallyLongPeriod
          : WellnessConstants.periodEntrySaved;
    } catch (error) {
      message.value = error is ArgumentError
          ? error.message.toString()
          : WellnessConstants.periodTrackingSaveError;
    } finally {
      isSaving.value = false;
    }
  }

  /// Deletes the current edit entry after confirmation from the page.
  Future<void> deleteCurrentEntry() async {
    final current = editingEntry.value;
    if (current == null) return;
    isDeleting.value = true;
    message.value = '';
    try {
      await deleteUseCase(current.id);
      history.removeWhere((entry) => entry.id == current.id);
      bindEntry(null);
      message.value = WellnessConstants.periodEntryDeleted;
    } catch (_) {
      message.value = WellnessConstants.error;
    } finally {
      isDeleting.value = false;
    }
  }

  void _upsertHistory(PeriodEntry entry) {
    final index = history.indexWhere((item) => item.id == entry.id);
    if (index == -1) {
      history.insert(0, entry);
    } else {
      history[index] = entry;
    }
  }

  @override
  void onClose() {
    irregularNoteController.dispose();
    notesController.dispose();
    super.onClose();
  }
}
