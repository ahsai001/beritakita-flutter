import 'package:beritakita/home/models/news_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:beritakita/configs/config.dart';

import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita Kita',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;

  HomePage({required this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<NewsResponse>? _futureResponse;
  @override
  void initState() {
    super.initState();
    _futureResponse = _getNewsAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder(
          future: _futureResponse,
          builder: (context, snapshot) {
            List<News>? data = (snapshot.data as NewsResponse).data;
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    News news = data.elementAt(index);
                    return ListTile(
                      leading: Image.network(news.photo),
                      title: Text(news.title),
                      subtitle: Text(news.summary),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("ada error: ${snapshot.error}");
            }

            return new CircularProgressIndicator();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<NewsResponse>? _getNewsAll() async {
    final response = await http.post(
        Uri.https(Config.BASE_AUTHORITY, Config.getNewsListPath()),
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'QVBJS0VZPXF3ZXJ0eTEyMzQ1Ng==',
          'x-packagename': "com.ahsailabs.beritakita",
          'x-platform': "android"
        },
        body: <String, String>{
          'groupcode': Config.GROUP_CODE,
          'keyword': "",
        });

    if (response.statusCode == 200) {
      //print(response.body);
      return NewsResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to get list.');
    }
  }
}
