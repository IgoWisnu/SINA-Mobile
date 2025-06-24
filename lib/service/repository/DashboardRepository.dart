import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/DashboardSiswa.dart';
import 'package:sina_mobile/Model/Materi.dart';
import 'package:sina_mobile/Model/RingkasanDashboardSiswaResponse.dart';
import 'package:sina_mobile/Model/SiswaResponse.dart';
import 'package:sina_mobile/View/dashboard.dart';
import '../../service/api/ApiService.dart';


class DashboardRepository {
  final ApiService apiService;

  DashboardRepository(this.apiService);

  Future<RingkasanDashboardData> fetchDashboard() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final dashboardResponse = RingkasanDashboardSiswaResponse.fromJson(jsonBody);
      return dashboardResponse.data;
    } else {
      throw Exception('Gagal mengambil data tugas : ${response.body}');
    }
  }

}
