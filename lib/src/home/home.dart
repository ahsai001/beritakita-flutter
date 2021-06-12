import 'package:beritakita/src/addnews/addnews.dart';
import 'package:beritakita/src/home/models/news_response.dart';
import 'package:beritakita/src/latihan/test.dart';
import 'package:beritakita/src/newsdetail/news_detail.dart';
import 'package:beritakita/src/widgets/app_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:beritakita/src/configs/config.dart';
import 'package:beritakita/src/login/login.dart';
import 'package:beritakita/src/utils/login_util.dart';

import 'dart:async';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({required this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Future<NewsResponse>? _newsResponseFuture;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _refreshIndicatorKey.currentState?.show();
    });

    isLoggedIn();
  }

  void isLoggedIn() async {
    _isLoggedIn = await LoginUtil.isLoggedIn();
    print("method isLoggedIn");
    setState(() {
      //_isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("home rebuild");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                _refreshIndicatorKey.currentState?.show();
              },
              icon: Icon(Icons.refresh)),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text("Menu 1"), value: 0),
                PopupMenuItem(child: Text("Test Page"), value: 1),
                PopupMenuItem(child: Text("Menu 3"), value: 2),
              ];
            },
            onSelected: (value) {
              if (value == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TestPage();
                }));
              }
            },
          )
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
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                        radius: 50,
                        child: Icon(Icons.ac_unit),
                      )),
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
            Visibility(
                visible: false,
                child: ListTile(title: Text("Home"), onTap: () {})),
            Consumer<AppRoot>(
              builder: (context, appRoot, child) {
                print("rebuild logout menu");
                return Visibility(
                  visible: _isLoggedIn,
                  child: ListTile(
                      title: Text("Logout"),
                      onTap: () {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Logout Confirmation'),
                                content: Text("Are you sure want to logout?"),
                                actions: [
                                  ElevatedButton(
                                    child: Text('yes'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      LoginUtil.logout().then((value) => {
                                            Provider.of<AppRoot>(context,
                                                    listen: false)
                                                .setLoggedOut(),
                                            isLoggedIn(),
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Logout berhasil"))),
                                          });
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text('cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            });
                      }),
                );
              },
            ),
            Consumer<AppRoot>(
              builder: (context, appRoot, child) {
                print("rebuild login menu");
                return Visibility(
                  visible: !_isLoggedIn,
                  child: ListTile(
                      title: Text("Login"),
                      onTap: () {
                        //close drawer
                        Navigator.pop(context);
                        //open login page

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        })).then((isLoggedInNow) {
                          print("login return : $isLoggedInNow");
                          isLoggedIn();
                        });
                      }),
                );
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshNews,
        child: FutureBuilder(
            future: _newsResponseFuture,
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
              })).then((isSuccess) => {_refreshNews()});
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              })).then((isLoggedInNow) {
                print("login return : $isLoggedInNow");
                isLoggedIn();
              });
            }
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<NewsResponse?> _refreshNews() async {
    print("run refresh news");
    setState(() {
      _newsResponseFuture = _getNewsAll();
    });
    return _newsResponseFuture;
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
    //print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return NewsResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to get list.');
    }
  }
}
