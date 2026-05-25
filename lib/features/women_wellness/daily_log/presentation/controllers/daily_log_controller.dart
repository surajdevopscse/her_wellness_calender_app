import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_date_helper.dart';
import 'package:her_wellness_calender/features/women_wellness/core/routes/wellness_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/entities/daily_log.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/usecases/add_daily_log_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/usecases/delete_daily_log_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/usecases/get_daily_logs_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/daily_log/domain/usecases/update_daily_log_usecase.dart';

/// View model for daily log history and add/edit/delete form state.
class DailyLogController extends GetxController {
  DailyLogController(
    this.getLogsUseCase,
    this.addUseCase,
    this.updateUseCase,
    this.deleteUseCase,
  );

  final GetDailyLogsUseCase getLogsUseCase;
  final AddDailyLogUseCase addUseCase;
  final UpdateDailyLogUseCase updateUseCase;
  final DeleteDailyLogUseCase deleteUseCase;

  final logs = <DailyLog>[].obs;
  final editingLog = Rxn<DailyLog>();
  final selectedDate = DateTime.now().obs;
  final flow = FlowLevel.medium.obs;
  final pain = PainLevel.mild.obs;
  final mood = MoodType.happy.obs;
  final energy = EnergyLevel.normal.obs;
  final sleep = SleepQuality.good.obs;
  final symptoms = <SymptomType>{}.obs;
  final water = 6.obs;
  final medicineTaken = false.obs;
  final medicineNameController = TextEditingController();
  final notesController = TextEditingController();
  final isLoading = false.obs;
  final isSaving = false.obs;
  final isDeleting = false.obs;
  final message = ''.obs;
  final errorMessage = ''.obs;

  bool get isEditMode => editingLog.value != null;

  @override
  void onReady() {
    super.onReady();
    loadLogs();
    bindLog(Get.arguments is DailyLog ? Get.arguments as DailyLog : null);
  }

  /// Loads log history for future list/edit flows.
  Future<void> loadLogs() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      logs.assignAll(await getLogsUseCase());
    } catch (_) {
      errorMessage.value = WellnessConstants.dailyLogLoadError;
    } finally {
      isLoading.value = false;
    }
  }

  /// Binds an existing log for edit mode, or resets add mode defaults.
  void bindLog(DailyLog? log) {
    editingLog.value = log;
    selectedDate.value = log?.logDate ?? DateTime.now();
    flow.value = log?.flow ?? FlowLevel.medium;
    pain.value = log?.painLevel ?? PainLevel.mild;
    mood.value = log?.mood ?? MoodType.happy;
    energy.value = log?.energyLevel ?? EnergyLevel.normal;
    sleep.value = log?.sleepQuality ?? SleepQuality.good;
    symptoms.assignAll(log?.symptoms ?? const []);
    water.value = log?.waterIntakeGlass ?? 6;
    medicineTaken.value = log?.medicineTaken ?? false;
    medicineNameController.text = log?.medicineName ?? '';
    notesController.text = log?.customNotes ?? '';
    message.value = '';
  }

  void updateLogDate(DateTime value) {
    selectedDate.value = WellnessDateHelper.dateOnly(value);
  }

  void toggleSymptom(SymptomType symptom) {
    symptoms.contains(symptom)
        ? symptoms.remove(symptom)
        : symptoms.add(symptom);
  }

  /// Opens the Symptoms feature and replaces the current symptom selection.
  Future<void> selectSymptoms() async {
    final selected = await Get.toNamed<List<SymptomType>>(
      WellnessRoutes.symptoms,
      arguments: symptoms.toList(),
    );
    if (selected != null) {
      symptoms.assignAll(selected);
    }
  }

  /// Validates medicine rules and saves a new or edited daily log.
  Future<void> save() async {
    final medicineName = medicineNameController.text.trim();
    if (medicineTaken.value && medicineName.isEmpty) {
      message.value = WellnessConstants.medicineNameRequired;
      return;
    }

    final current = editingLog.value;
    final log = DailyLog(
      id: current?.id ?? 'log_${DateTime.now().millisecondsSinceEpoch}',
      logDate: selectedDate.value,
      flow: flow.value,
      painLevel: pain.value,
      mood: mood.value,
      symptoms: symptoms.toList(),
      energyLevel: energy.value,
      sleepQuality: sleep.value,
      waterIntakeGlass: water.value,
      medicineTaken: medicineTaken.value,
      medicineName: medicineName.isEmpty ? null : medicineName,
      customNotes: notesController.text.trim().isEmpty
          ? null
          : notesController.text.trim(),
    );

    isSaving.value = true;
    message.value = '';
    try {
      final saved = current == null
          ? await addUseCase(log)
          : await updateUseCase(log);
      _upsertLog(saved);
      bindLog(saved);
      message.value = WellnessConstants.dailyLogSaved;
    } catch (error) {
      message.value = error is ArgumentError
          ? error.message.toString()
          : WellnessConstants.dailyLogSaveError;
    } finally {
      isSaving.value = false;
    }
  }

  /// Deletes the current edit log.
  Future<void> deleteCurrentLog() async {
    final current = editingLog.value;
    if (current == null) return;
    isDeleting.value = true;
    message.value = '';
    try {
      await deleteUseCase(current.id);
      logs.removeWhere((log) => log.id == current.id);
      bindLog(null);
      message.value = WellnessConstants.dailyLogDeleted;
    } catch (_) {
      message.value = WellnessConstants.error;
    } finally {
      isDeleting.value = false;
    }
  }

  void _upsertLog(DailyLog log) {
    final index = logs.indexWhere((item) => item.id == log.id);
    if (index == -1) {
      logs.insert(0, log);
    } else {
      logs[index] = log;
    }
  }

  @override
  void onClose() {
    medicineNameController.dispose();
    notesController.dispose();
    super.onClose();
  }
}
