import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  bool _switchValue = false;
  bool _checkboxValue1 = false;
  bool _checkboxValue2 = false;
  bool _checkboxValue3 = false;
  int? _radioValue = 1;
  String? _dropdownValue = "IOS";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Page"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Text("Hello Text"),
            TextField(
              decoration: InputDecoration(
                labelText: "Hello",
              ),
              toolbarOptions: ToolbarOptions(copy: true, paste: true),
            ),
            ElevatedButton(onPressed: () {}, child: Text('click')),
            SwitchListTile(
                title: Text("Title"),
                subtitle: Text("Subtitle"),
                secondary: Text("secondary"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                }),
            CheckboxListTile(
                title: Text("Title"),
                subtitle: Text("Subtitle"),
                secondary: Text("secondary"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _checkboxValue1,
                onChanged: (value) {
                  setState(() {
                    _checkboxValue1 = value!;
                  });
                }),
            CheckboxListTile(
                title: Text("Title"),
                subtitle: Text("Subtitle"),
                secondary: Text("secondary"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _checkboxValue2,
                onChanged: (value) {
                  setState(() {
                    _checkboxValue2 = value!;
                  });
                }),
            CheckboxListTile(
                title: Text("Title"),
                subtitle: Text("Subtitle"),
                secondary: Text("secondary"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _checkboxValue3,
                onChanged: (value) {
                  setState(() {
                    _checkboxValue3 = value!;
                  });
                }),
            RadioListTile(
                title: Text("Title"),
                subtitle: Text("Subtitle"),
                secondary: Text("secondary"),
                controlAffinity: ListTileControlAffinity.leading,
                value: 1,
                onChanged: (int? value) {
                  setState(() {
                    _radioValue = value!;
                  });
                },
                groupValue: _radioValue),
            RadioListTile(
                title: Text("Title"),
                subtitle: Text("Subtitle"),
                secondary: Text("secondary"),
                controlAffinity: ListTileControlAffinity.leading,
                value: 2,
                onChanged: (int? value) {
                  setState(() {
                    _radioValue = value!;
                  });
                },
                groupValue: _radioValue),
            RadioListTile(
              title: Text("Title"),
              subtitle: Text("Subtitle"),
              secondary: Text("secondary"),
              controlAffinity: ListTileControlAffinity.leading,
              value: 3,
              onChanged: (int? value) {
                setState(() {
                  _radioValue = value!;
                });
              },
              groupValue: _radioValue,
            ),
            DropdownButton<String>(
              items: [
                DropdownMenuItem(value: "Android", child: Text("Android")),
                DropdownMenuItem(value: "IOS", child: Text("IOS")),
                DropdownMenuItem(value: "Windows", child: Text("Windows")),
              ],
              value: _dropdownValue,
              onChanged: (value) {
                setState(() {
                  _dropdownValue = value;
                });
              },
            ),
            UnconstrainedBox(
              child: CircularProgressIndicator(),
              alignment: Alignment.centerLeft,
            ),
          ],
        ),
      ),
    );
  }
}
