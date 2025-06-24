import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/OrangTua/Siswa.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';

class DaftarSiswaRepository {
  ApiServiceOrangTua apiService;

  DaftarSiswaRepository(this.apiService);

  Future<List<Siswa>> fetchSiswaByOrtu() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception("Token tidak ditemukan");
    }

    final response = await http.get(
      apiService.buildUrl('dashboard/siswa'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['data'];

      return data.map((item) => Siswa.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data siswa: ${response.body}');
    }
  }
}
