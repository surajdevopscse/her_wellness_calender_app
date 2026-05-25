import 'package:her_wellness_calender/core/storage/mock_asset_loader.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Reads symptom catalog mock data from JSON using the future API wrapper shape.
class SymptomsMockDatasource {
  const SymptomsMockDatasource(this.assetLoader);

  final MockAssetLoader assetLoader;

  Future<Map<String, dynamic>> getSymptoms() {
    return assetLoader.loadMap(WellnessConstants.symptomsMockAsset);
  }

  Future<Map<String, dynamic>> saveSelectedSymptoms(
    List<Map<String, dynamic>> symptoms,
  ) {
    return Future.value({
      'success': true,
      'message': WellnessConstants.symptomsSaved,
      'data': symptoms,
    });
  }
}
