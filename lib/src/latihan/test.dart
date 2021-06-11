import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Page"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello Text"),
            TextField(
              decoration: InputDecoration(
                labelText: "Hello",
              ),
              toolbarOptions: ToolbarOptions(copy: true, paste: true),
            ),
            // SwitchListTile(
            //     title: Text("OK?"), value: true, onChanged: (value) {}),
            // Row(
            //   children: [
            //     CheckboxListTile(
            //         title: Text("Android"), value: false, onChanged: (value) {}),
            //     CheckboxListTile(
            //         title: Text("IOS"), value: false, onChanged: (value) {}),
            //     CheckboxListTile(
            //         title: Text("Windows"), value: false, onChanged: (value) {})
            //   ],
            // ),
            // Row(
            //   children: [
            //     RadioListTile(
            //         title: Text("Android"),
            //         value: false,
            //         onChanged: (value) {},
            //         groupValue: true),
            //     RadioListTile(
            //         title: Text("IOS"),
            //         value: false,
            //         onChanged: (value) {},
            //         groupValue: true),
            //     RadioListTile(
            //       title: Text("Windows"),
            //       value: false,
            //       onChanged: (value) {},
            //       groupValue: true,
            //     )
            //   ],
            // ),
            // DropdownButton<String>(
            //   items: [
            //     DropdownMenuItem(child: Text("Android")),
            //     DropdownMenuItem(child: Text("IOS")),
            //     DropdownMenuItem(child: Text("Windows")),
            //   ],
            // ),
            // CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
