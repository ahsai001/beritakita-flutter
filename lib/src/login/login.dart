import 'package:beritakita/src/configs/config.dart';
import 'package:beritakita/src/login/models/login_request.dart';
import 'package:beritakita/src/login/models/login_response.dart';
import 'package:beritakita/src/utils/login_util.dart';
import 'package:beritakita/src/widgets/color_loader.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginRequest request = LoginRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Icon(Icons.ac_unit),
                ),
                TextFormField(
                    decoration: InputDecoration(labelText: "Username"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please insert username";
                      }
                    },
                    onSaved: (value) {
                      request.username = value!;
                    }),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert password";
                    }
                  },
                  onSaved: (value) {
                    request.password = value!;
                  },
                ),
                Builder(builder: (context) {
                  return ElevatedButton(
                    child: Text("login"),
                    onPressed: () {
                      //FormState? _formState = _formKey.currentState;
                      FormState? _formState = Form.of(
                          context); //to use this, need Builder widget inside Form
                      if (_formState?.validate() ?? false) {
                        _formState?.save();
                        //hit to web service
                        showDialog(
                            context: context,
                            builder: (context) {
                              return WillPopScope(
                                  child: ColorLoader(
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
                                SnackBar(content: Text("Login Berhasil")));
                            LoginUtil.saveLoginData(value.data);
                            Navigator.pop(context); //close loading dialog
                            Navigator.pop(context, true); //close login
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Login Gagal")));
                            Navigator.pop(context); //close loading dialog
                            Navigator.pop(context, false); //close login
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
    final response = await http.post(
        Uri.https(Config.BASE_AUTHORITY, Config.getLoginPath()),
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'QVBJS0VZPXF3ZXJ0eTEyMzQ1Ng==',
          'x-packagename': "com.ahsailabs.beritakita",
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
