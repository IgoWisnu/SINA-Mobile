import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sina_mobile/Model/OrangTua/NilaiMapelBaru.dart';
import 'package:sina_mobile/service/repository/OrangTua/RaporFileRepository.dart';

class RaporFileViewModel extends ChangeNotifier {
  final RaporFileRepository repository;

  RaporFileViewModel({required this.repository});

  RaporFileResponse? _rapor;
  RaporFileResponse? get rapor => _rapor;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchRapor(String nis) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _rapor = await repository.getRaporByNis(nis);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<File> downloadRaporFile(String url, String filename) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) throw Exception("Permission ditolak");

    Directory? dir = Directory('/storage/emulated/0/Download');
    if (!await dir.exists()) {
      dir = await getExternalStorageDirectory();
    }

    final filePath = '${dir!.path}/$filename';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await Dio().download(
      url,
      filePath,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        responseType: ResponseType.bytes,
      ),
    );

    if (response.statusCode == 200) {
      return File(filePath);
    } else {
      throw Exception("Gagal mengunduh file");
    }
  }
}
