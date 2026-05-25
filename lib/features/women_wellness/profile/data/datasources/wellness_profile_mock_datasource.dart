import 'package:her_wellness_calender/core/storage/mock_asset_loader.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Reads profile data from a JSON mock shaped like the future API response.
class WellnessProfileMockDatasource {
  const WellnessProfileMockDatasource(this.assetLoader);

  final MockAssetLoader assetLoader;

  /// Loads the profile response wrapper from bundled assets.
  Future<Map<String, dynamic>> getProfile({String? userId}) {
    return assetLoader.loadMap(WellnessConstants.profileMockAsset);
  }

  /// Returns a saved-profile response using the same generic API wrapper shape.
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> profileJson) {
    return Future.value({
      'success': true,
      'message': WellnessConstants.profileSaveSuccess,
      'data': profileJson,
    });
  }
}
