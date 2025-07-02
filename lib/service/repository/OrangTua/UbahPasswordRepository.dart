import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';
import 'package:sina_mobile/Model/OrangTua/UpdatePasswordRequest.dart';

class UbahPasswordRepository {
  final ApiServiceOrangTua apiService;

  UbahPasswordRepository(this.apiService);

  Future<void> ubahPassword(UpdatePasswordRequest request) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final url = apiService.buildUrl('dashboard/ortu/password');

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Gagal mengubah password');
    }
  }
}
