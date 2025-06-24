import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/Guru/Guru.dart';
import 'package:sina_mobile/Model/Materi.dart';
import 'package:sina_mobile/Model/SiswaResponse.dart';
import 'package:sina_mobile/Model/Tugas.dart';
import 'package:sina_mobile/Model/kelas.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';


class BiodataGuruRepository {
  final ApiServiceGuru apiService;

  BiodataGuruRepository(this.apiService);

  Future<Guru> fetchBiodataGuru() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/profile'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final guruJson = jsonBody['data']; // ✅ FIX: ambil bagian data
      final dataGuru = Guru.fromJson(guruJson);
      return dataGuru;
    } else {
      throw Exception('Gagal mengambil data guru : ${response.body}');
    }
  }

}
