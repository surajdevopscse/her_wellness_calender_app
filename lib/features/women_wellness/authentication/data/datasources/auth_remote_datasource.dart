import 'package:her_wellness_calender/core/api/api_client.dart';

/// Remote auth API placeholder — swap mock repository when backend is live.
class AuthRemoteDatasource {
  const AuthRemoteDatasource(this.apiClient);

  final ApiClient apiClient;

  static const loginPath = '/api/v1/auth/login';
  static const registerPath = '/api/v1/auth/register';
  static const forgotPasswordPath = '/api/v1/auth/forgot-password';
  static const resetPasswordPath = '/api/v1/auth/reset-password';
  static const verifyOtpPath = '/api/v1/auth/verify-otp';
  static const logoutPath = '/api/v1/auth/logout';

  Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    final response = await apiClient.post(loginPath, body: body);
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> body) async {
    final response = await apiClient.post(registerPath, body: body);
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> forgotPassword(Map<String, dynamic> body) async {
    final response = await apiClient.post(forgotPasswordPath, body: body);
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> resetPassword(Map<String, dynamic> body) async {
    final response = await apiClient.post(resetPasswordPath, body: body);
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> verifyOtp(Map<String, dynamic> body) async {
    final response = await apiClient.post(verifyOtpPath, body: body);
    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> logout(Map<String, dynamic> body) async {
    final response = await apiClient.post(logoutPath, body: body);
    return response as Map<String, dynamic>;
  }
}
