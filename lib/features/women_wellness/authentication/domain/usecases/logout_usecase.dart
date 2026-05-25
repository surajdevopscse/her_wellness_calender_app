import 'package:her_wellness_calender/features/women_wellness/authentication/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  const LogoutUseCase(this.repository);

  final AuthRepository repository;

  Future<void> call() => repository.logout();
}
