import 'package:her_wellness_calender/app/environment/app_environment.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/data/datasources/wellness_profile_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/data/datasources/wellness_profile_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/data/models/wellness_profile_model.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/entities/wellness_profile.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/repositories/wellness_profile_repository.dart';

/// Repository implementation that switches between mock and remote profile APIs.
class WellnessProfileRepositoryImpl implements WellnessProfileRepository {
  const WellnessProfileRepositoryImpl({
    required this.environment,
    required this.mockDatasource,
    required this.remoteDatasource,
  });

  final AppEnvironment environment;
  final WellnessProfileMockDatasource mockDatasource;
  final WellnessProfileRemoteDatasource remoteDatasource;

  @override
  Future<WellnessProfile?> getProfile({String? userId}) async {
    final response = environment.isMockMode
        ? await mockDatasource.getProfile(userId: userId)
        : await remoteDatasource.getProfile(userId: userId);
    final data = response['data'];
    if (data == null) return null;
    return WellnessProfileModel.fromJson(
      data as Map<String, dynamic>,
    ).toEntity();
  }

  @override
  Future<WellnessProfile> updateProfile(WellnessProfile profile) async {
    final payload = WellnessProfileModel.fromEntity(profile).toJson();
    final response = environment.isMockMode
        ? await mockDatasource.updateProfile(payload)
        : await remoteDatasource.updateProfile(payload);
    return WellnessProfileModel.fromJson(
      response['data'] as Map<String, dynamic>,
    ).toEntity();
  }
}
