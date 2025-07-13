import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/OrangTua/NilaiMapelBaru.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';

class RaporFileRepository {
  final ApiServiceOrangTua apiService;

  RaporFileRepository(this.apiService);

  Future<RaporFileResponse> getRaporByNis(String nis) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/rapor-file/$nis'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return RaporFileResponse.fromJson(json);
    } else {
      throw Exception('Gagal mengambil rapor: ${response.body}');
    }
  }
}
