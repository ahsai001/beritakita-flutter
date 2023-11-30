class Config {
  static const String baseAuthority = "1ad3-182-0-100-126.ngrok-free.app";
  static const String protocol = "https";
  //static const String BASE_AUTHORITY = "192.168.43.172:8080";
  //https://flutter.dev/docs/release/breaking-changes/network-policy-ios-android

  static const String basePath = "/kango/cijou/";
  static const String apiKey = "qwerty123456";
  static const String groupCode = "ABJAL1";

  static String baseUrl() {
    return "$protocol://$baseAuthority/kango/";
  }

  static String getLoginPath() {
    return "${basePath}login";
  }

  static String getNewsListPath() {
    return "${basePath}news/all";
  }

  static String getNewsDetailPath() {
    return "${basePath}news/detail/{id}";
  }

  static String getAddNewsPath() {
    return "${basePath}news/add";
  }

  static const String appPreferences = "beritakita_preferences";
  static const String dataToken = "data_token";
  static const String dataName = "data_name";
  static const String dataUsername = "data_username";
  static const String dataIsloggedin = "data_isloggedin";
}
