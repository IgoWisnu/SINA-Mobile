import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sina_mobile/Model/OrangTua/SuratIjinDetail.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuratIjinDetailRepository {
  final ApiServiceOrangTua apiService;

  SuratIjinDetailRepository(this.apiService);

  Future<DetailSuratIzin> fetchDetailSurat(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/surat-izin/detail/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return DetailSuratIzin.fromJson(data);
    } else {
      throw Exception('Gagal mengambil detail surat izin');
    }
  }
}
