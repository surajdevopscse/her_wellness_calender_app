import 'package:her_wellness_calender/core/storage/mock_asset_loader.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Reads reports mock data from the wellness aggregate JSON contract.
class ReportsMockDatasource {
  const ReportsMockDatasource(this.assetLoader);

  final MockAssetLoader assetLoader;

  Future<Map<String, dynamic>> getReports() async {
    final payload = await assetLoader.loadMap(
      WellnessConstants.reportsMockAsset,
    );
    final data = payload['data'] as Map<String, dynamic>;
    return {
      'success': true,
      'message': payload['message'],
      'data': data['report'],
    };
  }
}
