import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/settings/domain/entities/app_settings.dart';
import 'package:her_wellness_calender/features/women_wellness/settings/domain/repositories/settings_repository.dart';

/// Global theme mode controller for light/dark/system.
class ThemeController extends GetxController {
  ThemeController(this.settingsRepository);

  final SettingsRepository settingsRepository;
  final themeMode = AppThemeMode.system.obs;

  ThemeMode get materialThemeMode => switch (themeMode.value) {
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
        AppThemeMode.system => ThemeMode.system,
      };

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    final settings = await settingsRepository.getSettings();
    themeMode.value = settings.themeMode;
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    themeMode.value = mode;
    final current = await settingsRepository.getSettings();
    await settingsRepository.updateSettings(current.copyWith(themeMode: mode));
    Get.changeThemeMode(materialThemeMode);
  }
}
