import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:sina_mobile/Model/OrangTua/AjukanSuratRespon.dart';
import 'package:sina_mobile/service/api/ApiService.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AjukanSuratRepository {
  final ApiServiceOrangTua apiService;

  AjukanSuratRepository({required this.apiService});

  Future<AjukanSuratResponse> ajukanSurat({
    required String nis,
    required String keterangan,
    required String uraian,
    required String
    tanggalAbsensi, // Pastikan ini sesuai dengan field yang diharapkan
    required String filePath,
  }) async {
    // Ambil token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    // Pastikan menggunakan instance apiService yang sudah diinisialisasi
    var request = http.MultipartRequest(
      'POST',
      apiService.buildUrl(
        'dashboard/ajukan-surat',
      ), // ✔️ pakai instance di sini
    );

    // ✅ Tambahkan header Authorization
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';

    request.fields['nis'] = nis;
    request.fields['keterangan'] = keterangan;
    request.fields['uraian'] = uraian;
    request.fields['tanggal_absensi'] = tanggalAbsensi;

    request.files.add(
      await http.MultipartFile.fromPath(
        'surat',
        filePath,
        contentType: MediaType('application', 'pdf'),
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      return AjukanSuratResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mengajukan surat: ${response.body}');
    }
  }
}
