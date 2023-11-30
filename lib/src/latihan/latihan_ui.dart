import 'package:beritakita/src/widgets/custom_loading.dart';
import 'package:flutter/material.dart';

class LatihanUiPage extends StatefulWidget {
  const LatihanUiPage({Key? key}) : super(key: key);

  @override
  _LatihanUiPageState createState() => _LatihanUiPageState();
}

class _LatihanUiPageState extends State<LatihanUiPage> {
  bool _switchValue = false;
  bool _checkboxValue1 = false;
  bool _checkboxValue2 = false;
  int? _radioValue = 1;
  String? _dropdownValue = "IOS";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latihan UI"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(14),
          children: [
            const Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                //textDirection: TextDirection.ltr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                //softWrap: false,
                textAlign: TextAlign.center,
                style: TextStyle(
                    backgroundColor: Colors.blue,
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.lineThrough)),
            const TextField(
              decoration:
                  InputDecoration(labelText: "Hello", errorText: "Error Text"),
              //toolbarOptions: ToolbarOptions(copy: true, paste: true),
            ),
            const TextField(
              decoration: InputDecoration(
                  labelText: "Hello",
                  helperText: "Helper Text",
                  counter: Text("3")),
              //toolbarOptions: ToolbarOptions(copy: true, paste: true),
            ),
            Image.network('https://picsum.photos/250?image=9'),
            //Image(image: NetworkImage('https://picsum.photos/250?image=9')),
            ElevatedButton(onPressed: () {}, child: const Text('click')),
            SwitchListTile(
                title: const Text("Title"),
                subtitle: const Text("Subtitle"),
                secondary: const Text("secondary"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                }),
            CheckboxListTile(
                title: const Text("Title"),
                subtitle: const Text("Subtitle"),
                secondary: const Text("secondary"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _checkboxValue1,
                onChanged: (value) {
                  setState(() {
                    _checkboxValue1 = value!;
                  });
                }),
            CheckboxListTile(
                title: const Text("Title"),
                subtitle: const Text("Subtitle"),
                secondary: const Text("secondary"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _checkboxValue2,
                onChanged: (value) {
                  setState(() {
                    _checkboxValue2 = value!;
                  });
                }),
            RadioListTile(
                title: const Text("Title"),
                subtitle: const Text("Subtitle"),
                secondary: const Text("secondary"),
                controlAffinity: ListTileControlAffinity.leading,
                value: 1,
                onChanged: (int? value) {
                  setState(() {
                    _radioValue = value!;
                  });
                },
                groupValue: _radioValue),
            RadioListTile(
                title: const Text("Title"),
                subtitle: const Text("Subtitle"),
                secondary: const Text("secondary"),
                controlAffinity: ListTileControlAffinity.leading,
                value: 2,
                onChanged: (int? value) {
                  setState(() {
                    _radioValue = value!;
                  });
                },
                groupValue: _radioValue),
            DropdownButton<String>(
              items: const [
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
            const UnconstrainedBox(
              alignment: Alignment.centerLeft,
              child: CustomLoader(),
            ),
          ],
        ),
      ),
    );
  }
}
