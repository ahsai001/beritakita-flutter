import 'package:flutter/widgets.dart';

class AppRoot extends ChangeNotifier {
  String username = "guest";
  String name = "guest";

  void setLoggedIn() {
    //notifyListeners();
  }

  void setLoggedOut() {
    //notifyListeners();
  }

  void refreshNewsList() {
    //notifyListeners();
  }

  void setUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }
}
