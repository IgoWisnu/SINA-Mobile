class User {
  final String message;
  final String token;

  User({required this.message, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      message: json['message'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
    };
  }
}
