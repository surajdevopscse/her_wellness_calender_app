import 'package:her_wellness_calender/core/storage/mock_asset_loader.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Reads daily log mock data from JSON using the future API wrapper shape.
class DailyLogMockDatasource {
  const DailyLogMockDatasource(this.assetLoader);

  final MockAssetLoader assetLoader;

  Future<Map<String, dynamic>> getDailyLogs({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return assetLoader.loadMap(WellnessConstants.dailyLogMockAsset);
  }

  Future<Map<String, dynamic>> addDailyLog(Map<String, dynamic> logJson) {
    return Future.value({
      'success': true,
      'message': WellnessConstants.dailyLogSaved,
      'data': logJson,
    });
  }

  Future<Map<String, dynamic>> updateDailyLog(Map<String, dynamic> logJson) {
    return Future.value({
      'success': true,
      'message': WellnessConstants.dailyLogSaved,
      'data': logJson,
    });
  }

  Future<Map<String, dynamic>> deleteDailyLog(String id) {
    return Future.value({
      'success': true,
      'message': WellnessConstants.dailyLogDeleted,
      'data': {'id': id, 'deleted': true},
    });
  }
}
