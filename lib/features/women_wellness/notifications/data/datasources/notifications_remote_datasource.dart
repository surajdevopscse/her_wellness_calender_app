import 'package:her_wellness_calender/core/api/api_client.dart';

class NotificationsRemoteDatasource {
  const NotificationsRemoteDatasource(this.apiClient);
  final ApiClient apiClient;
  static const path = '/api/v1/women-wellness/notifications/templates';

  Future<Map<String, dynamic>> getTemplates() async {
    final response = await apiClient.get(path);
    return response as Map<String, dynamic>;
  }
}
