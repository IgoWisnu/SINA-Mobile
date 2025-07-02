import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/JadwalResponse.dart';

import '../../service/api/ApiService.dart';

class JadwalRepository {
  final ApiService apiService;

  JadwalRepository(this.apiService);

  Future<List<Jadwal>> getJadwal() async {
    //ambil token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/jadwal'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final jadwal = JadwalResponse.fromJson(json);
      return jadwal.jadwalPelajaran;
    } else {
      throw Exception(
        'Gagal mengambil data jadwal: ${response.body}' + ' $token',
      );
    }
  }
}
