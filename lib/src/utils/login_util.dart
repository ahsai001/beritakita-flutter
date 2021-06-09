import 'package:beritakita/src/login/models/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUtil {
  static const String ISLOGGEDIN = "isloggedin";
  static const String LOGINDATA = "logindata";

  static Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(ISLOGGEDIN) ?? false;
  }

  static Future<List> saveLoginData(LoginData loginData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Future<bool> future1 =
        sharedPreferences.setString(LOGINDATA, loginData.toJson());
    Future<bool> future2 = sharedPreferences.setBool(ISLOGGEDIN, true);
    return Future.wait([future1, future2]);
  }

  static Future<LoginData> getLoginData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String loginDataJson = sharedPreferences.getString(LOGINDATA) ??
        LoginData(token: "", name: "", username: "").toJson();
    LoginData loginData = LoginData.fromJson(loginDataJson);
    return loginData;
  }

  static Future logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Future<bool> future1 = sharedPreferences.remove(ISLOGGEDIN);
    Future<bool> future2 = sharedPreferences.remove(LOGINDATA);
    return Future.wait([future1, future2]);
  }
}
