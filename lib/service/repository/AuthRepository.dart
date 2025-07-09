import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/user.dart';
import '../../service/api/ApiServiceAuth.dart';

class AuthRepository {
  final ApiServiceAuth apiService;

  AuthRepository(this.apiService);

  Future<User> login(String email, String password) async {
    final response = await apiService.client.post(
      apiService.buildUrl('login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      // Ambil token dan simpan
      final token = json['token']; // atau json['data']['token'] sesuai API Anda
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
      }

      return User.fromJson(json); // Asumsikan User sudah meng-handle json yang full
    } else {
      throw Exception('Login gagal: ${response.body}');
    }
  }

  // Ambil token yang sudah disimpan
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Hapus token saat logout (optional)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<void> updatePassword(
      String oldPw,
      String newPw
      ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final uri = Uri.parse('http://sina.pnb.ac.id:3007/api/dashboard/profile');

    final request = http.MultipartRequest('PUT', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['password_lama'] = oldPw
      ..fields['password_baru'] = newPw
      ..fields['konfirmasi_password'] = newPw;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui password. (${response.statusCode}) ${response.body}');
    }
  }

}
