import 'package:her_wellness_calender/core/api/api_client.dart';

class SettingsRemoteDatasource {
  const SettingsRemoteDatasource(this.apiClient);
  final ApiClient apiClient;
  static const path = '/api/v1/women-wellness/settings';

  Future<Map<String, dynamic>> getSettings() async {
    final response = await apiClient.get(path);
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateSettings(Map<String, dynamic> body) async {
    final response = await apiClient.put(path, body: body);
    return response as Map<String, dynamic>;
  }
}
