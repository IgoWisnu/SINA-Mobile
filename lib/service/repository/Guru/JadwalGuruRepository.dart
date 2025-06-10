import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/Guru/JadwalGuru.dart';
import 'package:sina_mobile/Model/JadwalResponse.dart';
import 'package:sina_mobile/Model/Tugas.dart';
import 'package:sina_mobile/Model/kelas.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';

class JadwalGuruRepository {
  final ApiServiceGuru apiService;

  JadwalGuruRepository(this.apiService);

  Future<List<JadwalItem>> getJadwal() async {
    //ambil token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/jadwal'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final jadwal = JadwalGuru.fromJson(json);
      return jadwal.data;
    } else {
      throw Exception('Gagal mengambil data jadwal: ${response.body}'+' $token');
    }
  }

}
