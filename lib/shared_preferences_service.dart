import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setUserLoggedIn(bool value) async {
    await _prefs.setBool('isLoggedIn', value);
  }

  static bool isUserLoggedIn() {
    return _prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> setUserId(String userId) async {
    await _prefs.setString('userId', userId);
  }

  static String getUserId() {
    return _prefs.getString('userId') ?? '';
  }

  static Future<void> clearUserData() async {
    await _prefs.remove('isLoggedIn');
    await _prefs.remove('userId');
  }
}