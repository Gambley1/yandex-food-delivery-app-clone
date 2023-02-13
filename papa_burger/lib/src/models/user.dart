// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String token;
  final String? email;
  final String? username;

  User({
    required this.token,
    this.email,
    this.username,
  });

  User copyWith({
    String? token,
    String? email,
    String? username,
  }) {
    return User(
      token: token ?? this.token,
      email: email ?? this.email,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'email': email,
      'username': username,
    };
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      token: json['token'] as String,
      email: json['email'] != null ? json['email'] as String : null,
      username: json['username'] != null ? json['username'] as String : null,
    );
  }
  factory User.fromJson(Map<String, dynamic> json) => User.fromMap(json);

  String toJson() => json.encode(toMap());
}
