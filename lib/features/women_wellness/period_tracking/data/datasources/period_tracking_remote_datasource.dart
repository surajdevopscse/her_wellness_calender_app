import 'package:her_wellness_calender/core/api/api_client.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Remote datasource placeholder for future period tracking REST APIs.
class PeriodTrackingRemoteDatasource {
  const PeriodTrackingRemoteDatasource(this.apiClient);

  final ApiClient apiClient;

  Future<Map<String, dynamic>> getPeriodHistory() async {
    final response = await apiClient.get(
      WellnessConstants.periodTrackingEndpoint,
    );
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> addPeriodEntry(
    Map<String, dynamic> entryJson,
  ) async {
    final response = await apiClient.post(
      WellnessConstants.periodTrackingEndpoint,
      body: entryJson,
    );
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updatePeriodEntry(
    Map<String, dynamic> entryJson,
  ) async {
    final id = entryJson[WellnessConstants.periodTrackingIdPath] as String;
    final response = await apiClient.put(
      '${WellnessConstants.periodTrackingEndpoint}/$id',
      body: entryJson,
    );
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> deletePeriodEntry(String id) async {
    final response = await apiClient.delete(
      '${WellnessConstants.periodTrackingEndpoint}/$id',
    );
    return response as Map<String, dynamic>;
  }
}
