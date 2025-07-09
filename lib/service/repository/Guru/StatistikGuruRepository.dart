import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/Guru/KelasGuru.dart';
import 'package:sina_mobile/Model/Guru/ListSiswa.dart';
import 'package:sina_mobile/Model/Guru/MateriGuru.dart';
import 'package:sina_mobile/Model/Guru/PengumpulanTugasResponse.dart';
import 'package:sina_mobile/Model/Guru/StatistikSiswaResponse.dart';
import 'package:sina_mobile/Model/Guru/TugasGuru.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';

class StatistikGuruRepository {
  final ApiServiceGuru apiService;

  StatistikGuruRepository(this.apiService);

  Future<List<KelasItem>> getKelas() async {
    //ambil token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/mapel'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final kelas = KelasGuru.fromJson(json);
      return kelas.data;
    } else {
      throw Exception('Gagal mengambil data kelas: ${response.body}'+' $token');
    }
  }

  Future<List<AbsensiSiswa>> getListSiswa(String idMapel) async {
    //ambil token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/siswa/$idMapel'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final listsiswa = ListSiswa.fromJson(json);
      return listsiswa.data;
    } else {
      throw Exception('Gagal mengambil data siswa: ${response.body}'+' $token');
    }
  }

  Future<List<StatistikGuru>> getStatistikSiswa(
      String krsId
      ) async {
    //ambil token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/nilai/statistik/$krsId?tahun_akademik_id=TA2023'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final statistik = StatistikGuruResponse.fromJson(json);
      return statistik.data;
    } else {
      throw Exception('Gagal mengambil data statistik: ${response.body}'+' $token');
    }
  }

}
