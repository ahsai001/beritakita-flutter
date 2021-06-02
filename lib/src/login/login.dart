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
                      FormState? _formState = Form.of(context);
                      if (_formState?.validate() ?? false) {
                        _formState?.save();
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
