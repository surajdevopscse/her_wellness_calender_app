import 'package:her_wellness_calender/features/women_wellness/authentication/domain/entities/auth_user.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this.repository);

  final AuthRepository repository;

  Future<AuthUser> call({
    required String emailOrMobile,
    required String password,
  }) =>
      repository.login(emailOrMobile: emailOrMobile, password: password);
}
