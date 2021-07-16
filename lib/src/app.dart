import 'package:beritakita/src/splash/splash.dart';
import 'package:beritakita/src/widgets/app_root.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  //final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AppRoot(),
        child: MaterialApp(
          //scaffoldMessengerKey: rootScaffoldMessengerKey,
          title: 'Berita Kita',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashPage(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
