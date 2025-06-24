import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/DetailKelasResponse.dart';
import 'package:sina_mobile/Model/DetailRaporResponse.dart';
import 'package:sina_mobile/Model/RekapAbsen.dart';
import 'package:sina_mobile/Model/StatistikSiswa.dart';
import 'package:sina_mobile/service/repository/RaporRepository.dart';
import 'package:sina_mobile/service/repository/StatistikRepository.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';




class RaporSiswaViewModel extends ChangeNotifier {
  final RaporRepository repository;

  RaporSiswaViewModel({required this.repository});

  DetailKelas? _detailKelas;
  bool _loading = false;
  String? _error;

  DetailKelas? get detailkelas => _detailKelas;
  bool get isLoading => _loading;
  String? get error => _error;

  RaporData? _raporData;
  RaporData? get rapordata => _raporData;

  Future<void> getlistRapor() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _detailKelas = await repository.fetchTahunAkademik();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> getRapor(
      String idAkademik
      ) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _raporData = await repository.fetchRaporList(idAkademik);
      print("URL PDF: ${_raporData?.pdfUrl}"); // <- ini akan bantu debug
    } catch (e) {
      _error = e.toString();
      print("Error: ${e?.toString() ?? 'Tidak diketahui'} | idAkademik: $idAkademik");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }


  Future<File> downloadPdfFileLocal(String url, String fileName) async {
    final dir = await getExternalStorageDirectory(); // Untuk menyimpan di storage luar
    final downloadsDir = Directory('${dir!.path}/Download'); // misalnya ke Download
    if (!downloadsDir.existsSync()) {
      downloadsDir.createSync(recursive: true);
    }

    final filePath = '${downloadsDir.path}/$fileName';
    final file = File(filePath);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception("Token tidak tersedia.");
      }

      final response = await Dio().download(
        url,
        filePath,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return file;
    } catch (e) {
      throw Exception('Gagal mengunduh PDF: $e');
    }
  }

  Future<File> downloadAndSavePdf(String url, String fileName) async {
    final dio = Dio();

    final status = await Permission.storage.request();
    if (!status.isGranted) throw Exception("Permission ditolak");

    // Simpan ke folder Download
    Directory? downloadsDir = Directory('/storage/emulated/0/Download');
    if (!await downloadsDir.exists()) {
      downloadsDir = await getExternalStorageDirectory(); // fallback
    }

    final filePath = '${downloadsDir!.path}/$fileName';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception("Token tidak tersedia.");
    }

    final response = await Dio().download(
      url,
      filePath,
      options: Options(
        responseType: ResponseType.bytes,
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      print("File disimpan di: $filePath");
      return File(filePath);
    } else {
      throw Exception("Gagal mengunduh file");
    }
  }







}
