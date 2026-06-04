import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/authentication/authentication_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/logout_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/core/routes/wellness_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/core/services/theme_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/domain/entities/app_settings.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/domain/repositories/settings_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/core/errors/exceptions.dart';

class SettingsController extends GetxController {
  SettingsController(this.settingsRepository, this.logoutUseCase);

  final SettingsRepository settingsRepository;
  final LogoutUseCase logoutUseCase;
  final isLoading = false.obs;
  final isLoggingOut = false.obs;
  final errorMessage = ''.obs;
  final settings = Rxn<AppSettings>();

  ThemeController get themeController => Get.find<ThemeController>();

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      settings.value = await settingsRepository.getSettings();
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = WellnessConstants.settingsLoadError;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTheme(AppThemeMode mode) async {
    await themeController.setThemeMode(mode);
    settings.value = settings.value?.copyWith(themeMode: mode);
  }

  Future<void> toggleNotifications(bool value) async {
    final current = settings.value;
    if (current == null) return;
    final updated = current.copyWith(notificationsEnabled: value);
    settings.value = updated;
    errorMessage.value = '';
    try {
      settings.value = await settingsRepository.updateSettings(updated);
    } on AppException catch (error) {
      settings.value = current;
      errorMessage.value = error.message;
    } catch (_) {
      settings.value = current;
      errorMessage.value = WellnessConstants.settingsSaveError;
    }
  }

  Future<void> confirmLogout() async {
    if (isLoggingOut.value) return;
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text(WellnessConstants.logoutTitle),
        content: const Text(WellnessConstants.logoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text(WellnessConstants.cancel),
          ),
          FilledButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
    if (confirmed == true) await logout();
  }

  Future<void> logout() async {
    isLoggingOut.value = true;
    errorMessage.value = '';
    try {
      await logoutUseCase();
      Get.offAllNamed(AuthenticationRoutes.login);
    } on AppException catch (error) {
      errorMessage.value = error.message;
      Get.snackbar(
        WellnessConstants.logoutTitle,
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      errorMessage.value = WellnessConstants.logoutError;
      Get.snackbar(
        WellnessConstants.logoutTitle,
        WellnessConstants.logoutError,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoggingOut.value = false;
    }
  }

  void openPrivacy() => Get.toNamed(WellnessRoutes.privacy);
  void openProfile() => Get.toNamed(WellnessRoutes.profile);
  void openExport() => Get.toNamed(WellnessRoutes.dataExport);
  void openBackup() => Get.toNamed(WellnessRoutes.backupRestore);
  void openNotifications() => Get.toNamed(WellnessRoutes.notifications);
}
