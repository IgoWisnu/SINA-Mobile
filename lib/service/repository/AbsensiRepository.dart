import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/RekapAbsen.dart';
import 'package:sina_mobile/Model/Tugas.dart';
import 'package:sina_mobile/Model/kelas.dart';
import '../../service/api/ApiService.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

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


}
