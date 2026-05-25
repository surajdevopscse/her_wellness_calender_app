import 'package:her_wellness_calender/core/api/api_client.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Remote datasource placeholder for future privacy REST API integration.
class PrivacyRemoteDatasource {
  const PrivacyRemoteDatasource(this.apiClient);

  final ApiClient apiClient;

  Future<Map<String, dynamic>> getSettings() async {
    final response = await apiClient.get(WellnessConstants.privacyEndpoint);
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateSettings(
    Map<String, dynamic> settings,
  ) async {
    final response = await apiClient.put(
      WellnessConstants.privacyEndpoint,
      body: settings,
    );
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> deleteWellnessData() async {
    final response = await apiClient.delete(
      WellnessConstants.privacyDeleteWellnessDataEndpoint,
    );
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> deleteAccountAndData() async {
    final response = await apiClient.delete(
      WellnessConstants.privacyDeleteAccountEndpoint,
    );
    return response as Map<String, dynamic>;
  }
}
