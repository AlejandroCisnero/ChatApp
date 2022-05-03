import 'package:chat_app/Providers/sharedPreferencesHelper.dart';
import 'package:flutter/cupertino.dart';

class DarkThemeProvider with ChangeNotifier {
  SharedPreferencesHelper darkThemePreference = SharedPreferencesHelper();
  bool _darkTheme = true;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setThemeMode(value);
    notifyListeners();
  }
}
