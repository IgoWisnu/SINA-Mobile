import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/Berita.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class BeritaGuruRepository {
  final ApiServiceGuru apiService;

  BeritaGuruRepository(this.apiService);

  Future<List<Berita>> getBerita() async {
    //ambil token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/berita'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final berita = BeritaResponse.fromJson(json);
      return berita.data;
    } else {
      throw Exception('Gagal mengambil data kelas: ${response.body}'+' $token');
    }
  }

  Future<void> tambahBerita({
    required String filePath,
    required String deskripsi,
    required String judul
  }) async {
    //ambil token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final uri = apiService.buildUrl('dashboard/berita');

    // Cari MIME type dari file
    final mimeType = lookupMimeType(filePath);

    final file = await http.MultipartFile.fromPath(
      'foto',
      filePath,
      contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      filename: basename(filePath),
    );

    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['judul'] = judul
      ..fields['isi'] = deskripsi
      ..fields['tipe'] = 'pengumuman'
      ..files.add(file);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 201) {
      throw Exception('Gagal mengumpulkan tugas: ${response.body}');
    }
  }


}
