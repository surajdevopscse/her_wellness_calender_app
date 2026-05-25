import 'package:her_wellness_calender/features/women_wellness/authentication/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  const ResetPasswordUseCase(this.repository);

  final AuthRepository repository;

  Future<void> call({
    required String emailOrMobile,
    required String otp,
    required String newPassword,
  }) =>
      repository.resetPassword(
        emailOrMobile: emailOrMobile,
        otp: otp,
        newPassword: newPassword,
      );
}
