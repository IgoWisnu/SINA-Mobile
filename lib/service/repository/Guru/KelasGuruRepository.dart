import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/Guru/KelasGuru.dart';
import 'package:sina_mobile/Model/Guru/MateriGuru.dart';
import 'package:sina_mobile/Model/Guru/PengumpulanTugasResponse.dart';
import 'package:sina_mobile/Model/Guru/TugasGuru.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';

class KelasGuruRepository {
  final ApiServiceGuru apiService;

  KelasGuruRepository(this.apiService);

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

  Future<List<TugasItem>> fetchTugasByMapelId(String mapelId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/tugas/$mapelId'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final tugasGuru = TugasGuru.fromJson(jsonBody);
      return tugasGuru.data;
    } else {
      throw Exception('Gagal mengambil data tugas : ${response.body}');
    }
  }

  Future<List<MateriItem>> fetchMateriByMapelId(String mapelId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/materi/$mapelId'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final materiGuru = MateriGuru.fromJson(jsonBody);
      return materiGuru.data;
    } else {
      throw Exception('Gagal mengambil data materi : ${response.body}');
    }
  }

  Future<File> downloadFile(String url, String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$filename';
    final file = File(filePath);

    final response = await Dio().download(url, filePath);
    return file;
  }

  Future<void> tambahTugas({
    required String idMapel,
    required String judul,
    required String filePath,
    required String deskripsi,
    required String tenggat
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final uri = apiService.buildUrl('dashboard/tugas/$idMapel');

    // Cari MIME type dari file
    final mimeType = lookupMimeType(filePath);

    final file = await http.MultipartFile.fromPath(
      'lampiran',
      filePath,
      contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      filename: basename(filePath),
    );

    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['judul'] = judul
      ..fields['deskripsi'] = deskripsi
      ..fields['tenggat_kumpul'] = tenggat
      ..files.add(file);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 201) {
      throw Exception('Gagal mengumpulkan tugas: ${response.body}');
    }
  }

  Future<void> tambahMateri({
    required String idMapel,
    required String judul,
    required String filePath,
    required String deskripsi,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final uri = apiService.buildUrl('dashboard/materi/$idMapel');

    // Cari MIME type dari file
    final mimeType = lookupMimeType(filePath);

    final file = await http.MultipartFile.fromPath(
      'lampiran',
      filePath,
      contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      filename: basename(filePath),
    );

    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['nama_materi'] = judul
      ..fields['uraian'] = deskripsi
      ..files.add(file);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 201) {
      throw Exception('Gagal mengumpulkan tugas: ${response.body}');
    }
  }

  Future<List<SudahMengumpulkan>> fetchSiwaMengumpulkan(String mapelId, String tugasId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/mapel/$mapelId/tugas/$tugasId'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final pengumpulanData = PengumpulanTugasResponse.fromJson(jsonBody);
      return pengumpulanData.data.sudahMengumpulkan;
    } else {
      throw Exception('Gagal mengambil data materi : ${response.body}');
    }
  }


}
