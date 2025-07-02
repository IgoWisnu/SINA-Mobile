import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:sina_mobile/Model/OrangTua/raportDetail.dart';
import 'package:sina_mobile/service/repository/OrangTua/RaporDetailRepository.dart';

class RaporDetailViewModel extends ChangeNotifier {
  final RaporDetailRepository repository;

  RaporDetailViewModel({required this.repository});

  RaporDetail? _raporDetail;
  RaporDetail? get raporDetail => _raporDetail;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDetail(String krsId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _raporDetail = await repository.getDetailRapor(krsId);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<File> downloadPdfFileLocal(String url, String fileName) async {
    final dir =
        await getExternalStorageDirectory(); // Untuk menyimpan di storage luar
    final downloadsDir = Directory(
      '${dir!.path}/Download',
    ); // misalnya ke Download
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
          headers: {'Authorization': 'Bearer $token'},
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
        headers: {'Authorization': 'Bearer $token'},
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
