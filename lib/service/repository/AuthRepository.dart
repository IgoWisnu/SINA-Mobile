import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sina_mobile/service/api/ApiService.dart';

import '../../Model/user.dart';

class AuthRepository{
  AuthRepository(this.apiService);
  final ApiService apiService;

  Future<User> login(String email, String password) async {
    final response = await apiService.client.post(
      apiService.buildUrl('login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return User.fromJson(json); // langsung gunakan json, bukan json['data']
    } else {
      throw Exception('Login gagal: ${response.body}');
    }
  }

}