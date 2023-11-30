import 'package:beritakita/src/login/models/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUtil {
  static const String isLoggedInKey = "isloggedin";
  static const String loginDataKey = "logindata";

  static Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(isLoggedInKey) ?? false;
  }

  static Future<List> saveLoginData(LoginData loginData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Future<bool> future1 =
        sharedPreferences.setString(loginDataKey, loginData.toJson());
    Future<bool> future2 = sharedPreferences.setBool(isLoggedInKey, true);
    return Future.wait([future1, future2]);
  }

  static Future<LoginData> getLoginData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String loginDataJson = sharedPreferences.getString(loginDataKey) ??
        LoginData(token: "", name: "guest", username: "guest").toJson();
    LoginData loginData = LoginData.fromJson(loginDataJson);
    return loginData;
  }

  static Future logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Future<bool> future1 = sharedPreferences.remove(isLoggedInKey);
    Future<bool> future2 = sharedPreferences.remove(loginDataKey);
    return Future.wait([future1, future2]);
  }
}
