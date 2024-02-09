import 'package:shared_preferences/shared_preferences.dart';
import 'package:zen_fit_hub/src/core/keys/keys.dart';

class StorageService {
  static late final SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  static bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  static Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  static String getString(String key) {
    return _prefs.getString(key) ?? '';
  }

  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  static String userID = getString(AppKey.userId);
}
