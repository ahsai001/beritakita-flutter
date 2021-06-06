import 'package:flutter/widgets.dart';

class AppRoot extends InheritedWidget {
  final bool isLoggedIn = false;

  AppRoot({required Widget child}) : super(child: child);

  static AppRoot? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppRoot>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
