import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';

import '../../../Model/Guru/SuratIzinModel.dart';

class SuratIzinRepository {
  final ApiServiceGuru apiService;

  SuratIzinRepository({required this.apiService});

  Future<List<SuratIzinModel>> getSuratIzin() async {
    final response = await apiService.client.get(
      apiService.buildUrl(
        'dashboard/surat-izin?status=menunggu,status=terima',
      ), // Filter by status
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      if (data['success'] == true) {
        return (data['data'] as List)
            .map((e) => SuratIzinModel.fromJson(e))
            .toList();
      }
    }
    return []; // Return empty list bukan error
  }

  // SuratIzinRepository.dart
  Future<bool> approveSuratIzin(String absensiId) async {
    final response = await apiService.client.put(
      apiService.buildUrl('dashboard/surat-izin/$absensiId/terima'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['success'] == true;
    }
    throw Exception('Status code: ${response.statusCode}');
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await SharedPreferences.getInstance().then(
      (prefs) => prefs.getString('auth_token') ?? '',
    );

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
