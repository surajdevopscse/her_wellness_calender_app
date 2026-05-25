import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/enums/wellness_enums.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/entities/symptom_item.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/usecases/get_symptoms_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/symptoms/domain/usecases/save_selected_symptoms_usecase.dart';

/// View model for searching, selecting, and returning symptoms.
class SymptomsController extends GetxController {
  SymptomsController(this.getSymptomsUseCase, this.saveSelectedSymptomsUseCase);

  final GetSymptomsUseCase getSymptomsUseCase;
  final SaveSelectedSymptomsUseCase saveSelectedSymptomsUseCase;

  final symptoms = <SymptomItem>[].obs;
  final selectedSymptoms = <SymptomItem>{}.obs;
  final searchController = TextEditingController();
  final customSymptomController = TextEditingController();
  final searchQuery = ''.obs;
  final isLoading = false.obs;
  final isSaving = false.obs;
  final errorMessage = ''.obs;

  List<SymptomItem> get filteredSymptoms {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return symptoms;
    return symptoms
        .where((item) => item.label.toLowerCase().contains(query))
        .toList();
  }

  List<SymptomItem> get recentlyUsedSymptoms =>
      symptoms.where((item) => item.isRecentlyUsed).toList();

  List<SymptomType> get selectedSymptomTypes => selectedSymptoms
      .map((item) => item.type)
      .whereType<SymptomType>()
      .toList();

  @override
  void onReady() {
    super.onReady();
    load();
  }

  /// Loads symptom catalog and hydrates any initial selected symptoms.
  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final loaded = await getSymptomsUseCase();
      symptoms.assignAll(loaded);
      _hydrateInitialSelection();
    } catch (_) {
      errorMessage.value = WellnessConstants.symptomsLoadError;
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void toggle(SymptomItem symptom) {
    selectedSymptoms.contains(symptom)
        ? selectedSymptoms.remove(symptom)
        : selectedSymptoms.add(symptom);
  }

  void addCustomSymptom() {
    final label = customSymptomController.text.trim();
    if (label.isEmpty) return;
    final item = SymptomItem(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      label: label,
      isCustom: true,
      isRecentlyUsed: true,
    );
    symptoms.insert(0, item);
    selectedSymptoms.add(item);
    customSymptomController.clear();
  }

  /// Saves selection and returns selected symptom types to the caller.
  Future<void> completeSelection() async {
    isSaving.value = true;
    errorMessage.value = '';
    try {
      await saveSelectedSymptomsUseCase(selectedSymptoms.toList());
      Get.back<List<SymptomType>>(result: selectedSymptomTypes);
    } catch (_) {
      errorMessage.value = WellnessConstants.symptomsSaveError;
    } finally {
      isSaving.value = false;
    }
  }

  void _hydrateInitialSelection() {
    final args = Get.arguments;
    if (args is Iterable<SymptomType>) {
      selectedSymptoms.assignAll(
        symptoms.where((item) => item.type != null && args.contains(item.type)),
      );
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    customSymptomController.dispose();
    super.onClose();
  }
}
