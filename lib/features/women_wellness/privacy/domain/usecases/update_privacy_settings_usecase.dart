import 'package:her_wellness_calender/features/women_wellness/privacy/domain/entities/privacy_settings.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/repositories/privacy_repository.dart';

/// Use case for saving privacy settings.
class UpdatePrivacySettingsUseCase {
  const UpdatePrivacySettingsUseCase(this.repository);

  final PrivacyRepository repository;

  Future<PrivacySettings> call(PrivacySettings settings) {
    return repository.updateSettings(settings);
  }
}
