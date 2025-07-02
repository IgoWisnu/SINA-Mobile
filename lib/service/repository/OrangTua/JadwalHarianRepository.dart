import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/OrangTua/jadwalRespon.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';

class JadwalHarianRepository {
  final ApiServiceOrangTua apiService;

  JadwalHarianRepository(this.apiService);

  Future<List<Jadwal>> getJadwal(String hari) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final nis = prefs.getString('nis');

    if (token == null || nis == null) {
      throw Exception('Token atau NIS tidak ditemukan');
    }

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/jadwal/$nis/$hari'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final jadwal = JadwalResponse.fromJson(json);
      return jadwal.jadwalPelajaran;
    } else if (response.statusCode == 404 ||
        response.body.contains("tidak memiliki akses")) {
      return []; // Kembalikan list kosong agar UI tidak error
    } else {
      throw Exception('Gagal mengambil jadwal: ${response.body}');
    }
  }
}
