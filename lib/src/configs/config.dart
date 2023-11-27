class Config {
  static const String BASE_AUTHORITY = "a82e-182-0-191-105.ngrok-free.app";
  //static const String BASE_AUTHORITY = "192.168.43.172:8080";
  //https://flutter.dev/docs/release/breaking-changes/network-policy-ios-android

  static const String BASE_PATH = "/kango/cijou/";
  static const String API_KEY = "qwerty123456";
  static const String GROUP_CODE = "ABJAL1";

  static String getLoginPath() {
    return "${BASE_PATH}login";
  }

  static String getNewsListPath() {
    return "${BASE_PATH}news/all";
  }

  static String getNewsDetailPath() {
    return "${BASE_PATH}news/detail/{id}";
  }

  static String getAddNewsPath() {
    return "${BASE_PATH}news/add";
  }

  static const String APP_PREFERENCES = "beritakita_preferences";
  static const String DATA_TOKEN = "data_token";
  static const String DATA_NAME = "data_name";
  static const String DATA_USERNAME = "data_username";
  static const String DATA_ISLOGGEDIN = "data_isloggedin";
}
