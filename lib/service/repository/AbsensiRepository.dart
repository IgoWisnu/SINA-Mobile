import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/RekapAbsen.dart';
import 'package:sina_mobile/Model/RiwayatSuratAbsenResponse.dart';
import '../../service/api/ApiService.dart';

class AbsensiRepository {
  final ApiService apiService;

  AbsensiRepository(this.apiService);

  Future<RekapAbsenData> getRekapAbsen() async {
    //ambil token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/ringkasan'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final rekap = RekapAbsen.fromJson(json);
      return rekap.data;
    } else {
      throw Exception('Gagal mengambil data kelas: ${response.body}'+' $token');
    }
  }

  Future <List<SuratAbsen>> getRekapData() async {
    //ambil token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/surat-absen'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final rekap = RiwayatSuratAbsenResponse.fromJson(json);
      return rekap.data;
    } else {
      throw Exception('Gagal mengambil data kelas: ${response.body}'+' $token');
    }
  }


}
