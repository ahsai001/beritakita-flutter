import 'package:flutter/widgets.dart';

class AppRoot extends ChangeNotifier {
  bool isLoggedIn = false;

  void setLoggedIn() {
    isLoggedIn = true;
    notifyListeners();
  }

  void setLoggedOut() {
    isLoggedIn = false;
    notifyListeners();
  }
}
