import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/Guru/DashboardGuru.dart';
import 'package:sina_mobile/Model/Guru/JadwalGuru.dart';
import 'package:sina_mobile/Model/Guru/ListSiswa.dart';
import 'package:sina_mobile/Model/JadwalResponse.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';

class AbsensiGuruRepository {
  final ApiServiceGuru apiService;

  AbsensiGuruRepository(this.apiService);

  Future<List<JadwalItem>> fetchMapelHariIni() async {
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
      final jsonBody = jsonDecode(response.body);
      final jadwalResponse = JadwalGuru.fromJson(jsonBody);
      return jadwalResponse.data;
    } else {
      throw Exception('Gagal mengambil data tugas : ${response.body}');
    }
  }

  Future<List<AbsensiSiswa>> fetchSiswa(String mapelId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/siswa/$mapelId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final jadwalResponse = ListSiswa.fromJson(jsonBody);
      return jadwalResponse.data;
    } else {
      throw Exception('Gagal mengambil data tugas : ${response.body}');
    }
  }

  Future<bool> kirimAbsensi(
    Map<String, dynamic> payload,
    String jadwalId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.post(
      apiService.buildUrl('dashboard/absensi/$jadwalId'),
      // ganti sesuai endpoint kamu
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      // bisa dicek nilai kembalian jika perlu
      return true;
    } else {
      throw Exception('Gagal mengirim absensi: ${response.body}');
    }
  }
}
