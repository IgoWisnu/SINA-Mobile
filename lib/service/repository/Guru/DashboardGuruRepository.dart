import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/DashboardSiswa.dart';
import 'package:sina_mobile/Model/Guru/DashboardGuru.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';


class DashboardGuruRepository {
  final ApiServiceGuru apiService;

  DashboardGuruRepository(this.apiService);

  Future<DashboardData> fetchDashboard() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final dashboardResponse = DashboardGuru.fromJson(jsonBody);
      return dashboardResponse.data;
    } else {
      throw Exception('Gagal mengambil data tugas : ${response.body}');
    }
  }

}
