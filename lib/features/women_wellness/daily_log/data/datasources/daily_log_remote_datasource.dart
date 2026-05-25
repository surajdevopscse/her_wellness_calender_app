import 'package:her_wellness_calender/core/api/api_client.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Remote datasource placeholder for future daily log REST APIs.
class DailyLogRemoteDatasource {
  const DailyLogRemoteDatasource(this.apiClient);

  final ApiClient apiClient;

  Future<Map<String, dynamic>> getDailyLogs({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final response = await apiClient.get(
      WellnessConstants.dailyLogEndpoint,
      queryParameters: {
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      },
    );
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> addDailyLog(Map<String, dynamic> logJson) async {
    final response = await apiClient.post(
      WellnessConstants.dailyLogEndpoint,
      body: logJson,
    );
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateDailyLog(
    Map<String, dynamic> logJson,
  ) async {
    final id = logJson[WellnessConstants.dailyLogIdPath] as String;
    final response = await apiClient.put(
      '${WellnessConstants.dailyLogEndpoint}/$id',
      body: logJson,
    );
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> deleteDailyLog(String id) async {
    final response = await apiClient.delete(
      '${WellnessConstants.dailyLogEndpoint}/$id',
    );
    return response as Map<String, dynamic>;
  }
}
