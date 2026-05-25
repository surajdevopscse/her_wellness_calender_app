import 'package:her_wellness_calender/features/women_wellness/privacy/domain/repositories/privacy_repository.dart';

/// Use case for irreversible privacy-sensitive delete actions.
class DeleteWellnessDataUseCase {
  const DeleteWellnessDataUseCase(this.repository);

  final PrivacyRepository repository;

  /// Deletes wellness data, and optionally account data, through the repository.
  Future<void> call({bool includeAccount = false}) {
    return includeAccount
        ? repository.deleteAccountAndData()
        : repository.deleteWellnessData();
  }
}
