import 'package:her_wellness_calender/core/api/api_client.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Remote datasource placeholder for future profile REST API integration.
class WellnessProfileRemoteDatasource {
  const WellnessProfileRemoteDatasource(this.apiClient);

  final ApiClient apiClient;

  /// Fetches profile by optional user id using the future backend contract.
  Future<Map<String, dynamic>> getProfile({String? userId}) async {
    final response = await apiClient.get(
      WellnessConstants.profileEndpoint,
      queryParameters: {
        if (userId != null && userId.isNotEmpty)
          WellnessConstants.profileUserIdQuery: userId,
      },
    );
    return response as Map<String, dynamic>;
  }

  /// Updates profile baseline fields using the future backend contract.
  Future<Map<String, dynamic>> updateProfile(
    Map<String, dynamic> profileJson,
  ) async {
    final response = await apiClient.put(
      WellnessConstants.profileEndpoint,
      body: profileJson,
    );
    return response as Map<String, dynamic>;
  }
}
