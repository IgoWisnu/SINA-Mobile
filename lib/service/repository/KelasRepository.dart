import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/Materi.dart';
import 'package:sina_mobile/Model/Tugas.dart';
import 'package:sina_mobile/Model/kelas.dart';
import '../../service/api/ApiService.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class KelasRepository {
  final ApiService apiService;

  KelasRepository(this.apiService);

  Future<List<Datum>> getKelas() async {
    //ambil token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/mapel-kelas'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final kelas = Kelas.fromJson(json);
      return kelas.data;
    } else {
      throw Exception('Gagal mengambil data kelas: ${response.body}'+' $token');
    }
  }

  Future<List<Tugas>> fetchTugasByMapelId(int mapelId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      //throw Exception('Token tidak ditemukan di SharedPreferences');
    }

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/tugas/1'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final kelasDetail = KelasDetail.fromJson(jsonBody);
      return kelasDetail.data;
    } else {
      throw Exception('Gagal mengambil data tugas : ${response.body}');
    }
  }

  Future<List<Materi>> fetchMateriByMapelId(int mapelId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/materi/$mapelId'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final materiList = (jsonBody['data'] as List)
          .map((e) => Materi.fromJson(e))
          .toList();
      return materiList;
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

  Future<void> kumpulkanTugas({
    required int idTugas,
    required String filePath,
    required String deskripsi,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final uri = apiService.buildUrl('dashboard/tugas/$idTugas');

    // Cari MIME type dari file
    final mimeType = lookupMimeType(filePath);

    final file = await http.MultipartFile.fromPath(
      'file_jawaban',
      filePath,
      contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      filename: basename(filePath),
    );

    final request = http.MultipartRequest('PUT', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['deskripsi'] = deskripsi
      ..files.add(file);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Gagal mengumpulkan tugas: ${response.body}');
    }
  }


}
