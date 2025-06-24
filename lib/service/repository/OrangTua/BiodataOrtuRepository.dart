import 'package:sina_mobile/Model/OrangTua/OrangTuaResponse.dart';
import 'package:sina_mobile/service/api/ApiService.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';

class BiodataOrtuRepository {
  final ApiServiceOrangTua apiService;

  BiodataOrtuRepository(this.apiService);

  Future<Ortu> fetchBiodataOrtu() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('Token tidak ditemukan.');
      }

      final response = await apiService.client.get(
        apiService.buildUrl('dashboard/biodata'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token',
        },
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);

        if (jsonBody['data'] == null) {
          throw Exception('Data biodata tidak ditemukan.');
        }

        final dataOrtu = OrangTuaRespon.fromJson(jsonBody);
        return dataOrtu.ortu;
      } else {
        throw Exception('Gagal mengambil data Orang Tua: ${response.body}');
      }
    } catch (e) {
      print('Error di fetchBiodataOrtu: $e');
      rethrow;
    }
  }
}
