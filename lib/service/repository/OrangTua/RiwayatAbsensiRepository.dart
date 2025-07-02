// lib/service/repository/OrangTua/RiwayatAbsensiRepository.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/OrangTua/RiwayatAbsensi.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';

class RiwayatAbsensiRepository {
  final ApiServiceOrangTua apiService;

  RiwayatAbsensiRepository(this.apiService);

  Future<List<RiwayatAbsensi>> getRiwayatAbsensi() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final nis = prefs.getString('nis');

    if (token == null || nis == null) {
      throw Exception("Token atau NIS tidak ditemukan");
    }

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/riwayat-absensi/$nis'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['data'];
      return data.map((e) => RiwayatAbsensi.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw Exception("Tidak ada riwayat absensi yang ditemukan");
    } else if (response.statusCode == 403) {
      throw Exception("Orang tua tidak memiliki akses ke data siswa ini");
    } else if (response.statusCode == 500) {
      throw Exception("Terjadi kesalahan pada server (500)");
    } else {
      throw Exception("Gagal mengambil riwayat absensi: ${response.body}");
    }
  }
}
