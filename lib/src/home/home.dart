import 'package:beritakita/src/addnews/addnews.dart';
import 'package:beritakita/src/home/models/news_response.dart';
import 'package:beritakita/src/newsdetail/news_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:beritakita/src/configs/config.dart';
import 'package:beritakita/src/login/login.dart';
import 'package:beritakita/src/utils/login_util.dart';

import 'dart:async';

class HomePage extends StatelessWidget {
  final String title;
  HomePage({required this.title});

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () {
                _refreshIndicatorKey.currentState?.show();
              },
              icon: Icon(Icons.refresh)),
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(child: Text("Menu 1")),
              PopupMenuItem(child: Text("menu 2")),
              PopupMenuItem(child: Text("Menu 3")),
            ];
          })
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
            ListTile(
                title: Text("Login"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                }),
          ],
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshNews,
        child: FutureBuilder(
            future: _getNewsAll(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<News>? data = (snapshot.data as NewsResponse).data;
                if (data != null) {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        News news = data.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Item $index clicked")));
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewsDetailPage(news: news);
                            }));
                          },
                          child: Card(
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
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1
                                                          ?.apply(
                                                              color:
                                                                  Colors.white,
                                                              fontSizeDelta: 2,
                                                              fontWeightDelta:
                                                                  4)),
                                                  subtitle: Text(news.summary,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2
                                                          ?.apply(
                                                              color: Colors
                                                                  .white)))))),
                                ],
                              ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          LoginUtil.isLoggedIn().then((value) {
            if (value) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddNewsPage();
              }));
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            }
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _refreshNews() async {
    print("run refresh news");
    return _getNewsAll() as Future;
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
