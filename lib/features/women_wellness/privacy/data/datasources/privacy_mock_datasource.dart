import 'package:her_wellness_calender/core/storage/mock_asset_loader.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Reads privacy settings from JSON mock data shaped like the future API.
class PrivacyMockDatasource {
  const PrivacyMockDatasource(this.assetLoader);

  final MockAssetLoader assetLoader;

  Future<Map<String, dynamic>> getSettings() {
    return assetLoader.loadMap(WellnessConstants.privacyMockAsset);
  }

  Future<Map<String, dynamic>> updateSettings(Map<String, dynamic> settings) {
    return Future.value({
      'success': true,
      'message': WellnessConstants.privacySaveSuccess,
      'data': settings,
    });
  }

  Future<Map<String, dynamic>> deleteWellnessData() {
    return Future.value({
      'success': true,
      'message': WellnessConstants.wellnessDataDeleted,
      'data': {'deleted': true, 'accountDeleted': false},
    });
  }

  Future<Map<String, dynamic>> deleteAccountAndData() {
    return Future.value({
      'success': true,
      'message': WellnessConstants.accountAndDataDeleted,
      'data': {'deleted': true, 'accountDeleted': true},
    });
  }
}
