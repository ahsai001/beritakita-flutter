import 'dart:io';
import 'package:beritakita/src/addnews/models/addnews_request.dart';
import 'package:beritakita/src/addnews/models/addnews_response.dart';
import 'package:beritakita/src/configs/config.dart';
import 'package:beritakita/src/login/models/login_response.dart';
import 'package:beritakita/src/utils/login_util.dart';
import 'package:beritakita/src/widgets/app_root.dart';
import 'package:beritakita/src/widgets/color_loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddNewsPage extends StatefulWidget {
  @override
  _AddNewsPageState createState() => _AddNewsPageState();
}

class _AddNewsPageState extends State<AddNewsPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddNewsRequest request = AddNewsRequest();
  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add News")),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Title"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert title";
                    }
                  },
                  onSaved: (value) {
                    request.title = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Summary", alignLabelWithHint: true),
                  minLines: 4,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert summary";
                    }
                  },
                  onSaved: (value) {
                    request.summary = value!;
                  },
                ),
                OutlinedButton(
                  child: Text("photo"),
                  onPressed: () {
                    _showImagePicker();
                  },
                ),
                Center(
                  child: _image == null
                      ? Text('No image selected.')
                      : Image.file(_image!),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Body", alignLabelWithHint: true),
                  minLines: 7,
                  maxLines: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert body";
                    }
                  },
                  onSaved: (value) {
                    request.body = value!;
                  },
                ),
                SizedBox(
                  width: 400,
                  child: ElevatedButton(
                      onPressed: () {
                        FormState? _formState = _formKey.currentState;
                        if (_formState?.validate() ?? false) {
                          _formState?.save();
                          //show loading indicator
                          showDialog(
                              context: context,
                              builder: (context) {
                                return WillPopScope(
                                    //use this to disable back button
                                    child: ColorLoader(
                                      radius: 20,
                                      dotRadius: 5,
                                    ),
                                    onWillPop: () async {
                                      return false;
                                    });
                              },
                              barrierDismissible: false);

                          //hit to web service
                          _addNews(request)?.then((value) {
                            print(value);
                            if (value.status == 1) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Tambah berita Berhasil")));
                              Navigator.pop(context); //close loading dialog
                              Navigator.pop(
                                  context, true); //close add news page
                              //use returned data when pop or use code below
                              Provider.of<AppRoot>(context, listen: false)
                                  .refreshNewsList();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Tambah berita Gagal")));
                              Navigator.pop(context); //close loading dialog
                            }
                          });
                        }
                      },
                      child: Text("submit")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<AddNewsResponse>? _addNews(AddNewsRequest request) async {
    var mpRequest = http.MultipartRequest(
        'POST', Uri.https(Config.BASE_AUTHORITY, Config.getAddNewsPath()));
    mpRequest.files.add(http.MultipartFile(
        'photo', _image!.readAsBytes().asStream(), _image!.lengthSync(),
        filename: _image!.path.split("/").last)); //filename required

    mpRequest.fields['title'] = request.title;
    mpRequest.fields['summary'] = request.summary;
    mpRequest.fields['body'] = request.body;
    mpRequest.fields['groupcode'] = Config.GROUP_CODE;

    LoginData loginData = await LoginUtil.getLoginData();

    mpRequest.headers.addAll(<String, String>{
      //'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'QVBJS0VZPXF3ZXJ0eTEyMzQ1Ng==',
      'x-packagename': "com.ahsailabs.beritakita",
      'x-platform': "android",
      'x-token': loginData.token
    });

    http.Response response =
        await http.Response.fromStream(await mpRequest.send());

    if (response.statusCode == 200) {
      //print(response.body);
      return AddNewsResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to get list.');
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _imgFromCamera() async {
    PickedFile? pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _imgFromGallery() async {
    PickedFile? pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
