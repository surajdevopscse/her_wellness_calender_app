import 'package:her_wellness_calender/features/women_wellness/profile/domain/entities/wellness_profile.dart';
import 'package:her_wellness_calender/features/women_wellness/profile/domain/repositories/wellness_profile_repository.dart';

/// Use case for loading the current wellness profile.
class GetWellnessProfileUseCase {
  const GetWellnessProfileUseCase(this.repository);

  final WellnessProfileRepository repository;

  /// Returns the requested profile without exposing data-source details.
  Future<WellnessProfile?> call({String? userId}) {
    return repository.getProfile(userId: userId);
  }
}
