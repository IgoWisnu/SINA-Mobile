import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/Guru/DashboardGuru.dart';
import 'package:sina_mobile/Model/Guru/JadwalGuru.dart';
import 'package:sina_mobile/Model/JadwalResponse.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';


class DashboardGuruRepository {
  final ApiServiceGuru apiService;

  DashboardGuruRepository(this.apiService);


  Future<List<JadwalItem>> fetchMapelHariIni() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/jadwal'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final jadwalResponse = JadwalGuru.fromJson(jsonBody);
      return jadwalResponse.data;
    } else {
      throw Exception('Gagal mengambil data tugas : ${response.body}');
    }
  }

  Future<List<JadwalItem>> fetchSiswa () async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/jadwal'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final jadwalResponse = JadwalGuru.fromJson(jsonBody);
      return jadwalResponse.data;
    } else {
      throw Exception('Gagal mengambil data tugas : ${response.body}');
    }
  }



}
