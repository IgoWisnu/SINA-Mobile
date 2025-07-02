import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/OrangTua/raportDetail.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';

class RaporDetailRepository {
  final ApiServiceOrangTua apiService;

  RaporDetailRepository(this.apiService);

  Future<RaporDetail> getDetailRapor(String krsId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/rapor/detail/$krsId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['data'] != null) {
        return RaporDetail.fromJson(json['data']);
      } else {
        throw Exception('Detail rapor tidak ditemukan.');
      }
    } else {
      throw Exception('Gagal ambil detail rapor: ${response.body}');
    }
  }
}
