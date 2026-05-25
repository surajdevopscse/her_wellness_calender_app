import 'package:her_wellness_calender/core/storage/mock_asset_loader.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Reads period tracking mock data from JSON using future API response shapes.
class PeriodTrackingMockDatasource {
  const PeriodTrackingMockDatasource(this.assetLoader);

  final MockAssetLoader assetLoader;

  Future<Map<String, dynamic>> getPeriodHistory() {
    return assetLoader.loadMap(WellnessConstants.periodTrackingMockAsset);
  }

  Future<Map<String, dynamic>> addPeriodEntry(Map<String, dynamic> entryJson) {
    return Future.value({
      'success': true,
      'message': WellnessConstants.periodEntrySaved,
      'data': entryJson,
    });
  }

  Future<Map<String, dynamic>> updatePeriodEntry(
    Map<String, dynamic> entryJson,
  ) {
    return Future.value({
      'success': true,
      'message': WellnessConstants.periodEntrySaved,
      'data': entryJson,
    });
  }

  Future<Map<String, dynamic>> deletePeriodEntry(String id) {
    return Future.value({
      'success': true,
      'message': WellnessConstants.periodEntryDeleted,
      'data': {'id': id, 'deleted': true},
    });
  }
}
