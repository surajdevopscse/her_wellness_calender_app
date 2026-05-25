import 'package:her_wellness_calender/core/storage/mock_asset_loader.dart';
import 'package:her_wellness_calender/core/storage/storage_service.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_storage_keys.dart';

class SettingsMockDatasource {
  const SettingsMockDatasource(this.assetLoader, this.storageService);

  static const assetPath = 'assets/mock/app_settings.json';

  final MockAssetLoader assetLoader;
  final StorageService storageService;

  Future<Map<String, dynamic>> loadDefaults() => assetLoader.loadMap(assetPath);

  String? readThemeMode() => storageService.getString(WellnessStorageKeys.themeMode);

  Future<void> saveThemeMode(String mode) =>
      storageService.setString(WellnessStorageKeys.themeMode, mode);
}
