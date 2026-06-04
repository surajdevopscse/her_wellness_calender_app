import 'package:her_wellness_calender/core/api/api_client.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

class DashboardRemoteDatasource {
  const DashboardRemoteDatasource(this.apiClient);

  final ApiClient apiClient;

  Future<Map<String, dynamic>> getDashboard() async {
    final response = await apiClient.get(WellnessConstants.dashboardEndpoint);
    return response as Map<String, dynamic>;
  }
}
