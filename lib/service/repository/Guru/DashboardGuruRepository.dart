import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/DashboardSiswa.dart';
import 'package:sina_mobile/Model/Guru/DashboardCountRespone.dart';
import 'package:sina_mobile/Model/Guru/DashboardGuru.dart';
import 'package:sina_mobile/Model/Guru/JadwalGuru.dart';
import 'package:sina_mobile/service/api/ApiService.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';


class DashboardGuruRepository {
  final ApiServiceGuru apiService;

  DashboardGuruRepository(this.apiService);

  Future<Map<String, DashboardGuruData>> fetchDashboardGuru() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/count'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil dashboard guru');
    }

    final jsonBody = jsonDecode(response.body);
    final data = jsonBody['data'] as Map<String, dynamic>;

    final Map<String, DashboardGuruData> result = {};

    try {
      for (var hari in data.entries) {
        final kelasMap = hari.value as Map<String, dynamic>;
        for (var kelas in kelasMap.entries) {
          final mapelMap = kelas.value as Map<String, dynamic>;
          for (var mapelEntry in mapelMap.entries) {
            final mapelName = mapelEntry.key;
            final mapelData = mapelEntry.value;

            result[mapelName] = DashboardGuruData.fromJson(mapelData);
          }
        }
      }
    } catch (e) {
      print("❌ Error parsing nested mapel: $e");
      rethrow;
    }

    print("✅ Mapel berhasil diparsing: ${result.keys.toList()}");
    return result;
  }
}
