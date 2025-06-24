import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/DetailKelasResponse.dart';
import 'package:sina_mobile/Model/SiswaResponse.dart';
import 'package:sina_mobile/Model/StatistikSiswa.dart';
import '../../service/api/ApiService.dart';


class StatistikRepository {
  final ApiService apiService;

  StatistikRepository(this.apiService);

  Future<DetailKelas> fetchStatistik() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/detail-kelas'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final dataSiswa = DetailKelasResponse.fromJson(jsonBody);
      return dataSiswa.data;
    } else {
      throw Exception('Gagal mengambil data statistik : ${response.body}');
    }
  }

  Future<StatistikData> fetchStatistikDetail(
      String idAkademik,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/nilai/$idAkademik'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final dataSiswa = StatistikSiswa.fromJson(jsonBody);
      return dataSiswa.data;
    } else {
      throw Exception('Gagal mengambil data statistik : ${response.body}');
    }
  }



}
