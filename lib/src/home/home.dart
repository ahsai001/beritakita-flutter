import 'dart:async';

import 'package:beritakita/src/addnews/addnews.dart';
import 'package:beritakita/src/configs/config.dart';
import 'package:beritakita/src/home/models/news_response.dart';
import 'package:beritakita/src/latihan/latihan_ui.dart';
import 'package:beritakita/src/login/login.dart';
import 'package:beritakita/src/login/models/login_response.dart';
import 'package:beritakita/src/newsdetail/news_detail.dart';
import 'package:beritakita/src/utils/login_util.dart';
import 'package:beritakita/src/widgets/app_root.dart';
import 'package:beritakita/src/widgets/appbar_textfield.dart';
import 'package:beritakita/src/widgets/custom_loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Future<NewsResponse>? _newsResponseFuture;
  bool _isLoggedIn = false;
  LoginData _loginData = LoginData(name: "guest", token: "", username: "guest");

  String keyword = "";

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _refreshIndicatorKey.currentState?.show();
    });

    checkLogin();
  }

  void checkLogin() async {
    if (kDebugMode) {
      print("checkLogin start");
    }
    Future<bool> future1 = LoginUtil.isLoggedIn();
    Future<LoginData> future2 = LoginUtil.getLoginData();
    List<Object> info = await Future.wait([future1, future2]);

    //rebuild all home widget
    setState(() {
      _isLoggedIn = info[0] as bool;
      _loginData = info[1] as LoginData;
    });

    //rebuild partial widget, use consumer in username widget
    /*
    Provider.of<AppRoot>(context, listen: false)
        .setUsername((info[1] as LoginData).username);
        */
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("home rebuild");
    }
    return Scaffold(
      appBar: AppBarTextField(
        title: Text(widget.title),
        onBackPressed: () {
          keyword = "";
          _refreshIndicatorKey.currentState?.show();
        },
        onClearPressed: () {
          keyword = "";
          _refreshIndicatorKey.currentState?.show();
        },
        onChanged: (value) {
          keyword = value;
          _refreshIndicatorKey.currentState?.show();
        },
        trailingActionButtons: [
          IconButton(
              onPressed: () {
                _refreshIndicatorKey.currentState?.show();
              },
              icon: const Icon(Icons.refresh)),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(value: 0, child: Text("Menu 1")),
                const PopupMenuItem(value: 1, child: Text("Latihan UI")),
                const PopupMenuItem(value: 2, child: Text("Menu 3")),
              ];
            },
            onSelected: (value) {
              if (value == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LatihanUiPage();
                }));
              }
            },
          )
        ],
      ),
      // appBar: AppBar(
      //   title: Text(widget.title),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           _refreshIndicatorKey.currentState?.show();
      //         },
      //         icon: const Icon(Icons.refresh)),
      //     PopupMenuButton(
      //       itemBuilder: (BuildContext context) {
      //         return [
      //           const PopupMenuItem(value: 0, child: Text("Menu 1")),
      //           const PopupMenuItem(value: 1, child: Text("Test Page")),
      //           const PopupMenuItem(value: 2, child: Text("Menu 3")),
      //         ];
      //       },
      //       onSelected: (value) {
      //         if (value == 1) {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) {
      //             return const LatihanUiPage();
      //           }));
      //         }
      //       },
      //     )
      //   ],
      // ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Stack(children: [
                const Align(
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
                        Text(_loginData.name),
                        Text("@${_loginData.username}"),

                        //use consumer if we use provider
                        // Consumer<AppRoot>(builder: (context, appRoot, child) {
                        //   return Text("@${appRoot.username}");
                        // }),
                      ],
                    )),
              ]),
            ),
            Visibility(
                visible: false,
                child: ListTile(title: const Text("Home"), onTap: () {})),
            Consumer<AppRoot>(
              builder: (context, appRoot, child) {
                if (kDebugMode) {
                  print("rebuild logout menu");
                }
                return Visibility(
                  visible: _isLoggedIn,
                  child: ListTile(
                      title: const Text("Logout"),
                      onTap: () {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Logout Confirmation'),
                                content:
                                    const Text("Are you sure want to logout?"),
                                actions: [
                                  ElevatedButton(
                                    child: const Text('yes'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      LoginUtil.logout().then((value) => {
                                            Provider.of<AppRoot>(context,
                                                    listen: false)
                                                .setLoggedOut(),
                                            checkLogin(),
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Logout berhasil"))),
                                          });
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text('cancel'),
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
                if (kDebugMode) {
                  print("rebuild login menu");
                }
                return Visibility(
                  visible: !_isLoggedIn,
                  child: ListTile(
                      title: const Text("Login"),
                      onTap: () {
                        //close drawer
                        Navigator.pop(context);
                        //open login page

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginPage();
                        })).then((isLoggedInNow) {
                          if (kDebugMode) {
                            print("login return : $isLoggedInNow");
                          }
                          checkLogin();
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
                        return InkWell(
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
                                    child: (news.photo?.isNotEmpty ?? false)
                                        ? Image.network(news.photo!,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.cover)
                                        : null,
                                  ),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Opacity(
                                          opacity: 0.7,
                                          child: Container(
                                              color: Colors.black,
                                              child: ListTile(
                                                  title: Text(news.title ?? "-",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium
                                                          ?.apply(
                                                              color:
                                                                  Colors.white,
                                                              fontSizeDelta: 2,
                                                              fontWeightDelta:
                                                                  4)),
                                                  subtitle: Text(
                                                      news.summary ?? "-",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall
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
                  return const Center(
                    child: Text("Ooops data kosong"),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("ada error: ${snapshot.error}"),
                );
              }

              return const Center(
                child: CustomLoader(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          LoginUtil.isLoggedIn().then((value) {
            if (value) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AddNewsPage();
              })).then((isSuccess) => {_refreshNews()});
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const LoginPage();
              })).then((isLoggedInNow) {
                if (kDebugMode) {
                  print("login return : $isLoggedInNow");
                }
                checkLogin();
              });
            }
          });
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<NewsResponse?> _refreshNews() async {
    if (kDebugMode) {
      print("run refresh news");
    }
    setState(() {
      _newsResponseFuture = _getNewsAll();
    });
    return _newsResponseFuture;
  }

  Future<NewsResponse> _getNewsAll() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final response = await http.post(
        Uri.https(Config.baseAuthority, Config.getNewsListPath()),
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'QVBJS0VZPXF3ZXJ0eTEyMzQ1Ng==',
          'x-packagename': packageInfo.packageName,
          'x-platform': "android"
        },
        body: <String, String>{
          'groupcode': Config.groupCode,
          'keyword': keyword,
        });
    //print(response.statusCode);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      return newsResponseFromJson(response.body);
    } else {
      //throw Exception('Failed to get list.');
      //or
      return Future.error("Failed to get list.");
    }
  }
}
