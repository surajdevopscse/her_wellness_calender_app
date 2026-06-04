import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:her_wellness_calender/core/constants/app_constants.dart';

/// Lightweight local key-value storage used by the wellness app.
class StorageService extends GetxService {
  late SharedPreferences _prefs;
  String? _sessionAuthToken;
  String? _sessionRefreshToken;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> saveAuthToken(String token, {bool persist = true}) async {
    _sessionAuthToken = token;
    if (persist) {
      await _prefs.setString(AppConstants.keyAuthToken, token);
    } else {
      await _prefs.remove(AppConstants.keyAuthToken);
    }
  }

  String? getAuthToken() =>
      _sessionAuthToken ?? _prefs.getString(AppConstants.keyAuthToken);

  Future<void> saveRefreshToken(String token, {bool persist = true}) async {
    _sessionRefreshToken = token;
    if (persist) {
      await _prefs.setString(AppConstants.keyRefreshToken, token);
    } else {
      await _prefs.remove(AppConstants.keyRefreshToken);
    }
  }

  String? getRefreshToken() =>
      _sessionRefreshToken ?? _prefs.getString(AppConstants.keyRefreshToken);

  Future<void> clearAuthToken() async {
    _sessionAuthToken = null;
    await _prefs.remove(AppConstants.keyAuthToken);
  }

  Future<void> clearRefreshToken() async {
    _sessionRefreshToken = null;
    await _prefs.remove(AppConstants.keyRefreshToken);
  }

  Future<void> clearAll() async {
    _sessionAuthToken = null;
    _sessionRefreshToken = null;
    await _prefs.clear();
  }

  Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);

  Future<void> setBool(String key, bool value) => _prefs.setBool(key, value);

  bool? getBool(String key) => _prefs.getBool(key);

  Future<void> setInt(String key, int value) => _prefs.setInt(key, value);

  int? getInt(String key) => _prefs.getInt(key);
}
