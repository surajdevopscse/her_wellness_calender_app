import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:her_wellness_calender/core/constants/app_constants.dart';

/// Lightweight local key-value storage used by the wellness app.
class StorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> saveAuthToken(String token) =>
      _prefs.setString(AppConstants.keyAuthToken, token);

  String? getAuthToken() => _prefs.getString(AppConstants.keyAuthToken);

  Future<void> clearAuthToken() => _prefs.remove(AppConstants.keyAuthToken);

  Future<void> clearAll() => _prefs.clear();

  Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);

  Future<void> setBool(String key, bool value) => _prefs.setBool(key, value);

  bool? getBool(String key) => _prefs.getBool(key);

  Future<void> setInt(String key, int value) => _prefs.setInt(key, value);

  int? getInt(String key) => _prefs.getInt(key);
}
