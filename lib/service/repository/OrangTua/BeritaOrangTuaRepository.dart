import 'dart:convert';
import 'package:sina_mobile/Model/OrangTua/BeritaOrangTua.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';

class BeritaOrangTuaRepository {
  final ApiServiceOrangTua apiService;

  BeritaOrangTuaRepository(this.apiService);

  Future<List<Berita>> getBeritaOrangTua() async {
    // Ambil token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/berita'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Berita = BeritaOrangTuaResponse.fromJson(json);
      return Berita.data;
    } else {
      throw Exception(
        'Kesalahan dalam mengambil berita: ${response.body}' +
            '$token'
                ' (Status Code: ${response.statusCode})',
      );
    }
  }
}
