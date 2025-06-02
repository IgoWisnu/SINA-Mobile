import 'dart:ffi';

class User {
  final String message;
  final String token;
  final UserData data;

  User({
    required this.message,
    required this.token,
    required this.data,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      message: json['message'],
      token: json['token'],
      data: UserData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'data': data.toJson(),
    };
  }
}

class UserData {
  final int userId;
  final String email;
  final String role;

  UserData({
    required this.userId,
    required this.email,
    required this.role,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: int.parse(json['userId'].toString()),
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'role': role,
    };
  }
}
