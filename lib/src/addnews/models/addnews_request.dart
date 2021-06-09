import 'dart:io';

class AddNewsRequest {
  String title;
  String summary;
  File? photo;
  String body;

  AddNewsRequest({
    this.title = "",
    this.summary = "",
    this.body = "",
  });
}
