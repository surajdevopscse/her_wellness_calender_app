import 'package:her_wellness_calender/core/api/api_client.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/onboarding/data/models/onboarding_status_model.dart';

class OnboardingRemoteDatasource {
  const OnboardingRemoteDatasource(this.apiClient);

  final ApiClient apiClient;

  Future<OnboardingStatusModel> getStatus() async {
    final response =
        await apiClient.get(WellnessConstants.onboardingEndpoint)
            as Map<String, dynamic>;
    return OnboardingStatusModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }

  Future<OnboardingStatusModel> completeSetup({
    required String goal,
    required DateTime lastPeriodStart,
    required int cycleLength,
    required int periodLength,
  }) async {
    final response =
        await apiClient.put(
              WellnessConstants.onboardingEndpoint,
              body: {
                'goal': goal,
                'lastPeriodStartDate': lastPeriodStart.toIso8601String(),
                'averageCycleLength': cycleLength,
                'averagePeriodLength': periodLength,
              },
            )
            as Map<String, dynamic>;
    return OnboardingStatusModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }
}
