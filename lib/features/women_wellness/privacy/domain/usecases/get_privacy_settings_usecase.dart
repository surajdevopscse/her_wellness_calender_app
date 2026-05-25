import 'package:her_wellness_calender/features/women_wellness/privacy/domain/entities/privacy_settings.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/repositories/privacy_repository.dart';

/// Use case for loading privacy settings.
class GetPrivacySettingsUseCase {
  const GetPrivacySettingsUseCase(this.repository);

  final PrivacyRepository repository;

  Future<PrivacySettings?> call() => repository.getSettings();
}
