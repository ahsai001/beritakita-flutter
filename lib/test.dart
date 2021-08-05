import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//stateless page
class StatelessPage extends StatelessWidget {
  const StatelessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//stateful page
class StatefulPage extends StatefulWidget {
  const StatefulPage({Key? key}) : super(key: key);

  @override
  _StatefulPageState createState() => _StatefulPageState();
}

class _StatefulPageState extends State<StatefulPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//material app
class MaterialTestApp extends StatelessWidget {
  const MaterialTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Berita Kita",
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          fontFamily: 'Georgia',
          textTheme: TextTheme(
              headline1: TextStyle(fontSize: 72.0),
              headline6: TextStyle(fontSize: 32.0),
              bodyText2: TextStyle(fontSize: 14.0))),
      home: StatelessPage(),
    );
  }
}

//cupertino app
class CupertinoTestApp extends StatelessWidget {
  const CupertinoTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "Berita Kita",
      theme: CupertinoThemeData(
          brightness: Brightness.dark,
          barBackgroundColor: CupertinoColors.activeBlue,
          primaryColor: CupertinoColors.darkBackgroundGray,
          textTheme: CupertinoTextThemeData(
              textStyle: TextStyle(fontSize: 10.0),
              actionTextStyle: TextStyle(fontSize: 14.0),
              tabLabelTextStyle: TextStyle(fontSize: 12.0))),
      home: StatelessPage(),
    );
  }
}

//material page
class MaterialTestPage extends StatefulWidget {
  const MaterialTestPage({Key? key}) : super(key: key);

  @override
  _MaterialTestPageState createState() => _MaterialTestPageState();
}

class _MaterialTestPageState extends State<MaterialTestPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text("Material Page")),
      body: IndexedStack(
        index: _selectedIndex,
        children: _tabs,
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(child: Text("header")),
          ListTile(
            title: Text("menu 1"),
            onTap: () {},
          ),
          ListTile(
            title: Text("menu 2"),
            onTap: () {},
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Item 1"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Item 2"),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            //bottom sheet
            scaffoldKey.currentState?.showBottomSheet((context) => Container(
                  height: 250,
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: Text('This is Bottom Sheet'),
                ));

            //snack bar
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Hello snackbar")));

            //alert dialog
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("dialog title"),
                    content: Text("dialog content"),
                    actions: [
                      ElevatedButton(
                        child: Text('yes'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(
                        child: Text('no'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                });
          },
          child: Icon(Icons.add)),
    );
  }
}

//cupertino page
class CupertinoTestPage extends StatefulWidget {
  const CupertinoTestPage({Key? key}) : super(key: key);

  @override
  _CupertinoTestPageState createState() => _CupertinoTestPageState();
}

class _CupertinoTestPageState extends State<CupertinoTestPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino Page"),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Item 1"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Item 2"),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return _tabs[index];
        },
      ),
    );
  }
}

List<Widget> _tabs = [
  FirstPage(),
  SecondPage(),
];

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigatorPane(
      builder: (context) {
        return Container(
          child: GestureDetector(
            child: Center(child: Text("First Page")),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FirstChildPage();
              }));
            },
          ),
        );
      },
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigatorPane(
      builder: (context) {
        return Container(
          child: GestureDetector(
            child: Center(child: Text("Second Page")),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SecondChildPage();
              }));
            },
          ),
        );
      },
    );
  }
}

class FirstChildPage extends StatelessWidget {
  const FirstChildPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Back"),
        ),
      ),
    );
  }
}

class SecondChildPage extends StatelessWidget {
  const SecondChildPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Back"),
        ),
      ),
    );
  }
}

//this class same as CupertinoTabView in managing navigator stack
class NavigatorPane extends StatelessWidget {
  const NavigatorPane({Key? key, required this.builder}) : super(key: key);
  final Widget Function(BuildContext) builder;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: builder);
      },
    );
  }
}
