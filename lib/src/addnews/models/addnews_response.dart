import 'dart:convert';

class AddNewsResponse {
  final int status;
  final String message;
  AddNewsResponse({
    required this.status,
    required this.message,
  });

  AddNewsResponse copyWith({
    int? status,
    String? message,
  }) {
    return AddNewsResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory AddNewsResponse.fromMap(Map<String, dynamic> map) {
    return AddNewsResponse(
      status: map['status']?.toInt(),
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddNewsResponse.fromJson(String source) =>
      AddNewsResponse.fromMap(json.decode(source));

  @override
  String toString() => 'AddNewsResponse(status: $status, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddNewsResponse &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
