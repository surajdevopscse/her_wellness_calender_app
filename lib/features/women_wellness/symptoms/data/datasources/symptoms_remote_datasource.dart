import 'package:her_wellness_calender/core/api/api_client.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';

/// Remote datasource placeholder for future symptom REST APIs.
class SymptomsRemoteDatasource {
  const SymptomsRemoteDatasource(this.apiClient);

  final ApiClient apiClient;

  Future<Map<String, dynamic>> getSymptoms() async {
    final response = await apiClient.get(WellnessConstants.symptomsEndpoint);
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> saveSelectedSymptoms(
    List<Map<String, dynamic>> symptoms,
  ) async {
    final response = await apiClient.put(
      WellnessConstants.selectedSymptomsEndpoint,
      body: {'items': symptoms},
    );
    return response as Map<String, dynamic>;
  }
}
