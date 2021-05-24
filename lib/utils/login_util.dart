import 'package:shared_preferences/shared_preferences.dart';

class LoginUtil {
  static const String ISLOGGEDIN = "isloggedin";

  static Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(ISLOGGEDIN) ?? false;
  }
}
