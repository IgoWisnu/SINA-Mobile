import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/OrangTua/SuratIjin.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';

class SuratIzinRepository {
  final ApiServiceOrangTua apiService;

  SuratIzinRepository(this.apiService);

  Future<List<SuratIzin>> getSuratIjin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final nis = prefs.getString('nis');

    print("NIS yang dikirim: $nis");
    print("URL: ${apiService.buildUrl('dashboard/surat-izin/$nis')}");
    print("Token: $token");

    if (token == null || nis == null) {
      throw Exception("Token atau NIS tidak ditemukan");
    }

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/surat-izin/$nis'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['data'];
      return data.map((e) => SuratIzin.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw Exception("Tidak ada surat yang ditemukan");
    } else if (response.statusCode == 403) {
      throw Exception("Orang tua tidak memiliki akses ke siswa ini");
    } else if (response.statusCode == 500) {
      throw Exception("Terjadi kesalahan pada server (500)");
    } else {
      throw Exception("Gagal mengambil surat izin: ${response.body}");
    }
  }
}
