import 'package:beritakita/src/widgets/color_loader.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                CircleAvatar(),
                TextFormField(
                    decoration: InputDecoration(labelText: "Username"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please insert username";
                      }
                    },
                    onSaved: (value) {}),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert password";
                    }
                  },
                  onSaved: (value) {},
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

                        /*showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Hellow'),
                                content: Text("ini adalah informasi"),
                                actions: [
                                  ElevatedButton(
                                    child: Text('yes'),
                                    onPressed: () {
                                      Navigator.pop(context)
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text('cancel'),
                                    onPressed: () {
                                      Navigator.pop(context)
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text('ignore'),
                                    onPressed: () {
                                      Navigator.pop(context)
                                    },
                                  )
                                ],
                              );
                            });*/
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

                        Future.delayed(Duration(milliseconds: 5000))
                            .then((value) => {Navigator.pop(context)});
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ));
  }
}
