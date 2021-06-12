import 'dart:async';

import 'package:beritakita/src/home/home.dart';
import 'package:beritakita/src/latihan/test.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  startSplash(context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage(title: "Home");
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    startSplash(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/icon.png",
              width: 200.0,
              height: 100.0,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Text(
            "Berita Kita",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
