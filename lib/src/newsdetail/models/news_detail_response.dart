import 'dart:convert';

class NewsDetailResponse {
  final int status;
  final String message;
  final NewsDetail data;
  NewsDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  NewsDetailResponse copyWith({
    int? status,
    String? message,
    NewsDetail? data,
  }) {
    return NewsDetailResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data.toMap(),
    };
  }

  factory NewsDetailResponse.fromMap(Map<String, dynamic> map) {
    return NewsDetailResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: NewsDetail.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsDetailResponse.fromJson(String source) =>
      NewsDetailResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'NewsDetailResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsDetailResponse &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}

class NewsDetail {
  final String id;
  final String group_id;
  final String title;
  final String summary;
  final String photo;
  final String body;
  final String created_by;
  final String created_at;
  final String? updated_by;
  final String? updated_at;
  NewsDetail({
    required this.id,
    required this.group_id,
    required this.title,
    required this.summary,
    required this.photo,
    required this.body,
    required this.created_by,
    required this.created_at,
    this.updated_by,
    this.updated_at,
  });

  NewsDetail copyWith({
    String? id,
    String? group_id,
    String? title,
    String? summary,
    String? photo,
    String? body,
    String? created_by,
    String? created_at,
    String? updated_by,
    String? updated_at,
  }) {
    return NewsDetail(
      id: id ?? this.id,
      group_id: group_id ?? this.group_id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      photo: photo ?? this.photo,
      body: body ?? this.body,
      created_by: created_by ?? this.created_by,
      created_at: created_at ?? this.created_at,
      updated_by: updated_by ?? this.updated_by,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'group_id': group_id,
      'title': title,
      'summary': summary,
      'photo': photo,
      'body': body,
      'created_by': created_by,
      'created_at': created_at,
      'updated_by': updated_by,
      'updated_at': updated_at,
    };
  }

  factory NewsDetail.fromMap(Map<String, dynamic> map) {
    return NewsDetail(
      id: map['id'],
      group_id: map['group_id'],
      title: map['title'],
      summary: map['summary'],
      photo: map['photo'],
      body: map['body'],
      created_by: map['created_by'],
      created_at: map['created_at'],
      updated_by: map['updated_by'],
      updated_at: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsDetail.fromJson(String source) =>
      NewsDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewsDetail(id: $id, group_id: $group_id, title: $title, summary: $summary, photo: $photo, body: $body, created_by: $created_by, created_at: $created_at, updated_by: $updated_by, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsDetail &&
        other.id == id &&
        other.group_id == group_id &&
        other.title == title &&
        other.summary == summary &&
        other.photo == photo &&
        other.body == body &&
        other.created_by == created_by &&
        other.created_at == created_at &&
        other.updated_by == updated_by &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        group_id.hashCode ^
        title.hashCode ^
        summary.hashCode ^
        photo.hashCode ^
        body.hashCode ^
        created_by.hashCode ^
        created_at.hashCode ^
        updated_by.hashCode ^
        updated_at.hashCode;
  }
}
