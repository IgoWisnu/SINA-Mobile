import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/DetailKelasResponse.dart';
import 'package:sina_mobile/Model/DetailRaporResponse.dart';
import 'package:sina_mobile/Model/StatistikSiswa.dart';
import '../../service/api/ApiService.dart';


class RaporRepository {
  final ApiService apiService;

  RaporRepository(this.apiService);

  Future<DetailKelas> fetchTahunAkademik() async {
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

  Future<RaporData> fetchRaporList(
      String idAkademik,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/rapor/$idAkademik'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");


    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final dataRapor = DetailRaporResponse.fromJson(jsonBody);
      return dataRapor.data;
    } else {
      throw Exception('Gagal mengambil data rapor : ${response.body}');
    }
  }



}
