import 'package:her_wellness_calender/features/women_wellness/authentication/domain/repositories/auth_repository.dart';

class VerifyOtpUseCase {
  const VerifyOtpUseCase(this.repository);

  final AuthRepository repository;

  Future<void> call({
    required String emailOrMobile,
    required String otp,
  }) =>
      repository.verifyOtp(emailOrMobile: emailOrMobile, otp: otp);
}
