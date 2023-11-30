// To parse this JSON data, do
//
//     final newsResponse = newsResponseFromJson(jsonString);

import 'dart:convert';

NewsResponse newsResponseFromJson(String str) =>
    NewsResponse.fromJson(json.decode(str));

String newsResponseToJson(NewsResponse data) => json.encode(data.toJson());

class NewsResponse {
  int? status;
  String? message;
  List<News>? data;

  NewsResponse({
    this.status,
    this.message,
    this.data,
  });

  NewsResponse copyWith({
    int? status,
    String? message,
    List<News>? data,
  }) =>
      NewsResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<News>.from(json["data"]!.map((x) => News.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class News {
  String? id;
  String? title;
  String? summary;
  String? photo;
  String? createdAt;
  String? createdBy;

  News({
    this.id,
    this.title,
    this.summary,
    this.photo,
    this.createdAt,
    this.createdBy,
  });

  News copyWith({
    String? id,
    String? title,
    String? summary,
    String? photo,
    String? createdAt,
    String? createdBy,
  }) =>
      News(
        id: id ?? this.id,
        title: title ?? this.title,
        summary: summary ?? this.summary,
        photo: photo ?? this.photo,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
      );

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        title: json["title"],
        summary: json["summary"],
        photo: json["photo"],
        createdAt: json["created_at"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "summary": summary,
        "photo": photo,
        "created_at": createdAt,
        "created_by": createdBy,
      };
}
