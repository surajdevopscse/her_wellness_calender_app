import 'package:her_wellness_calender/features/women_wellness/authentication/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  const ForgotPasswordUseCase(this.repository);

  final AuthRepository repository;

  Future<void> call({required String emailOrMobile}) =>
      repository.sendPasswordReset(emailOrMobile: emailOrMobile);
}
