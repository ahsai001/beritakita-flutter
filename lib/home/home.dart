import 'package:beritakita/home/models/news_response.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:beritakita/configs/config.dart';

import 'dart:async';

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
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
          PopupMenuButton(itemBuilder: )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Container(
                //color: Colors.green,
                child: Stack(children: [
                  Align(
                      alignment: Alignment.centerRight, child: CircleAvatar()),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("username"),
                          Text("@username"),
                        ],
                      )),
                ]),
              ),
            ),
            ListTile(title: Text("Home"), onTap: () {}),
            ListTile(title: Text("Logout"), onTap: () {}),
            ListTile(title: Text("Login"), onTap: () {}),
          ],
        ),
      ),
      body: FutureBuilder(
          future: _futureResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<News>? data = (snapshot.data as NewsResponse).data;
              if (data != null) {
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      News news = data.elementAt(index);
                      return Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 20,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          height: 200,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(news.photo,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover),
                              ),
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Opacity(
                                      opacity: 0.7,
                                      child: Container(
                                        color: Colors.black,
                                        child: ListTile(
                                          title: Text(news.title,
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          subtitle: Text(news.summary,
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ))),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: Text("Ooops data kosong"),
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text("ada error: ${snapshot.error}"),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
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
