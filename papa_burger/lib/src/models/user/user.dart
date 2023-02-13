class User {
  final String token;
  final String? email;
  final String? username;
  User({
    required this.token,
    this.email,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json['token'],
        email: json['email'],
        username: json['username'],
      );
}
