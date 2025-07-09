import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/SiswaResponse.dart';
import '../../service/api/ApiService.dart';
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
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final dataSiswa = SiswaResponse.fromJson(jsonBody);
      return dataSiswa.siswa;
    } else {
      throw Exception('Gagal mengambil data tugas : ${response.body}');
    }
  }

  Future<void> UpdateBiodataSiswa(Siswa siswa, {File? imageFile}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final uri = Uri.parse('http://sina.pnb.ac.id:3001/api/dashboard/biodata');

    final request = http.MultipartRequest('PUT', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['nama'] = siswa.nama
      ..fields['tempat_lahir'] = siswa.tempatLahir
      ..fields['tanggal_lahir'] = siswa.tanggalLahir.toIso8601String()
      ..fields['alamat'] = siswa.alamat;

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
      Uri.parse('http://sina.pnb.ac.id:3001/api/dashboard/update-password'),
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
