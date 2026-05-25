import 'package:her_wellness_calender/core/api/api_client.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Remote datasource placeholder for wellness reminder APIs.
class RemindersRemoteDatasource {
  const RemindersRemoteDatasource(this.apiClient);

  final ApiClient apiClient;

  Future<Map<String, dynamic>> getReminders() async {
    final response = await apiClient.get(WellnessConstants.remindersEndpoint);
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateReminder(
    Map<String, dynamic> reminder,
  ) async {
    final response = await apiClient.put(
      '${WellnessConstants.remindersEndpoint}/${reminder['id']}',
      body: reminder,
    );
    return response as Map<String, dynamic>;
  }
}
