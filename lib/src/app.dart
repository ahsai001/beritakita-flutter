import 'package:beritakita/src/widgets/app_root.dart';
import 'package:flutter/material.dart';
import 'package:beritakita/src/home/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return AppRoot(child: child!);
      },
      title: 'Berita Kita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}
