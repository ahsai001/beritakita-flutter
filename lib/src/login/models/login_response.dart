import 'dart:convert';

class LoginResponse {
  final int status;
  final String message;
  final LoginData data;
  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  LoginResponse copyWith({
    int? status,
    String? message,
    LoginData? data,
  }) {
    return LoginResponse(
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

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: LoginData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginResponse &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}

class LoginData {
  final String token;
  final String name;
  final String username;
  LoginData({
    required this.token,
    required this.name,
    required this.username,
  });

  LoginData copyWith({
    String? token,
    String? name,
    String? username,
  }) {
    return LoginData(
      token: token ?? this.token,
      name: name ?? this.name,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'name': name,
      'username': username,
    };
  }

  factory LoginData.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return LoginData(token: "", name: "guest", username: "guest");
    }

    return LoginData(
      token: map['token'],
      name: map['name'],
      username: map['username'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginData.fromJson(String source) =>
      LoginData.fromMap(json.decode(source));

  @override
  String toString() => 'Data(token: $token, name: $name, username: $username)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginData &&
        other.token == token &&
        other.name == name &&
        other.username == username;
  }

  @override
  int get hashCode => token.hashCode ^ name.hashCode ^ username.hashCode;
}
