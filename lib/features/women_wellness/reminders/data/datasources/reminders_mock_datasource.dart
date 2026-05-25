import 'package:her_wellness_calender/core/storage/mock_asset_loader.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Reads reminders mock data from the wellness aggregate JSON contract.
class RemindersMockDatasource {
  const RemindersMockDatasource(this.assetLoader);

  final MockAssetLoader assetLoader;

  Future<Map<String, dynamic>> getReminders() async {
    final payload = await assetLoader.loadMap(
      WellnessConstants.remindersMockAsset,
    );
    final data = payload['data'] as Map<String, dynamic>;
    return {
      'success': true,
      'message': payload['message'],
      'data': data['reminders'],
    };
  }

  Future<Map<String, dynamic>> updateReminder(Map<String, dynamic> reminder) {
    return Future.value({
      'success': true,
      'message': WellnessConstants.save,
      'data': reminder,
    });
  }
}
