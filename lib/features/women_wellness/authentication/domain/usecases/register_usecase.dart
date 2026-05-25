import 'package:her_wellness_calender/features/women_wellness/authentication/domain/entities/auth_user.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this.repository);

  final AuthRepository repository;

  Future<AuthUser> call({
    required String fullName,
    required String emailOrMobile,
    required String password,
  }) =>
      repository.register(
        fullName: fullName,
        emailOrMobile: emailOrMobile,
        password: password,
      );
}
