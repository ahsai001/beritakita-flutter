import 'package:beritakita/src/widgets/app_root.dart';
import 'package:flutter/material.dart';
import 'package:beritakita/src/home/home.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AppRoot(),
        child: MaterialApp(
          title: 'Berita Kita',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(title: 'Home Page'),
          debugShowCheckedModeBanner: false,
        ));
  }
}
