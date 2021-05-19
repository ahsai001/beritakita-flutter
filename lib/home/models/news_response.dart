import 'dart:convert';

class NewsResponse {
  final int status;
  final String message;
  final List<News>? data;
  NewsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  NewsResponse copyWith({
    int? status,
    String? message,
    List<News>? data,
  }) {
    return NewsResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory NewsResponse.fromMap(Map<String, dynamic> map) {
    return NewsResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: List<News>.from(map['data']?.map((x) => News.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsResponse.fromJson(String source) =>
      NewsResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'NewsResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    /*final listEquals = const DeepCollectionEquality().equals;

    return other is NewsResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);*/
    return false;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}

class News {
  final String id;
  final String title;
  final String summary;
  final String photo;
  final String created_at;
  final String created_by;
  News({
    required this.id,
    required this.title,
    required this.summary,
    required this.photo,
    required this.created_at,
    required this.created_by,
  });

  News copyWith({
    String? id,
    String? title,
    String? summary,
    String? photo,
    String? created_at,
    String? created_by,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      photo: photo ?? this.photo,
      created_at: created_at ?? this.created_at,
      created_by: created_by ?? this.created_by,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'photo': photo,
      'created_at': created_at,
      'created_by': created_by,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id'],
      title: map['title'],
      summary: map['summary'],
      photo: map['photo'],
      created_at: map['created_at'],
      created_by: map['created_by'],
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) => News.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(id: $id, title: $title, summary: $summary, photo: $photo, created_at: $created_at, created_by: $created_by)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is News &&
        other.id == id &&
        other.title == title &&
        other.summary == summary &&
        other.photo == photo &&
        other.created_at == created_at &&
        other.created_by == created_by;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        summary.hashCode ^
        photo.hashCode ^
        created_at.hashCode ^
        created_by.hashCode;
  }
}
