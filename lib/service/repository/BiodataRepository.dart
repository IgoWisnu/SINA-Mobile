import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/Materi.dart';
import 'package:sina_mobile/Model/SiswaResponse.dart';
import 'package:sina_mobile/Model/Tugas.dart';
import 'package:sina_mobile/Model/kelas.dart';
import '../../service/api/ApiService.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class BiodataRepository {
  final ApiService apiService;

  BiodataRepository(this.apiService);

  Future<Siswa> fetchBiodataSiswa() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/biodata'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final dataSiswa = SiswaResponse.fromJson(jsonBody);
      return dataSiswa.siswa;
    } else {
      throw Exception('Gagal mengambil data tugas : ${response.body}');
    }
  }
}
