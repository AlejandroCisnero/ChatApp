// ignore: file_names
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<bool> getUserThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isDarkMode") ?? false;
  }

  static Future<bool> setUserThemeMode(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("isDarkMode", value);
  }
}
