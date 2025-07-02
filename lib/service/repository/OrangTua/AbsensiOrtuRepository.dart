import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/OrangTua/RekapAbsenOrtu.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';

class AbsensiOrtuRepository {
  final ApiServiceOrangTua apiService;

  AbsensiOrtuRepository(this.apiService);

  Future<RekapAbsenData> getRekapAbsen(String nis, String krsId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/absensi/rekap/$nis/$krsId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final rekap = RekapAbsenOrtu.fromJson(json);
      return rekap.data;
    } else {
      throw Exception('Gagal mengambil data rekap absensi: ${response.body}');
    }
  }
}
