import 'package:her_wellness_calender/features/women_wellness/profile/domain/entities/wellness_profile.dart';

/// Contract for reading and updating the women wellness profile.
abstract class WellnessProfileRepository {
  /// Returns the current user's profile, or null when no profile exists.
  Future<WellnessProfile?> getProfile({String? userId});

  /// Persists profile baseline fields and returns the saved profile.
  Future<WellnessProfile> updateProfile(WellnessProfile profile);
}
