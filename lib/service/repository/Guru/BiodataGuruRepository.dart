import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/Guru/Guru.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';


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

  Future<void> UpdateBiodataGuru(Guru guru, {File? imageFile}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final uri = Uri.parse('http://sina.pnb.ac.id:3007/api/dashboard/profile');

    final request = http.MultipartRequest('PUT', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['no_telepon'] = guru.noTelepon
      ..fields['agama_guru'] = guru.agamaGuru
      ..fields['tempat_lahir'] = guru.tempatLahirGuru
      ..fields['tanggal_lahir'] = guru.tanggalLahirGuru.toIso8601String()
      ..fields['alamat'] = guru.alamat;

    if (imageFile != null) {
      final filePath = imageFile.path;
      final mimeType = lookupMimeType(filePath);

      final file = await http.MultipartFile.fromPath(
        'foto_profil',
        filePath,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        filename: basename(filePath),
      );

      request.files.add(file);
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui biodata siswa. (${response.statusCode}) ${response.body}');
    }
  }

  Future<void> updatePassword(
      String oldPw,
      String newPw
      ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.put(
      Uri.parse('http://sina.pnb.ac.id:3007/api/dashboard/profile/password'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'password_lama': oldPw,
        'password_baru': newPw,
        'konfirmasi_password': newPw,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui password. (${response.statusCode}) ${response.body}');
    }
  }

}
