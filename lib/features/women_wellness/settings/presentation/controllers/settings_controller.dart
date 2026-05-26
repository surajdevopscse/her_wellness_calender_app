import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/authentication/authentication_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/usecases/logout_usecase.dart';
import 'package:her_wellness_calender/features/women_wellness/core/routes/wellness_routes.dart';
import 'package:her_wellness_calender/features/women_wellness/core/services/theme_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/domain/entities/app_settings.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/domain/repositories/settings_repository.dart';

class SettingsController extends GetxController {
  SettingsController(this.settingsRepository, this.logoutUseCase);

  final SettingsRepository settingsRepository;
  final LogoutUseCase logoutUseCase;
  final isLoading = false.obs;
  final settings = Rxn<AppSettings>();

  ThemeController get themeController => Get.find<ThemeController>();

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    settings.value = await settingsRepository.getSettings();
    isLoading.value = false;
  }

  Future<void> updateTheme(AppThemeMode mode) async {
    await themeController.setThemeMode(mode);
    settings.value = settings.value?.copyWith(themeMode: mode);
  }

  Future<void> toggleNotifications(bool value) async {
    final current = settings.value;
    if (current == null) return;
    final updated = current.copyWith(notificationsEnabled: value);
    settings.value = await settingsRepository.updateSettings(updated);
  }

  Future<void> logout() async {
    await logoutUseCase();
    Get.offAllNamed(AuthenticationRoutes.login);
  }

  void openPrivacy() => Get.toNamed(WellnessRoutes.privacy);
  void openProfile() => Get.toNamed(WellnessRoutes.profile);
  void openExport() => Get.toNamed(WellnessRoutes.dataExport);
  void openBackup() => Get.toNamed(WellnessRoutes.backupRestore);
  void openNotifications() => Get.toNamed(WellnessRoutes.notifications);
}
