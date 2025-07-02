import 'package:sina_mobile/Model/OrangTua/OrangTuaResponse.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sina_mobile/service/api/ApiServisOrangTua.dart';

class BiodataOrtuRepository {
  final ApiServiceOrangTua apiService;

  BiodataOrtuRepository(this.apiService);

  Future<Ortu> fetchBiodataOrtu() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) throw Exception('Token tidak ditemukan.');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/biodata'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final dataOrtu = OrangTuaRespon.fromJson(jsonBody);
      return dataOrtu.ortu;
    } else {
      throw Exception('Gagal mengambil data Orang Tua: ${response.body}');
    }
  }

  Future<void> uploadFotoProfil(File imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) throw Exception("Token tidak ditemukan");

    final dio = Dio();
    final formData = FormData.fromMap({
      'foto_profil': await MultipartFile.fromFile(
        imageFile.path,
        filename: basename(imageFile.path),
        contentType: MediaType('image', 'jpeg'),
      ),
    });

    final response = await dio.put(
      'http://sina.pnb.ac.id:3006/api/dashboard/biodata',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal upload foto: ${response.statusCode} ${response.data}',
      );
    }
  }
}
