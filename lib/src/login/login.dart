import 'package:beritakita/src/configs/config.dart';
import 'package:beritakita/src/login/models/login_request.dart';
import 'package:beritakita/src/login/models/login_response.dart';
import 'package:beritakita/src/utils/login_util.dart';
import 'package:beritakita/src/widgets/app_root.dart';
import 'package:beritakita/src/widgets/color_loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginRequest request = LoginRequest();

  @override
  Widget build(BuildContext context) {
    print("login rebuild");
    return Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.ac_unit),
                ),
                TextFormField(
                    decoration: const InputDecoration(labelText: "Username"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please insert username";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      request.username = value!;
                    }),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert password";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    request.password = value!;
                  },
                ),
                Builder(builder: (context) {
                  //we use Builder, if we want to use Form.of()
                  return ElevatedButton(
                    child: const Text("login"),
                    onPressed: () {
                      //FormState? _formState = _formKey.currentState;
                      FormState? formState = Form.of(
                          context); //to use this, need Builder widget inside Form
                      if (formState.validate() ?? false) {
                        formState.save();
                        //hit to web service
                        showDialog(
                            context: context,
                            builder: (context) {
                              return WillPopScope(
                                  //use this to disable back button
                                  child: const ColorLoader(
                                    radius: 20,
                                    dotRadius: 5,
                                  ),
                                  onWillPop: () async {
                                    return false;
                                  });
                            },
                            barrierDismissible: false);

                        /*Future.delayed(Duration(milliseconds: 5000))
                            .then((value) => {Navigator.pop(context)});*/
                        _login(request)?.then((LoginResponse value) {
                          if (value.status == 1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Login Berhasil")));
                            LoginUtil.saveLoginData(value.data).then((value) {
                              Navigator.pop(context); //close loading dialog
                              Navigator.pop(context, true); //close login
                              //use returned data when pop or use code below
                              Provider.of<AppRoot>(context, listen: false)
                                  .setLoggedIn();
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Login Gagal")));
                            Navigator.pop(context); //close loading dialog
                          }
                        });
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ));
  }

  Future<LoginResponse>? _login(LoginRequest request) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final response = await http.post(
        Uri.http(Config.BASE_AUTHORITY, Config.getLoginPath()),
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'QVBJS0VZPXF3ZXJ0eTEyMzQ1Ng==',
          'x-packagename': packageInfo.packageName,
          'x-platform': "android"
        },
        body: <String, String>{
          'username': request.username,
          'password': request.password,
        });

    if (response.statusCode == 200) {
      //print(response.body);
      return LoginResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to get list.');
    }
  }
}
