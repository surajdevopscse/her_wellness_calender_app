import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/entities/privacy_settings.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/usecases/delete_wellness_data_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/usecases/get_privacy_settings_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/usecases/update_privacy_settings_usecase.dart';

/// View model for privacy settings, save state, and delete actions.
class PrivacySettingsController extends GetxController {
  PrivacySettingsController(
    this.getPrivacySettingsUseCase,
    this.updatePrivacySettingsUseCase,
    this.deleteWellnessDataUseCase,
  );

  final GetPrivacySettingsUseCase getPrivacySettingsUseCase;
  final UpdatePrivacySettingsUseCase updatePrivacySettingsUseCase;
  final DeleteWellnessDataUseCase deleteWellnessDataUseCase;

  final isLoading = false.obs;
  final isSaving = false.obs;
  final isDeleting = false.obs;
  final errorMessage = ''.obs;
  final settings = Rxn<PrivacySettings>();

  @override
  void onReady() {
    super.onReady();
    load();
  }

  /// Loads privacy settings without logging sensitive user data.
  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      settings.value = await getPrivacySettingsUseCase();
    } catch (_) {
      errorMessage.value = WellnessConstants.privacyLoadError;
    } finally {
      isLoading.value = false;
    }
  }

  /// Optimistically saves a settings update and rolls back on failure.
  Future<void> saveSettings(PrivacySettings next) async {
    final previous = settings.value;
    settings.value = next;
    isSaving.value = true;
    errorMessage.value = '';
    try {
      settings.value = await updatePrivacySettingsUseCase(next);
    } catch (_) {
      settings.value = previous;
      errorMessage.value = WellnessConstants.privacySaveError;
    } finally {
      isSaving.value = false;
    }
  }

  /// Deletes wellness tracking data through a privacy-safe repository action.
  Future<void> deleteWellnessData({bool includeAccount = false}) async {
    isDeleting.value = true;
    errorMessage.value = '';
    try {
      await deleteWellnessDataUseCase(includeAccount: includeAccount);
      Get.snackbar(
        WellnessConstants.privacyTitle,
        includeAccount
            ? WellnessConstants.accountAndDataDeleted
            : WellnessConstants.wellnessDataDeleted,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      errorMessage.value = WellnessConstants.error;
    } finally {
      isDeleting.value = false;
    }
  }
}
