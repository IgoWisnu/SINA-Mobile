import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/OrangTua/raport.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';

class RaporRepository {
  final ApiServiceOrangTua apiService;

  RaporRepository(this.apiService);

  Future<RaporSiswa?> getRaport() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final nis = prefs.getString('nis');

    if (nis == null || nis.isEmpty) {
      throw Exception('NIS tidak ditemukan di SharedPreferences.');
    }

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/rapor/$nis'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['data'] != null && json['data'].isNotEmpty) {
        return RaporSiswa.fromJson(json['data'][0]);
      } else {
        throw Exception('Data rapor tidak tersedia.');
      }
    } else {
      throw Exception('Gagal mengambil data rapor: ${response.body}');
    }
  }
}
