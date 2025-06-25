import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/Guru/NilaiRaporModel.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';

class NilaiRepository {
  final ApiServiceGuru apiService;

  NilaiRepository(this.apiService);

  Future<List<Mapel>> getMapelYangDiajar() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/nilai/mapel'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return (data['data'] as List)
            .map((item) => Mapel.fromJson(item))
            .toList();
      }
    }
    throw Exception('Failed to load mapel: ${response.statusCode}');
  }

  Future<List<Kelas>> getKelasByMapel(String mapelId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/nilai/mapel/$mapelId/kelas'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return (data['data'] as List)
            .map((item) => Kelas.fromJson(item))
            .toList();
      }
    }
    throw Exception('Failed to load kelas: ${response.statusCode}');
  }

  Future<List<SiswaNilai>> getSiswaByMapelKelas(
    String mapelId,
    String kelasId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    final response = await apiService.client.get(
      apiService.buildUrl(
        'dashboard/nilai/mapel/$mapelId/kelas/$kelasId/siswa',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return (data['data'] as List)
            .map((item) => SiswaNilai.fromJson(item))
            .toList();
      }
    }
    throw Exception('Failed to load siswa: ${response.statusCode}');
  }

  Future<bool> submitNilai({
    required String krsId,
    required int nilai,
    required String status,
    required String mapelId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    final response = await apiService.client.put(
      apiService.buildUrl('dashboard/nilai/$krsId/$status'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'mapel_id': mapelId, 'nilai': nilai}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['success'] == true;
    }
    throw Exception('Failed to submit nilai: ${response.statusCode}');
  }
}
