import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/Model/Guru/KelasGuru.dart';
import 'package:sina_mobile/Model/Guru/MateriDetailResponse.dart';
import 'package:sina_mobile/Model/Guru/MateriGuru.dart';
import 'package:sina_mobile/Model/Guru/PengumpulanTugasResponse.dart';
import 'package:sina_mobile/Model/Guru/TugasDetailResponse.dart';
import 'package:sina_mobile/Model/Guru/TugasGuru.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sina_mobile/service/api/ApiServiceGuru.dart';

class KelasGuruRepository {
  final ApiServiceGuru apiService;

  KelasGuruRepository(this.apiService);

  Future<List<KelasItem>> getKelas() async {
    //ambil token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/mapel'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final kelas = KelasGuru.fromJson(json);
      return kelas.data;
    } else {
      throw Exception('Gagal mengambil data kelas: ${response.body}'+' $token');
    }
  }

  Future<List<TugasItem>> fetchTugasByMapelId(String mapelId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/tugas/$mapelId'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final tugasGuru = TugasGuru.fromJson(jsonBody);
      return tugasGuru.data;
    } else {
      throw Exception('Gagal mengambil data tugas : ${response.body}');
    }
  }

  Future<List<MateriItem>> fetchMateriByMapelId(String mapelId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/materi/$mapelId'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final materiGuru = MateriGuru.fromJson(jsonBody);
      return materiGuru.data;
    } else {
      throw Exception('Gagal mengambil data materi : ${response.body}');
    }
  }

  Future<File> downloadFile(String url, String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$filename';
    final file = File(filePath);

    final response = await Dio().download(url, filePath);
    return file;
  }

  Future<void> updateNilai({
    required String idMapel,
    required String idTugas,
    required String krsID,
    required String nilai,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final uri = apiService.buildUrl('dashboard/mapel/$idMapel/tugas/$idTugas/siswa/$krsID');

    final response = await http.put(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'nilai': nilai}),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal update nilai: ${response.body}');
    }
  }

  Future<void> tambahTugas({
    required String idMapel,
    required String judul,
    required String filePath,
    required String deskripsi,
    required String tenggat
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final uri = apiService.buildUrl('dashboard/tugas/$idMapel');

    // Cari MIME type dari file
    final mimeType = lookupMimeType(filePath);

    final file = await http.MultipartFile.fromPath(
      'lampiran',
      filePath,
      contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      filename: basename(filePath),
    );

    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['judul'] = judul
      ..fields['deskripsi'] = deskripsi
      ..fields['tenggat_kumpul'] = tenggat
      ..files.add(file);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 201) {
      throw Exception('Gagal mengumpulkan tugas: ${response.body}');
    }
  }

  Future<void> editTugas({
    required String idTugas,
    required String judul,
    String? filePath, // ✅ ubah menjadi nullable
    required String deskripsi,
    required String tenggat,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final uri = apiService.buildUrl('dashboard/tugas/$idTugas');

    final request = http.MultipartRequest('PUT', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['judul'] = judul
      ..fields['deskripsi'] = deskripsi
      ..fields['tenggat_kumpul'] = tenggat;

    // ✅ Hanya kirim file jika path tidak null atau kosong
    if (filePath != null && filePath.isNotEmpty) {
      final mimeType = lookupMimeType(filePath);
      final file = await http.MultipartFile.fromPath(
        'lampiran',
        filePath,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        filename: basename(filePath),
      );
      request.files.add(file);
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Gagal mengumpulkan tugas: ${response.body}');
    }
  }

  Future<void> deleteTugas({required String idTugas}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Token tidak tersedia');
    }

    final uri = apiService.buildUrl('dashboard/tugas/$idTugas');

    final response = await http.delete(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      // Jika API mengembalikan 204 No Content (yang umum untuk delete), boleh ditambahkan:
      // if (response.statusCode != 204)
      throw Exception('Gagal menghapus tugas: ${response.body}');
    }
  }

  Future<void> editMateri({
    required String idMateri,
    required String judul,
    required String filePath,
    required String deskripsi,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final uri = apiService.buildUrl('dashboard/materi/$idMateri');

    // Cari MIME type dari file
    final mimeType = lookupMimeType(filePath);

    final file = await http.MultipartFile.fromPath(
      'lampiran',
      filePath,
      contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      filename: basename(filePath),
    );

    final request = http.MultipartRequest('PUT', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['nama_materi'] = judul
      ..fields['uraian'] = deskripsi
      ..files.add(file);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Gagal mengedit materi: ${response.body}');
    }
  }

  Future<void> deleteMateri({required String idMateri}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Token tidak tersedia');
    }

    final uri = apiService.buildUrl('dashboard/materi/$idMateri');

    final response = await http.delete(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      // Jika API mengembalikan 204 No Content (yang umum untuk delete), boleh ditambahkan:
      // if (response.statusCode != 204)
      throw Exception('Gagal menghapus tugas: ${response.body}');
    }
  }

  Future<void> tambahMateri({
    required String idMapel,
    required String judul,
    required String filePath,
    required String deskripsi,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final uri = apiService.buildUrl('dashboard/materi/$idMapel');

    // Cari MIME type dari file
    final mimeType = lookupMimeType(filePath);

    final file = await http.MultipartFile.fromPath(
      'lampiran',
      filePath,
      contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      filename: basename(filePath),
    );

    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['nama_materi'] = judul
      ..fields['uraian'] = deskripsi
      ..files.add(file);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 201) {
      throw Exception('Gagal mengumpulkan tugas: ${response.body}');
    }
  }

  Future<List<SudahMengumpulkan>> fetchSiwaMengumpulkan(String mapelId, String tugasId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/mapel/$mapelId/tugas/$tugasId'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final pengumpulanData = PengumpulanTugasResponse.fromJson(jsonBody);
      return pengumpulanData.data.sudahMengumpulkan;
    } else {
      throw Exception('Gagal mengambil data materi : ${response.body}');
    }
  }

  Future <MateriDetail> getDetailMateri({required String idMateri}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Token tidak tersedia');
    }

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/materi/detail/$idMateri'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final materiGuru = MateriDetailResponse.fromJson(jsonBody);
      return materiGuru.data.detail;
    } else {
      throw Exception('Gagal mengambil data tugas : ${response.body}');
    }
  }

  Future <TugasDetail> getDetailTugas({required String idTugas}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Token tidak tersedia');
    }

    final response = await apiService.client.get(
      apiService.buildUrl('dashboard/tugas/detail/$idTugas'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final tugasGuru = TugasDetailResponse.fromJson(jsonBody);
      print(tugasGuru);
      return tugasGuru.data.detail;
    } else {
      throw Exception('Gagal mengambil data tugas : ${response.body}');
    }
  }




}
