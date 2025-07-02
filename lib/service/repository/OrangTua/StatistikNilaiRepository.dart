import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/OrangTua/StatistikOrtu.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';

class StatistikNilaiRepository {
  final ApiServiceOrangTua apiService;

  StatistikNilaiRepository(this.apiService);

  Future<StatistikOrtu> fetchStatistik() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final nis = prefs.getString('nis');

    if (nis == null || token == null) {
      throw Exception('NIS atau token tidak ditemukan di SharedPreferences');
    }

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/statistik/$nis'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      return StatistikOrtu.fromJson(jsonBody);
    } else {
      throw Exception('Gagal mengambil data statistik: ${response.body}');
    }
  }
}
