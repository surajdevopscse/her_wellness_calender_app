import 'package:her_wellness_calender/features/women_wellness/authentication/domain/entities/auth_user.dart';

/// Authentication repository contract.
abstract class AuthRepository {
  Future<AuthUser> login({
    required String emailOrMobile,
    required String password,
  });

  Future<AuthUser> register({
    required String fullName,
    required String emailOrMobile,
    required String password,
  });

  Future<void> sendPasswordReset({required String emailOrMobile});

  Future<void> resetPassword({
    required String emailOrMobile,
    required String otp,
    required String newPassword,
  });

  Future<void> verifyOtp({
    required String emailOrMobile,
    required String otp,
  });

  Future<void> logout();
}
