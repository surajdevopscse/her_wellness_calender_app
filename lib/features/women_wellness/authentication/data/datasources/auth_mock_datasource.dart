import 'package:her_wellness_calender/core/storage/mock_asset_loader.dart';

class AuthMockDatasource {
  const AuthMockDatasource(this.assetLoader);

  static const assetPath = 'assets/mock/auth_users.json';

  final MockAssetLoader assetLoader;

  Future<Map<String, dynamic>> getUsersPayload() => assetLoader.loadMap(assetPath);

  Future<Map<String, dynamic>> loginSuccess(Map<String, dynamic> userJson) {
    return Future.value({
      'success': true,
      'message': 'Login successful.',
      'data': {
        'user': userJson,
        'token': 'mock_token_${userJson['id']}',
      },
    });
  }

  Future<Map<String, dynamic>> registerSuccess(Map<String, dynamic> userJson) {
    return Future.value({
      'success': true,
      'message': 'Account created.',
      'data': {
        'user': userJson,
        'token': 'mock_token_${userJson['id']}',
      },
    });
  }

  Future<Map<String, dynamic>> genericSuccess(String message) {
    return Future.value({'success': true, 'message': message, 'data': const {}});
  }
}
