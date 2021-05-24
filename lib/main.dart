import 'package:flutter/material.dart';
import 'package:beritakita/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.+
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita Kita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}
