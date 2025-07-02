import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/OrangTua/DashboardOrtu.dart';

import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';

class DashboardOrtuRepository {
  final ApiServiceOrangTua apiService;

  DashboardOrtuRepository(this.apiService);

  Future<DashboardStatus> fetchDashboard(String nis) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception("Token tidak ditemukan");
    }

    final url = apiService.buildUrl('dashboard/$nis');

    final response = await apiService.client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final dashboardResponse = DashboardResponse.fromJson(jsonBody);
      return dashboardResponse.data;
    } else {
      throw Exception('Gagal mengambil data dashboard: ${response.body}');
    }
  }
}
