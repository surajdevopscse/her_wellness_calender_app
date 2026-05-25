import 'package:her_wellness_calender/app/environment/app_environment.dart';
import 'package:her_wellness_calender/core/errors/exceptions.dart';
import 'package:her_wellness_calender/core/storage/storage_service.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/data/datasources/auth_mock_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/data/models/auth_user_model.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/entities/auth_user.dart';
import 'package:her_wellness_calender/features/women_wellness/authentication/domain/repositories/auth_repository.dart';
import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_storage_keys.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.environment,
    required this.mockDatasource,
    required this.remoteDatasource,
    required this.storageService,
  });

  final AppEnvironment environment;
  final AuthMockDatasource mockDatasource;
  final AuthRemoteDatasource remoteDatasource;
  final StorageService storageService;

  @override
  Future<AuthUser> login({
    required String emailOrMobile,
    required String password,
  }) async {
    if (environment.isMockMode) {
      final payload = await mockDatasource.getUsersPayload();
      final users = (payload['data'] as Map<String, dynamic>)['users']
          as List<dynamic>;
      final match = users.cast<Map<String, dynamic>>().where((user) {
        final email = user['email'] as String;
        final mobile = user['mobile'] as String?;
        final pass = user['password'] as String;
        final identifierMatch =
            email == emailOrMobile || mobile == emailOrMobile;
        return identifierMatch && pass == password;
      }).toList();
      if (match.isEmpty) {
        throw const ValidationAppException(
          message: 'Invalid email/mobile or password.',
        );
      }
      final model = AuthUserModel.fromJson(match.first);
      final response = await mockDatasource.loginSuccess(model.toJson());
      await _persistSession(response);
      return model.toEntity();
    }

    final response = await remoteDatasource.login({
      'emailOrMobile': emailOrMobile,
      'password': password,
    });
    await _persistSession(response);
    return AuthUserModel.fromJson(
      (response['data'] as Map<String, dynamic>)['user'] as Map<String, dynamic>,
    ).toEntity();
  }

  @override
  Future<AuthUser> register({
    required String fullName,
    required String emailOrMobile,
    required String password,
  }) async {
    if (environment.isMockMode) {
      final isEmail = emailOrMobile.contains('@');
      final userJson = {
        'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
        'fullName': fullName,
        'email': isEmail ? emailOrMobile : '$emailOrMobile@wellness.local',
        if (!isEmail) 'mobile': emailOrMobile,
        'password': password,
      };
      final response = await mockDatasource.registerSuccess(userJson);
      await _persistSession(response);
      return AuthUserModel.fromJson(userJson).toEntity();
    }

    final response = await remoteDatasource.register({
      'fullName': fullName,
      'emailOrMobile': emailOrMobile,
      'password': password,
    });
    await _persistSession(response);
    return AuthUserModel.fromJson(
      (response['data'] as Map<String, dynamic>)['user'] as Map<String, dynamic>,
    ).toEntity();
  }

  @override
  Future<void> sendPasswordReset({required String emailOrMobile}) async {
    if (environment.isMockMode) {
      await mockDatasource.genericSuccess('Reset code sent if account exists.');
      return;
    }
    await remoteDatasource.forgotPassword({'emailOrMobile': emailOrMobile});
  }

  @override
  Future<void> resetPassword({
    required String emailOrMobile,
    required String otp,
    required String newPassword,
  }) async {
    if (environment.isMockMode) {
      if (otp.length < 4) {
        throw const ValidationAppException(message: 'Invalid reset code.');
      }
      await mockDatasource.genericSuccess('Password updated.');
      return;
    }
    await remoteDatasource.resetPassword({
      'emailOrMobile': emailOrMobile,
      'otp': otp,
      'newPassword': newPassword,
    });
  }

  @override
  Future<void> verifyOtp({
    required String emailOrMobile,
    required String otp,
  }) async {
    if (environment.isMockMode) {
      if (otp != '123456') {
        throw const ValidationAppException(
          message: 'Invalid OTP. Use 123456 in mock mode.',
        );
      }
      await mockDatasource.genericSuccess('OTP verified.');
      return;
    }
    await remoteDatasource.verifyOtp({
      'emailOrMobile': emailOrMobile,
      'otp': otp,
    });
  }

  @override
  Future<void> logout() async {
    await storageService.clearAuthToken();
    await storageService.setString(WellnessStorageKeys.currentUserId, '');
  }

  Future<void> _persistSession(Map<String, dynamic> response) async {
    final data = response['data'] as Map<String, dynamic>?;
    if (data == null) return;
    final token = data['token'] as String?;
    final user = data['user'] as Map<String, dynamic>?;
    if (token != null) await storageService.saveAuthToken(token);
    if (user != null) {
      await storageService.setString(
        WellnessStorageKeys.currentUserId,
        user['id'] as String,
      );
    }
  }
}
