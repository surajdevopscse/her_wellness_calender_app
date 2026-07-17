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

  Future<void> showLanguageOptions() {
    return Get.dialog<void>(
      AlertDialog(
        title: const Text('Language'),
        content: const ListTile(
          leading: Icon(Icons.check_circle_outline),
          title: Text('English'),
          subtitle: Text('More languages can be added from settings later.'),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text(WellnessConstants.close),
          ),
        ],
      ),
    );
  }

  Future<void> showPrivacyPolicy() {
    return _showInfoDialog(
      title: 'Privacy policy',
      body:
          'Your cycle dates, symptoms, daily logs, reminders, and profile details are used only to provide tracking, predictions, reports, reminders, and privacy controls inside this app. You can update, export, or delete wellness data from the app settings. We do not use wellness data for advertising.',
    );
  }

  Future<void> showTerms() {
    return _showInfoDialog(
      title: 'Terms and conditions',
      body:
          'This app helps you track wellness patterns and cycle estimates. It is not medical advice, contraception guidance, diagnosis, or treatment. For severe pain, unusually heavy bleeding, pregnancy concerns, fever, fainting, or symptoms that feel unsafe or unusual, contact a qualified healthcare professional.',
    );
  }

  Future<void> _showInfoDialog({required String title, required String body}) {
    return Get.dialog<void>(
      AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(body)),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text(WellnessConstants.close),
          ),
        ],
      ),
    );
  }
}
