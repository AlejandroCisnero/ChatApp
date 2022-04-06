// ignore: file_names
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const THEME_STATUS = "THEMESTATUS";

  Future<bool> getThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }

  setThemeMode(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(THEME_STATUS, value);
  }
}
