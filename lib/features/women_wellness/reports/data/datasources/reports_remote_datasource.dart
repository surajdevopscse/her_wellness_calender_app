import 'package:her_wellness_calender/core/api/api_client.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Remote datasource placeholder for wellness reports APIs.
class ReportsRemoteDatasource {
  const ReportsRemoteDatasource(this.apiClient);

  final ApiClient apiClient;

  Future<Map<String, dynamic>> getReports({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final response = await apiClient.get(
      WellnessConstants.reportsEndpoint,
      queryParameters: {
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      },
    );
    return response as Map<String, dynamic>;
  }
}
