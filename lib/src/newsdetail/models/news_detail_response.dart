// To parse this JSON data, do
//
//     final newsDetailResponse = newsDetailResponseFromJson(jsonString);

import 'dart:convert';

NewsDetailResponse newsDetailResponseFromJson(String str) =>
    NewsDetailResponse.fromJson(json.decode(str));

String newsDetailResponseToJson(NewsDetailResponse data) =>
    json.encode(data.toJson());

class NewsDetailResponse {
  int? status;
  String? message;
  NewsDetail? data;

  NewsDetailResponse({
    this.status,
    this.message,
    this.data,
  });

  NewsDetailResponse copyWith({
    int? status,
    String? message,
    NewsDetail? data,
  }) =>
      NewsDetailResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory NewsDetailResponse.fromJson(Map<String, dynamic> json) =>
      NewsDetailResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : NewsDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class NewsDetail {
  String? id;
  String? groupId;
  String? title;
  String? summary;
  String? photo;
  String? body;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  NewsDetail({
    this.id,
    this.groupId,
    this.title,
    this.summary,
    this.photo,
    this.body,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  NewsDetail copyWith({
    String? id,
    String? groupId,
    String? title,
    String? summary,
    String? photo,
    String? body,
    String? createdAt,
    String? createdBy,
    String? updatedAt,
    String? updatedBy,
  }) =>
      NewsDetail(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        title: title ?? this.title,
        summary: summary ?? this.summary,
        photo: photo ?? this.photo,
        body: body ?? this.body,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedBy: updatedBy ?? this.updatedBy,
      );

  factory NewsDetail.fromJson(Map<String, dynamic> json) => NewsDetail(
        id: json["id"],
        groupId: json["group_id"],
        title: json["title"],
        summary: json["summary"],
        photo: json["photo"],
        body: json["body"],
        createdAt: json["created_at"],
        createdBy: json["created_by"],
        updatedAt: json["updated_at"],
        updatedBy: json["updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_id": groupId,
        "title": title,
        "summary": summary,
        "photo": photo,
        "body": body,
        "created_at": createdAt,
        "created_by": createdBy,
        "updated_at": updatedAt,
        "updated_by": updatedBy,
      };
}
