import 'package:shared_preferences/shared_preferences.dart';

class SignInPreference {
  static const String _screenKey = "currentScreen";

  static Future<void> setCurrentScreen(String screen) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_screenKey, screen);
  }

  static Future<String?> getCurrentScreen() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_screenKey);
  }
}
