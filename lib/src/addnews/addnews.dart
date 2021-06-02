import 'package:flutter/material.dart';

class AddNewsPage extends StatefulWidget {
  @override
  _AddNewsPageState createState() => _AddNewsPageState();
}

class _AddNewsPageState extends State<AddNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Title"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert title";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Summary"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert summary";
                    }
                  },
                ),
                OutlinedButton(
                  child: Text("photo"),
                  onPressed: () {},
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Body"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert body";
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
